//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UIShellDifficulty.uc
//  AUTHOR:  Brit Steiner       -- 01/25/12
//           Tronster           -- 04/13/12
//  PURPOSE: Controls the difficulty menu in the shell SP game. 
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class UITLE_LadderDifficulty extends UITLEScreen;


// top panel - basic difficulty selection
var UIPanel			 m_TopPanel;
var UIMechaListItem  m_DifficultyRookieMechaItem;
var UIMechaListItem  m_DifficultyVeteranMechaItem;
var UIMechaListItem  m_DifficultyCommanderMechaItem;
var UIMechaListItem  m_DifficultyLegendMechaItem;


// bottom panel - major options selection
var UIPanel			 m_BottomPanel;
var UIMechaListItem  m_FirstTimeVOMechaItem;
var UIMechaListItem  m_IronmanMechaItem;
var UIMechaListItem  m_SubtitlesMechaItem;
var UIMechaListItem  m_SoundtrackMechaItem;

// navigation
//var UIButton         m_CancelButton;
var UILargeButton	 m_StartButton;


var int  m_iSelectedDifficulty, m_iSelectedIndex;

var bool m_bSuppressFirstTimeNarrative;

var UINavigationHelp NavHelp;

var localized string m_PlayNarrative;
var localized string m_NarrativeDifficulty;
var localized string m_RandomLadderReplay;
var localized string m_IronManMode;
var localized string m_PlayNarrativeVODesc;


//----------------------------------------------------------------------------

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);
	
	//bsg-crobinson (5.15.17): Set correct navhelp based on what screen we're in
	// 1 - Main Menu. 2 - Tactical. 3 - Strategy
	if(Movie.Pres.m_eUIMode == eUIMode_Shell)
	{
		NavHelp = InitController.Pres.GetNavHelp();
	}
	else if (`PRES != none) //bsg-crobinson (5.16.17): Added the else to show navhelp in the main menu
	{
		NavHelp = Spawn(class'UINavigationHelp', Movie.Stack.GetScreen(class'UIMouseGuard')).InitNavHelp();
	}
	else
	{
		NavHelp = `HQPRES.m_kAvengerHUD.NavHelp;
	}
	//bsg-crobinson (5.15.17): end

	BuildMenu();

	UpdateNavHelp(); 

	if( `ISCONTROLLERACTIVE )
	{
		Navigator.SetSelected(m_TopPanel);
	}
	
	m_TopPanel.Navigator.OnSelectedIndexChanged = OnSelectedIndexChanged;
	m_BottomPanel.Navigator.OnSelectedIndexChanged = OnSelectedIndexChanged;

	MC.FunctionVoid("AnimateIn");
	RefreshDescInfo();
}

//bsg-crobinson (5.3.17): Update NavHelp for difficulty screen
simulated function UpdateNavHelp()
{
	NavHelp.ClearButtonHelp();
	NavHelp.bIsVerticalHelp = `ISCONTROLLERACTIVE;
	NavHelp.AddBackButton(OnUCancel);
	NavHelp.AddSelectNavHelp();
}
//bsg-crobinson (5.3.17): end


//----------------------------------------------------------------------------

simulated function bool OnUnrealCommand(int cmd, int arg)
{
	local bool bHandled;
	local UIPanel CurrentSelection;

	if(!CheckInputIsReleaseOrDirectionRepeat(cmd, arg))
		return true;

	switch(cmd)
	{
	case class'UIUtilities_Input'.const.FXS_KEY_ENTER:
	case class'UIUtilities_Input'.const.FXS_BUTTON_START:
		
		CurrentSelection = Navigator.GetSelected();
		if (CurrentSelection != None)
		{
			if( CurrentSelection == m_StartButton ) 
			{
				OnDifficultyConfirm(none);
			}
			else
			{
				bHandled = CurrentSelection.OnUnrealCommand(cmd, arg);
			}
		}		
		break;

	case class'UIUtilities_Input'.const.FXS_BUTTON_X :
		OnDifficultyConfirm(none);
		break;

	case class'UIUtilities_Input'.const.FXS_BUTTON_B:
	case class'UIUtilities_Input'.const.FXS_KEY_ESCAPE:
	case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN:
		
		NavHelp.ClearButtonHelp(); //bsg-crobinson (3.24.17): be sure to clear the navhelp
		OnUCancel();
		//bsg-jneal (1.25.17): end
		break;


	case class'UIUtilities_Input'.const.FXS_DPAD_UP:
	case class'UIUtilities_Input'.const.FXS_ARROW_UP:
	case class'UIUtilities_Input'.const.FXS_VIRTUAL_LSTICK_UP:
	case class'UIUtilities_Input'.const.FXS_KEY_W:
		PlaySound(SoundCue'SoundUI.MenuScrollCue', true);
		break;

	case class'UIUtilities_Input'.const.FXS_DPAD_DOWN:
	case class'UIUtilities_Input'.const.FXS_ARROW_DOWN:
	case class'UIUtilities_Input'.const.FXS_VIRTUAL_LSTICK_DOWN:
	case class'UIUtilities_Input'.const.FXS_KEY_S:
		PlaySound(SoundCue'SoundUI.MenuScrollCue', true);
		break;

	default:
		bHandled = false;
	}

	//Refresh data as our selection may have changed
	RefreshDescInfo();

	return bHandled || super.OnUnrealCommand(cmd, arg);
}


//----------------------------------------------------------------------------

simulated function BuildMenu()
{
	local string strDifficultyTitle;
	local UIPanel LinkPanel;
	local UITLE_LadderModeMenu ladderScreen;
	ladderScreen = UITLE_LadderModeMenu(Movie.Pres.ScreenStack.GetFirstInstanceOf(class'UITLE_LadderModeMenu'));

	// Title
	strDifficultyTitle = class'UIShellDifficulty'.default.m_strSelectDifficulty;
	
	AS_SetDifficultyMenu(
		strDifficultyTitle, 
		GetDifficultyButtonText());

	
	m_iSelectedDifficulty = 1; //Default to normal 

	// but use the difficulty of the ladder for procedural replays
	if (!ladderScreen.IsNarrativeLadderSelected() && (ladderScreen.GetRequiredLadderDifficulty( ) >= 0))
	{
		m_iSelectedDifficulty = ladderScreen.GetRequiredLadderDifficulty( );
	}

	//////////////////
	// top panel
	LinkPanel = Spawn(class'UIPanel', self);
	LinkPanel.bAnimateOnInit = false;
	LinkPanel.bCascadeSelection = true;
	LinkPanel.bCascadeFocus = false;
	LinkPanel.InitPanel('topPanel');
	m_TopPanel = LinkPanel;

	m_DifficultyRookieMechaItem = Spawn(class'UIMechaListItem', LinkPanel);
	m_DifficultyRookieMechaItem.bAnimateOnInit = false;
	m_DifficultyRookieMechaItem.InitListItem('difficultyRookieButton');
	m_DifficultyRookieMechaItem.SetWidgetType(EUILineItemType_Checkbox);
	m_DifficultyRookieMechaItem.UpdateDataCheckbox(class'UITLE_LadderModeMenu'.default.m_arrDifficultyTypeStrings[0], "", m_iSelectedDifficulty == 0, UpdateDifficulty, OnButtonDifficultyRookie);
	m_DifficultyRookieMechaItem.BG.SetTooltipText(class'UIShellDifficulty'.default.m_arrDifficultyDescStrings[0], , , 10, , , , 0.0f);

	m_DifficultyVeteranMechaItem = Spawn(class'UIMechaListItem', LinkPanel);
	m_DifficultyVeteranMechaItem.bAnimateOnInit = false;
	m_DifficultyVeteranMechaItem.InitListItem('difficultyVeteranButton');
	m_DifficultyVeteranMechaItem.SetWidgetType(EUILineItemType_Checkbox);
	m_DifficultyVeteranMechaItem.UpdateDataCheckbox(ladderScreen.IsNarrativeLadderSelected() ? class'UITLE_LadderModeMenu'.default.m_arrDifficultyTypeStrings[1] : class'UIShellDifficulty'.default.m_arrDifficultyTypeStrings[1], "", m_iSelectedDifficulty == 1, UpdateDifficulty, OnButtonDifficultyVeteran);
	m_DifficultyVeteranMechaItem.BG.SetTooltipText(class'UIShellDifficulty'.default.m_arrDifficultyDescStrings[1], , , 10, , , , 0.0f);

	m_DifficultyCommanderMechaItem = Spawn(class'UIMechaListItem', LinkPanel);
	m_DifficultyCommanderMechaItem.bAnimateOnInit = false;
	m_DifficultyCommanderMechaItem.InitListItem('difficultyCommanderButton');
	m_DifficultyCommanderMechaItem.SetWidgetType(EUILineItemType_Checkbox);
	m_DifficultyCommanderMechaItem.UpdateDataCheckbox(ladderScreen.IsNarrativeLadderSelected() ? class'UITLE_LadderModeMenu'.default.m_arrDifficultyTypeStrings[2] : class'UIShellDifficulty'.default.m_arrDifficultyTypeStrings[2], "", m_iSelectedDifficulty == 2, UpdateDifficulty, OnButtonDifficultyCommander);
	m_DifficultyCommanderMechaItem.BG.SetTooltipText(class'UIShellDifficulty'.default.m_arrDifficultyDescStrings[2], , , 10, , , , 0.0f);

	m_DifficultyLegendMechaItem = Spawn(class'UIMechaListItem', LinkPanel);
	m_DifficultyLegendMechaItem.bAnimateOnInit = false;
	m_DifficultyLegendMechaItem.InitListItem('difficultyLegendButton');
	m_DifficultyLegendMechaItem.SetWidgetType(EUILineItemType_Checkbox);
	m_DifficultyLegendMechaItem.UpdateDataCheckbox(class'UITLE_LadderModeMenu'.default.m_arrDifficultyTypeStrings[3], "", m_iSelectedDifficulty == 3, UpdateDifficulty, OnButtonDifficultyLegend);
	m_DifficultyLegendMechaItem.BG.SetTooltipText(class'UIShellDifficulty'.default.m_arrDifficultyDescStrings[3], , , 10, , , , 0.0f);

	if (ladderScreen.IsNarrativeLadderSelected())
	{
		// disable unsupported difficulties for narrative ladders
		m_DifficultyRookieMechaItem.SetDisabled(true, m_NarrativeDifficulty);
		m_DifficultyLegendMechaItem.SetDisabled(true, m_NarrativeDifficulty);
	}
	else if (ladderScreen.GetRequiredLadderDifficulty( ) >= 0)
	{
		// disable difficulty selection in general for procedural ladder replays
		m_DifficultyRookieMechaItem.SetDisabled(true, m_RandomLadderReplay);
		m_DifficultyVeteranMechaItem.SetDisabled(true, m_RandomLadderReplay);
		m_DifficultyCommanderMechaItem.SetDisabled(true, m_RandomLadderReplay);
		m_DifficultyLegendMechaItem.SetDisabled(true, m_RandomLadderReplay);
	}
	//////////////////
	// bottom panel

	LinkPanel = Spawn(class'UIPanel', self);
	LinkPanel.bAnimateOnInit = false;
	LinkPanel.bCascadeSelection = true;
	LinkPanel.bCascadeFocus = false;
	LinkPanel.InitPanel('bottomPanel');
	m_BottomPanel = LinkPanel;

	m_FirstTimeVOMechaItem = Spawn(class'UIMechaListItem', LinkPanel);
	m_FirstTimeVOMechaItem.bAnimateOnInit = false;
	m_FirstTimeVOMechaItem.InitListItem('difficultyNarrativeButton');
	if( ladderScreen.IsNarrativeLadderSelected() )
	{
		m_FirstTimeVOMechaItem.SetWidgetType(EUILineItemType_Checkbox);
		m_FirstTimeVOMechaItem.UpdateDataCheckbox(m_PlayNarrative, "", `XPROFILESETTINGS.Data.m_bLadderNarrativesOn, , OnClickNarrative);
		m_FirstTimeVOMechaItem.BG.SetTooltipText(m_PlayNarrativeVODesc, , , 10, , , , 0.0f);
	}
	else
	{
		m_FirstTimeVOMechaItem.Remove();
	}

	m_IronmanMechaItem = Spawn(class'UIMechaListItem', LinkPanel);
	m_IronmanMechaItem.bAnimateOnInit = false;
	m_IronmanMechaItem.InitListItem('difficultyIronmanButton');
	m_IronmanMechaItem.SetWidgetType(EUILineItemType_Checkbox);
	m_IronmanMechaItem.UpdateDataCheckbox( class'UIChooseIronMan'.default.m_strIronmanOK , "", true, , );
	m_IronmanMechaItem.SetDisabled(true, m_IronManMode);

	m_StartButton = Spawn(class'UILargeButton', LinkPanel);
	if( `ISCONTROLLERACTIVE )
	{
		m_StartButton.bIsNavigable = false; 
	}
	m_StartButton.InitLargeButton('difficultyLaunchButton', GetDifficultyButtonText(), "", OnDifficultyConfirm);

	RefreshDescInfo();
}

simulated function string GetDifficultyButtonText()
{
	local String strDifficultyAccept;

	strDifficultyAccept = class'UITLEHub'.default.m_Launch;
	
	if (`ISCONTROLLERACTIVE)
	{
		strDifficultyAccept = class'UIUtilities_Text'.static.InjectImage( class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_X_SQUARE, 26, 26, -10) @ strDifficultyAccept; //bsg-jneal (2.2.17): fix for InjectImage calls not using platform prefix for button icons
	}

	return strDifficultyAccept;
}

simulated function UpdateDifficulty(UICheckbox CheckboxControl)
{
	if( m_DifficultyRookieMechaItem.Checkbox.bChecked && m_DifficultyRookieMechaItem.Checkbox == CheckboxControl )
	{
		m_iSelectedDifficulty = 0;
	}
	else if( m_DifficultyVeteranMechaItem.Checkbox.bChecked && m_DifficultyVeteranMechaItem.Checkbox == CheckboxControl )
	{
		m_iSelectedDifficulty = 1;
	}
	else if( m_DifficultyCommanderMechaItem.Checkbox.bChecked && m_DifficultyCommanderMechaItem.Checkbox == CheckboxControl )
	{
		m_iSelectedDifficulty = 2;
	}
	else if( m_DifficultyLegendMechaItem.Checkbox.bChecked && m_DifficultyLegendMechaItem.Checkbox == CheckboxControl )
	{
		m_iSelectedDifficulty = 3;
	}

	m_DifficultyRookieMechaItem.Checkbox.SetChecked(m_iSelectedDifficulty == 0);
	m_DifficultyVeteranMechaItem.Checkbox.SetChecked(m_iSelectedDifficulty == 1);
	m_DifficultyCommanderMechaItem.Checkbox.SetChecked(m_iSelectedDifficulty == 2);
	m_DifficultyLegendMechaItem.Checkbox.SetChecked(m_iSelectedDifficulty == 3);

	RefreshDescInfo();
}

simulated function OnButtonDifficultyRookie()
{
	if( !m_DifficultyRookieMechaItem.Checkbox.bChecked )
	{
		m_DifficultyRookieMechaItem.Checkbox.SetChecked(!m_DifficultyRookieMechaItem.Checkbox.bChecked);
	}
}

simulated function OnButtonDifficultyVeteran()
{
	if( !m_DifficultyVeteranMechaItem.Checkbox.bChecked )
	{
		m_DifficultyVeteranMechaItem.Checkbox.SetChecked(!m_DifficultyVeteranMechaItem.Checkbox.bChecked);
	}
}

simulated function OnButtonDifficultyCommander()
{
	if( !m_DifficultyCommanderMechaItem.Checkbox.bChecked )
	{
		m_DifficultyCommanderMechaItem.Checkbox.SetChecked(!m_DifficultyCommanderMechaItem.Checkbox.bChecked);
	}
}

simulated function OnButtonDifficultyLegend()
{
	if( !m_DifficultyLegendMechaItem.Checkbox.bChecked )
	{
		m_DifficultyLegendMechaItem.Checkbox.SetChecked(!m_DifficultyLegendMechaItem.Checkbox.bChecked);
	}
}


simulated function OnClickNarrative()
{
	m_FirstTimeVOMechaItem.Checkbox.SetChecked(!m_FirstTimeVOMechaItem.Checkbox.bChecked);
}


// Lower pause screen
simulated public function OnUCancel()
{
	local UITLE_LadderModeMenu ladderScreen;
	ladderScreen = UITLE_LadderModeMenu(Movie.Pres.ScreenStack.GetFirstInstanceOf(class'UITLE_LadderModeMenu'));

	ladderScreen.OnDifficultySelectionCallback('eUIAction_Decline', 0, false);
	NavHelp.ClearButtonHelp();
	Movie.Pres.PlayUISound(eSUISound_MenuClose);

	Movie.Stack.Pop(self);
}

simulated public function OnButtonCancel(UIButton ButtonControl)
{
	OnUCancel();
}

simulated public function OnDifficultyConfirm(UIButton ButtonControl)
{
	local UITLE_LadderModeMenu ladderScreen;
	ladderScreen = UITLE_LadderModeMenu(Movie.Pres.ScreenStack.GetFirstInstanceOf(class'UITLE_LadderModeMenu'));

	ladderScreen.OnDifficultySelectionCallback('eUIAction_Accept', m_iSelectedDifficulty, m_FirstTimeVOMechaItem.Checkbox.bChecked );

	Movie.Pres.PlayUISound(eSUISound_MenuSelect);
}


simulated function OnSelectedIndexChanged(int NewIndex)
{
	m_iSelectedIndex = NewIndex;
	RefreshDescInfo();
}

simulated function RefreshDescInfo()
{
	local string sDesc;
	
	
	
	if( !`ISCONTROLLERACTIVE )
	{
		sDesc = class'UIShellDifficulty'.default.m_arrDifficultyDescStrings[m_iSelectedDifficulty];
	}
	else
	{
		if(Navigator.GetSelected() == m_TopPanel)
		{
			sDesc = class'UIShellDifficulty'.default.m_arrDifficultyDescStrings[m_TopPanel.Navigator.SelectedIndex];
			
		}
		else
		{
			if (m_iSelectedIndex != 1)
			{
				sDesc = m_PlayNarrativeVODesc;
			}
			else
			{
				sDesc = class'UIShellDifficulty'.default.m_strDifficultyIronmanDesc;
			}
		}
	}
	
	AS_SetDifficultyDesc(sDesc);
}

simulated function CloseScreen()
{
	super.CloseScreen();
}

simulated function OnReceiveFocus()
{
	super.OnReceiveFocus();

	UpdateNavHelp(); //bsg-crobinson (5.3.17): Update navhelp when receiving focus
	Show();
}

simulated function OnLoseFocus()
{
	super.OnLoseFocus();
	NavHelp.ClearButtonHelp(); //bsg-hlee (05.02.17): Removing extra bottom left b button.
	Hide();
}

// FLASH COMMUNICATION
simulated function AS_SetDifficultyDesc(string desc)
{
	MC.FunctionString("SetDifficultyDesc", desc);
}

simulated function AS_SetDifficultyMenu(
	string title, 
	string launchLabel)
{
	MC.BeginFunctionOp("UpdateDifficultyMenu");
	MC.QueueString(title);
	MC.QueueString(launchLabel);
	MC.EndOp();
}


//==============================================================================
//		CLEANUP:
//==============================================================================

event Destroyed()
{
	super.Destroyed();
}

DefaultProperties
{
	m_iSelectedIndex = 0;
	Package = "/ package/gfxTLE_LadderDifficultyMenu/TLE_LadderDifficultyMenu";
	LibID = "TLE_LadderDifficultyMenu"

	InputState = eInputState_Consume;
	bConsumeMouseEvents = true

}
