//---------------------------------------------------------------------------------------
//  FILE:    X2LadderUpgradeTemplate.uc
//  AUTHOR:  Russell Aasland
//
//  PURPOSE: The data for a single upgrade choice of ladder progression.
//---------------------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2LadderUpgradeTemplate extends X2DataTemplate config(Ladder)
	native(core);

struct native Upgrade
{
	var string ClassFilter;
	var localized string Description;
	var bool Required;
	var string ClassGroup;

	var array<name> EquipmentNames;
};

var localized string ShortDescription;
var localized string FullDescription;

var config array<Upgrade> Upgrades;

var config int MinLadderLevel;
var config int MaxLadderLevel;

var config string ImagePath;