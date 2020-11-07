//-----------------------------------------------------------
//	Class:	UITacticalHUD_Enemies_HitChance
//	Author: tjnome / Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class UITacticalHUD_Enemies_HitChance extends UITacticalHUD_Enemies;

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

var bool TH_AIM_ASSIST;
var bool DISPLAY_MISS_CHANCE;

simulated function int GetHitChanceForObjectRef(StateObjectReference TargetRef) {
	local AvailableAction Action;
	local ShotBreakdown Breakdown;
	local X2TargetingMethod TargetingMethod;
	local XComGameState_Ability AbilityState;
	local int AimBonus, HitChance;

	//If a targeting action is active and we're hoving over the enemy that matches this action, then use action percentage for the hover  
	TargetingMethod = XComPresentationLayer(screen.Owner).GetTacticalHUD().GetTargetingMethod();

	if(TargetingMethod != none && TargetingMethod.GetTargetedObjectID() == TargetRef.ObjectID)
	{
		AbilityState = TargetingMethod.Ability;
	}
	else
	{			
		AbilityState = XComPresentationLayer(Movie.Pres).GetTacticalHUD().m_kAbilityHUD.GetCurrentSelectedAbility();

		if(AbilityState == None) {
			XComPresentationLayer(Movie.Pres).GetTacticalHUD().m_kAbilityHUD.GetDefaultTargetingAbility(TargetRef.ObjectID, Action, true);
			AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(Action.AbilityObjectRef.ObjectID));
		}
	}

	if(AbilityState != none)
	{
		AbilityState.LookupShotBreakdown(AbilityState.OwnerStateObject, TargetRef, AbilityState.GetReference(), Breakdown);
		
		if(!Breakdown.HideShotBreakdown)
		{
			AimBonus = 0;
			HitChance = Breakdown.bIsMultishot ? Breakdown.MultiShotHitChance : Breakdown.FinalHitChance;
			if (GetTH_AIM_ASSIST()) {
				AimBonus =WOTC_DisplayHitChance_UITacticalHUD_ShotWings(UITacticalHUD(Screen).m_kShotInfoWings).GetModifiedHitChance(AbilityState, HitChance);
			}

			if (getDISPLAY_MISS_CHANCE())
				HitChance = 100 - (AimBonus + HitChance);
			else
				HitChance = AimBonus + HitChance;
				
			return Clamp(HitChance, 0, 100);
	    }
	}

	return -1;
}

`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)

function bool GetTH_AIM_ASSIST() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_AIM_ASSIST, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_AIM_ASSIST);
}

function bool GetDISPLAY_MISS_CHANCE() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DISPLAY_MISS_CHANCE, class'WOTC_DisplayHitChance_MCMScreen'.default.DISPLAY_MISS_CHANCE);
}
