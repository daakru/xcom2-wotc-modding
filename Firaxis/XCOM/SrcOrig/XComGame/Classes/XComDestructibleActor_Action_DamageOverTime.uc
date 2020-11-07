class XComDestructibleActor_Action_DamageOverTime extends XComDestructibleActor_Action
	native(Destruction)
	dependson(XComDestructibleActor);

var(XComDestructibleActor_Action) int NumTurns<Tooltip="Number of turns to take before destroying the destructible actor.">;


cpptext
{
public:
	virtual void GetDynamicListValues( const FString& ListName, TArray<FString>& Values );
}

// Called when it is time for this event to fire
event PreActivateResponse()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameState_Effect NewEffect;
	local EffectAppliedData EffectParams;
	local XComGameState_Destructible DestructibleState;

	super.PreActivateResponse( );

	if (`XWORLD.bSyncingVisualizer)
	{
		return; // when we're syncing, this effect should already be part of the gamestate history.  no need to add it again.
	}

	History = `XCOMHISTORY;

	NewGameState = History.CreateNewGameState( true, class'XComGameStateContext_ChangeContainer'.static.CreateXComGameStateContext() );

	if (Outer.ObjectID <= 0)
	{
		DestructibleState = XComGameState_Destructible(NewGamestate.CreateNewStateObject( class'XComGameState_Destructible' ));
		DestructibleState.SetInitialState( Outer );
	}

	NewEffect = XComGameState_Effect( NewGameState.CreateNewStateObject( class'XComGameState_Effect' ) );
	EffectParams.SourceStateObjectRef.ObjectID = Outer.ObjectID;
	EffectParams.TargetStateObjectRef.ObjectID = Outer.ObjectID;
	EffectParams.PlayerStateObjectRef = `TACTICALRULES.GetCachedUnitActionPlayerRef();
	EffectParams.EffectRef.LookupType = TELT_PersistantEffect;
	EffectParams.EffectRef.SourceTemplateName = 'X2Effect_DelayedDestruction';

	NewEffect.PostCreateInit( EffectParams, eGameRule_PlayerTurnBegin, NewGameState );
	NewEffect.iTurnsRemaining = NumTurns; // duration is determined by the action and not the template

	`TACTICALRULES.SubmitGameState( NewGameState );
}

native function Activate();
native function Tick(float DeltaTime);

defaultproperties
{
	NumTurns=1;
}
