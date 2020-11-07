//---------------------------------------------------------------------------------------
//  FILE:    XComOnlineProfileSettingsDataBlob.uc
//  AUTHOR:  Ryan McFall  --  08/22/2011
//  PURPOSE: This lightweight objects is what is serialized as a blob in XCom's online
//           player profile
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class XComOnlineProfileSettingsDataBlob extends Object
	dependson(XComContentManager, X2CardManager, X2TacticalGameRulesetDataStructures, X2MPData_Native)
	native(Core) config(UI);

struct native MarketingPreset
{
	var string PresetName;
	var array<name> CheckboxSettings; //If a check box's name is in the list, it is checked
	var bool bDOFEnable;
	var float DOFFocusDistance;
	var float DOFFocusRadius;
	var float DOFMaxNearBlur;
	var float DOFMaxFarBlur;
};

struct native NarrativeContentFlag
{
	var bool NarrativeContentEnabled;
	var name DLCName;
};

struct native CustomizationAlertInfo
{
	var int Category;
	var name DLCName;
};

struct native LadderProgress
{
	var int LadderIndex;
	var int LadderHighScore;
};

struct native LadderMissionID
{
	var int LadderIndex;
	var int MissionIndex;
};

struct native TLEHubStats
{
	var int SuccessfulLadders;
	var array<LadderMissionID> LadderCompletions;

	var int NumSkirmishes;
	var int NumSkirmishVictories;

	var int NumOfflineChallengeVictories;
	var int OfflineChallengeHighScore;
	var array<int> OfflineChallengeCompletion;
};

var MarketingPreset MarketingPresets;

// Stores the player's selection for the part packs ( chance to see the various parts show up on generated soldiers )
var array<PartPackPreset> PartPackPresets;

// Single Player Tactical Debug Launch
var array<byte>                         TacticalGameStartState; //Compressed data representing the last game state used to launch a tactical game

//X-Com 2
//=====================================================
var array<SavedCardDeck>                SavedCardDecks; // Save data for the X2CardManager
var array<byte>                         X2MPLoadoutGameStates;
var array<byte>                         X2MPTempLobbyLoadout; // temporary loadout used when transitioning into an online game. necessary in the event a player makes changes to a squad but doesnt want to save it. -tsmith
var int                                 X2MPShellLastEditLoadoutId;  // loadout that was selected before creating/joining a game lobby -tsmith
var array<TX2UnitPresetData>            X2MPUnitPresetData;
var int                                 NumberOfMy2KConversionAttempts;
//=====================================================

var array<int>                          m_arrGameOptions;
var array<int>                          m_arrGamesSubmittedToMCP_Victory;
var array<int>                          m_arrGamesSubmittedToMCP_Loss;

var int                                 m_iPodGroup; // Deprecated

//  single player games started
var int  m_iGames;
var int m_Ladders;	// number of ladders started

// Settings
var bool m_bMuteSoundFX;
var bool m_bMuteMusic;
var bool m_bMuteVoice;

var bool m_bVSync; 
var bool m_bAutoSave;

// Never use m_bActivateMouse.  Always use the accessor function IsMouseActive().  -dwuenschell
var protected bool m_bActivateMouse;
var EControllerIconType m_eControllerIconType; 
var transient bool m_bIsConsoleBuild;
var bool m_bAbilityGrid;
var float m_GeoscapeSpeed;
var float	m_fScrollSpeed;

var bool	m_bSmoothCursor;
var float CursorSpeed;
//</workshop>
var bool	m_bGlamCam;
var bool	m_bForeignLanguages;
var bool	m_bAmbientVO;
var bool	m_bShowEnemyHealth; 
var bool	m_bEnableSoldierSpeech;
var bool	m_bSubtitles;
var bool	m_bPushToTalk;
var bool	m_bPlayerHasUncheckedBoxTutorialSetting;
var bool	m_bPlayerHasUncheckedBoxXPackNarrativeSetting;
var bool	m_bPlayerHasSeenNoAchievesInChallenge;
var bool	m_bTargetPreviewAlwaysOn;
var bool	m_bLadderNarrativesOn;
var int		m_iMasterVolume;
var int		m_iVoiceVolume;
var int		m_iFXVolume;
var int		m_iMusicVolume;
var int		m_iGammaPercentage;
var int		m_iSoundtrackChoice;
var float	m_fGamma;
var int		m_iLastUsedMPLoadoutId; // Multiple MP Squad Loadouts -ttalley
var float	UnitMovementSpeed; //Adjusts how fast units move around - 1.0f, the default settings, does not alter the movement rate from what was authored.

// For tracking achievements whose conditions do not have to be met in the same game
var array<bool> arrbSkulljackedUnits;
var int m_HeavyWeaponKillMask;
var int	m_ContinentBonusMask;
var int m_BlackMarketSuppliesReceived;
var int m_iGlobalAlienKills;
var int m_iVOIPVolume;

// Character Pool Usage
var ECharacterPoolSelectionMode m_eCharPoolUsage;
var bool bEnableZipMode;
var int MaxVisibleCrew;

// Character customization usage 
var array<int> m_arrCharacterCustomizationCategoriesClearedAttention; // DEPRECATED. Converted in XComCharacterCustomization.Init
var array<CustomizationAlertInfo> m_arrCharacterCustomizationCategoriesInfo; //Used from DLC2 forward, for all DLCs.

// DLC Narrative Tracking
var array<NarrativeContentFlag> m_arrNarrativeContentEnabled;
var bool m_bXPackNarrative; 

var config bool bForceController;
var config int ForceConsole;
var EConsoleType ConsoleType;

var array<LadderProgress> LadderScores;
var TLEHubStats HubStats;

function int GetLadderHighScore( int LadderIndex )
{
	local LadderProgress Score;

	foreach LadderScores( Score )
	{
		if (Score.LadderIndex == LadderIndex)
			return Score.LadderHighScore;
	}

	return -1;
}

function AddLadderHighScore( int LadderIndex, int NewScore )
{
	local int Idx;
	local LadderProgress NewHighScore;

	for (Idx = 0; Idx < LadderScores.Length; ++Idx)
	{
		if (LadderScores[Idx].LadderIndex != LadderIndex)
			continue;

		if (LadderScores[Idx].LadderHighScore < NewScore)
			LadderScores[Idx].LadderHighScore = NewScore;

		break;
	}

	if (Idx == LadderScores.Length)
	{
		NewHighScore.LadderIndex = LadderIndex;
		NewHighScore.LadderHighScore = NewScore;

		LadderScores.AddItem( NewHighScore );
	}
}

function int GetHighestLadderScore( )
{
	local int HighScore;
	local LadderProgress Score;

	HighScore = 0;

	foreach LadderScores( Score )
	{
		if (Score.LadderHighScore > HighScore)
			HighScore = Score.LadderHighScore;
	}

	return HighScore;
}

event EConsoleType GetConsoleType()
{
	return ConsoleType;
}

event bool IsConsoleBuild(optional EConsoleType eConsoleType = CONSOLE_Any)
{
	if (m_bIsConsoleBuild)
	{
		return ConsoleType == eConsoleType || eConsoleType == CONSOLE_Any;
	}

	return false;
}
event bool IsMouseActive()
{
	//if( m_bIsConsoleBuild ) 
	//	return false;
	//
	return m_bActivateMouse;
}

function ActivateMouse( bool activate )
{
	ScriptTrace();

	if (bForceController)
	{
		m_bActivateMouse = false;
	}
	else
	{
		m_bActivateMouse = activate;
	}
	XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).SetIsMouseActive(m_bActivateMouse);

}

function SetControllerIconType( EControllerIconType eNewType )
{
	m_eControllerIconType = eNewType;

	ActivateMouse(m_eControllerIconType == eControllerIconType_Mouse);
}

function int GetGamesStarted()
{
	return m_iGames;
}

function bool IfGameStatsSubmitted( int iGame, bool bVictory )
{
	if( bVictory )
		return m_arrGamesSubmittedToMCP_Victory.Find( iGame ) != -1;
	else
		return m_arrGamesSubmittedToMCP_Loss.Find( iGame ) != -1;

}
function GameStatsSubmitted( int iGame, bool bVictory )
{
	if( bVictory )
		m_arrGamesSubmittedToMCP_Victory.AddItem( iGame );
	else
		m_arrGamesSubmittedToMCP_Loss.AddItem( iGame );

}

function SetGameplayOption( int eOption, bool bEnable )
{
	if( m_arrGameOptions.Length <= eOption )
	{
		m_arrGameOptions.Add(1 + eOption - m_arrGameOptions.Length);
	}

	if(bEnable)
		m_arrGameOptions[eOption] = 1;
	else
		m_arrGameOptions[eOption] = 0;
}

function ClearGameplayOptions()
{
	local int iOption;

	for( iOption = 0; iOption < m_arrGameOptions.Length; iOption++ )
	{
		m_arrGameOptions[iOption] = 0;
	}
}

function bool IsSecondWaveUnlocked()
{
	return false;
}

// Moved to script because of craziness involving converting eOptions into FStrings - sbatista 5/11/12
function bool IsGameplayToggleUnlocked( int eOption )
{
	if( !IsSecondWaveUnlocked() ) return false;
	
	return true;
}

native function bool GetGameplayOption( int eOption );

function Options_ResetToDefaults( bool bInShell )
{
	//In Japanese or Korean, default to the subtitles on. 
	if( GetLanguage() == "JPN" || GetLanguage() == "KOR" )
	{
		m_bSubtitles = true; 
	}
	else
	{	
		m_bSubtitles = false; 
	}
	`XENGINE.bSubtitlesEnabled = m_bSubtitles;

	m_bMuteSoundFX  = class'XComOnlineProfileSettingsDataBlob'.default.m_bMuteSoundFX;
	m_bMuteMusic    = class'XComOnlineProfileSettingsDataBlob'.default.m_bMuteMusic;
	m_bMuteVoice    = class'XComOnlineProfileSettingsDataBlob'.default.m_bMuteVoice;
	m_bVSync        = class'XComOnlineProfileSettingsDataBlob'.default.m_bVSync; 
	m_bAutoSave     = class'XComOnlineProfileSettingsDataBlob'.default.m_bAutoSave;

	m_bIsConsoleBuild   = `GAMECORE.WorldInfo.IsConsoleBuild();

	//UI: We can not let you change input device while in game. The Ui will explode. Legacy issues. -bsteiner
	if( bInShell )
	{
		m_bActivateMouse    = class'Engine'.static.IsSteamBigPicture() ? false : !m_bIsConsoleBuild;

		XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).SetIsMouseActive(m_bActivateMouse);
	}

	m_bAbilityGrid = class'XComOnlineProfileSettingsDataBlob'.default.m_bAbilityGrid;
	m_GeoscapeSpeed = class'XComOnlineProfileSettingsDataBlob'.default.m_GeoscapeSpeed;
	CursorSpeed = class'XComOnlineProfileSettingsDataBlob'.default.CursorSpeed;
	//</workshop>
	m_fScrollSpeed      = class'XComOnlineProfileSettingsDataBlob'.default.m_fScrollSpeed;
	m_bForeignLanguages = class'XComOnlineProfileSettingsDataBlob'.default.m_bForeignLanguages;
	m_bAmbientVO		= class'XComOnlineProfileSettingsDataBlob'.default.m_bAmbientVO;
	m_bSmoothCursor     = class'XComOnlineProfileSettingsDataBlob'.default.m_bSmoothCursor;
	m_bGlamCam          = class'XComOnlineProfileSettingsDataBlob'.default.m_bGlamCam;
	m_bShowEnemyHealth  = class'XComOnlineProfileSettingsDataBlob'.default.m_bShowEnemyHealth; 
	m_bEnableSoldierSpeech = class'XComOnlineProfileSettingsDataBlob'.default.m_bEnableSoldierSpeech;

	m_iMasterVolume = class'XComOnlineProfileSettingsDataBlob'.default.m_iMasterVolume;
	m_iVoiceVolume  = class'XComOnlineProfileSettingsDataBlob'.default.m_iVoiceVolume;
	m_iFXVolume     = class'XComOnlineProfileSettingsDataBlob'.default.m_iFXVolume;
	m_iMusicVolume  = class'XComOnlineProfileSettingsDataBlob'.default.m_iMusicVolume;
	m_iVOIPVolume   = class'XComOnlineProfileSettingsDataBlob'.default.m_iVOIPVolume;

	m_bPlayerHasSeenNoAchievesInChallenge = class'XComOnlineProfileSettingsDataBlob'.default.m_bPlayerHasSeenNoAchievesInChallenge;
	m_bPlayerHasUncheckedBoxTutorialSetting = class'XComOnlineProfileSettingsDataBlob'.default.m_bPlayerHasUncheckedBoxTutorialSetting;
	m_bPlayerHasUncheckedBoxXPackNarrativeSetting = class'XComOnlineProfileSettingsDataBlob'.default.m_bPlayerHasUncheckedBoxXPackNarrativeSetting;

	m_arrNarrativeContentEnabled.Length = 0;
	bEnableZipMode = class'XComOnlineProfileSettingsDataBlob'.default.bEnableZipMode;

	LadderScores.Length = 0;
}

defaultproperties
{
	m_bMuteSoundFX=false
	m_bMuteMusic=false
	m_bMuteVoice=false
	m_bActivateMouse=true
	m_fScrollSpeed=50
	m_bSmoothCursor=true
	m_bGlamCam=true
	m_bVSync=true
	m_bShowEnemyHealth=true;
	m_bEnableSoldierSpeech=true
	m_bForeignLanguages=false
	m_bAmbientVO=true
	m_bTargetPreviewAlwaysOn=false
	m_bPlayerHasSeenNoAchievesInChallenge=false
	m_bLadderNarrativesOn = true

	m_iSoundtrackChoice = -1
	m_iMasterVolume = 80
	m_iVoiceVolume = 80
	m_iFXVolume = 80
	m_iMusicVolume = 80
	m_iVOIPVolume = 80
	m_iGammaPercentage = 50
	m_fGamma = 2.2
	m_bIsConsoleBuild = false
	CursorSpeed = 58
	m_bAbilityGrid = false
	m_GeoscapeSpeed = 50
	ConsoleType=CONSOLE_Any
	bEnableZipMode = false
	m_bPlayerHasUncheckedBoxTutorialSetting = false;
	m_bPlayerHasUncheckedBoxXPackNarrativeSetting = false;
	UnitMovementSpeed = 1.0f;
	
	m_bPushToTalk=false
	m_bAutoSave=true

	m_eCharPoolUsage=eCPSM_PoolOnly
	MaxVisibleCrew=30

	m_eControllerIconType = eControllerIconType_Mouse

	m_bXPackNarrative = true;

	// start off the ladders at something non-zero to save space for published ladders
	m_Ladders = 9
}
