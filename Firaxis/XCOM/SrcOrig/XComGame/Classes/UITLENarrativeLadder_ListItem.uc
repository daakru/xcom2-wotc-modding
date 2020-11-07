//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UIInventory_ListItem.uc
//  AUTHOR:  Samuel Batista
//  PURPOSE: UIPanel representing a list entry on UIInventory_Manufacture screen.
//--------------------------------------------------------------------------------------- 
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class UITLENarrativeLadder_ListItem extends UIPanel;

var XComGameState_LadderProgress m_LadderData;
var bool		bDisabled;

var localized string m_LadderInprogress;
var localized string m_LadderComplete;


simulated function UITLENarrativeLadder_ListItem InitTLENarrativeLadderListItem(XComGameState_LadderProgress LadderData, optional name InitName, optional name InitLibID)
{
	m_LadderData = LadderData;

	super.InitPanel(InitName, InitLibID);

	return self;
}


simulated function OnInit()
{
	super.OnInit();	
	PopulateData();
}

simulated function PopulateData()
{
	local int i, highscore, medalScore;
	local XComOnlineProfileSettings Profile;

	mc.FunctionString("setHTMLText", m_LadderData.NarrativeLadderNames[m_LadderData.LadderIndex]);

	Profile = `XPROFILESETTINGS;
	highscore = Profile.Data.GetLadderHighScore(m_LadderData.LadderIndex);
	for (i = 0; i < 3; i++)
	{
		medalScore = m_LadderData.GetLadderMedalThreshold(m_LadderData.LadderIndex, i);;

		MC.BeginFunctionOp("setMedal");
		mc.QueueNumber(i);
		mc.QueueNumber(highscore >= medalScore ? i + 1 : 0);
		mc.EndOp();
	}

	if (UITLE_LadderModeMenu(`SCREENSTACK.GetFirstInstanceOf(class'UITLE_LadderModeMenu')).HasLadderSave(m_LadderData.LadderIndex))
	{
		mc.FunctionString("setStatusText", m_LadderInprogress);
	}
	else if (highscore > 0)
	{
		mc.FunctionString("setStatusText", m_LadderComplete);
	}
	else
	{
		mc.FunctionString("setStatusText", "");
	}

	mc.FunctionString("setImage", m_LadderData.GetBackgroundPath());
}

simulated function UITLENarrativeLadder_ListItem SetDisabled(bool disabled, optional string TooltipText)
{
	if (disabled != bDisabled)
	{
		bDisabled = disabled;
		MC.FunctionBool("setDisabled", disabled);
	}

	return self;
}

simulated function OnDoubleclickConfirmButton(UIButton Button)
{
	// do nothing
}

simulated function SetFocus(bool bHighlight)
{
	if (bHighlight)
	{
		MC.FunctionVoid("onReceiveFocus");
	}
	else
	{
		MC.FunctionVoid("onLoseFocus");
	}
}

defaultproperties
{
	LibID = "NarrativeLadderButton";
	bDisabled = false;
	bCascadeFocus = false;
	Height = 70
}
