//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UILadderModeScoringDialog.uc
//  AUTHORS: Russell Aasland
//
//  PURPOSE: Container for special challenge mode dialog showing possible points for challenge match
//  NOTE: Reuses the flash elements from the MP HUD. 
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class UILadderModeScoringDialog extends UIScreen;

var UIButton m_ContinueButton;

var localized string m_TotalLabel;
var localized string m_ScoreLabels[ChallengeModePointType.EnumCount]<BoundEnum = ChallengeModePointType>;
var localized string m_ScoreDescription1;
var localized string m_ScoreDescription2;
var localized string m_ButtonLabel;

var localized string m_LongDescription;
var localized string m_PerMinute;
var localized string m_ParScore;

var localized string m_LadderHeader;
var localized string m_StartLadderString;

simulated function InitScreen( XComPlayerController InitController, UIMovie InitMovie, optional name InitName )
{
	super.InitScreen( InitController, InitMovie, InitName );

	m_ContinueButton = Spawn( class'UILargeButton', self );
	
	//bsg-jneal (5.19.17): adding controller button image
	if(`ISCONTROLLERACTIVE)
	{
		m_ContinueButton.InitButton('challengeContinueButton', 
									class'UIUtilities_Text'.static.InjectImage(class'UIUtilities_Input'.static.GetAdvanceButtonIcon(), 26, 26, -10) @ m_StartLadderString, OnContinueButtonPress );
	}
	else
	{
		m_ContinueButton.InitButton( 'challengeContinueButton', m_StartLadderString, OnContinueButtonPress );
	}
	//bsg-jneal (5.19.17): end
}

// Flash side is initialized.
simulated function OnInit( )
{
	local int idx, count, score, maxscore;
	local XComChallengeModeManager ChallengeModeManager;
	local array<ScoreTableEntry> ScoreTable;
	local ChallengeSoldierScoring SoldierScoring;

	super.OnInit( );

	ChallengeModeManager = XComEngine(Class'GameEngine'.static.GetEngine()).ChallengeModeManager;
	ScoreTable.Length = 0;
	maxscore = ChallengeModeManager.GetChallengeMaxPossibleScoreTable(ScoreTable);

	MC.BeginFunctionOp( "setScoreHeader" );
	MC.QueueString( m_LadderHeader );
	MC.EndOp( );

	count = 0;
	for (idx = 0; idx < CMPT_MAX; ++idx)
	{
		if (idx == CMPT_UninjuredSoldiers || idx == CMPT_AliveSoldiers)
			continue;

		`log(`location @ `ShowVar(ScoreTable[idx].ScoreMax) @ `ShowEnum(ChallengeModePointType, ScoreTable[idx].ScoreType) @ `ShowVar(m_ScoreLabels[idx]));
		if (ScoreTable[idx].ScoreMax > 0)
		{
			score = ScoreTable[idx].ScoreMax;
			MC.BeginFunctionOp( "addScoreRow" );
			MC.QueueNumber( count++ );
			MC.QueueString( m_ScoreLabels[idx] );
			MC.QueueNumber( score );
			MC.EndOp( );
		}
	}

	ChallengeModeManager.GetSoldierScoring( SoldierScoring );
	if (SoldierScoring.UninjuredBonus > 0)
	{
		MC.BeginFunctionOp( "addScoreRow" );
		MC.QueueNumber( count++ );
		MC.QueueString( m_ScoreLabels[CMPT_UninjuredSoldiers] );
		MC.QueueNumber( -SoldierScoring.UninjuredBonus );
		MC.EndOp( );
	}
	if (SoldierScoring.WoundedBonus > 0)
	{
		MC.BeginFunctionOp( "addScoreRow" );
		MC.QueueNumber( count++ );
		MC.QueueString( m_ScoreLabels[CMPT_AliveSoldiers] );
		MC.QueueNumber( -SoldierScoring.WoundedBonus );
		MC.EndOp( );
	}


	MC.BeginFunctionOp("setScoreTotal");
	MC.QueueString(m_TotalLabel);
	MC.QueueString(string(maxscore));
	MC.EndOp();

	MC.BeginFunctionOp( "setScoreDescription" );
	MC.QueueString( m_ScoreDescription1 );
	MC.QueueString( m_ScoreDescription2 );
	MC.EndOp( );

	MC.BeginFunctionOp( "setScoreButton" );
	MC.QueueString( m_StartLadderString );
	MC.EndOp( );
	XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).HideInputButtonRelatedHUDElements(true);
}

simulated function Remove( )
{
	super.Remove( );
}

function OnContinueButtonPress( UIButton Button )
{
	Movie.Pres.PlayUISound(eSUISound_MenuSelect);
	`PRES.ScreenStack.PopFirstInstanceOfClass( class'UILadderModeScoringDialog' ); 
	XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).HideInputButtonRelatedHUDElements(false);
}


// ===========================================================================
//  DEFAULTS:
// ===========================================================================
defaultproperties
{
	MCName = "theScreen";
	Package = "/ package/gfxTLE_LadderScoreScreen/TLE_LadderScoreScreen";
}