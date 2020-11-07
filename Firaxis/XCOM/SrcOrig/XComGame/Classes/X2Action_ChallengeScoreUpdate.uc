//---------------------------------------------------------------------------------------
//  FILE:    X2Action_ChallengeScoreUpdate.uc
//  AUTHOR:  Russell Aasland
//  PURPOSE: Action for triggering visual changes to the challenge score
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2Action_ChallengeScoreUpdate extends X2Action;

var UIChallengeModeHUD ChallengeHUD;

var ChallengeModePointType ScoringType;
var int AddedPoints;

function Init(  )
{
	super.Init( );
}

event bool BlocksAbilityActivation( )
{
	local bool IsLadder;

	IsLadder = (`XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_LadderProgress', true ) != none);

	return !IsLadder;
}

//------------------------------------------------------------------------------------------------
simulated state Executing
{
	simulated event BeginState( Name PreviousStateName )
	{
		ChallengeHUD = `PRES.GetChallengeModeHUD();
	}

	simulated function MaybeAdvanceUnitSelection( )
	{
		local XComTacticalController TacticalController;
		local XComGameStateHistory History;
		local X2TacticalGameRuleset Ruleset;
		local bool bAvailableInputAction;
		local XComGameState_Unit ControllingUnitState;
		local GameRulesCache_Unit OutCacheData;
		local int ActionIndex;
		local AvailableAction CheckAction;

		TacticalController = XComTacticalController( `BATTLE.GetALocalPlayerController() );
		Ruleset = X2TacticalGameRuleset( `XCOMGAME.GameRuleset );
		History = `XCOMHISTORY;

		// if we're in tactical but it's not actually our turn, we shouldn't really bother
		if ((Ruleset != none) &&
			(Ruleset.GetCachedUnitActionPlayerRef().ObjectID != TacticalController.ControllingPlayerVisualizer.ObjectID))
		{
			return;
		}

		// set the new active player, or reenable the current active player.
		bAvailableInputAction = false;
		if (TacticalController.ControllingUnit.ObjectID > 0)
		{
			ControllingUnitState = XComGameState_Unit(History.GetGameStateForObjectID(TacticalController.ControllingUnit.ObjectID));
			if (ControllingUnitState != None && !ControllingUnitState.IsPanicked())
			{
				Ruleset.GetGameRulesCache_Unit(TacticalController.ControllingUnit, OutCacheData);
				for (ActionIndex = 0; ActionIndex < OutCacheData.AvailableActions.Length; ++ActionIndex)
				{
					CheckAction = OutCacheData.AvailableActions[ActionIndex];
					if (CheckAction.bInputTriggered && CheckAction.AvailableCode == 'AA_Success')
					{
						bAvailableInputAction = true;
						break;
					}
				}
			}
		}

		if (!bAvailableInputAction)
		{
			TacticalController.bManuallySwitchedUnitsWhileVisualizerBusy = true;

			//Switch control to the next unit if the current one has no actions left
			TacticalController.Visualizer_SelectNextUnit();
		}
	}

Begin:

	if (!`XCOMVISUALIZATIONMGR.VisualizerBlockingAbilityActivation())
	{
		MaybeAdvanceUnitSelection( );
	}

	if (ScoringType != CMPT_None && ScoringType != CMPT_TotalScore && !`REPLAY.bInReplay)
	{
		// Make sure that a banner isn't already in flight
		while (ChallengeHUD.IsWaitingForBanner())
		{
			Sleep(0.0f);
		}

		ChallengeHUD.UpdateChallengeScore(ScoringType, AddedPoints);
		Sleep(0.1f);
		ChallengeHUD.TriggerChallengeBanner();

		while (ChallengeHUD.IsWaitingForBanner())
		{
			Sleep(0.0f);
		}
	}
	
	CompleteAction( );
}

defaultproperties
{
	TimeoutSeconds = 20;
}