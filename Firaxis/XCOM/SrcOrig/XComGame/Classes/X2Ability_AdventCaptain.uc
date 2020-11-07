//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2Ability_AdventCaptain extends X2Ability
	config(GameData_SoldierSkills);

var config int MARK_TARGET_LOCAL_COOLDOWN;

var localized string TargetGettingMarkedFriendlyName;
var localized string TargetGettingMarkedFriendlyDesc;

var localized string StilettoRoundsName;
var localized string StilettoRoundsDesc;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(CreateMarkTargetAbility());
	Templates.AddItem(CreateAdventStilettoRoundsAbility());
	
	return Templates;
}

static function X2DataTemplate CreateMarkTargetAbility()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_Visibility TargetVisibilityCondition;
	local X2Condition_UnitEffects UnitEffectsCondition;
	local X2AbilityTarget_Single SingleTarget;
	local X2AbilityTrigger_PlayerInput InputTrigger;
	local X2Effect_Persistent MarkedEffect;
	local X2AbilityCooldown_LocalAndGlobal Cooldown;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MarkTarget');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_advent_marktarget";
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.Hostility = eHostility_Offensive;

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = default.MARK_TARGET_LOCAL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	// The shooter cannot be mind controlled
	UnitEffectsCondition = new class'X2Condition_UnitEffects';
	UnitEffectsCondition.AddExcludeEffect(class'X2Effect_MindControl'.default.EffectName, 'AA_UnitIsMindControlled');
	Template.AbilityShooterConditions.AddItem(UnitEffectsCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Target must be an enemy
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.RequireWithinRange = false;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	
	// Target must be visible and may use squad sight
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bAllowSquadsight = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	// Target cannot already be marked
	UnitEffectsCondition = new class'X2Condition_UnitEffects';
	UnitEffectsCondition.AddExcludeEffect(class'X2StatusEffects'.default.MarkedName, 'AA_UnitIsMarked');
	Template.AbilityTargetConditions.AddItem(UnitEffectsCondition);

	// 100% chance to hit
	Template.AbilityToHitCalc = default.DeadEye;

	SingleTarget = new class'X2AbilityTarget_Single';
	Template.AbilityTargetStyle = SingleTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	//// Create the Marked effect
	MarkedEffect = class'X2StatusEffects'.static.CreateMarkedEffect(2, false);

	Template.AddTargetEffect(MarkedEffect); //BMU - changing to an immediate execution for evaluation

	Template.CustomFireAnim = 'HL_SignalPoint';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TargetGettingMarked_BuildVisualization;
	Template.CinescriptCameraType = "Mark_Target";
//BEGIN AUTOGENERATED CODE: Template Overrides 'MarkTarget'
	Template.bFrameEvenWhenUnitIsHidden = true;
//END AUTOGENERATED CODE: Template Overrides 'MarkTarget'
	
	return Template;
}

simulated function TargetGettingMarked_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory				History;
	local XComGameStateContext_Ability		Context;
	local StateObjectReference				ShooterUnitRef;
	local StateObjectReference				TargetUnitRef;
	local XComGameState_Ability				Ability;
	local X2AbilityTemplate					AbilityTemplate;
	local AbilityInputContext				AbilityContext;
	
	local VisualizationActionMetadata		EmptyTrack;
	local VisualizationActionMetadata		ActionMetadata;

	local X2Action_PlaySoundAndFlyOver		SoundAndFlyOver;	
	local X2Action_PlayAnimation            PlayAnimation;

	local Actor								TargetVisualizer, ShooterVisualizer;
	local X2VisualizerInterface				TargetVisualizerInterface, ShooterVisualizerInterface;
	local int								EffectIndex;

	local name								ApplyResult;
	

	History = `XCOMHISTORY;
	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());

	AbilityContext = Context.InputContext;
	Ability = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.AbilityRef.ObjectID));
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(AbilityContext.AbilityTemplateName);
	
	//Configure the visualization track for the shooter
	//****************************************************************************************
	ShooterUnitRef = Context.InputContext.SourceObject;
	ShooterVisualizer = History.GetVisualizer(ShooterUnitRef.ObjectID);
	ShooterVisualizerInterface = X2VisualizerInterface(ShooterVisualizer);

	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(ShooterUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(ShooterUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(ShooterUnitRef.ObjectID);

	if (AbilityTemplate != None)
	{
		if (!AbilityTemplate.bSkipFireAction && !AbilityTemplate.bSkipExitCoverWhenFiring)
		{
			class'X2Action_ExitCover'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
		}
	}

	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Ability.GetMyTemplate().LocFlyOverText, '', eColor_Bad);

	PlayAnimation = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	PlayAnimation.Params.AnimName = 'HL_SignalPoint';

	if (AbilityTemplate != None && AbilityTemplate.AbilityTargetEffects.Length > 0)			//There are effects to apply
	{
		//Add any X2Actions that are specific to this effect being applied. These actions would typically be instantaneous, showing UI world messages
		//playing any effect specific audio, starting effect specific effects, etc. However, they can also potentially perform animations on the 
		//track actor, so the design of effect actions must consider how they will look/play in sequence with other effects.
		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
		{
			ApplyResult = Context.FindTargetEffectApplyResult(AbilityTemplate.AbilityTargetEffects[EffectIndex]);

			// Source effect visualization
			AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualizationSource(VisualizeGameState, ActionMetadata, ApplyResult);
		}
	}

	if (ShooterVisualizerInterface != none)
	{
		ShooterVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, ActionMetadata);
	}

	if (AbilityTemplate != None)
	{
		if (!AbilityTemplate.bSkipFireAction && !AbilityTemplate.bSkipExitCoverWhenFiring)
		{
			class'X2Action_EnterCover'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
		}
	}

		//****************************************************************************************

	//Configure the visualization track for the target
	//****************************************************************************************
	TargetUnitRef = Context.InputContext.PrimaryTarget;
	TargetVisualizer = History.GetVisualizer(AbilityContext.PrimaryTarget.ObjectID);
	TargetVisualizerInterface = X2VisualizerInterface(TargetVisualizer);

	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(TargetUnitRef.ObjectID);
					
	Ability = XComGameState_Ability(History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));

	if (AbilityTemplate != None && AbilityTemplate.AbilityTargetEffects.Length > 0)			//There are effects to apply
	{
		//Add any X2Actions that are specific to this effect being applied. These actions would typically be instantaneous, showing UI world messages
		//playing any effect specific audio, starting effect specific effects, etc. However, they can also potentially perform animations on the 
		//track actor, so the design of effect actions must consider how they will look/play in sequence with other effects.
		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
		{
			ApplyResult = Context.FindTargetEffectApplyResult(AbilityTemplate.AbilityTargetEffects[EffectIndex]);

			// Target effect visualization
			AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, ApplyResult);
		}

		if (TargetVisualizerInterface != none)
		{
			//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
			TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, ActionMetadata);
		}
	}
	
		//****************************************************************************************
}

// Trigger the Stiletto Rounds effect on any advent when the dark event Stiletto Rounds is active.  33% chance.
static function X2DataTemplate CreateAdventStilettoRoundsAbility()
{
	local X2AbilityTemplate			Template;
	local X2Condition_DarkEvent DarkEventCondition;
	local X2Effect_Persistent           PersistentEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AdventStilettoRounds');

//BEGIN AUTOGENERATED CODE: Template Overrides 'AdventStilettoRounds'
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_ammo_stiletto";
//END AUTOGENERATED CODE: Template Overrides 'AdventStilettoRounds'
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.AbilityToHitCalc = default.DeadEye;

	// Conditional depending on if the dark event is active.
	DarkEventCondition = new class'X2Condition_DarkEvent';
	DarkEventCondition.bStilettoRounds = true;
	Template.AbilityShooterConditions.AddItem(DarkEventCondition);

	// Add effect.
	PersistentEffect = new class'X2Effect_Persistent';
	PersistentEffect.EffectName = 'AdventStilettoRoundsEffect';
	PersistentEffect.BuildPersistentEffect(1, true, false);
	PersistentEffect.SetDisplayInfo( ePerkBuff_Bonus, default.StilettoRoundsName, default.StilettoRoundsDesc, Template.IconImage);
	PersistentEffect.ApplyChance = class'X2StrategyElement_XpackDarkEvents'.default.STILETTO_ROUNDS_CHANCE;
	Template.AddTargetEffect(PersistentEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	// Note: no visualization on purpose!

	return Template;
}

