//---------------------------------------------------------------------------------------
//  FILE:    X2LadderUpgradeTemplateManager.uc
//  AUTHOR:  Russell Aasland
//
//  PURPOSE: Container for templates related to ladder progression upgrades
//---------------------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2LadderUpgradeTemplateManager extends X2DataTemplateManager
	native(Core);

native static function X2LadderUpgradeTemplateManager GetLadderUpgradeTemplateManager();

function X2LadderUpgradeTemplate FindUpgradeTemplate(name DataName)
{
	local X2DataTemplate kTemplate;

	kTemplate = FindDataTemplate(DataName);
	if (kTemplate != none)
		return X2LadderUpgradeTemplate(kTemplate);
	return none;
}

DefaultProperties
{
	TemplateDefinitionClass=class'X2Ladder_DefaultUpgrades'
}