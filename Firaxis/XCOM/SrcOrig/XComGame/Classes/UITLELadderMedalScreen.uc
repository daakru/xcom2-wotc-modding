//----------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UILadderUpgradeScreen.uc
//  AUTHOR:  Joe Cortese
//----------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games, Inc. All rights reserved.
//----------------------------------------------------------------------------

class UITLELadderMedalScreen extends UITLEScreen;

var UINavigationHelp NavHelp;

var localized string m_RewardsLabel;
var localized string m_ScoreLabel;
var localized string m_MedalScoreLabel;
var localized string m_MedalUnlockedString;
var localized string m_VictoryString;
var localized string m_UnlockedNextLadder;
var localized string m_ArchiveComplete;
var localized string m_LastArchiveBronzeDescription;
var localized string m_LadderUnlockDescription;
var localized array<string> m_MedalDescriptions;
var localized array<string> m_NarrativeLadderUnlocks;

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);

	NavHelp = Spawn(class'UINavigationHelp', self).InitNavHelp();
	NavHelp.AddContinueButton(ContinueButtonClicked);

	SetPosition(400, 200);
}

simulated function OnInit()
{
	local XComGameState_LadderProgress LadderData;
	local int iMedal, i, ladderHighScore;
	local string sMedalString;

	LadderData = XComGameState_LadderProgress(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LadderProgress'));

	iMedal = 0;
	for (i = 0; i < LadderData.MedalThresholds.Length; i++)
	{
		if (LadderData.CumulativeScore > LadderData.MedalThresholds[i])
		{
			iMedal = i+1;
		}
	}

	super.OnInit();

	MC.BeginFunctionOp("SetScreenTitle");
	MC.QueueString(class'UIMissionSummary'.default.m_strMissionComplete); // Title
	if (LadderData.LadderIndex < 10)
	{
		MC.QueueString(LadderData.NarrativeLadderNames[LadderData.LadderIndex]);//Mission Name
	}
	else
	{
		MC.QueueString(LadderData.LadderName);//Mission Name
	}
	MC.QueueString(class'UILadderSoldierInfo'.default.m_MissionLabel);//Mission Label
	MC.QueueString(String(LadderData.LadderRung - 1) $ "/" $ String(LadderData.LadderSize));//Mission Count
	MC.EndOp();

	MC.BeginFunctionOp("SetScoreData");
	MC.QueueString(m_ScoreLabel);
	MC.QueueString(string(LadderData.CumulativeScore));
	MC.QueueString(m_MedalScoreLabel);
	MC.QueueString(string(LadderData.MedalThresholds[iMedal-1]));
	MC.EndOp();

	m_MedalUnlockedString = Repl(m_MedalUnlockedString, "%s", class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(class'UITLE_LadderModeMenu'.default.m_MedalTypes[iMedal]));

	if (iMedal == 1)
		sMedalString = "Bronze";
	else if (iMedal == 2)
		sMedalString = "Silver";
	else if (iMedal == 3)
		sMedalString = "Gold";

	MC.BeginFunctionOp("SetMedalData");
	MC.QueueString(class'UIUtilities_Image'.static.ValidateImagePath("UILibrary_TLE_Common.LadderMedal_" $ LadderData.LadderIndex $ "_" $ sMedalString));
	MC.QueueString(m_MedalUnlockedString);
	MC.QueueString(m_VictoryString);
	MC.EndOp();

	MC.BeginFunctionOp("SetRewardData");

	ladderHighScore = `XPROFILESETTINGS.data.GetLadderHighScore(LadderData.LadderIndex);

	if (ladderHighScore >= LadderData.MedalThresholds[0])
	{
		//we've previously unlocked stuff no new unlocks, show what we unlocked but grayed out
		MC.QueueString(m_RewardsLabel);
		//ladder unlock
		MC.QueueString(m_UnlockedNextLadder);
		MC.QueueString(LadderData.NarrativeLadderNames[LadderData.LadderIndex + 1]);

		//content unlock
		MC.QueueString(m_NarrativeLadderUnlocks[LadderData.LadderIndex]);
		MC.QueueString(m_LadderUnlockDescription);
		MC.QueueString(LadderData.GetLadderCompletionUnlockImagePath());
		MC.QueueBoolean( false );
	}
	else
	{
		//did we score high enough to unlock anything?
		if (iMedal >= 1 && LadderData.LadderIndex <= 4)
		{
			MC.QueueString(m_RewardsLabel);
			//ladder unlock
			MC.QueueString(m_UnlockedNextLadder);
			MC.QueueString(LadderData.NarrativeLadderNames[LadderData.LadderIndex + 1]);

			//content unlock
			MC.QueueString(m_NarrativeLadderUnlocks[LadderData.LadderIndex]);
			MC.QueueString(m_LadderUnlockDescription);
			MC.QueueString(LadderData.GetLadderCompletionUnlockImagePath());
			MC.QueueBoolean(true);
		}
		else
		{
			MC.QueueString("");
			MC.QueueString("");
			MC.QueueString("");

			//content unlock
			MC.QueueString("");
			MC.QueueString("");
			MC.QueueString("");
		}
	}

	MC.EndOp();

	MC.FunctionVoid("AnimateIn");

	NavHelp.ContinueButton.OffsetY = -90;

	if( `ISCONTROLLERACTIVE )
	{
		NavHelp.AddLeftHelp(class'UITacticalHUD_MouseControls'.default.m_strSoldierInfo, class'UIUtilities_Input'.const.ICON_Y_TRIANGLE);
	}
}

public function ContinueButtonClicked()
{
	`TACTICALRULES.bWaitingForMissionSummary = false;
	CloseScreen();
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
	LibID = "MedalUnlockScreen";
	InputState = eInputState_Consume;

	bHideOnLoseFocus = true;
}
