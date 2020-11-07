//----------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UIPanel.uc
//  AUTHOR:  Samuel Batista, Brit Steiner
//  PURPOSE: Base class for managing a SWF/GFx file that is loaded into the game.
//----------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//----------------------------------------------------------------------------

class UITLEScreen extends UIScreen
	native(UI);

	
var private XComOnlineEventMgr EventMgr;

//==============================================================================
//  INITIALIZATION
//==============================================================================

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);
}

simulated function OnInit()
{
	super.OnInit();
}

native function bool HasTLEEntitlement();
simulated native function AddChild(UIPanel Control);
simulated native function SignalOnInit();
simulated native function SignalOnReceiveFocus();
simulated native function SignalOnLoseFocus();
simulated native function bool AcceptsInput();