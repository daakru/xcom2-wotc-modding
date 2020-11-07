class X2Effect_DisableWeapon extends X2Effect
	config(GameCore);

var localized string DisabledWeapon;
var localized string FailedDisable;

var config array<name> HideVisualizationOfResults;
var config array<name> WeaponsImmuneToDisable;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit TargetUnit;
	local XComGameState_Item WeaponState, NewWeaponState;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (TargetUnit != none)
	{
		WeaponState = TargetUnit.GetItemInSlot(eInvSlot_PrimaryWeapon, NewGameState);
		if (WeaponState != none)
		{
			NewWeaponState = XComGameState_Item(NewGameState.ModifyStateObject(WeaponState.Class, WeaponState.ObjectID));
			NewWeaponState.Ammo = 0;
		}
	}
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;

	if( XComGameState_Unit(ActionMetadata.StateObject_NewState) != none )
	{
		if (default.HideVisualizationOfResults.Find(EffectApplyResult) != INDEX_NONE)
		{
			return;
		}

		// Must be a unit in order to have this occur
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));

		if (EffectApplyResult == 'AA_Success')
		{
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, default.DisabledWeapon, '', eColor_Bad);
		}
		else
		{
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, default.FailedDisable, '', eColor_Good);
		}
	}
}

function name CheckWeaponImmunities(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState)
{
	local XComGameState_Unit TargetUnit;
	local XComGameState_Item WeaponState;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (TargetUnit != none)
	{
		WeaponState = TargetUnit.GetItemInSlot(eInvSlot_PrimaryWeapon, NewGameState);
		if ((WeaponState != none) &&
			(default.WeaponsImmuneToDisable.Find(WeaponState.GetMyTemplateName()) != INDEX_NONE))
		{
			return 'AA_UnitIsImmune';
		}
	}

	return 'AA_Success';
}

defaultproperties
{
	ApplyChanceFn=CheckWeaponImmunities
}