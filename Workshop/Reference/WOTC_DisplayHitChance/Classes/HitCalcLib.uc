// This is an Unreal Script

//Mr. Nice: Only reason subclassing X2AbilityToHitCalc_RollStatTiers is to stop bleating about protected function/variable access!!
class HitCalcLib extends X2AbilityToHitCalc_RollStatTiers;

static function int GetShotBreakdownPast(XComGameState_Ability AbilityState, AvailableTarget kTarget, optional out ShotBreakdown kBreakdown, optional int HistoryIndex=-1)
{
	local X2AbilityTemplate AbilityTemplate;
	
	AbilityTemplate=AbilityState.GetMyTemplate();
	if (AbilityTemplate != None && AbilityTemplate.AbilityToHitCalc != none)
		return GetShotBreakdownH(AbilityTemplate.AbilityToHitCalc, AbilityState, kTarget, kBreakdown, HistoryIndex);

	//If there's no AbilityToHitCalc, don't show a breakdown. (Example: doors.)
	kBreakdown.HideShotBreakdown = true;
	return 0;
}

static function int GetShotBreakdownH(X2AbilityToHitCalc HitCalc, XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional int HistoryIndex=-1)
{
	if ( X2AbilityToHitCalc_DeadEye(HitCalc)!=none
		|| X2AbilityToHitCalc_PercentChance(HitCalc)!=none && X2AbilityToHitCalc_PercentChancePlusFocus(HitCalc)==none
		|| X2AbilityToHitCalc_SeeMovement(HitCalc)!=none )
		return HitCalc.GetShotBreakDown(kAbility, kTarget, m_ShotBreakdown);

	return GetHitChanceH(HitCalc, kAbility, kTarget, m_ShotBreakdown, HistoryIndex);
}

static function int GetHitChanceH(X2AbilityToHitCalc HitCalc, XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional int HistoryIndex=-1)
{
	local X2AbilityToHitCalc_RollStat HitCalcStat;
	local X2AbilityToHitCalc_RollStatTiers HitCalcTier;
	local X2AbilityToHitCalc_PercentChancePlusFocus HitCalcFocus;
	local X2AbilityToHitCalc_StasisLance HitCalcLance;
	local X2AbilityToHitCalc_StandardAim HItCalcStandard;

	local XComGameState_Unit UnitState;
	local ShotBreakdown EmptyShotBreakdown;
	local int FinalHitChance;


	//Want to get subclasses (espeically of standard aim!) so can't just switch on .classname
	HitCalcStat=X2AbilityToHitCalc_RollStat(HitCalc);
	if (HitCalcStat!=none)
	{
		m_ShotBreakdown = EmptyShotBreakdown;
	
		HitCalcStat.AddModifier(HitCalcStat.BaseChance, class'XLocalizedData'.default.BaseChance, m_ShotBreakdown, eHit_Success);

		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID,, HistoryIndex));
		if (UnitState != None)
		{
			HitCalcStat.AddModifier(UnitState.GetCurrentStat(HitCalcStat.StatToRoll), class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[HitCalcStat.StatToRoll], m_ShotBreakdown, eHit_Success);
		}
		return m_ShotBreakdown.FinalHitChance;		
	}

	HitCalcTier=X2AbilityToHitCalc_RollStatTiers(HitCalc);
	if (HitCalcTier!=none)
	{
		FinalHitChance = 0;

		if (HitCalcTier.StatContestTiers.Length > 0)
		{
			FinalHitChance = HitCalcTier.StatContestTiers[HitCalcTier.StatContestTiers.Length - 1].BasePercentChance;

			UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kTarget.PrimaryTarget.ObjectID,, HistoryIndex));
			if ((UnitState != None) && HitCalcTier.StatContestTiers[HitCalcTier.StatContestTiers.Length - 1].bUseStatInCheck)
			{
				FinalHitChance -= UnitState.GetCurrentStat(HitCalcTier.StatToRoll);
			}
		}
		return FinalHitChance;
	}

	HitCalcFocus=X2AbilityToHitCalc_PercentChancePlusFocus(HitCalc);
	if (HitCalcFocus!=none)
	{
		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID,, HistoryIndex));
		m_ShotBreakdown.FinalHitChance = HitCalcFocus.PercentToHit + (UnitState.GetTemplarFocusLevel() * HitCalcFocus.FocusMultiplier);
		return m_ShotBreakdown.FinalHitChance;
	}

	HitCalcLance=X2AbilityToHitCalc_StasisLance(HitCalc);
	if (HitCalcLance!=none)
	{
		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kTarget.PrimaryTarget.ObjectID,, HistoryIndex));
		m_ShotBreakdown = EmptyShotBreakdown;

		if (UNitState != none && !`XENGINE.IsMultiplayerGame())
		{
			HitCalcLance.AddModifier(HitCalcLance.default.BASE_CHANCE, class'XLocalizedData'.default.BaseChance, m_ShotBreakdown, eHit_Success);
			HitCalcLance.FinalizeHitChance(m_ShotBreakdown);
		}
		return m_ShotBreakdown.FinalHitChance;
	}

	//Standard Aim is a big enough beast to get its own function call
	HitCalcStandard=X2AbilityToHitCalc_StandardAim(HitCalc);
	if (HitCalcStandard!=none)
		return class'HitCalcLib2'.static.GetHitChanceStandardAim(HitCalcStandard, kAbility, kTarget, m_ShotBreakdown, HistoryIndex);
	
	//Not one of the cases we are considering, so let it do its thing
	return HitCalc.GetHitChance(kAbility, kTarget, m_ShotBreakdown);
}

