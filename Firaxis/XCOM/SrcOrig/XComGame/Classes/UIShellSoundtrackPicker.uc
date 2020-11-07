//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UIShellNarrativeContent.uc
//  AUTHOR:  Mark Nauta --2/4/2016

//  PURPOSE: Controls enabling optional narrative content for the campaign. 
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class UIShellSoundtrackPicker extends UIScreen
	dependson(XComOnlineProfileSettingsDataBlob);

var UIList           m_List;
var UILargeButton    m_StartButton;
var UIX2PanelHeader	 m_HeaderPanel;

var UIMechaListItem	 m_XpacknarrativeMechaItem;

var int				 m_soundtrackChoice;

var UINavigationHelp NavHelp; //bsg-hlee (05.05.17): Moving this here for other nav help functions.

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);
	
	m_HeaderPanel = Spawn(class'UIX2PanelHeader', self);
	m_HeaderPanel.bAnimateOnInit = false;
	m_HeaderPanel.InitPanelHeader('headerMC', "Choose Soundtrack");
	m_HeaderPanel.SetHeaderWidth(740, false);
	//m_HeaderPanel.SetPosition(-425, 18);

	m_HeaderPanel.DisableNavigation();

	m_List = Spawn(class'UIList', self);
	m_List.InitList('TLESoundtrackPickerListMC');
	m_List.bPermitNavigatorToDefocus = true;
	m_List.Navigator.LoopSelection = false;
	m_List.Navigator.LoopOnReceiveFocus = false;
	m_List.bCascadeSelection = true;
	m_List.bCascadeFocus = true;
	m_List.SetHeight(330);
	m_List.OnItemClicked = OnClicked;
	m_List.OnSetSelectedIndex = OnSetSelectedIndex;
	Navigator.SetSelected(m_List);
	m_List.Navigator.SetSelected(m_List.ItemContainer);

	m_XpacknarrativeMechaItem = Spawn(class'UIMechaListItem', self);
	m_XpacknarrativeMechaItem.bAnimateOnInit = false;
	m_XpacknarrativeMechaItem.width = 270;
	m_XpacknarrativeMechaItem.InitListItem('XPackNarrativeListItemMC');

	NavHelp = Movie.Pres.GetNavHelp();
	UpdateNavHelp(); //bsg-hlee (05.05.17): Added to function call.
	
	m_StartButton = Spawn(class'UILargeButton', self);
	m_StartButton.InitLargeButton('narrativeLaunchButton', GetStartButtonText(), "", ConfirmNarrativeContent);
	if( `ISCONTROLLERACTIVE ) 
		m_StartButton.DisableNavigation();

	//m_List.Navigator.SetSelected(m_List.GetItem(m_List.SelectedIndex));
}

simulated function string GetStartButtonText()
{
	local String strLabel;

	strLabel = class'UIUtilities_Text'.default.m_strGenericConfirm;

	if( `ISCONTROLLERACTIVE )
	{
		strLabel = class'UIUtilities_Text'.static.InjectImage(class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_X_SQUARE, 26, 26, -10) @ strLabel; //bsg-jneal (2.2.17): fix for InjectImage calls not using platform prefix for button icons
	}

	return strLabel;
}

simulated function OnInit()
{
	super.OnInit();
	//SetX(570);
	BuildMenu();	

	m_XpacknarrativeMechaItem.Hide();
}

simulated function BuildMenu()
{
	m_soundtrackChoice = `XPROFILESETTINGS.Data.m_iSoundtrackChoice;


	MC.BeginFunctionOp("UpdateNarrativeContentMenu");
	MC.QueueString("");
	MC.QueueString("Title area ");
	MC.QueueString("Subtitle area");
	MC.EndOp();

	AS_SetDifficultyDesc("");

	mc.FunctionVoid("HideForSoundtrackPicker");
	CreateListItem(class'UIOptionsPCScreen'.default.m_kstr_SoundtrackStrings[0], m_soundtrackChoice == 0);
	CreateListItem(class'UIOptionsPCScreen'.default.m_kstr_SoundtrackStrings[1], m_soundtrackChoice == 1);
	CreateListItem(class'UIOptionsPCScreen'.default.m_kstr_SoundtrackStrings[2], m_soundtrackChoice == 2);
}


simulated function CreateListItem(string Label, bool bChecked)
{
	local UIMechaListItem SpawnedItem;

	SpawnedItem = UIMechaListItem(m_List.CreateItem(class'UIMechaListItem'));
	SpawnedItem.bAnimateOnInit = false;
	SpawnedItem.InitListItem();
	SpawnedItem.UpdateDataCheckbox(Label, "", bChecked, OnCheckboxChanged);
	m_List.SetSelectedIndex(m_soundtrackChoice);
}


simulated function OnCheckboxChanged(UICheckbox CheckboxControl)
{
	local int index;

	for (index = 0; index < m_List.ItemCount; index++)
	{
		if (UIMechaListItem(m_List.GetItem(index)).Checkbox == CheckboxControl)
			break;
	}

	if(m_soundtrackChoice != index )
		OnClicked(m_List, index);
}

simulated function OnClicked(UIList ContainerList, int ItemIndex)
{
	//Hack. Brute Force. sigh. -bsteiner 
	UIMechaListItem(m_List.GetItem(0)).Checkbox.SetChecked(false);
	UIMechaListItem(m_List.GetItem(1)).Checkbox.SetChecked(false);
	UIMechaListItem(m_List.GetItem(2)).Checkbox.SetChecked(false);

	m_soundtrackChoice = ItemIndex;
	UIMechaListItem(m_List.GetItem(m_soundtrackChoice)).Checkbox.SetChecked(true);
}

simulated function OnSetSelectedIndex(UIList ContainerList, int ItemIndex)
{
	
}

simulated function AS_SetTitle(string title)
{
	mc.FunctionString("SetTitle", title);
}
simulated function AS_SetDifficultyDesc(string desc)
{
	mc.FunctionString("SetDifficultyDesc", desc);
}

simulated public function OnButtonCancel()
{
	if(bIsInited)
	{
		Movie.Pres.PlayUISound(eSUISound_MenuClose);
		Movie.Stack.Pop(self);
	}
}

simulated public function ConfirmNarrativeContent(UIButton ButtonControl)
{
	`XPROFILESETTINGS.Data.m_iSoundtrackChoice = m_soundtrackChoice;

	`ONLINEEVENTMGR.SaveProfileSettings(true);

	switch (m_soundtrackChoice)
	{
	case 0: `SOUNDMGR.SetState('SoundtrackGame', 'XComUFO'); break;
	case 1: `SOUNDMGR.SetState('SoundtrackGame', 'XCom1'); break;
	case 2: `SOUNDMGR.SetState('SoundtrackGame', 'XCom2'); break;
	}

	Movie.Stack.Pop(self);
}


simulated function bool OnUnrealCommand(int cmd, int arg)
{
	local bool bHandled;
	local UIPanel CurrentSelection;

	if(!CheckInputIsReleaseOrDirectionRepeat(cmd, arg))
		return true;

	switch(cmd)
	{
	case class'UIUtilities_Input'.const.FXS_KEY_ENTER:

		CurrentSelection = Navigator.GetSelected();
		if(CurrentSelection != None)
		{
			bHandled = CurrentSelection.OnUnrealCommand(cmd, arg);
		}
		break;

	case class'UIUtilities_Input'.const.FXS_BUTTON_X :
	case class'UIUtilities_Input'.const.FXS_BUTTON_START :
		ConfirmNarrativeContent(none);
		break;
	case class'UIUtilities_Input'.const.FXS_BUTTON_B:
	case class'UIUtilities_Input'.const.FXS_KEY_ESCAPE:
	case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN:
		OnButtonCancel();
		break;

	default:
		bHandled = false;
	}

	if( !bHandled )
	{
		//`log("TLE?" @ HasTLEEntitlement());
		bHandled = super.OnUnrealCommand(cmd, arg);
	}
	return bHandled;
}


//bsg-hlee (05.05.17): Adding in nav help functions for focus.
simulated function UpdateNavHelp()
{
	NavHelp.ClearButtonHelp();
	NavHelp.bIsVerticalHelp = true;
	NavHelp.AddBackButton(OnButtonCancel);
	NavHelp.AddSelectNavHelp();
}

simulated function OnLoseFocus()
{
	super.OnLoseFocus();
	NavHelp.ClearButtonHelp();
}

simulated function OnReceiveFocus()
{
	super.OnReceiveFocus();
	UpdateNavHelp();
}
//bsg-hlee (05.05.17): End

//==============================================================================
//		CLEANUP:
//==============================================================================

event Destroyed()
{
	super.Destroyed();
}

DefaultProperties
{
	Package = "/ package/gfxTLE_LadderDifficultyMenu/TLE_LadderDifficultyMenu";
	LibID = "TLEDifficultyMenu_SoundtrackSelect"

	InputState = eInputState_Consume;
	bConsumeMouseEvents = true;
	bHideOnLoseFocus = true;
}