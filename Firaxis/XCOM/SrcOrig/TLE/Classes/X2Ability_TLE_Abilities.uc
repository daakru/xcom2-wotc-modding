class X2Ability_TLE_Abilities extends X2Ability
	config(GameData_SoldierSkills);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem( CreateLadderUnkillable() );

	return Templates;
}

static function X2AbilityTemplate CreateLadderUnkillable()
{
	local X2AbilityTemplate Template;
	local X2Effect_Unkillable UnkillableEffect;
	local X2Effect_SetUnitValue SetUnitValue;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LadderUnkillable');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_none";
	Template.bDontDisplayInAbilitySummary = true;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bIsPassive = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	UnkillableEffect = new class'X2Effect_Unkillable';
	UnkillableEffect.AdditionalEffectsFN = LadderUnkillableUnconsciousness;
	Template.AddTargetEffect( UnkillableEffect );

	SetUnitValue = new class'X2Effect_SetUnitValue';
	SetUnitValue.UnitName = 'AllowedAbility_KnockoutSelf';
	SetUnitValue.NewValueToSet = 1;
	SetUnitValue.CleanupType = eCleanup_Never;
	Template.AddTargetEffect(SetUnitValue);

	SetUnitValue = new class'X2Effect_SetUnitValue';
	SetUnitValue.UnitName = 'LadderUnkillable';
	SetUnitValue.NewValueToSet = 1;
	SetUnitValue.CleanupType = eCleanup_Never;
	Template.AddTargetEffect(SetUnitValue);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	// Note: no visualization on purpose!

	return Template;
}

static function LadderUnkillableUnconsciousness( XComGameState NewGameState, XComGameState_Unit Unit )
{
	local X2EventManager EventManager;
	local Object TriggerObj;

	EventManager = `XEVENTMGR;
	TriggerObj = Unit;

	EventManager.RegisterForEvent( TriggerObj, 'LadderUnkillableTriggered', TriggerUnconscious, ELD_OnStateSubmitted, 50, , , Unit );
	EventManager.TriggerEvent('LadderUnkillableTriggered', Unit, Unit, NewGameState);
}

static function EventListenerReturn TriggerUnconscious(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit Unit;
	local X2EventManager EventManager;

	Unit = XComGameState_Unit( CallbackData );

	EventManager = `XEVENTMGR;
	EventManager.UnRegisterFromEvent( CallbackData, 'LadderUnkillableTriggered', ELD_OnStateSubmitted, TriggerUnconscious );

	class'XComGameStateContext_Ability'.static.ActivateAbilityByTemplateName( Unit.GetReference(), 'KnockoutSelf', Unit.GetReference() );

	return ELR_NoInterrupt;
}