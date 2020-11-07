//----------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UILadderUpgradeScreen.uc
//  AUTHOR:  Joe Cortese
//----------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games, Inc. All rights reserved.
//----------------------------------------------------------------------------

class UITLELadderEndScreen extends UITLEScreen;

var UINavigationHelp NavHelp;

var localized array<string> m_RunStats;
var localized string m_Description;

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);

	NavHelp = Spawn(class'UINavigationHelp', self).InitNavHelp();
	NavHelp.AddContinueButton(ContinueButtonClicked);

	SetPosition(400, 200);
}

simulated function OnInit()
{
	local int i;
	local Texture2D PosterTexture;
	local XComGameState_CampaignSettings SettingsState;
	local XComGameState_Analytics Analytics;
	local array<string> Stats;
	local XComGameState_LadderProgress LadderData;
	local XComOnlineProfileSettings Profile;

	LadderData = XComGameState_LadderProgress(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LadderProgress'));

	Stats.Length = m_RunStats.Length;

	Analytics = XComGameState_Analytics(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_Analytics'));
	if (Analytics != none)
	{
// 		m_RunStats[0]="ALIENS KILLED"
// 		m_RunStats[1]="BONUS POINTS EARNED"
// 		m_RunStats[2]="MISSIONS FAILED"
// 		m_RunStats[3]="SOLDIERS WOUNDED"
// 		m_RunStats[4]="SOLDIERS LOST"
// 		m_RunStats[5]="TURNS TAKEN"
		Stats[ 0 ] = Analytics.GetValueAsString( "ACC_UNIT_KILLS" );
		Stats[ 1 ] = Analytics.GetValueAsString( "TLE_LADDER_BONUS" );
		Stats[ 2 ] = Analytics.GetValueAsString( "BATTLES_LOST" );
		Stats[ 3 ] = Analytics.GetValueAsString( "TLE_INJURIES" );
		Stats[ 4 ] = Analytics.GetValueAsString( "UNITS_LOST" );
		Stats[ 5 ] = Analytics.GetValueAsString( "TURN_COUNT" );
	}

	for (i = 0; i < 6 && i < m_RunStats.Length; i++)
	{
		MC.BeginFunctionOp("SetStat");
		mc.QueueNumber(i);
		mc.QueueString(m_RunStats[i]);
		mc.QueueString(Stats[i]);
		mc.EndOp();
	}

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

	mc.FunctionString("SetDescription", m_Description);

	SettingsState = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));
	
	PosterTexture = `XENGINE.m_kPhotoManager.GetLatestPoster(SettingsState.GameIndex);

	mc.FunctionString("SetPoster", class'UIUtilities_Image'.static.ValidateImagePath(PathName(PosterTexture)));

	super.OnInit();

	NavHelp.ContinueButton.OffsetY = -90;

	if( `ISCONTROLLERACTIVE )
	{
		NavHelp.AddLeftHelp(class'UITacticalHUD_MouseControls'.default.m_strSoldierInfo, class'UIUtilities_Input'.const.ICON_Y_TRIANGLE);
	}

	Profile = `XPROFILESETTINGS;
	Profile.Data.AddLadderHighScore(LadderData.LadderIndex, LadderData.CumulativeScore);
	++Profile.Data.HubStats.SuccessfulLadders;

	`ONLINEEVENTMGR.SaveProfileSettings();
}


public function ContinueButtonClicked()
{
	`ONLINEEVENTMGR.SetShuttleToLadderMenu();
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
	LibID = "LadderEndScreen";
	InputState = eInputState_Consume;

	bHideOnLoseFocus = true;
}
