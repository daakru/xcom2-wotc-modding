//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UIInventory_ListItem.uc
//  AUTHOR:  Samuel Batista
//  PURPOSE: UIPanel representing a list entry on UIInventory_Manufacture screen.
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class UITLEChallenge_ListItem extends UIPanel;

var ChallengeListItemData Data;

simulated function Refresh(ChallengeListItemData ItemData)
{
	Data = ItemData; 
	PopulateData();
}

simulated function PopulateData()
{
	MC.BeginFunctionOp("UpdateData");
	
	MC.QueueString(Data.MissionName);		// Mission
	MC.QueueString(Data.MissionObjective);	// Objective
	MC.QueueString(Data.MapName);			// Map
	MC.QueueString(Data.Squad);				// Squad
	MC.QueueString(Data.Enemies);			// Enemies
	
	MC.EndOp();
}

simulated function OnDoubleclickConfirmButton(UIButton Button)
{
	// do nothing
}

defaultproperties
{
	LibID = "ChallengeRowItem";
	bCascadeFocus = false;
	Height = 37;
	bAnimateOnInit = false;
}
