//-----------------------------------------------------------
//	Class:	X2Action_ApplyWeaponDamageToUnit_HITCHANCE
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------
// Used by the visualizer system to control a Visualization Actor
//-----------------------------------------------------------

class X2Action_ApplyWeaponDamageToUnit_HITCHANCE extends X2Action_ApplyWeaponDamageToUnit;

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

var bool HIT_CHANCE_ENABLED;
var bool VERBOSE_TEXT;
var bool DISPLAY_MISS_CHANCE;
var bool SHOW_TEMPLAR_MSG;
//var config float FLYOVER_DURATION;
var bool SHOW_GUARANTEED_HIT;
var bool	 TH_AIM_ASSIST;


var localized string GUARANTEED_HIT;
var localized string HIT_CHANCE;
var localized string MISS_CHANCE;
var localized string CRIT_CHANCE;
var localized string DODGE_CHANCE;
var localized string FAILED_TEXT;

// Short versions
var localized string SHORT_GUARANTEED_HIT;
var localized string SHORT_HIT_CHANCE;
var localized string SHORT_MISS_CHANCE;
var localized string SHORT_CRIT_CHANCE;
var localized string SHORT_DODGE_CHANCE;


simulated function bool getHIT_CHANCE_ENABLED()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.HIT_CHANCE_ENABLED, class'WOTC_DisplayHitChance_MCMScreen'.default.HIT_CHANCE_ENABLED);
}

simulated function bool getVERBOSE_TEXT()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.VERBOSE_TEXT, class'WOTC_DisplayHitChance_MCMScreen'.default.VERBOSE_TEXT);
}

simulated function bool getDISPLAY_MISS_CHANCE()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DISPLAY_MISS_CHANCE, class'WOTC_DisplayHitChance_MCMScreen'.default.DISPLAY_MISS_CHANCE);
}

simulated function bool getSHOW_TEMPLAR_MSG()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.SHOW_TEMPLAR_MSG, class'WOTC_DisplayHitChance_MCMScreen'.default.SHOW_TEMPLAR_MSG);
}

/*simulated function float getFLYOVER_DURATION()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.FLYOVER_DURATION, class'WOTC_DisplayHitChance_MCMScreen'.default.FLYOVER_DURATION);
}*/

simulated function bool getSHOW_GUARANTEED_HIT()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.SHOW_GUARANTEED_HIT, class'WOTC_DisplayHitChance_MCMScreen'.default.SHOW_GUARANTEED_HIT);
}

simulated function bool getTH_AIM_ASSIST()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_AIM_ASSIST, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_AIM_ASSIST);
}


`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)

simulated state Executing
{
	simulated function ShowHPDamageMessage(string UIMessage, optional string CritMessage, optional EWidgetColor DisplayColor = eColor_Bad)
	{
		local string HitIcon;
		local XComPresentationLayerBase kPres;

		// This is done to re-create a Crit-Like flyover message to be displayed just under the Crit Flyover containing damages, and the Crit Label
		
		kPres = XComPlayerController(class'Engine'.static.GetCurrentWorldInfo().GetALocalPlayerController()).Pres;
		UIMessage $= GetChanceString();
		if (CritMessage != "")
		{
			HitIcon = "img:///UILibrary_WOTC_DisplayHitChance.HitIcon32";
			// Soooo Grimy's right, had to do Shenanigans until Firaxis fixes their shit on the damn Flash Component that handles Crit Flyovers behavior.
			// Right now the Flash makes it so when Crit Flyover appears, then Crit Label stays for 1.3s before disappearing (with its panel beneath it)
			// but then another panel beneath text may not appear properly although text is being displayed...
			class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), CritMessage, UnitPawn.m_eTeamVisibilityFlags, , m_iDamage, 0, CritMessage, DamageTypeName == 'Psi'? eWDT_Psi : -1, eColor_Yellow);
			kPres.GetWorldMessenger().Message(UIMessage, m_vHitLocation, Unit.GetVisualizedStateReference(), eColor_Yellow, , class'UIWorldMessageMgr'.default.DAMAGE_DISPLAY_DEFAULT_ID, UnitPawn.m_eTeamVisibilityFlags, class'UIWorldMessageMgr'.default.DAMAGE_DISPLAY_DEFAULT_USE_SCREEN_LOC_PARAM, class'UIWorldMessageMgr'.default.DAMAGE_DISPLAY_DEFAULT_SCREEN_LOC, , , HitIcon, , , , , DamageTypeName == 'Psi'? eWDT_Psi : -1);
		}
		else
		{
			class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), UIMessage, UnitPawn.m_eTeamVisibilityFlags, , m_iDamage, 0, CritMessage, DamageTypeName == 'Psi'? eWDT_Psi : -1, DisplayColor);
		}
	}
	
	simulated function ShowMissMessage(EWidgetColor DisplayColor)
	{

		if (m_iDamage > 0)
			class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), (class'XLocalizedData'.default.MissedMessage $ GetChanceString()), UnitPawn.m_eTeamVisibilityFlags, , m_iDamage);
		else if (!OriginatingEffect.IsA('X2Effect_Persistent')) //Persistent effects that are failing to cause damage are not noteworthy.
			class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), (class'XLocalizedData'.default.MissedMessage $ GetChanceString()));
	}
	
	simulated function ShowCounterattackMessage(EWidgetColor DisplayColor)
	{
		class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), (class'XLocalizedData'.default.CounterattackMessage $ GetChanceString()));
	}

	simulated function ShowLightningReflexesMessage(EWidgetColor DisplayColor)
	{
		class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), (class'XLocalizedData'.default.LightningReflexesMessage $ GetChanceString()));
	}

	simulated function ShowUntouchableMessage(EWidgetColor DisplayColor)
	{
		class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), (class'XLocalizedData'.default.UntouchableMessage $ GetChanceString()));
	}

	simulated function ShowFreeKillMessage(name AbilityName, EWidgetColor DisplayColor)
	{
		class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), (class'XLocalizedData'.default.FreeKillMessage $ GetChanceString()), , , , , , eWDT_Repeater);
	}

		simulated function ShowParryMessage(EWidgetColor DisplayColor)
	{
		local string ParryMessage;

		ParryMessage = class'XLocalizedData'.default.ParryMessage;
		if (getSHOW_TEMPLAR_MSG()) { ParryMessage = ParryMessage $ GetChanceString(); }
		class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), ParryMessage,,,,,,, DisplayColor);
	}

	simulated function ShowDeflectMessage(EWidgetColor DisplayColor)
	{
		local string DeflectMessage;

		DeflectMessage = class'XLocalizedData'.default.DeflectMessage;
		if (getSHOW_TEMPLAR_MSG()) { DeflectMessage = DeflectMessage $ GetChanceString(); }
		class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), DeflectMessage,,,,,,, DisplayColor);
	}

	simulated function ShowReflectMessage(EWidgetColor DisplayColor)
	{
		local string ReflectMessage;

		ReflectMessage = class'XLocalizedData'.default.ReflectMessage;
		if (getSHOW_TEMPLAR_MSG()) { ReflectMessage = ReflectMessage $ GetChanceString(); }
		class'UIWorldMessageMgr'.static.DamageDisplay(m_vHitLocation, Unit.GetVisualizedStateReference(), ReflectMessage,,,,,,, DisplayColor);
	}

	// Hit Chance mod change
	function string GetChanceString()
	{
		local int chanceToPrint;
		local string guaranteedHit;
		local string hitString;

		// I find this code quite short and efficient, and I want to keep it that way
		local XComGameState_Ability AbilityState;
		//local XComGameStateHistory History;
		local AvailableTarget kTarget;
		local int critChance, dodgeChance;
		local ShotBreakdown TargetBreakdown;
		//local StateObjectReference Shooter;

		//History = `XCOMHISTORY;
		AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID, , CurrentHistoryIndex - 1));
		//kTarget.PrimaryTarget = AbilityContext.InputContext.PrimaryTarget;

		//Shooter = AbilityState.OwnerStateObject;
		// THIS, that simple fix for multishot! Thanks Mr. Nice!!!
		//kTarget.PrimaryTarget.ObjectID = Metadata.StateObject_NewState.ObjectID;
		//Mr. Nice: Although the ObjectIDs well be identical, Using OldState to get the ID reinforces that we are checking the past.
		kTarget.PrimaryTarget.ObjectID = Metadata.StateObject_OldState.ObjectID;

		//kTarget.AdditionalTargets = AbilityContext.InputContext.MultiTargets;
		
			
		class'HitCalcLib'.static.GetShotBreakdownPast(AbilityState, kTarget, TargetBreakdown, CurrentHistoryIndex - 1);
		//AbilityState.LookupShotBreakdown(Shooter, kTarget.PrimaryTarget, AbilityState.GetReference(), TargetBreakdown);
		critChance = TargetBreakdown.ResultTable[eHit_Crit];
		dodgeChance = TargetBreakdown.ResultTable[eHit_Graze];

		VERBOSE_TEXT = getVERBOSE_TEXT();
		DISPLAY_MISS_CHANCE = getDISPLAY_MISS_CHANCE();
		HIT_CHANCE_ENABLED = getHIT_CHANCE_ENABLED();

		//chanceToPrint = XComGameStateContext_Ability(StateChangeContext).ResultContext.CalculatedHitChance;
		// Basically retrieving value this way to try to get multishot accurate values is useless as the game affects Main Target Breakdown Hit Chance Value to Multi Shot hit Chance (who knows why...)
		chanceToPrint = TargetBreakdown.FinalHitChance;
		if(getTH_AIM_ASSIST()) chanceToPrint += class'WOTC_DisplayHitChance_UITacticalHUD_ShotWings'.static.GetModifiedHitChance(AbilityState, chanceToPrint, , CurrentHistoryIndex - 1);
		chanceToPrint = Clamp(chanceToPrint, 0, 100);
		critChance = Clamp(critChance, 0, 100);
		dodgeChance = Clamp(dodgeChance, 0, 100);

		if (VERBOSE_TEXT)
		{
			guaranteedHit = " " $ GUARANTEED_HIT $ " - " $ CRIT_CHANCE $ ": " $ critChance $ "% - " $ DODGE_CHANCE $ ": " $ dodgeChance $ "%";
			hitString = " " $ HIT_CHANCE $ ": " $ chanceToPrint $ "% - " $ CRIT_CHANCE $ ": " $ critChance $ "% - " $ DODGE_CHANCE $ ": " $ dodgeChance $ "%";
		}
		else
		{
			guaranteedHit = " " $ SHORT_GUARANTEED_HIT $ " - " $ SHORT_CRIT_CHANCE $ ": " $ critChance $ "% - " $ SHORT_DODGE_CHANCE $ ": " $ dodgeChance $ "%";
			hitString = " " $ SHORT_HIT_CHANCE $ ": " $ chanceToPrint $ "% - " $ SHORT_CRIT_CHANCE $ ": " $ critChance $ "% - " $ SHORT_DODGE_CHANCE $ ": " $ dodgeChance $ "%";
		}

		if ( DISPLAY_MISS_CHANCE )
		{
			chanceToPrint = 100 - chanceToPrint;
			if ( VERBOSE_TEXT )
			{
				hitString = " " $ MISS_CHANCE $ ": " $ chanceToPrint $ "% - " $ CRIT_CHANCE $ ": " $ critChance $ "% - " $ DODGE_CHANCE $ ": " $ dodgeChance $ "%";
			}
			else
			{
				hitString = " " $ SHORT_MISS_CHANCE $ ": " $ chanceToPrint $ "% - " $ SHORT_CRIT_CHANCE $ ": " $ critChance $ "% - " $ SHORT_DODGE_CHANCE $ ": " $ dodgeChance $ "%";
			}

		}

		if ( HIT_CHANCE_ENABLED )
		{
			if ( CheckPersistentDamage() )
			{
				return "";
			}
			else if ( getSHOW_GUARANTEED_HIT() && CheckGuaranteedHit() )
			{
				return guaranteedHit;
			}
			else
			{
				return hitString;
			}
		}
		else
		{
			return "";
		}
	}

	simulated function bool CheckPersistentDamage()
	{
		if (X2Effect_Persistent(DamageEffect) != none)
			return true;

		if (X2Effect_Persistent(OriginatingEffect) != None)
			return true;

		if (X2Effect_Persistent(AncestorEffect) != None)
			return true;

		return false;
	}

	simulated function bool CheckGuaranteedHit()
	{
		if ( X2AbilityToHitCalc_DeadEye(AbilityTemplate.AbilityToHitCalc) != None)	return true;
		
		return false;
	}
}