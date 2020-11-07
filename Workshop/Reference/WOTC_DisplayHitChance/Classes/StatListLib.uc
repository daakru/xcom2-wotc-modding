//-----------------------------------------------------------
//	Class:	StatListLib
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------


class StatListLib extends Object;

//var localized string KILLS_LABEL; Can get from UIAfterAction_ListItem
//var localized string ASSIST_LABEL; Can get from UITacticalHUD_SoldierInfoTooltip_HitChance
//var localized string FLANKING_CRIT_LABEL;

`define BASESTAT(STAT) Summary.base`STAT
`define CURRENTSTAT(STAT) Summary.`STAT

`define BASECURRENTSTAT(STAT) `BASESTAT(`STAT), `CURRENTSTAT(`STAT)
`define NONZERO(STAT) (`CURRENTSTAT(`STAT)!=0 || `BASESTAT(`STAT)!=0)

var localized string HackDefenseLabel;

struct EUISummary_UnitStats_HitChance extends UIQueryInterfaceUnit.EUISummary_UnitStats
{
	var int BaseAim;
	var int BaseTech;
	var int BaseDefense;
	var int BaseDodge;
	var int BaseArmor;
	var int BasePsiOffense;
	var int BaseMobility;
	var int BaseCrit, Crit;
	var int BaseArmorPiercing, ArmorPiercing;
	var int BaseHackDefense, HackDefense;
};

static simulated function array<UISummary_ItemStat> GetStats(XComGameState_Unit kGameStateUnit, optional bool Xcom=false)
{
	local array<UISummary_ItemStat> Stats; 
	local UISummary_ItemStat Item; 
	local EUISummary_UnitStats_HitChance Summary;
	local WeaponDamageValue WeapDam;
	local int MinDam, MaxDam;//Mr. Nice: "t" for Temporary
	local XComGameState_Unit BackInTimeGameStateUnit;

	Summary = GetUISummary_UnitStats(kGameStateUnit);

	if (!Xcom)
	{
		WeapDam=X2WeaponTemplate(kGameStateUnit.GetPrimaryWeapon().GetMyTemplate()).BaseDamage;

		//Hack!
		//Title.SetHTMLText( class'UIUtilities_Text'.static.StyleText(Summary.UnitName, eUITextStyle_Tooltip_Title) );
	
		MinDam=WeapDam.Damage-WeapDam.Spread;
		MaxDam=WeapDam.Damage+WeapDam.Spread+int(bool(WeapDam.PlusOne));

		if (MinDam==MaxDam) Item.Value=string(WeapDam.Damage);
		else Item.Value=MinDam $ "-" $ MaxDam;
	
		Item.Label = class'XLocalizedData'.default.DamageLabel;
		//Item.Value = string(X2WeaponTemplate(kGameStateUnit.GetPrimaryWeapon().GetMyTemplate()).BaseDamage.Damage);
		Stats.AddItem(Item); 

		Item.Label = class'WOTC_DisplayHitChance_UITacticalHUD_ShotWings'.default.CRIT_DAMAGE_LABEL;
		Item.Value = StatChange(0, WeapDam.Crit);
		Stats.AddItem(Item); 

		//Item.Label = default.PrimaryPlusOne;
		//Item.Value = string(X2WeaponTemplate(kGameStateUnit.GetPrimaryWeapon().GetMyTemplate()).BaseDamage.PlusOne);
		//Stats.AddItem(Item);

		Item.Label = class'XLocalizedData'.default.AimLabel;
		Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Aim), "%"); 
		Stats.AddItem(Item);
	
		if (`NONZERO(Crit))
		{
			Item.Label = class'XLocalizedData'.default.CritChanceLabel;
			Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Crit), "%");
			Stats.AddItem(Item);
		}

		if (`NONZERO(ArmorPiercing))
		{
			Item.Label = class'XLocalizedData'.default.PierceLabel;
			Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(ArmorPiercing));
			Stats.AddItem(Item);
		}
	}

	Item.Label = class'XLocalizedData'.default.HealthLabel;
	Item.Value = class'UIUtilities_Text'.static.GetColoredText(Summary.CurrentHP $"/" $Summary.MaxHP, ColorHP(Summary.CurrentHP, Summary.MaxHP)); 
	Stats.AddItem(Item);

	if (`NONZERO(Armor))
	{
		Item.Label = class'XLocalizedData'.default.ArmorLabel;
		Item.Value = string(Summary.Armor);
		Stats.AddItem(Item);
	}

	if (Xcom)
	{
		Item.Label = class'XLocalizedData'.default.AimLabel;
		Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Aim), "%"); 
		Stats.AddItem(Item);
	
		if (`NONZERO(Crit))
		{
			Item.Label = class'XLocalizedData'.default.CritLabel;
			Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Crit), "%");
			Stats.AddItem(Item);
		}

		if (`NONZERO(ArmorPiercing))
		{
			Item.Label = class'XLocalizedData'.default.PierceLabel;
			Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(ArmorPiercing));
			Stats.AddItem(Item);
		}
	}

	if (`NONZERO(Defense))
	{
		Item.Label = class'XLocalizedData'.default.DefenseLabel;
		Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Defense), "%");  
		Stats.AddItem(Item);
	}

	if (`NONZERO(Dodge))
	{
		Item.Label = class'XLocalizedData'.default.DodgeLabel;
		Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Dodge), "%");
		Stats.AddItem(Item);
	}

	Item.Label = class'XLocalizedData'.default.MobilityLabel;
	Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Mobility));
	Stats.AddItem(Item);

	if (Summary.CurrentWill!=0 || Summary.MaxWill!=0)
	{
		Item.Label = class'XLocalizedData'.default.WillLabel; 
		if (Xcom) Item.Value = class'UIUtilities_Text'.static.GetColoredText(Summary.CurrentWill $"/" $Summary.MaxWill, ColorHP(Summary.CurrentWill, Summary.MaxWill)); 
		else Item.Value = ColorAndStringForStats(Summary.MaxWill, Summary.CurrentWill);  
		Stats.AddItem(Item);
	}

	if (`NONZERO(PsiOffense))
	{
		Item.Label = class'XLocalizedData'.default.PsiOffenseLabel; 
		Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(PsiOffense));
		Stats.AddItem(Item); 
	}

	if (`NONZERO(HackDefense))
	{
		// Preferring Localization method so we don't have to test all languages...
		Item.Label = default.HackDefenseLabel;
		//Item.Label = class'XLocalizedData'.default.TechLabel @ class'XLocalizedData'.default.DefenseLabel; 
		Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(HackDefense)); 
		Stats.AddItem(Item);
	}

	if (`NONZERO(Tech))
	{
		Item.Label = class'XLocalizedData'.default.TechLabel; 
		Item.Value = ColorAndStringForStats(`BASECURRENTSTAT(Tech)); 
		Stats.AddItem(Item);
	}

	if (Xcom)
	{
		BackInTimeGameStateUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kGameStateUnit.ObjectID, , 1));

		Item.Label = class'UIAfterAction_ListItem'.default.m_strKillsLabel;
		Item.Value = ColorAndStringForStats(BackInTimeGameStateUnit.GetNumKills(), kGameStateUnit.GetNumKills(), "+");
		Stats.AddItem(Item);

		Item.Label = class'UITacticalHUD_SoldierInfoTooltip_HitChance'.default.ASSIST_LABEL;
		Item.Value = ColorAndStringForStats(BackInTimeGameStateUnit.GetNumKillsFromAssists(), kGameStateUnit.GetNumKillsFromAssists(), "+");
		Stats.AddItem(Item);
	}

	return Stats;
}

static function EUISummary_UnitStats_HitChance GetUISummary_UnitStats(XComGameState_Unit Unit)
{
	local XComGameStateHistory History;
	local XComGameState_Effect EffectState;
	local StateObjectReference EffectRef;
	local X2Effect_Persistent EffectTemplate;

	local EUISummary_UnitStats_HitChance Summary;

	Summary=Unit.GetUISummary_UnitStats();

	
	Summary.BaseAim=Unit.GetBaseStat(eStat_Offense);
	Summary.BaseTech=Unit.GetBaseStat(eStat_Hacking);
	Summary.BaseDefense=Unit.GetBaseStat(eStat_Defense);
	Summary.BaseDodge=Unit.GetBaseStat(eStat_Dodge);
	Summary.BaseArmor=Unit.GetBaseStat(eStat_ArmorMitigation);
	Summary.BasePsiOffense=Unit.GetBaseStat(eStat_PsiOffense);
	Summary.BaseMobility=Unit.GetBaseStat(eStat_Mobility);
	Summary.BaseCrit=Unit.GetBaseStat(eStat_CritChance);
	Summary.BaseArmorPiercing=Unit.GetBaseStat(eStat_ArmorPiercing);
	Summary.BaseHackDefense=Unit.GetBaseStat(eStat_HackDefense);

	Summary.Crit=Unit.GetCurrentStat(eStat_CritChance);
	Summary.ArmorPiercing=Unit.GetCurrentStat(eStat_ArmorPiercing);
	Summary.HackDefense=Unit.GetCurrentStat(eStat_HackDefense);

	History = `XCOMHISTORY;
	foreach Unit.AffectedByEffects(EffectRef)
	{
		EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
		if (EffectState != none)
		{
			EffectTemplate = EffectState.GetX2Effect();
			EffectTemplate.ModifyUISummaryUnitStats(EffectState, unit, eStat_CritChance, Summary.Crit);
			EffectTemplate.ModifyUISummaryUnitStats(EffectState, unit, eStat_ArmorPiercing, Summary.ArmorPiercing);
			EffectTemplate.ModifyUISummaryUnitStats(EffectState, unit, eStat_HackDefense, Summary.HackDefense);
			EffectTemplate.ModifyUISummaryUnitStats(EffectState, unit, eStat_ArmorMitigation, Summary.Armor);
			EffectTemplate.ModifyUISummaryUnitStats(EffectState, unit, eStat_Mobility, Summary.Mobility);
		}
	}
	return Summary;
}
	
static function string ColorAndStringForStats(int statbase, int statcurrent, optional string Suffix="") {
	//local eUIState Tcolor;
	//local string CText;
	local String CurrentText, BaseText; 

	//CText = "(" $ StatChange(statbase, statcurrent) $ Suffix $ ")"; 
	switch (Suffix)
	{
		case "/":
			CurrentText=class'UIUtilities_Text'.static.GetColoredText(string(statCurrent), StatChangeColor(statbase, statcurrent));
			BaseText=Suffix $ StatBase;
			break;
		case "+":
			CurrentText=string(statcurrent);
			BaseText=class'UIUtilities_Text'.static.GetColoredText("(" $ StatChange(statbase, statcurrent) $ ")", StatChangeColor(statbase, statcurrent));
			break;
		default:
			 CurrentText=class'UIUtilities_Text'.static.GetColoredText(statCurrent $ Suffix, StatChangeColor(statbase, statcurrent));
			 BaseText="(" $ StatBase $ Suffix $ ")";
	}
	if ((statbase - statcurrent) == 0)
		return CurrentText;
	else return CurrentText $ BaseText;
} 

static function string StatChange(int statbase, int statcurrent) {
	if (statbase > statcurrent) 
		return "-" $ (statbase - statcurrent);
	else
		return "+" $ (statcurrent - statbase);
}

static function eUIState ColorHP(float CurrentHP, int MaxHP) {
	if (CurrentHP/MaxHP > 2/3) 
		return eUISTate_Good;
	else if (CurrentHP/MaxHP > 1/3) 
		return eUIState_Warning;
	else 
		return eUIState_Bad;
}

static function eUIState StatChangeColor(int BaseStat, int CurrentStat) {
	if (BaseStat==CurrentStat)
		return eUIState_Normal;
	if (BaseStat > CurrentStat) 
		return eUIState_Bad;
	else 
		return eUIState_Good;
}
