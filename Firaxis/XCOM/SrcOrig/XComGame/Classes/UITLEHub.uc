//----------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UILadderUpgradeScreen.uc
//  AUTHOR:  Joe Cortese
//----------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games, Inc. All rights reserved.
//----------------------------------------------------------------------------

class UITLEHub extends UITLEScreen
	dependson(UITacticalQuickLaunch_MapData);

var localized string m_strTitle;
var localized string m_strSubtitle;
var localized string m_LadderTitle;
var localized string m_LadderDetails;
var localized string m_SkirmishTitle;
var localized string m_SkirmishDetails;
var localized string m_ChallengeTitle;
var localized string m_ChallengeDetails;
var localized string m_New;
var localized string m_Launch;
var localized string m_LadderWins;
var localized string m_HighestScore;
var localized string m_UnlockLabel;
var localized string m_CompletedLabel;
var localized string m_VictoryLabel;
var localized string m_CreatedLabel;
var localized string m_MissionsLabel;
var localized string m_strHelpPrev;
var localized string m_strHelpNext;

var UIButton	 ChallengeButton;
var UIButton	 LadderButton;
var UIButton	 SkirmishButton;

var UINavigationHelp NavHelp;

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);

	NavHelp = GetNavHelp();
	Navigator.HorizontalNavigation = true;
	UpdateNavHelp();

	ChallengeButton = Spawn(class'UIButton', self);
	LadderButton = Spawn(class'UIButton', self);
	SkirmishButton = Spawn(class'UIButton', self);
	
	LadderButton.InitButton('Button0', , EnterLadderMode);
	SkirmishButton.InitButton('Button1', , EnterSkirmishMode);
	ChallengeButton.InitButton('Button2', , EnterChallengeMode);
}

simulated function EnterChallengeMode(UIButton button)
{
	XComShellPresentationLayer(Owner).UITLEChallengeMode();	
}
simulated function EnterLadderMode(UIButton button)
{
	XComShellPresentationLayer(Owner).UITLELadderMode();
}
simulated function EnterSkirmishMode(UIButton button)
{
	`XCOMHISTORY.ResetHistory(, false);
	XComShellPresentationLayer(Owner).UITLESkirmishMode();
}

simulated function UINavigationHelp GetNavHelp()
{
	local UINavigationHelp Result;
	Result = PC.Pres.GetNavHelp();
	if (Result == None)
	{
		if (`PRES != none) // Tactical
		{
			Result = Spawn(class'UINavigationHelp', self).InitNavHelp();
			Result.SetX(-500); //offset to match the screen. 
		}
		else if (`HQPRES != none) // Strategy
			Result = `HQPRES.m_kAvengerHUD.NavHelp;
	}
	return Result;
}

simulated function UpdateNavHelp()
{
	NavHelp.ClearButtonHelp();
	NavHelp.AddBackButton(OnCancel);

	if( `ISCONTROLLERACTIVE )
	{
		NavHelp.AddLeftHelp(class'UIUtilities_Text'.default.m_strGenericConfirm, class'UIUtilities_Input'.static.GetAdvanceButtonIcon());
		NavHelp.AddCenterHelp(m_strHelpPrev, class'UIUtilities_Input'.const.ICON_LB_L1);
		NavHelp.AddCenterHelp(m_strHelpNext, class'UIUtilities_Input'.const.ICON_RB_R1);
	}

	NavHelp.Show();
}

simulated public function OnCancel()
{
	NavHelp.ClearButtonHelp();
	Movie.Pres.PlayUISound(eSUISound_MenuClose);
	Movie.Stack.Pop(self);
}

simulated function OnReceiveFocus()
{
	super.OnReceiveFocus();
	UpdateNavHelp();
}

simulated function bool OnUnrealCommand(int cmd, int arg)
{
	local bool bHandled; 

	// Only pay attention to presses or repeats; ignoring other input types
	// NOTE: Ensure repreats only occur with arrow keys
	if (!CheckInputIsReleaseOrDirectionRepeat(cmd, arg))
		return false;

	if (!bIsInited)
		return true;
	//if( !QueryAllImagesLoaded() ) return true; //If allow input before the images load, you will crash. Serves you right. -bsteiner

	bHandled = false; 

	switch (cmd)
	{
	case (class'UIUtilities_Input'.const.FXS_BUTTON_B):
	case (class'UIUtilities_Input'.const.FXS_KEY_ESCAPE):
	case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN :
		OnCancel();
		bHandled = true;
		break;
	case class'UIUtilities_Input'.const.FXS_VIRTUAL_LSTICK_LEFT :
	case class'UIUtilities_Input'.const.FXS_DPAD_LEFT :
	case class'UIUtilities_Input'.const.FXS_BUTTON_LBUMPER :
	case class'UIUtilities_Input'.const.FXS_ARROW_LEFT :
		bHandled = Navigator.OnUnrealCommand(class'UIUtilities_Input'.const.FXS_ARROW_LEFT, arg);
		break;
	case class'UIUtilities_Input'.const.FXS_VIRTUAL_LSTICK_RIGHT :
	case class'UIUtilities_Input'.const.FXS_DPAD_RIGHT :
	case class'UIUtilities_Input'.const.FXS_BUTTON_RBUMPER :
	case class'UIUtilities_Input'.const.FXS_ARROW_RIGHT :
		bHandled = Navigator.OnUnrealCommand(class'UIUtilities_Input'.const.FXS_ARROW_RIGHT, arg);
		break;

	default:
		bHandled = false; 
		break;
	}

	if( !bHandled && Navigator.GetSelected() != none && Navigator.GetSelected().OnUnrealCommand(cmd, arg) )
	{
		bHandled = true;
	}


	// always give base class a chance to handle the input so key input is propogated to the panel's navigator
	return (bHandled || super.OnUnrealCommand(cmd, arg));
}

simulated function string BuildUnlockString( XComOnlineProfileSettings Profile )
{
	local int BronzeMedals, i;
	local int BronzeScore, HighScore;

	BronzeMedals = 0;

	for (i = 1; i <= 4; ++i)
	{
		BronzeScore = class'XComGameState_LadderProgress'.static.GetLadderMedalThreshold( i, 0 );
		HighScore = Profile.Data.GetLadderHighScore( i );

		if (BronzeScore <= HighScore)
			++BronzeMedals;
	}

	return string(BronzeMedals) $ "/4";
}

simulated function OnInit()
{
	local XComOnlineProfileSettings Profile;

	super.OnInit();

	Profile = `XPROFILESETTINGS;

	mc.BeginFunctionOp("SetScreenTitle");
	mc.QueueString(m_strTitle);
	mc.QueueString(m_strSubtitle);
	mc.EndOp();

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////

	mc.BeginFunctionOp("SetButtonInfo");
	mc.QueueNumber(0);
	mc.QueueString(Profile.Data.GetHighestLadderScore() > 0 ? "" : m_New);
	mc.QueueString("img:///" $ "UILibrary_MissionImages.Mission_lg_Museum_01");
	mc.QueueString(m_LadderTitle);
	mc.QueueString(m_LadderDetails);
	mc.QueueString(m_Launch);
	mc.EndOp();

	mc.BeginFunctionOp("SetSmallStat");
	mc.QueueNumber(0);
	mc.QueueNumber(0);
	mc.QueueString( string(Profile.Data.HubStats.SuccessfulLadders) ); //This number is the total completed ladder number, not missions, in either narrative or random
	mc.QueueString(m_LadderWins);
	mc.EndOp();

	mc.BeginFunctionOp("SetSmallStat");
	mc.QueueNumber(0);
	mc.QueueNumber(1);
	mc.QueueString( string(Profile.Data.GetHighestLadderScore()) ); //This number is the highest total ladder score achieved in either narrative or random
	mc.QueueString(m_HighestScore);
	mc.EndOp();

	mc.BeginFunctionOp("SetLargeStat");
	mc.QueueNumber(0);
	mc.QueueNumber(0);
	mc.QueueString("");
	mc.QueueString( BuildUnlockString(Profile) ); //This number is how many bronze medals the player has, one per ladder, 4 ladders, Display as "X/4"
	mc.QueueString(m_UnlockLabel);
	mc.EndOp();

	mc.BeginFunctionOp("SetMeterStat");
	mc.QueueNumber(0);
	mc.QueueNumber(100 * Profile.Data.HubStats.LadderCompletions.Length / 28); //This progress and number are how many unique missions have been completed total out of the total 28 narrative missions
	mc.QueueString( string(Profile.Data.HubStats.LadderCompletions.Length) ); //this will help give the player more incremental progress
	mc.QueueString(class'UITLE_LadderModeMenu'.default.m_NarrativeLaddersHeader);
	mc.EndOp();

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	mc.BeginFunctionOp("SetButtonInfo");
	mc.QueueNumber(1);
	mc.QueueString(Profile.Data.HubStats.NumSkirmishes > 0 ? "" : m_New);
	mc.QueueString("img:///" $ "UILibrary_MissionImages.Mission_md_GasStation_01");
	mc.QueueString(m_SkirmishTitle);
	mc.QueueString(m_SkirmishDetails);
	mc.QueueString(m_Launch);
	mc.EndOp();

	mc.BeginFunctionOp("SetSmallStat");
	mc.QueueNumber(1);
	mc.QueueNumber(0);
	mc.QueueString( string(Profile.Data.HubStats.NumSkirmishVictories) ); //This number is how many total wins the player has in skirmish missions
	mc.QueueString(m_VictoryLabel);
	mc.QueueBoolean(true);
	mc.EndOp();

	mc.BeginFunctionOp("SetLargeStat");
	mc.QueueNumber(1);
	mc.QueueNumber(1);
	mc.QueueString(m_MissionsLabel);
	mc.QueueString( string(Profile.Data.HubStats.NumSkirmishes) );//This number is how many total skirmish missions have been created
	mc.QueueString(m_CreatedLabel);
	mc.QueueBoolean(true);
	mc.EndOp();

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	mc.BeginFunctionOp("SetButtonInfo");
	mc.QueueNumber(2);
	mc.QueueString(Profile.Data.HubStats.OfflineChallengeHighScore > 0 ? "" : m_New);
	mc.QueueString("img:///" $ "UILibrary_MissionImages.Mission_lg_GeneClinic_01");
	mc.QueueString(m_ChallengeTitle);
	mc.QueueString(m_ChallengeDetails);
	mc.QueueString(m_Launch);
	mc.EndOp();

	mc.BeginFunctionOp("SetSmallStat");
	mc.QueueNumber(2);
	mc.QueueNumber(0);
	mc.QueueString( string(Profile.Data.HubStats.NumOfflineChallengeVictories) ); //This number is the total number of challenges won
	mc.QueueString(m_VictoryLabel);
	mc.EndOp();

	mc.BeginFunctionOp("SetSmallStat");
	mc.QueueNumber(2);
	mc.QueueNumber(1);
	mc.QueueString( string(Profile.Data.HubStats.OfflineChallengeHighScore) ); //This number is the highest score across all challenges
	mc.QueueString(m_HighestScore);
	mc.EndOp();

	mc.BeginFunctionOp("SetMeterStat");
	mc.QueueNumber(2);
	mc.QueueNumber( 100 * Profile.Data.HubStats.OfflineChallengeCompletion.Length / 109);//This number is the running percentage of how many unique completed challenges there are, it is meant to drive player progression in completing all the challenges, Current unique wins / Total Challenges
	mc.QueueString( string(Profile.Data.HubStats.OfflineChallengeCompletion.Length) );//This number is the running unique win total
	mc.QueueString(m_CompletedLabel);
	mc.QueueBoolean(true);
	mc.EndOp();
}


defaultproperties
{
	Package = "/ package/gfxTLE_HubMenu/TLE_HubMenu";
	InputState = eInputState_Consume;

	bHideOnLoseFocus = true;
}
