//---------------------------------------------------------------------------------------
//  FILE:    X2Ladder_DefaultUpgrades.uc
//  AUTHOR:  Russell Aasland
//
//  PURPOSE: The set of ladder progression upgrades
//---------------------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2Ladder_DefaultUpgrades extends X2DataSet config(Ladder);

var config array<name> UpgradeNames;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	local X2LadderUpgradeTemplate Template;
	local name UpgradeName;

	foreach default.UpgradeNames(UpgradeName)
	{
		`CREATE_X2TEMPLATE(class'X2LadderUpgradeTemplate', Template, UpgradeName);
		Templates.AddItem(Template);
	}

	return Templates;
}