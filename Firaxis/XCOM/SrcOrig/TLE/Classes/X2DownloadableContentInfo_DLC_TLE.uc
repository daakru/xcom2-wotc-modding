//---------------------------------------------------------------------------------------
//  FILE:    X2DownloadableContentInfo_DLC_Day90.uc
//  AUTHOR:  Joe Weinhoffer
//           
//	Installs Day 90 DLC into new campaigns and loaded ones. New armors, weapons, etc
//
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_DLC_TLE extends X2DownloadableContentInfo;

var config array<name> DLCEquipment;

/// <summary>
/// Called after the Templates have been created (but before they are validated) while this DLC / Mod is installed.
/// </summary>
static event OnPostTemplatesCreated()
{
	class'X2Helpers_DLC_TLE'.static.OnPostCharacterTemplatesCreated();
}

static function bool FindByName( const out array<X2SchematicTemplate> Array, name Search )
{
	local X2SchematicTemplate Template;

	foreach Array(Template)
	{
		if (Template.DataName == Search)
			return true;
	}

	return false;
}

static function DoInstall( )
{
	local XComGameStateHistory History;
	local XComGameState_CampaignSettings Campaign;
	local XComGameState NewGameState;
	local name TemplateName;
	local X2ItemTemplateManager ItemManager;
	local X2ItemTemplate Template;
	local XComGameState_Item NewItemState;
	local XComGameState_HeadquartersXCom XComHQ;
	local array<X2SchematicTemplate> PurchasedSchematics;

	History = `XCOMHISTORY;
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding TLE DLC State Objects");

	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));

	PurchasedSchematics = XComHQ.GetPurchasedSchematics();

	foreach default.DLCEquipment(TemplateName)
	{
		Template = ItemManager.FindItemTemplate( TemplateName );

		if (Template.StartingItem) // Add starting items
		{
			NewItemState = Template.CreateInstanceFromTemplate( NewGameState );
			XComHQ.AddItemToHQInventory( NewItemState );
		}
		else if (FindByName( PurchasedSchematics, Template.CreatorTemplateName )) // upgrade existing item (DLCEquipment should be ordered by increasing tier)
		{
			class'XComGameState_HeadquartersXCom'.static.UpgradeItems( NewGameState, Template.CreatorTemplateName );
		}
	}

	Campaign = XComGameState_CampaignSettings(History.GetSingleGameStateObjectForClass( class'XComGameState_CampaignSettings' ));
	Campaign = XComGameState_CampaignSettings(NewGameState.ModifyStateObject( class'XComGameState_CampaignSettings', Campaign.ObjectID ));
	Campaign.TLEInstalled = true;

	if (NewGameState.GetNumGameStateObjects() > 0)
	{
		History.AddGameStateToHistory(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}
}

/// <summary>
/// Called after the player exits the post-mission sequence while this DLC / Mod is installed.
/// </summary>
static event OnExitPostMissionSequence()
{
	local XComGameState_CampaignSettings Campaign;

	Campaign = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_CampaignSettings' ));
	if (!Campaign.TLEInstalled)
	{
		DoInstall( );
	}
}

/// <summary>
/// This method is run when the player loads a saved game directly into Strategy while this DLC is installed
/// </summary>
static event OnLoadedSavedGameToStrategy()
{
	local XComGameState_CampaignSettings Campaign;

	Campaign = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_CampaignSettings' ));
	if (!Campaign.TLEInstalled)
	{
		DoInstall( );
	}
}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{
	local XComGameState_CampaignSettings Campaign;

	// everything should be handled through templates, no real work to do
	Campaign = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_CampaignSettings' ));
	Campaign = XComGameState_CampaignSettings(StartState.ModifyStateObject( class'XComGameState_CampaignSettings', Campaign.ObjectID ));
	Campaign.TLEInstalled = true;
}