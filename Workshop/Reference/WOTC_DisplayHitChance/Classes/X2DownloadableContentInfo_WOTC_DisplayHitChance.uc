//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_WC_PhotoReBooth.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
//-----------------------------------------------------------
//	Class:	UIAbilityList_HitChance
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------


class X2DownloadableContentInfo_WOTC_DisplayHitChance extends X2DownloadableContentInfo;

`define GETAB(ABNAME) abilities.FindAbilityTemplate('`ABNAME')
`define IFGETAB(ABNAME) ability=`GETAB(`ABNAME); if (ability!=none)

// Append local Config(s)
static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager Abilities;
	local X2AbilityTemplate Ability;
	local HitChanceBuildVisualization NewVis;
	local X2Condition_ShadowStrike SSCondition;


	Abilities = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();


	`IFGETAB(MindSpin)
	{
		NewVis=new class'HitChanceBuildVisualization';
		Ability.BuildVisualizationFn = NewVis.BuildVisualization;
		Abilities.FindAbilityTemplate('MindSpin').LocHitMessage=Ability.LocFriendlyName;
		Abilities.FindAbilityTemplate('MindSpin').LocMissMessage=Ability.LocFriendlyName @ class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.FAILED_TEXT;
		NewVis.FlyoverMessages.additem(Ability.LocHitMessage);
		NewVis.FlyoverMessages.additem(Ability.LocMissMessage);
	}

	`IFGETAB(Domination)
	{
		NewVis=new class'HitChanceBuildVisualization';
		Ability.BuildVisualizationFn = NewVis.BuildVisualization;
		NewVis.FlyoverMessages.additem(class'X2StatusEffects'.default.ResistedMindControlText);//Miss
		NewVis.FlyoverMessages.additem(class'X2StatusEffects'.default.MindControlFriendlyName);//Hit
	}

	`IFGETAB(PsiMindControl)
	{
		NewVis=new class'HitChanceBuildVisualization';
		Ability.BuildVisualizationFn = NewVis.BuildVisualization;
		NewVis.FlyoverMessages.additem(class'X2StatusEffects'.default.ResistedMindControlText);//Miss
		NewVis.FlyoverMessages.additem(class'X2StatusEffects'.default.MindControlFriendlyName);//Hit
	}

	`IFGETAB(MindScorch)
	{
		NewVis=new class'HitChanceBuildVisualization';
		Ability.BuildVisualizationFn = NewVis.BuildVisualization;
		Abilities.FindAbilityTemplate('MindScorch').LocHitMessage=Ability.LocFriendlyName;
		NewVis.FlyoverMessages.additem(Ability.LocHitMessage);
		NewVis.FlyoverMessages.additem(Ability.LocMissMessage); //Mr. Nice: I'm assuming MindScorch can fail!
	}
	`IFGETAB(SHADOWSTRIKE)
	{
		SSCondition=new class'X2Condition_ShadowStrike';
		SSCondition.VisCondition=X2Condition_Visibility(X2Effect_ToHitModifier(Ability.AbilityTargetEffects[0]).ToHitConditions[0]);
		X2Effect_ToHitModifier(Ability.AbilityTargetEffects[0]).ToHitConditions[0]=SSCondition;
	}
}