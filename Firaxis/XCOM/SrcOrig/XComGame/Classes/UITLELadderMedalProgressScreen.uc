//----------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UITLELadderMedalProgressScreen.uc
//  AUTHOR:  Jason Montgomery
//----------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games, Inc. All rights reserved.
//----------------------------------------------------------------------------

class UITLELadderMedalProgressScreen extends UITLEScreen;

var UINavigationHelp NavHelp;

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);

	NavHelp = Spawn(class'UINavigationHelp', self).InitNavHelp();
	NavHelp.AddContinueButton(ContinueButtonClicked);

	SetPosition(400, 45);
}

simulated function OnInit()
{
	local XComGameState_LadderProgress LadderData;

	super.OnInit();

	LadderData = XComGameState_LadderProgress(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LadderProgress'));

	MC.BeginFunctionOp("SetScreenTitle");
	MC.QueueString(class'UIMissionSummary'.default.m_strMissionComplete); // Title
	if (LadderData.LadderIndex < 10)
	{
		MC.QueueString(LadderData.NarrativeLadderNames[LadderData.LadderIndex]);//Mission Name
	}
	else
	{
		MC.QueueString(LadderData.LadderName);//Mission Name
	}//Mission Name
	MC.QueueString(class'UILadderSoldierInfo'.default.m_MissionLabel);//Mission Label
	MC.QueueString(String(LadderData.LadderRung - 1) $ "/" $ String(LadderData.LadderSize));//Mission Count
	MC.EndOp();

	MC.FunctionVoid("SetScreenFooter");

	MC.FunctionString("SetMissionProgressText", class'UITLE_LadderModeMenu'.default.m_ProgressLabel);
	MC.FunctionString("SetMedalProgressLabel", class'UITLE_LadderModeMenu'.default.m_MedalProgress);

	UpdateData();

	NavHelp.ContinueButton.OffsetY = -90;

}

simulated function UpdateData()
{
	local XComGameState_LadderProgress LadderData;
	local float medalPercentage;
	local int i, goldMedalProgress, currentMedalProgress;

	LadderData = XComGameState_LadderProgress(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LadderProgress'));
	
	for (i = 0; i < LadderData.LadderSize; i++)
	{
		mc.BeginFunctionOp("SetMissionNode");
		mc.QueueNumber(i);

		/*
		NODE_LOCKED     = 0;
		NODE_READY      = 1;
		NODE_COMPLETE   = 2;
		NODE_BOSSLOCKED = 3;
		NODE_BOSS       = 4;
		*/
		
		if ( i < LadderData.LadderRung - 1)
		{
			mc.QueueNumber(2);
		}
		else if (i == LadderData.LadderRung - 1)
		{
			mc.QueueNumber(1);
		}
		else
		{
			mc.QueueNumber(0);
		}
		
		mc.EndOp();
	}

	goldMedalProgress = LadderData.GetLadderMedalThreshold(LadderData.LadderIndex, 2);
	for (i = 0; i < 3; i++)
	{
		currentMedalProgress = LadderData.GetLadderMedalThreshold(LadderData.LadderIndex, i);
		medalPercentage = float(currentMedalProgress) / float(goldMedalProgress);
		mc.BeginFunctionOp("SetMedalScoreMarker");
		mc.QueueNumber(i);
		mc.QueueNumber(medalPercentage);
		mc.QueueString(string(currentMedalProgress));
		mc.QueueString(class'UITLE_LadderModeMenu'.default.m_MedalTypes[i + 1]);
		mc.QueueNumber(LadderData.LadderIndex);
		mc.EndOp();

	}

	medalPercentage = float(LadderData.CumulativeScore) / float(goldMedalProgress);

	mc.FunctionNum("SetMedalProgressMeter", medalPercentage);

}

public function ContinueButtonClicked()
{
	local XComGameState_LadderProgress LadderData;

	Movie.Pres.PlayUISound(eSUISound_MenuSelect);

	`TACTICALRULES.bWaitingForMissionSummary = false;

	// clear out these references to the previous state, we don't need them and they may track back to the world about to be unloaded.
	LadderData = XComGameState_LadderProgress(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LadderProgress'));
	LadderData.LastMissionState.Length = 0;
}

simulated function bool OnUnrealCommand(int cmd, int arg)
{
	local bool bHandled;
	bHandled = true;

	if (!CheckInputIsReleaseOrDirectionRepeat(cmd, arg))
		return true;

	switch( cmd )
	{
	case class'UIUtilities_Input'.const.FXS_BUTTON_A :
	case class'UIUtilities_Input'.const.FXS_KEY_ENTER :
	case class'UIUtilities_Input'.const.FXS_KEY_SPACEBAR :
		ContinueButtonClicked();
		break;

	default:
		bHandled = false;
		break;
	}

	return bHandled;
}


defaultproperties
{
	Package = "/ package/gfxTLE_LadderLevelUp/TLE_LadderLevelUp";
	LibID = "MedalProgressScreen";
	InputState = eInputState_Consume;

	bHideOnLoseFocus = true;
}
