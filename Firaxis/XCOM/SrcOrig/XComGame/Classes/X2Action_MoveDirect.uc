//-----------------------------------------------------------
// Used by the visualizer system to control a Visualization Actor
//-----------------------------------------------------------
class X2Action_MoveDirect extends X2Action_Move
	config(Animation);

//@TODO - rmcfall - generalize interrupts so that any action can process them
enum EStopMoveType
{
	eSMT_CloseCombat,
	eSMT_Death,
	eSMT_PatrolInterrupt,
	eSMT_RevealInterrupt,
};

enum AnimationState
{
	eAnimNone,
	eAnimRun,
	eAnimRunTurn,
	eAnimStopping,
	eAnimStop,
	eAnimRunFlinch
};

struct TurnData
{
	var Name AnimName;
	var BoneAtom Destination;
	var float Distance;
};

//@TODO - rmcfall/jwatson - audit this action and decide what needs to go and what should stay. Currently operates with code copied from the XEU/EW code base.
var vector			CurrentDirection;
var bool            bNoChangeRMA;
var bool            bNextMoveIsEndMove;
var bool            bNextMoveIsDirectMove;
var vector          NewDirection;
var vector          StartLocation;
var float           StartDistance;
var AnimationState  CurrentAnimState;
var bool            bSpawnForcedWalkIn;
var Array<TurnData> TurnQueue;
var AnimNodeSequence SwitchAnimNodeSequence;
var bool			bShouldSkipStop;
var bool			bIsFlying;
var config float	RunStopVsRunCoverThreshold;
var config float	PredictedCoverShouldUsePeeksThreshold;
var config float	MaxUnitRunRate;
var config float	MinUnitRunRate;
var config bool		bUseRunRateOption;
var config float	RunFlinchBlendTime;
var config float	RunFlinchDuration;
var float			RunFlinchCurrentTime;
var bool			CurrentlyRunFlinching;
var float			AnimationRateModifier;
var float			LastAnimPlayRate;
var config float	RunSlopeRateModifier;
var X2Action_MoveEnd MoveEndAction; // Points to MoveEnd action if next action.

function Init()
{
	super.Init();

	bNextMoveIsEndMove = ModifyDestinationForCover(MoveEndAction);
	bNextMoveIsDirectMove = IsNextActionTypeOf(class'X2Action_MoveDirect');

	if(bShouldUseWalkAnim)
	{
		TurnQueue.Length = 0;
		// Walks could take longer, the demo is timing out on a long advent walk, lets up the timeout 50% for walks
		TimeoutSeconds = default.TimeoutSeconds*1.5f;
	}

	if (bIsFlying)
	{
		BeginFlying();
	}
}

function BeginFlying()
{
	UnitPawn.SetPhysics(PHYS_Flying);
	UnitPawn.m_kLastPhysicsState.m_ePhysics = PHYS_Flying;
	Unit.m_bIsFlying = true;
}

function SetFlying()
{
	bIsFlying = true;
}

function EndFlying()
{
	UnitPawn.SetPhysics(PHYS_Walking);
	UnitPawn.m_kLastPhysicsState.m_ePhysics = PHYS_Walking;
	Unit.m_bIsFlying = false;
}

function ParsePathSetParameters(int Index, const out vector InDestination, float InDistance, const out vector InCurrentDirection, const out vector InNewDirection, bool ShouldSkipStop = false, float MoveSpeedModifier = 1.0f)
{	
	local float Dot;
	local float AngleBetween;
	local vector Left;
	local TurnData TurnInfo;

	PathIndices.Length = 0;
	PathIndices.AddItem(Index);

	CurrentDirection = InCurrentDirection;
	Destination = InDestination;
	Distance = InDistance;
	NewDirection = InNewDirection;
	bShouldSkipStop = ShouldSkipStop;
	AnimationRateModifier = MoveSpeedModifier * GetMoveAnimationSpeed();

	if( (abs(NewDirection.X) >= 0.001f || abs(NewDirection.Y) >= 0.001f) && (abs(CurrentDirection.X) >= 0.001f || abs(CurrentDirection.Y) >= 0.001f) )
	{		
		Dot = NoZDot(CurrentDirection, NewDirection);
		AngleBetween = Acos(Dot) * RadToDeg;

		//check if a turn animation should be played.
		if ( AngleBetween >= 60.0f )
		{
			TurnInfo.Distance = Distance;
			TurnInfo.Destination.Translation = Destination;
			TurnInfo.Destination.Rotation = QuatFromRotator(Rotator(NewDirection));
			TurnInfo.Destination.Scale = 1.0f;

			Left = CurrentDirection cross vect(0, 0, 1);
			Dot = NoZDot(Left, NewDirection);
			if (Dot > 0)
			{
				TurnInfo.AnimName = 'MV_RunTurn90Left';
			}
			else
			{
				TurnInfo.AnimName = 'MV_RunTurn90Right';
			}

			TurnQueue.AddItem(TurnInfo);
		}
	}
}

function AnimNodeSequence TriggerRunFlinch()
{
	if(CurrentAnimState == eAnimRun) //Don't try this unless we are mid run - it has bad effects otherwise
	{
		SwitchAnimation(eAnimRunFlinch);
	}

	return SwitchAnimNodeSequence;
}

simulated function SwitchAnimation(AnimationState anim)
{
	local CustomAnimParams AnimParams;
	local BoneAtom DesiredAtom;
	local Vector Facing;
	local float AngleBetween;
	local bool ShouldOverrideAnim;
	local Vector CrossDirection;
	local bool ComingFromPositive;
	local XComWorldData World;	
	local AnimationState PreviousState;
	local AnimNodeSequence PreviousSequence;
	local float HealthPercent;

	if (CurrentAnimState == anim)
		return;

	PreviousState = CurrentAnimState;
	CurrentAnimState = anim;
	PreviousSequence = SwitchAnimNodeSequence;
	SwitchAnimNodeSequence = None;
	World = `XWORLD;

	switch( anim )
	{
		case eAnimRun:
			UnitPawn.bShouldRotateToward = true;
			UnitPawn.EnableRMA(true,false);
			UnitPawn.EnableRMAInteractPhysics(false);
			if( bShouldUseWalkAnim )
			{
				AnimParams.AnimName = 'MV_WalkFwd';

				// Randomly choose a special walk if it exists.
				if( rand(600) == 0 && UnitPawn.GetAnimTreeController().CanPlayAnimation('MV_WalkFwdFun') )
				{
					AnimParams.AnimName = 'MV_WalkFwdFun';
				}
			}
			else
			{
				AnimParams.AnimName = 'MV_RunFwd';
				HealthPercent = float(Unit.GetUnitHP()) / Unit.GetUnitMaxHP();
				if( HealthPercent <= 0.5f && UnitPawn.GetAnimTreeController().CanPlayAnimation('MV_RunFwdInjured') )
				{
					AnimParams.AnimName = 'MV_RunFwdInjured';
				}

				if(bUseRunRateOption)
				{
					//Players may adjust the movement rate or all units within the limits set by MinUnitRunRate and MaxUnitRunRate, using the options menu. Only affects the run anim.
					AnimParams.PlayRate = Lerp(MinUnitRunRate, MaxUnitRunRate, FMin(`XPROFILESETTINGS.Data.UnitMovementSpeed, 1.0f)) * AnimationRateModifier;
				}
				else
				{
					AnimParams.PlayRate = AnimationRateModifier;
				}

				if( CurrentlyRunFlinching )
				{
					AnimParams.BlendTime = RunFlinchBlendTime;
					CurrentlyRunFlinching = false;
				}
			}	
			
			AnimParams.Looping = true;
			SwitchAnimNodeSequence = UnitPawn.GetAnimTreeController().PlayFullBodyDynamicAnim(AnimParams);
		break;

		case eAnimRunFlinch:
			UnitPawn.bShouldRotateToward = true;
			UnitPawn.EnableRMA(true, false);
			UnitPawn.EnableRMAInteractPhysics(false);

			if( UnitPawn.GetAnimTreeController().IsPlayingCurrentAnimation('MV_RunFwd') )
			{
				AnimParams.AnimName = 'MV_RunFlinch';

				if( UnitPawn.GetAnimTreeController().CanPlayAnimation(AnimParams.AnimName) )
				{
					AnimParams.BlendTime = RunFlinchBlendTime;
					AnimParams.Looping = true;
					AnimParams.StartOffsetTime = UnitPawn.GetAnimTreeController().GetCurrentAnimationTime();
					AnimParams.PlayRate = AnimationRateModifier;
					RunFlinchCurrentTime = 0.0f;
					CurrentlyRunFlinching = true;
					SwitchAnimNodeSequence = UnitPawn.GetAnimTreeController().PlayFullBodyDynamicAnim(AnimParams);
				}
			}

			// We failed to trigger run flinch so revert to our previous state
			if( SwitchAnimNodeSequence == None )
			{
				CurrentAnimState = PreviousState;
				SwitchAnimNodeSequence = PreviousSequence;
			}
		break;

		case eAnimRunTurn:
			UnitPawn.bShouldRotateToward = false;
			UnitPawn.EnableRMA(true,true);
			UnitPawn.EnableRMAInteractPhysics(true);

			// Always use turn anim 0 since it comes first and will be removed once we played it			
			AnimParams.AnimName = TurnQueue[0].AnimName;
			AnimParams.DesiredEndingAtoms.AddItem(TurnQueue[0].Destination);
			AnimParams.DesiredEndingAtoms[0].Translation.Z = Unit.GetDesiredZForLocation(AnimParams.DesiredEndingAtoms[0].Translation, World.IsPositionOnFloor(DesiredAtom.Translation));
			AnimParams.PlayRate = AnimationRateModifier;
			SwitchAnimNodeSequence = UnitPawn.GetAnimTreeController().PlayFullBodyDynamicAnim(AnimParams);
		break;

		case eAnimStop:
			UnitPawn.bShouldRotateToward = false;
			bNoChangeRMA = false;
			UnitPawn.EnableRMA(true, true);
			UnitPawn.EnableRMAInteractPhysics(true);
		break;

		case eAnimStopping:
			bNoChangeRMA = false;
			if(!bShouldUseWalkAnim)
			{
				DesiredAtom.Rotation = QuatFromRotator(Rotator(PredictedCoverDirection));
				DesiredAtom.Translation = GetEndDestinationForStopAnim();
				DesiredAtom.Scale = 1.0f;

				Facing = Normal(Vector(Unit.Rotation));
				PredictedCoverDirection = Normal(PredictedCoverDirection);
				AngleBetween = RadToDeg * Acos(NoZDot(Facing, PredictedCoverDirection));
				
				// If we are going into left cover from the positive side we want to play the standard anim.
				// If we are going into right cover from the negative side we want to play the standard anim
				ComingFromPositive = false;
				ShouldOverrideAnim = AngleBetween < RunStopVsRunCoverThreshold;
				if( !ShouldOverrideAnim )
				{
					CrossDirection = PredictedCoverDirection cross Facing;
					if( CrossDirection.Z > 0 )
					{
						ComingFromPositive = true;
					}
				}
				
				switch (PredictedCoverState)
				{
					case eCS_LowLeft:
						if (ShouldOverrideAnim || ComingFromPositive)
						{
							AnimParams.AnimName = 'MV_RunFwd_StopCrouch';
						}
						else
						{
							AnimParams.AnimName = 'LL_Run2Cover';
						}
						Unit.IdleStateMachine.DesiredPeekSide = ePeekRight;
						Unit.IdleStateMachine.DesiredCoverIndex = PredictedCoverIndex;
						break;
					case eCS_LowRight:
						if (ShouldOverrideAnim || !ComingFromPositive )
						{
							AnimParams.AnimName = 'MV_RunFwd_StopCrouch';
						}
						else
						{
							AnimParams.AnimName = 'LR_Run2Cover';
						}
						Unit.IdleStateMachine.DesiredPeekSide = ePeekLeft;
						Unit.IdleStateMachine.DesiredCoverIndex = PredictedCoverIndex;
						break;
					case eCS_HighRight:
						if( ShouldOverrideAnim || !ComingFromPositive )
						{
							AnimParams.AnimName = 'MV_RunFwd_StopStand';
						}
						else
						{
							AnimParams.AnimName = 'HR_Run2Cover';
						}
						Unit.IdleStateMachine.DesiredPeekSide = ePeekLeft;
						Unit.IdleStateMachine.DesiredCoverIndex = PredictedCoverIndex;
						break;
					case eCS_HighLeft:
						if( ShouldOverrideAnim || ComingFromPositive )
						{
							AnimParams.AnimName = 'MV_RunFwd_StopStand';
						}
						else
						{
							AnimParams.AnimName = 'HL_Run2Cover';
						}
						Unit.IdleStateMachine.DesiredPeekSide = ePeekRight;
						Unit.IdleStateMachine.DesiredCoverIndex = PredictedCoverIndex;
						break;
					case eCS_None:
						AnimParams.AnimName = 'MV_RunFwd_StopStand';
						if( UnitPawn.GetAnimTreeController().CanPlayAnimation('MV_RunFwd_StopStandAlt') && UnitPawn.GetAnimTreeController().ShouldPlayAlternativeRunStop() )
						{
							AnimParams.AnimName = 'MV_RunFwd_StopStandAlt';
						}
						
						// Ensure we always stop with no pitch
						NewDirection.Z = 0.0f;
						if( abs(NewDirection.X) < 0.001f && abs(NewDirection.Y) < 0.001f )
						{
							NewDirection = Vector(UnitPawn.Rotation);
							NewDirection.Z = 0.0f;
						}

						DesiredAtom.Rotation = QuatFromRotator(Rotator(NewDirection));
						Unit.IdleStateMachine.DesiredPeekSide = eNoPeek;
						Unit.IdleStateMachine.DesiredCoverIndex = -1;
						break;
				}

				DesiredAtom.Translation.Z = Unit.GetDesiredZForLocation(DesiredAtom.Translation, World.IsPositionOnFloor(DesiredAtom.Translation));
								
				AnimParams.DesiredEndingAtoms.AddItem(DesiredAtom);
				AnimParams.PlayRate = AnimationRateModifier;
				UnitPawn.m_fDistanceMovedAlongPath = Distance; // Since we are no longer following path but we know we are hitting our destination
				UnitPawn.bShouldRotateToward = false;
				UnitPawn.EnableRMA(true,true);
				UnitPawn.EnableRMAInteractPhysics(true);
				SwitchAnimNodeSequence = UnitPawn.GetAnimTreeController().PlayFullBodyDynamicAnim(AnimParams);

				// Jwats: Since we are playing the get in cover animation set our cover state
				Unit.SetUnitCoverState(PredictedCoverState);
				if ( PredictedCoverState != eCS_None && PredictedCoverIndex != -1 )
				{
					Unit.SetCoverDirectionIndex(PredictedCoverIndex);
				}

				//Shift any objects around that are using cosmetic physics
				if( PredictedCoverState != eCS_None )
				{
					SetTimer(0.5f, false, nameof(BumpCover));
				}
			}
		break;
	}

	LastAnimPlayRate = AnimParams.PlayRate;
}

// Check for hidden teleport (from no visibility to unit).  If so, we need to pull the end destination from the ability context input.
// Otherwise the final pop to the destination in MoveEnd will get overridden by an RMA in the stopping animation.
function vector GetEndDestinationForStopAnim()
{
	local int NumPathTiles;
	local TTile EndTile;

	if (bNextMoveIsEndMove && MoveEndAction != None)
	{
		if (!MoveEndAction.IgnoreDestinationMismatch && MoveEndAction.bHiddenTeleportToEndPos )
		{
			NumPathTiles = AbilityContext.InputContext.MovementPaths[MovePathIndex].MovementTiles.Length;
			EndTile = AbilityContext.InputContext.MovementPaths[MovePathIndex].MovementTiles[NumPathTiles - 1];
			return `XWORLD.GetPositionFromTileCoordinates(EndTile);
		}
	}
	return Destination;
}

function BumpCover()
{
	local XComDestructibleActor BumpActor;
	local vector BumpDirection;
	local vector BumpLocation;
	
	//Get the bump direction from the predicted cover state
	BumpDirection = `XWORLD.GetWorldDirection(`IDX_TO_DIR(Unit.m_FavorCoverIndex), false); 

	//The bump location source is the unit, minus a buffer accounting for curbs and low debris the unit may stand on
	BumpLocation = UnitPawn.Location; 
	BumpLocation.Z -= class'XComWorldData'.const.Cover_BufferDistance;
	
	//Walk a list of destructible actors within range of us, and attempt to apply an impulse to them. This is contingent 
	//on hitting with a ray built from the location and direction
	foreach WorldInfo.CollidingActors(class'XComDestructibleActor', BumpActor, 96.0f, UnitPawn.Location, true)
	{
		if( BumpActor.CollisionComponent != none && BumpActor.Physics == PHYS_RigidBody )
		{	
			BumpActor.BumpPhysics(BumpLocation, BumpDirection, 40.0f);
		}
	}
}

function CompleteAction()
{
	if (bIsFlying)
	{
		EndFlying();
	}
	// Ensure we reset our value
	UnitPawn.bShouldRotateToward = false;
	super.CompleteAction();
}

simulated state Executing
{
	simulated function BeginState(name nmPrev)
	{
		super.BeginState(nmPrev);
		
		StartDistance = UnitPawn.m_fDistanceMovedAlongPath;
		StartLocation = UnitPawn.Location;
	
		UnitPawn.m_fDistanceToStopExactly = Distance;		
	}

	simulated function bool ReachedDestination()
	{		
		return UnitPawn.m_fDistanceMovedAlongPath >= Distance;
	}

	simulated function SetMoveDirectionAndFocalPoint()
	{	
		UnitPawn.vMoveDirection = Normal(UnitPawn.Velocity);

		if( UnitPawn.Velocity.X == 0 && UnitPawn.Velocity.Y == 0 && UnitPawn.Velocity.Z == 0 )
		{
			UnitPawn.SetFocalPoint(UnitPawn.Location + Vector(UnitPawn.Rotation) * 128.0f);
		}
		else
		{ 
			UnitPawn.SetFocalPoint(UnitPawn.Location + (UnitPawn.vMoveDirection) * 128.0f);
		}
	}

	simulated function bool DoStopMoveAnimCheck()
	{
		local float fStopDist;

		if (PredictedCoverState == eCS_None)
		{
			fStopDist = UnitPawn.fStopDistanceNoCover;
		}
		else 
		{
			fStopDist = UnitPawn.fStopDistanceCover;
		}
			
		// Jwats: Don't do a run stop if we landed in this tile.
		if(Distance - UnitPawn.m_fDistanceMovedAlongPath <= fStopDist && bShouldUseWalkAnim == false && Distance - UnitPawn.m_fDistanceMovedAlongPath > 10.0f )
		{
			if (bShouldSkipStop)
			{
				UnitPawn.EnableRMA(true, true);
				UnitPawn.EnableRMAInteractPhysics(true);
				CompleteAction();
				return false;
			}

			// Should be playing stopmove anim now
			SwitchAnimation( eAnimStopping );
			return true;
		}

		return false;
	}


	simulated function bool DoTurnAnimCheck()
	{
		if( TurnQueue.Length != 0 )
		{
			// Only check the 0th turn since we know it comes first in the path
			if (TurnQueue[0].Distance - UnitPawn.m_fDistanceMovedAlongPath <= UnitPawn.fRunTurnDistance)
			{
				SwitchAnimation(eAnimRunTurn);
				
				// Jwats: Animation will put us at that distance on the path
				UnitPawn.m_fDistanceMovedAlongPath = TurnQueue[0].Distance;
				TurnQueue.Remove(0, 1);
				return true;
			}
		}

		return false;
	}

	function Tick(float dt)
	{
		local PathPoint CurrPoint, NextPoint;
		local int LocalPathIndex;

		// This flag is set when an action begins, and cleared when it ends. Unfortunately, multiple actions
		// can fire on the same visualizer now, so another action could clear the flag midway through this action.
		// Since skeletons that don't update don't process RMA, this unit will never move if they are not
		// currently rendering.
		// The correct solution to this problem is to make these calls either ref counted, or else handled
		// at the start and stop of an entire tree my the visualization manager itself, but for now this will do,
		// as those changes really should be part of another changelist.
		UnitPawn.SetUpdateSkelWhenNotRendered(true);

		if (SwitchAnimNodeSequence == none)
			return;

		if( CurrentlyRunFlinching )
		{
			if( UnitPawn.GetAnimTreeController().IsPlayingCurrentAnimation('MV_RunFlinch') )
			{
				RunFlinchCurrentTime += (dt * UnitPawn.CustomTimeDilation);
				if( RunFlinchCurrentTime >= RunFlinchDuration )
				{
					SwitchAnimation(eAnimRun);
				}
			}
			else
			{
				CurrentlyRunFlinching = false;
			}
		}
		else if( UnitPawn.m_kLastPhysicsState.m_ePhysics == PHYS_Walking )
		{
			LocalPathIndex = Unit.VisualizerUsePath.GetPathIndexFromPathDistance(UnitPawn.m_fDistanceMovedAlongPath);
			if( (LocalPathIndex + 1) >= Unit.CurrentMoveData.MovementData.Length ) // >= to handle the empty path case (such as a full teleport on a hidden unit)
			{
				SwitchAnimNodeSequence.Rate = LastAnimPlayRate;
			}
			else
			{
				CurrPoint = Unit.CurrentMoveData.MovementData[LocalPathIndex];
				NextPoint = Unit.CurrentMoveData.MovementData[LocalPathIndex + 1];

				if( abs(CurrPoint.Position.Z - NextPoint.Position.Z) > 64.0 )
				{
					SwitchAnimNodeSequence.Rate = LastAnimPlayRate * RunSlopeRateModifier;
				}
				else
				{
					SwitchAnimNodeSequence.Rate = LastAnimPlayRate;
				}
			}
		}
	}

Begin:
	if( ReachedDestination() )
	{
		//Make sure the character is in a good animation state if we pass through this code block
		if (bShouldUseWalkAnim)
		{
			Unit.IdleStateMachine.PlayIdleAnim();
		}
		else
		{
			DoStopMoveAnimCheck();
		}

		CompleteAction();
	}

	if( UnitPawn.bIsFemale ) //Enable left hand IK for females per direction from Hector
	{
		UnitPawn.EnableLeftHandIK(true);
	}

	SwitchAnimation(eAnimRun);
	bNoChangeRMA = true;	
	
	while (!ReachedDestination() && !IsTimedOut() && SwitchAnimNodeSequence.AnimSeq != None)
	{
		if (bNoChangeRMA)
		{
			if (UnitPawn.Mesh.RootMotionMode==RMM_Ignore)
			{
				`Warn("XGAction_Mode_Direct should be in Run Animation but RootMotionMode was set to RMM_Ignore!  Resetting Anim.");
				CurrentAnimState=eAnimNone; // Force animation change.
				SwitchAnimation( eAnimRun );
			}
		}

		if (UnitPawn.Physics == PHYS_None)
		{
			// This is bad, lets try to fix it
			UnitPawn.SetPhysics(PHYS_Walking);
			`log("Physics was none in Move_direct, fixing it back up",,'DevAnim');
		}

		if (DoTurnAnimCheck())
		{
			FinishAnim(SwitchAnimNodeSequence);
			SwitchAnimation(eAnimRun);
		}

		if( bNextMoveIsEndMove || bShouldSkipStop ) // If we are skipping the stop for an attack then our next move is not an end move
		{
			if (DoStopMoveAnimCheck())
			{
				FinishAnim(SwitchAnimNodeSequence);
			}
		}

		SetMoveDirectionAndFocalPoint();

		Sleep(0.0f);		
	}

	if(ReachedDestination() && bShouldUseWalkAnim)
	{
		// Since we are walking make sure we start our idle anim here.
		Unit.IdleStateMachine.PlayIdleAnim();
	}

	if( !ReachedDestination() && SwitchAnimNodeSequence.AnimSeq == None )
	{
		`RedScreen("X2Action_MoveDirect tried to play" @ SwitchAnimNodeSequence.AnimSeqName @ "but" @ UnitPawn.Name @ "can't play it.");
	}

	//If we timed out, see if we had an interrupt, and call it before we exit
	if(ExecutingTime >= TimeoutSeconds) 
	{
		`log("WARNING!!!!!! X2Action_MoveDirect timed out! Movement has gone off the rails and the unit had to be teleported to its correct location!");
		//Stop running Forrest. The move end node should take care of teleporting this lost unit to its destination.
		SwitchAnimation(eAnimStopping);
		FinishAnim(SwitchAnimNodeSequence);
	}
		
	SetMoveDirectionAndFocalPoint();

	if (!bSpawnForcedWalkIn)
	{
		//Adjust the destination Z so that units do not teleport to points higher than the ground ( looking at you ladder traversals )
		Destination.Z = `XWORLD.GetFloorZForPosition(Destination, true) + UnitPawn.CollisionHeight + class'XComWorldData'.const.Cover_BufferDistance;
	}
	
	UnitPawn.m_fDistanceMovedAlongPath = Distance;

	Sleep(0);

	if( UnitPawn.bIsFemale ) //Enable left hand IK for females per direction from Hector
	{
		UnitPawn.EnableLeftHandIK(false);
	}
		
	CompleteAction();
}

DefaultProperties
{
	TimeoutSeconds = 10.0f; //Should eventually be an estimate of how long we will run
	bShouldSkipStop = false;
}
