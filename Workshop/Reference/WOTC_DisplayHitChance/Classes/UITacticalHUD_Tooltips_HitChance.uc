//-----------------------------------------------------------
//	Class:	UITacticalHUD_Tooltips_HitChance
//	Author: tjnome / Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class UITacticalHUD_Tooltips_HitChance extends UITacticalHUD_Tooltips;

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

var bool ES_TOOLTIP;
var int TOOLTIP_ALPHA;

simulated function InitializeTooltipData()
{
	local UITacticalHUD_WeaponTooltip WeaponTooltip;
	//local UITacticalHUD_BackPackTooltip BackpackTooltip;
	local UITacticalHUD_SoldierInfoTooltip SoldierInfoTooltip;
	//local UITacticalHUD_HackingTooltip HackingTooltip;
	local UITacticalHUD_EnemyTooltip_HitChance EnemyTooltip;
	local UITacticalHUD_EnemyAbilityTooltip EnemyAbilityTooltip;
	local UITacticalHUD_PerkTooltip PerkTooltip;
	local UITacticalHUD_BuffsTooltip_HitChance EnemyPassivesTooltip;
	local UITacticalHUD_AbilityTooltip AbilityTooltip;
	local UITacticalHUD_BuffsTooltip_HitChance EnemyBonusesTooltip;
	local UITacticalHUD_BuffsTooltip_HitChance EnemyPenaltiesTooltip;
	local UITacticalHUD_BuffsTooltip SoldierBonusesTooltip;
	local UITacticalHUD_BuffsTooltip SoldierPenaltiesTooltip;

	ES_TOOLTIP = getES_TOOLTIP();
	TOOLTIP_ALPHA = getTOOLTIP_ALPHA();

	EnemyStats = new class'UITooltipGroup_Share';

	// Weapon tooltip ---------------------------------------------------------------------
	WeaponTooltip = Spawn(class'UITacticalHUD_WeaponTooltip', Movie.Pres.m_kTooltipMgr); 
	WeaponTooltip.InitWeaponStats('TooltipWeaponStats');

	WeaponTooltip.AmmoInfoList.Remove();
	WeaponTooltip.AmmoInfoList = WeaponTooltip.Spawn(class'UITooltipInfoList_HitChance', WeaponTooltip.Container).InitTooltipInfoList('AmmoPanelInfoList',,,, WeaponTooltip.Width, WeaponTooltip.OnChildPanelSizeRealized);

	WeaponTooltip.UpgradeInfoList.Remove();
	WeaponTooltip.UpgradeInfoList = WeaponTooltip.Spawn(class'UITooltipInfoList_HitChance', WeaponTooltip.Container).InitTooltipInfoList('UpgradePanelInfoList',,,, WeaponTooltip.Width, WeaponTooltip.OnChildPanelSizeRealized);
	
	WeaponTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_BOTTOM_RIGHT);
	WeaponTooltip.SetPosition(-20, -150);
	WeaponTooltip.bFollowMouse = false;

	WeaponTooltip.targetPath = string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kInventory.m_kWeapon.MCPath); 
	WeaponTooltip.SetAlpha(TOOLTIP_ALPHA);

	WeaponTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip(WeaponTooltip);

	// Unit Stats tooltip ------------------------------------------------------------------
	SoldierInfoTooltip = Spawn(class'UITacticalHUD_SoldierInfoTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
	SoldierInfoTooltip.InitSoldierStats('TooltipSoldierStats');

	SoldierInfoTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_BOTTOM_LEFT);
	SoldierInfoTooltip.SetPosition(35 , -180 - SoldierInfoTooltip.height);
	SoldierInfoTooltip.bFollowMouse = false;

	SoldierInfoTooltip.targetPath = string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kStatsContainer.MCPath);

	SoldierInfoTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip(SoldierInfoTooltip);

	// Hacking  Stats tooltip **DEPRECATED** -----------------------------------------------
	/*
	HackingTooltip = Spawn(class'UITacticalHUD_HackingTooltip', Movie.Pres.m_kTooltipMgr); 
	HackingTooltip.InitHackingStats('TooltipHackingStats');

	HackingTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_BOTTOM_RIGHT);
	HackingTooltip.SetPosition(-20 - HackingTooltip.width , -210 - HackingTooltip.height);

	HackingTooltip.targetPath =  string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kEnemyTargets.MCPath);

	HackingTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip( HackingTooltip );
	*/

	// Enemy Stats tooltip ------------------------------------------------------------------
	// dburchanowski - Oct 16, 2015: Disabling, but leaving here in case Jake wants it back before we ship
	If (ES_TOOLTIP) {
		EnemyTooltip = Spawn(class'UITacticalHUD_EnemyTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
		EnemyTooltip.InitEnemyStats('TooltipEnemyStats');

		//EnemyTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_TOP_RIGHT);
		//EnemyTooltip.SetPosition(-8, 55);
		//EnemyTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_NONE);
		EnemyTooltip.SetPosition(Movie.ConvertNormalizedScreenCoordsToUICoords(1, 1).X-20, 56);
		//EnemyTooltip.SetPosition(Movie.m_v2ScaledDimension.X - 20 - EnemyTooltip.width, Movie.m_v2ScaledDimension.Y - 450 - EnemyTooltip.height);

		//EnemyTooltip.bFollowMouse = false;

		EnemyTooltip.targetPath = string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kEnemyTargets.MCPath);
		EnemyTooltip.bUsePartialPath = true; 

		EnemyTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip(EnemyTooltip);
		
		// Enemy Abilities tooltip ------------------------------------------------------------------
		EnemyAbilityTooltip = Spawn(class'UITacticalHUD_EnemyAbilityTooltip', Movie.Pres.m_kTooltipMgr); 
		EnemyAbilityTooltip.InitEnemyAbilities('TooltipEnemyAbilityStats');

		//EnemyAbilityTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_TOP_RIGHT);
		EnemyAbilityTooltip.SetPosition(Movie.ConvertNormalizedScreenCoordsToUICoords(1, 1).X -20 - EnemyAbilityTooltip.width, EnemyTooltip.Y + EnemyTooltip.height + 10);

		//EnemyAbilityTooltip.bFollowMouse = false;

		EnemyAbilityTooltip.targetPath = string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kEnemyTargets.MCPath);
		EnemyAbilityTooltip.bUsePartialPath = true; 

		EnemyAbilityTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip(EnemyAbilityTooltip);
		
		// Enemy Passives tooltip ------------------------------------------------------------------
		EnemyPassivesTooltip = Spawn(class'UITacticalHUD_BuffsTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
		EnemyPassivesTooltip.bShowPassive=true;
		EnemyPassivesTooltip.InitBonusesAndPenalties('TooltipEnemyPassives',,false, false, Movie.m_v2ScaledDimension.X - 160, Movie.m_v2ScaledDimension.Y - 400, true);

		EnemyPassivesTooltip.targetPath =  string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kEnemyTargets.MCPath); 
		EnemyPassivesTooltip.bUsePartialPath = true; 

		EnemyPassivesTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip(EnemyPassivesTooltip );

	}



	// Soldier Passives tooltip ------------------------------------------------------------------
	PerkTooltip = Spawn(class'UITacticalHUD_PerkTooltip', Movie.Pres.m_kTooltipMgr); 
	PerkTooltip.InitPerkTooltip('TooltipSoldierPerks');
	PerkToolTip.GetChild('BGBoxSimple').SetAlpha(TOOLTIP_ALPHA);
	PerkTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_BOTTOM_LEFT);
	PerkTooltip.SetPosition(20, -210- PerkTooltip.height);
	PerkTooltip.bFollowMouse = false;

	PerkTooltip.targetPath =  string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kPerks.MCPath); 
	PerkTooltip.bUsePartialPath = true;

	PerkTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip( PerkTooltip );

	// Enemy Bonuses tooltip ------------------------------------------------------------------
	EnemyBonusesTooltip = Spawn(class'UITacticalHUD_BuffsTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
	EnemyBonusesTooltip.InitBonusesAndPenalties('TooltipEnemyBonuses',,true, false, Movie.m_v2ScaledDimension.X - 160, Movie.m_v2ScaledDimension.Y - 400, true);

	EnemyBonusesTooltip.targetPath =  string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kEnemyTargets.MCPath); 
	EnemyBonusesTooltip.bUsePartialPath = true; 

	EnemyBonusesTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip(EnemyBonusesTooltip );
	
	// Enemy Penalties tooltip ------------------------------------------------------------------
	EnemyPenaltiesTooltip = Spawn(class'UITacticalHUD_BuffsTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
	EnemyPenaltiesTooltip.InitBonusesAndPenalties('TooltipEnemyPenalties',,false, false, Movie.m_v2ScaledDimension.X - 160, Movie.m_v2ScaledDimension.Y - 400, true);

	EnemyPenaltiesTooltip.targetPath =  string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kEnemyTargets.MCPath); 
	EnemyPenaltiesTooltip.bUsePartialPath = true; 

	EnemyPenaltiesTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip( EnemyPenaltiesTooltip );

	// Unit Bonuses tooltip ------------------------------------------------------------------
	SoldierBonusesTooltip = Spawn(class'UITacticalHUD_BuffsTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
	SoldierBonusesTooltip.InitBonusesAndPenalties('TooltipSoldierBonuses',,true, true, 20, -210);

	SoldierBonusesTooltip.SetPosition(20, Movie.m_v2ScaledDimension.Y - 210 - SoldierBonusesTooltip.Height);
	SoldierBonusesTooltip.targetPath =  string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kStatsContainer.MCPath) $ "." $ class'UITacticalHUD_BuffsTooltip_HitChance'.default.m_strBonusMC; 
	SoldierBonusesTooltip.bUsePartialPath = true; 

	SoldierBonusesTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip( SoldierBonusesTooltip );

	// Unit Penalties tooltip ------------------------------------------------------------------
	SoldierPenaltiesTooltip = Spawn(class'UITacticalHUD_BuffsTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
	SoldierPenaltiesTooltip.InitBonusesAndPenalties('TooltipSoldierPenalties', , false, true, 20, -210);

	SoldierPenaltiesTooltip.SetPosition(20, Movie.m_v2ScaledDimension.Y - 210 - SoldierPenaltiesTooltip.Height);
	SoldierPenaltiesTooltip.targetPath = UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kStatsContainer.MCPath $ "." $ class'UITacticalHUD_BuffsTooltip_HitChance'.default.m_strPenaltyMC;
	SoldierPenaltiesTooltip.bUsePartialPath = true; 

	SoldierPenaltiesTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip( SoldierPenaltiesTooltip );

	// Soldier ability hover tooltip -----------------------------------------------------------
	AbilityTooltip = Spawn(class'UITacticalHUD_AbilityTooltip_HitChance', Movie.Pres.m_kTooltipMgr); 
	AbilityTooltip.InitAbility('TooltipAbility',,20, -210);

	AbilityTooltip.SetAnchor(class'UIUtilities'.const.ANCHOR_BOTTOM_LEFT);
	AbilityTooltip.bFollowMouse = false;

	AbilityTooltip.targetPath =  string(UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kAbilityHUD.MCPath); 
	AbilityTooltip.bUsePartialPath = true; 

	AbilityTooltip.ID = Movie.Pres.m_kTooltipMgr.AddPreformedTooltip( AbilityTooltip );

	`define ADDGP(TOOLTIP) UITooltipGroup_Share(EnemyStats).AddDetail(`TOOLTIP, `TOOLTIP.bTop, `TOOLTIP.Weight, `TOOLTIP.DeadHeight);
	`ADDGP(EnemyPenaltiesTooltip);
	`ADDGP(EnemyBonusesTooltip);
	if (ES_TOOLTIP)
	{
		`ADDGP(EnemyTooltip);
		`ADDGP(EnemyAbilityTooltip);
		`ADDGP(EnemyPassivesTooltip);
	}
}

`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)

function bool getES_TOOLTIP()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.ES_TOOLTIP, class'WOTC_DisplayHitChance_MCMScreen'.default.ES_TOOLTIP);
}

function int getTOOLTIP_ALPHA()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TOOLTIP_ALPHA, class'WOTC_DisplayHitChance_MCMScreen'.default.TOOLTIP_ALPHA);
}

/*defaultproperties
{
	ES_TOOLTIP=true;
	TOOLTIP_ALPHA=85;
}*/