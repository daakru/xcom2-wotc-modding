//-----------------------------------------------------------
//	Class:	HitChanceBuildVisualization
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------


class HitChanceBuildVisualization extends Object;

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

// Localized Array(s) required
var bool		DISPLAY_MISS_CHANCE;
var bool		HIT_CHANCE_ENABLED;
var bool		VERBOSE_TEXT;

//var localized string HIT_CHANCE_LABEL;

var array<string> FlyoverMessages;

function BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateVisualizationMgr VisMgr;
	local X2Action						Action;
	local Array<X2Action>				arrActions;

	local XComGameStateContext_Ability	Context;
	local AbilityInputContext			AbilityContext;
	local XComGameState_Ability			AbilityState;

	local AvailableTarget				kTarget;
	local int							hitChance;
	
	local string						hittext;
	//Let normal build vis do it's stuff.
	class'x2ability'.static.TypicalAbility_BuildVisualization(VisualizeGameState);

	// Here we're gonna lookup into a struct array to see if flyover message matches one of our already defined Message for targeted Ability
	if(getHIT_CHANCE_ENABLED())
	{
		//Fill in those context/state variables
		Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
		AbilityContext = Context.InputContext;
		AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.AbilityRef.ObjectID,, VisualizeGameState.HistoryIndex - 1));

		VisMgr = `XCOMVISUALIZATIONMGR;
		VisMgr.GetNodesOfType(VisMgr.BuildVisTree, class'X2Action_PlaySoundAndFlyOver', arrActions);

		
		if(getVERBOSE_TEXT()) hittext=class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.HIT_CHANCE;
		else hittext=class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.SHORT_HIT_CHANCE;

		//look through those actions for the expected flyoverstrings;
		foreach arrActions(action)
		{
			if (FlyoverMessages.Find(X2Action_PlaySoundAndFlyOver(Action).FlyOverMessage) != INDEX_NONE)
			{
				//Get the hitchance, note we get the target out of the object, multi-shot compatability
				kTarget.PrimaryTarget.ObjectID = Action.Metadata.StateObject_NewState.ObjectID;
				//We don't actually care about the shotbreak down, but the breakdown parameter is not optional;
				HitChance=class'HitCalcLib'.static.GetShotBreakdownPast(AbilityState, kTarget, , VisualizeGameState.HistoryIndex - 1);
				if(getDISPLAY_MISS_CHANCE())
				{
					HitChance = 100 - HitChance;
				}
				X2Action_PlaySoundAndFlyOver(Action).FlyOverMessage @= "-" @ HitText $ ":" @ HitChance $ "%";
			}
		}
	}
}

`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)

simulated function bool getHIT_CHANCE_ENABLED()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.HIT_CHANCE_ENABLED, class'WOTC_DisplayHitChance_MCMScreen'.default.HIT_CHANCE_ENABLED);
}

simulated function bool getDISPLAY_MISS_CHANCE()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DISPLAY_MISS_CHANCE, class'WOTC_DisplayHitChance_MCMScreen'.default.DISPLAY_MISS_CHANCE);
}

simulated function bool getVERBOSE_TEXT()
{	
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.VERBOSE_TEXT, class'WOTC_DisplayHitChance_MCMScreen'.default.VERBOSE_TEXT);
}


