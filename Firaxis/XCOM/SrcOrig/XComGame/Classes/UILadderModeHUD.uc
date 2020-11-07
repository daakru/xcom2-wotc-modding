//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UILadderModeHUD.uc
//  AUTHORS: Russell Aasland
//
//  PURPOSE: Container for special ladder mode specific UI elements
//  NOTE: Reuses the flash elements from the MP HUD. 
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class UILadderModeHUD extends UIChallengeModeHUD;

simulated function InitScreen( XComPlayerController InitController, UIMovie InitMovie, optional name InitName )
{
	Super.InitScreen( InitController, InitMovie, InitName );
}

// Flash side is initialized.
simulated function OnInit( )
{
	local XComGameState_LadderProgress LadderData;
	Super.OnInit( );

	LadderData = XComGameState_LadderProgress( `XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_LadderProgress', true ) );
	if (LadderData != none)
	{
		MC.BeginFunctionOp( SetScoreDirectFunction );
		MC.QueueNumber( LadderData.CumulativeScore );
		MC.QueueString(m_ScoreLabel);
		MC.EndOp( );
	}
}

simulated event Tick( float DeltaTime )
{
	// we don't want/need to do any of the tick/timer related challenge hud stuff
}

simulated function Remove()
{
	super.Remove();
}


defaultproperties
{
	Package = "/ package/gfxTLE_HUD/TLE_HUD";

	SetScoreDirectFunction="setTLEScoreDirect"
	SetScoreFunction="setTLEScore"
	TriggerBannerFunction="setTLEBanner"
}