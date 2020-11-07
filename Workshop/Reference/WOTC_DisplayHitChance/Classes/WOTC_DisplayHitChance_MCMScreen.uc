//-----------------------------------------------------------
//	Class:	WOTC_DisplayHitChance_MCMScreen
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class WOTC_DisplayHitChance_MCMScreen extends Object config(WOTC_DisplayHitChance);

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_Includes.uci)
`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

var config int				CONFIG_VERSION;

var config bool				TH_AIM_ASSIST;
var config bool				HIT_CHANCE_ENABLED;
var config bool				VERBOSE_TEXT;
var config bool				DISPLAY_MISS_CHANCE;
var config bool				SHOW_TEMPLAR_MSG;
//var config float			FLYOVER_DURATION;
var config bool				SHOW_GUARANTEED_HIT;

//var config int				BAR_HEIGHT, BAR_OFFSET_X, BAR_OFFSET_Y, BAR_WIDTH_MULT, GENERAL_OFFSET_Y;
//var config int				DODGE_OFFSET_X, DODGE_OFFSET_Y, CRIT_OFFSET_X, CRIT_OFFSET_Y;
var config int				BAR_ALPHA, BAR_HEIGHT;
var config string			HIT_HEX_COLOR, CRIT_HEX_COLOR, DODGE_HEX_COLOR, MISS_HEX_COLOR, ASSIST_HEX_COLOR;
var config int				GRAZE_CRIT_LAYOUT;
var config string			GRAZE_CRIT_LAYOUT_MCM;

var config bool				TH_SHOW_GRAZED;
var config bool				TH_SHOW_CRIT_DMG;
var config bool				TH_AIM_LEFT_OF_CRIT;
var config bool				TH_ASSIST_BESIDE_HIT;
var config bool				TH_PREVIEW_MINIMUM;
var config bool				TH_PREVIEW_HACKING;

//var config bool				SHOW_ALWAYS_SHOT_BREAKDOWN_HUD;

var config int				TOOLTIP_ALPHA;
var config bool				ES_TOOLTIP;
var config bool				SHOW_EXTRA_WEAPONSTATS;

var localized string			sBlack;
var localized string			sWhite;
var localized string			sCyan;
var localized string			sFadedCyan;
var localized string			sFadedYellow;
var localized string			sGray;
var localized string			sGreen;
var localized string			sRed;
var localized string			sYellow;
var localized string			sPerkYellow;
var localized string			sCashGreen;
var localized string			sPurple;
var localized string			sOrange;
var localized string			sOrangeEngineering;
var localized string			sBlueScience;
var localized string			sObjIconBackground;

var localized string			sLayoutLeft;
var localized string			sLayoutBalanced;
var localized string			sLayoutRight;

var localized string			sSettingsPage_MCMText;
var localized string			sPageTitle_MCMText;
var localized string			sGroupGeneralSettings_MCMText;
var localized string			sGroupFlyoverSettings_MCMText;
var localized string			sShowHitChance_MCMText;
var localized string			sVerboseText_MCMText;
var localized string			sDisplayMissChance_MCMText;
var localized string			sShowTemplarMessages_MCMText;
var localized string			sShowAimAssist_MCMText;
//var localized string			sFlyoverDuration_MCMText;
var localized string			sShowGuaranteedHit_MCMText;

var localized string			sGroupShotBar_MCMText;
var localized string			sBarHeight_MCMText;
/*var localized string			sBarOffsetX_MCMText;
var localized string			sBarOffsetY_MCMText;*/
var localized string			sBarAlpha_MCMText;
/*var localized string			sBarWidthMult_MCMText;
var localized string			sGeneralOffsetY_MCMText;
var localized string			sDodgeOffsetX_MCMText;
var localized string			sCritOFfsetX_MCMText;
var localized string			sCritOffsetY_MCMText;*/
var localized string			sHitHexColor_MCMText;
var localized string			sCritHexColor_MCMText;
var localized string			sDodgeHexColor_MCMText;
var localized string			sMissHexColor_MCMText;
var localized string			sGroupShotHUD_MCMText;
var localized string			sGroupBarColors_MCMText;
var localized string			sShowGrazed_MCMText;
var localized string			sShowCrit_MCMText;
var localized string			sAimLeftOfCrit_MCMText;
var localized string			sAssistBesideHit_MCMText;
var localized string			sPreviewMinimum_MCMText;
var localized string			sPreviewHacking_MCMText;
var localized string			sWarningMessage_MCMText;
var localized string			sAssistHexColor_MCMText;
var localized string			sGrazeCritLayout_MCMText;


//var localized string			sShowAlwaysShotBreakdownHUD_MCMText;
var localized string			sShowAssistAimBreakdownHUD_MCMText;
//var localized string			sGroupShotWings_MCMText;

var localized string			sToolTipAlpha_MCMText;
var localized string			sGroupToolTips_MCMTtext;
var localized string			sShowEnemyToolTip_MCMText;
var localized string			sShowExtraWeaponStats_MCMText;

var MCM_API_Checkbox			ShowHitChance_MCMUI;
var MCM_API_Checkbox			VerboseText_MCMUI;
var MCM_API_Checkbox			DisplayMissChance_MCMUI;
var MCM_API_Checkbox			ShowTemplarMessages_MCMUI;
var MCM_API_Checkbox			ShowAimAssist_MCMUI;
//var MCM_API_Slider				FlyoverDuration_MCMUI;
var MCM_API_Checkbox			ShowGuaranteedHit_MCMUI;

var MCM_API_Checkbox			ShowGrazed_MCMUI;
var MCM_API_Checkbox			ShowCrit_MCMUI;
var MCM_API_Checkbox			AimLeftOfCrit_MCMUI;
var MCM_API_Checkbox			AssistBesideHit_MCMUI;
var MCM_API_Checkbox			PreviewMinimum_MCMUI;
var MCM_API_Checkbox			PreviewHacking_MCMUI;

var MCM_API_Slider			BarHeight_MCMUI;
/*var MCM_API_Slider			BarOffsetX_MCMUI;
var MCM_API_Slider			BarOffsetY_MCMUI;*/
var MCM_API_Slider			BarAlpha_MCMUI;
/*var MCM_API_Slider			BarWidthMult_MCMUI;
var MCM_API_Slider			GeneralOffsetY_MCMUI;
var MCM_API_Slider			DodgeOffsetX_MCMUI;
var MCM_API_Slider			CritOffsetX_MCMUI;
var MCM_API_Slider			CritOffsetY_MCMUI;*/
var MCM_API_Dropdown			GrazeCritLayout_MCMUI;

var MCM_API_Dropdown			HitHexColor_MCMUI;
var MCM_API_Dropdown			CritHexColor_MCMUI;
var MCM_API_Dropdown			DodgeHexColor_MCMUI;
var MCM_API_Dropdown			MissHexColor_MCMUI;
var MCM_API_Dropdown			AssistHexColor_MCMUI;

//var MCM_API_Checkbox			ShowAlwaysShotBreakdownHUD_MCMUI;

var MCM_API_Slider			ToolTipAlpha_MCMUI;
var MCM_API_Checkbox			ShowEnemyToolTip_MCMUI;
var MCM_API_Checkbox			ShowExtraWeaponStats_MCMUI;


var string					HIT_HEX_COLOR_MCM, CRIT_HEX_COLOR_MCM, DODGE_HEX_COLOR_MCM, MISS_HEX_COLOR_MCM, ASSIST_HEX_COLOR_MCM;
var array<string>			ColorArray, LayoutArray;


//DEBUG
/*var config float				DODGE_OFFSET_Y;
var localized string			sDodgeOffsetY_MCMText;
var MCM_API_Slider			DodgeOffsetY_MCMUI;
`MCM_API_BasicSliderSaveHandler(DodgeOffsetYHandler,		DODGE_OFFSET_Y)*/
//DEBUG


event OnInit(UIScreen Screen)
{
	// Everything in here runs only when you need to touch MCM.
	`MCM_API_Register(Screen, ClientModCallback);
}

`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION,CONFIG_VERSION)

`MCM_API_BasicCheckboxSaveHandler(VerboseTextHandler, VERBOSE_TEXT)
`MCM_API_BasicCheckboxSaveHandler(DisplayMissChanceHandler, DISPLAY_MISS_CHANCE)
`MCM_API_BasicCheckboxSaveHandler(ShowTemplarMessagesHandler, SHOW_TEMPLAR_MSG)
`MCM_API_BasicCheckboxSaveHandler(ShowAimAssistHandler, TH_AIM_ASSIST)
//`MCM_API_BasicSliderSaveHandler(FlyoverDurationHandler,		FLYOVER_DURATION)
`MCM_API_BasicCheckboxSaveHandler(ShowGuaranteedHitHandler, SHOW_GUARANTEED_HIT)

`MCM_API_BasicCheckboxSaveHandler(ShowGrazedHandler,			TH_SHOW_GRAZED)
`MCM_API_BasicCheckboxSaveHandler(ShowCritHandler,			TH_SHOW_CRIT_DMG)
`MCM_API_BasicCheckboxSaveHandler(AimLeftOfCritHandler,		TH_AIM_LEFT_OF_CRIT)
`MCM_API_BasicCheckboxSaveHandler(AssistBesideHitHandler,		TH_ASSIST_BESIDE_HIT)
`MCM_API_BasicCheckboxSaveHandler(PreviewMinimumHandler,		TH_PREVIEW_MINIMUM)
`MCM_API_BasicCheckboxSaveHandler(PreviewHackingHandler,		TH_PREVIEW_HACKING)

`MCM_API_BasicSliderSaveHandler(BarHeightHandler,		BAR_HEIGHT)
/*`MCM_API_BasicSliderSaveHandler(BarOffsetXHandler,		BAR_OFFSET_X)
`MCM_API_BasicSliderSaveHandler(BarOffsetYHandler,		BAR_OFFSET_Y)*/
`MCM_API_BasicSliderSaveHandler(BarAlphaHandler,			BAR_ALPHA)
/*`MCM_API_BasicSliderSaveHandler(BarWidthMultHandler,		BAR_WIDTH_MULT)
`MCM_API_BasicSliderSaveHandler(GeneralOffsetYHandler,	GENERAL_OFFSET_Y)
`MCM_API_BasicSliderSaveHandler(DodgeOffsetXHandler,		DODGE_OFFSET_X)
`MCM_API_BasicSliderSaveHandler(CritOffsetXHandler,		CRIT_OFFSET_X)
`MCM_API_BasicSliderSaveHandler(CritOffsetYHandler,		CRIT_OFFSET_Y)*/
`MCM_API_BasicDropdownSaveHandler(GrazeCritLayoutHandler,	GRAZE_CRIT_LAYOUT_MCM)

`MCM_API_BasicDropdownSaveHandler(HitHexColorHandler,	HIT_HEX_COLOR_MCM)
`MCM_API_BasicDropdownSaveHandler(CritHexColorHandler,	CRIT_HEX_COLOR_MCM)
`MCM_API_BasicDropdownSaveHandler(DodgeHexColorHandler,	DODGE_HEX_COLOR_MCM)
`MCM_API_BasicDropdownSaveHandler(MissHexColorHandler,	MISS_HEX_COLOR_MCM)
//`MCM_API_BasicCheckboxSaveHandler(ThAssistBarHandler,		TH_ASSIST_BAR)
`MCM_API_BasicDropdownSaveHandler(AssistHexColorHandler,	ASSIST_HEX_COLOR_MCM)

//`MCM_API_BasicCheckboxSaveHandler(ShotBreakdownHUDHandler, SHOW_ALWAYS_SHOT_BREAKDOWN_HUD)

`MCM_API_BasicSliderSaveHandler(ToolTipAlphaHandler,		TOOLTIP_ALPHA)
`MCM_API_BasicCheckboxSaveHandler(ShowEnemyToolTipHandler,		ES_TOOLTIP)
`MCM_API_BasicCheckboxSaveHandler(ShowExtraWeaponStatsHandler,		SHOW_EXTRA_WEAPONSTATS)

simulated function CheckBoxChangeHandler(MCM_API_Setting _Setting, bool _SettingValue)
{
	local name	SettingName;
	SettingName = _Setting.GetName();
	switch (SettingName)
	{
		case 'ShowHitChance'	:
			VerboseText_MCMUI.SetEditable(_SettingValue);
			ShowTemplarMessages_MCMUI.SetEditable(_SettingValue);
			//FlyoverDuration_MCMUI.SetEditable(_SettingValue);
			ShowGuaranteedHit_MCMUI.SetEditable(_SettingValue);
			HIT_CHANCE_ENABLED = _SettingValue;
			break;
		case	 'ShowAimAssist':
			AssistBesideHit_MCMUI.SetEditable(_SettingValue);
			AssistHexColor_MCMUI.SetEditable(_SettingValue);
			TH_AIM_ASSIST = _SettingValue;
			break;
		default					: assert(false);
	}
}

simulated function ClientModCallback(MCM_API_Instance ConfigAPI, int GameMode)
{
	// Code goes here.
	local MCM_API_SettingsPage Page;
	local MCM_API_SettingsGroup Group0;
	local MCM_API_SettingsGroup Group1;
	local MCM_API_SettingsGroup Group2;
	local MCM_API_SettingsGroup Group3;
	local MCM_API_SettingsGroup Group4;
	//local MCM_API_SettingsGroup Group5;
	local MCM_API_SettingsGroup Group6;

	ColorArray.AddItem(sBlack);
	ColorArray.AddItem(sWhite);
	ColorArray.AddItem(sCyan);
	ColorArray.AddItem(sFadedCyan);
	ColorArray.AddItem(sFadedYellow);
	ColorArray.AddItem(sGray);
	ColorArray.AddItem(sGreen);
	ColorArray.AddItem(sRed);
	ColorArray.AddItem(sYellow);
	ColorArray.AddItem(sPerkYellow);
	ColorArray.AddItem(sCashGreen);
	ColorArray.AddItem(sPurple);
	ColorArray.AddItem(sOrange);
	ColorArray.AddItem(sOrangeEngineering);
	ColorArray.AddItem(sBlueScience);
	ColorArray.AddItem(sObjIconBackground);

	LayoutArray.AddItem(sLayoutLeft);
	LayoutArray.AddItem(	sLayoutBalanced);
	LayoutArray.AddItem(	sLayoutRight);

	LoadSavedSettings();

	Page = ConfigAPI.NewSettingsPage(sSettingsPage_MCMText);
	Page.SetPageTitle(sPageTitle_MCMText);
	Page.SetSaveHandler(SaveButtonClicked);
	Page.EnableResetButton(ResetButtonClicked);

	Group0 = Page.AddGroup('Group0', sGroupGeneralSettings_MCMText);
	ShowAimAssist_MCMUI				= Group0.AddCheckbox('ShowAimAssist', sShowAimAssist_MCMText, sShowAimAssist_MCMText, TH_AIM_ASSIST, , CheckBoxChangeHandler);
	DisplayMissChance_MCMUI			= Group0.AddCheckbox('DisplayMissChance', sDisplayMissChance_MCMText, sDisplayMissChance_MCMText, DISPLAY_MISS_CHANCE, DisplayMissChanceHandler, );
	Group0.AddLabel('empty_line',"","");
	
	Group1 = Page.AddGroup('Group1', sGroupFlyoverSettings_MCMText);
	ShowHitChance_MCMUI				= Group1.AddCheckbox('ShowHitChance', sShowHitChance_MCMText, sShowHitChance_MCMText, HIT_CHANCE_ENABLED, , CheckBoxChangeHandler);
	VerboseText_MCMUI				= Group1.AddCheckbox('VerboseText', sVerboseText_MCMText, sVerboseText_MCMText, VERBOSE_TEXT, VerboseTextHandler, );
	ShowTemplarMessages_MCMUI		= Group1.AddCheckbox('ShowTemplarMessages', sShowTemplarMessages_MCMText, sShowTemplarMessages_MCMText, SHOW_TEMPLAR_MSG, ShowTemplarMessagesHandler, );
	//FlyoverDuration_MCMUI			= Group1.AddSlider('FlyoverDuration', sFlyoverDuration_MCMText, sFlyoverDuration_MCMText, 1, 25, 1, FLYOVER_DURATION, FlyoverDurationHandler, );
	ShowGuaranteedHit_MCMUI			= Group1.AddCheckbox('ShowGuaranteedHit', sShowGuaranteedHit_MCMText, sShowGuaranteedHit_MCMText, SHOW_GUARANTEED_HIT, ShowGuaranteedHitHandler, );
	VerboseText_MCMUI.SetEditable(HIT_CHANCE_ENABLED);
	ShowTemplarMessages_MCMUI.SetEditable(HIT_CHANCE_ENABLED);
	//FlyoverDuration_MCMUI.SetEditable(HIT_CHANCE_ENABLED);
	ShowGuaranteedHit_MCMUI.SetEditable(HIT_CHANCE_ENABLED);
	Group1.AddLabel('empty_line',"","");

	Group2 = Page.AddGroup('Group2', sGroupShotHUD_MCMText);
	ShowGrazed_MCMUI					= Group2.AddCheckbox('ShowGrazed', sShowGrazed_MCMText, sShowGrazed_MCMText, TH_SHOW_GRAZED, ShowGrazedHandler, );
	ShowCrit_MCMUI					= Group2.AddCheckbox('ShowCrit', sShowCrit_MCMText, sShowCrit_MCMText, TH_SHOW_CRIT_DMG, ShowCritHandler, );
	PreviewMinimum_MCMUI				= Group2.AddCheckbox('PreviewMinimum', sPreviewMinimum_MCMText, sPreviewMinimum_MCMText, TH_PREVIEW_MINIMUM, PreviewMinimumHandler, );
	PreviewHacking_MCMUI				= Group2.AddCheckbox('PreviewHacking', sPreviewHacking_MCMText, sPreviewHacking_MCMText, TH_PREVIEW_HACKING, PreviewHackingHandler, );
	GrazeCritLayout_MCMUI				= Group2.AddDropdown('GrazeCritLayout', sGrazeCritLayout_MCMText, sGrazeCritLayout_MCMText, LayoutArray, GRAZE_CRIT_LAYOUT_MCM, GrazeCritLayoutHandler, );
	Group2.AddLabel('empty_line',"","");

	Group3 = Page.AddGroup('Group3', sGroupShotBar_MCMText);
	/*Group3.AddLabel('Warning1',sWarningMessage_MCMText,"");*/
	BarHeight_MCMUI					= Group3.AddSlider('BarHeight', sBarHeight_MCMText, sBarHeight_MCMText, 0, 20, 1, BAR_HEIGHT, BarHeightHandler, );
	/*BarOffsetX_MCMUI					= Group3.AddSlider('BarOffsetX', sBarOffsetX_MCMText, sBarOffsetX_MCMText, -200, 200, 1, BAR_OFFSET_X, BarOffsetXHandler, );
	BarOffsetY_MCMUI					= Group3.AddSlider('BarOffsetY', sBarOffsetY_MCMText, sBarOffsetY_MCMText, -200, 0, 1, BAR_OFFSET_Y, BarOffsetYHandler, );*/
	BarAlpha_MCMUI					= Group3.AddSlider('BarAlpha', sBarAlpha_MCMText, sBarAlpha_MCMText, 0, 100, 1, BAR_ALPHA, BarAlphaHandler, );
	AimLeftOfCrit_MCMUI				= Group3.AddCheckbox('AimLeftOfCrit', sAimLeftOfCrit_MCMText, sAimLeftOfCrit_MCMText, TH_AIM_LEFT_OF_CRIT, AimLeftOfCritHandler, );
	AssistBesideHit_MCMUI			= Group3.AddCheckbox('AssistBesideHit', sAssistBesideHit_MCMText, sAssistBesideHit_MCMText, TH_ASSIST_BESIDE_HIT, AssistBesideHitHandler, );
	
	//DEBUG
	//DodgeOffsetY_MCMUI				= Group3.AddSlider('DodgeOffsetY', sDodgeOffsetY_MCMText, sDodgeOffsetY_MCMText, -30, -20, 0.01, DODGE_OFFSET_Y, DodgeOffsetYHandler, );
	//DEBUG
	
	/*BarWidthMult_MCMUI				= Group3.AddSlider('BarWidthMult', sBarWidthMult_MCMText, sBarWidthMult_MCMText, 0, 10, 1, BAR_WIDTH_MULT, BarWidthMultHandler, );
	GeneralOffsetY_MCMUI				= Group3.AddSlider('GeneralOffsetY', sGeneralOffsetY_MCMText, sGeneralOffsetY_MCMText, -100, 0, 1, GENERAL_OFFSET_Y, GeneralOffsetYHandler, );
	DodgeOffsetX_MCMUI				= Group3.AddSlider('DodgeOffsetX', sDodgeOffsetX_MCMText, sDodgeOffsetX_MCMText, -300, 600, 1, DODGE_OFFSET_X, DodgeOffsetXHandler, );
	CritOffsetX_MCMUI				= Group3.AddSlider('CritOffsetX', sCritOffsetX_MCMText, sCritOffsetX_MCMText, -300, 300, 1, CRIT_OFFSET_X, CritOffsetXHandler, );
	CritOffsetY_MCMUI				= Group3.AddSlider('CritOffsetY', sCritOffsetY_MCMText, sCritOffsetY_MCMText, -200, 200, 1, CRIT_OFFSET_Y, CritOffsetYHandler, );*/
	AssistBesideHit_MCMUI.SetEditable(TH_AIM_ASSIST);
	AssistHexColor_MCMUI.SetEditable(TH_AIM_ASSIST);
	Group3.AddLabel('empty_line',"","");

	Group4 = Page.AddGroup('Group4', sGroupBarColors_MCMText);
	HitHexColor_MCMUI				= Group4.AddDropdown('HitHexColor', sHitHexColor_MCMText, sHitHexColor_MCMText, ColorArray, HIT_HEX_COLOR_MCM, HitHexColorHandler, );
	CritHexColor_MCMUI				= Group4.AddDropdown('CritHexColor', sCritHexColor_MCMText, sCritHexColor_MCMText, ColorArray, CRIT_HEX_COLOR_MCM, CritHexColorHandler, );
	DodgeHexColor_MCMUI				= Group4.AddDropdown('DodgeHexColor', sDodgeHexColor_MCMText, sDodgeHexColor_MCMText, ColorArray, DODGE_HEX_COLOR_MCM, DodgeHexColorHandler, );
	MissHexColor_MCMUI				= Group4.AddDropdown('MissHexColor', sMissHexColor_MCMText, sMissHexColor_MCMText, ColorArray, MISS_HEX_COLOR_MCM, MissHexColorHandler, );
	AssistHexColor_MCMUI				= Group4.AddDropdown('AssistHexColor', sAssistHexColor_MCMText, sAssistHexColor_MCMText, ColorArray, ASSIST_HEX_COLOR_MCM, AssistHexColorHandler, );
	Group4.AddLabel('empty_line',"","");
	
	/*Group5 = Page.AddGroup('Group5', sGroupShotWings_MCMText);
	ShowHitChance_MCMUI				= Group5.AddCheckbox('ShowAlwaysShotBreakdownHUD', sShowAlwaysShotBreakdownHUD_MCMText, sShowAlwaysShotBreakdownHUD_MCMText, SHOW_ALWAYS_SHOT_BREAKDOWN_HUD, ShotBreakdownHUDHandler, );
	Group5.AddLabel('empty_line',"","");*/

	Group6 = Page.AddGroup('Group6', sGroupToolTips_MCMTtext);
	ToolTipAlpha_MCMUI				= Group6.AddSlider('ToolTipAlpha', sToolTipAlpha_MCMText, sToolTipAlpha_MCMText, 0, 100, 1, TOOLTIP_ALPHA, ToolTipAlphaHandler, );
	ShowEnemyToolTip_MCMUI			= Group6.AddCheckbox('ShowEnemyToolTip', sShowEnemyToolTip_MCMText, sShowEnemyToolTip_MCMText, ES_TOOLTIP, ShowEnemyToolTipHandler, );
	ShowExtraWeaponStats_MCMUI		= Group6.AddCheckbox('ShowExtraWeaponStats', sShowExtraWeaponStats_MCMText, sShowExtraWeaponStats_MCMText, SHOW_EXTRA_WEAPONSTATS, ShowExtraWeaponStatsHandler, );
	Group6.AddLabel('empty_line',"","");

	Page.ShowSettings();
}

simulated function LoadSavedSettings()
{
    HIT_CHANCE_ENABLED =		`MCM_CH_GetValue(class'MCM_Defaults'.default.HIT_CHANCE_ENABLED,HIT_CHANCE_ENABLED);
    TH_AIM_ASSIST =			`MCM_CH_GetValue(class'MCM_Defaults'.default.TH_AIM_ASSIST,TH_AIM_ASSIST);
	VERBOSE_TEXT =			`MCM_CH_GetValue(class'MCM_Defaults'.default.VERBOSE_TEXT,VERBOSE_TEXT);
	DISPLAY_MISS_CHANCE =	`MCM_CH_GetValue(class'MCM_Defaults'.default.DISPLAY_MISS_CHANCE,DISPLAY_MISS_CHANCE);
	SHOW_TEMPLAR_MSG =		`MCM_CH_GetValue(class'MCM_Defaults'.default.SHOW_TEMPLAR_MSG,SHOW_TEMPLAR_MSG);
	BAR_HEIGHT =				`MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_HEIGHT,BAR_HEIGHT);
	/*BAR_OFFSET_X =			`MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_OFFSET_X,BAR_OFFSET_X);
	BAR_OFFSET_Y =			`MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_OFFSET_Y,BAR_OFFSET_Y);*/
	BAR_ALPHA =				`MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_ALPHA,BAR_ALPHA);
	/*BAR_WIDTH_MULT =			`MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_WIDTH_MULT,BAR_WIDTH_MULT);
	GENERAL_OFFSET_Y =		`MCM_CH_GetValue(class'MCM_Defaults'.default.GENERAL_OFFSET_Y,GENERAL_OFFSET_Y);
	DODGE_OFFSET_X =			`MCM_CH_GetValue(class'MCM_Defaults'.default.DODGE_OFFSET_X,DODGE_OFFSET_X);
	CRIT_OFFSET_X =			`MCM_CH_GetValue(class'MCM_Defaults'.default.CRIT_OFFSET_X,CRIT_OFFSET_X);
	CRIT_OFFSET_Y =			`MCM_CH_GetValue(class'MCM_Defaults'.default.CRIT_OFFSET_Y,CRIT_OFFSET_Y);*/
	HIT_HEX_COLOR =			`MCM_CH_GetValue(class'MCM_Defaults'.default.HIT_HEX_COLOR,HIT_HEX_COLOR);
	CRIT_HEX_COLOR =			`MCM_CH_GetValue(class'MCM_Defaults'.default.CRIT_HEX_COLOR,CRIT_HEX_COLOR);
	DODGE_HEX_COLOR =		`MCM_CH_GetValue(class'MCM_Defaults'.default.DODGE_HEX_COLOR,DODGE_HEX_COLOR);
	MISS_HEX_COLOR =			`MCM_CH_GetValue(class'MCM_Defaults'.default.MISS_HEX_COLOR,MISS_HEX_COLOR);
	ASSIST_HEX_COLOR =		`MCM_CH_GetValue(class'MCM_Defaults'.default.ASSIST_HEX_COLOR,ASSIST_HEX_COLOR);
	TH_SHOW_GRAZED =			`MCM_CH_GetValue(class'MCM_Defaults'.default.TH_SHOW_GRAZED,TH_SHOW_GRAZED);
	TH_SHOW_CRIT_DMG =		`MCM_CH_GetValue(class'MCM_Defaults'.default.TH_SHOW_CRIT_DMG,TH_SHOW_CRIT_DMG);
	TH_AIM_LEFT_OF_CRIT =	`MCM_CH_GetValue(class'MCM_Defaults'.default.TH_AIM_LEFT_OF_CRIT,TH_AIM_LEFT_OF_CRIT);
	TH_ASSIST_BESIDE_HIT =	`MCM_CH_GetValue(class'MCM_Defaults'.default.TH_ASSIST_BESIDE_HIT,TH_ASSIST_BESIDE_HIT);
	TH_PREVIEW_MINIMUM =		`MCM_CH_GetValue(class'MCM_Defaults'.default.TH_PREVIEW_MINIMUM,TH_PREVIEW_MINIMUM);
	TH_PREVIEW_HACKING =		`MCM_CH_GetValue(class'MCM_Defaults'.default.TH_PREVIEW_HACKING,TH_PREVIEW_HACKING);
	HIT_HEX_COLOR_MCM = getStringColorFromHex(HIT_HEX_COLOR);
	CRIT_HEX_COLOR_MCM = getStringColorFromHex(CRIT_HEX_COLOR);
	DODGE_HEX_COLOR_MCM = getStringColorFromHex(DODGE_HEX_COLOR);
	MISS_HEX_COLOR_MCM = getStringColorFromHex(MISS_HEX_COLOR);
	ASSIST_HEX_COLOR_MCM = getStringColorFromHex(ASSIST_HEX_COLOR);
	TOOLTIP_ALPHA =			`MCM_CH_GetValue(class'MCM_Defaults'.default.TOOLTIP_ALPHA,TOOLTIP_ALPHA);
	ES_TOOLTIP =				`MCM_CH_GetValue(class'MCM_Defaults'.default.ES_TOOLTIP,ES_TOOLTIP);
	SHOW_EXTRA_WEAPONSTATS = `MCM_CH_GetValue(class'MCM_Defaults'.default.SHOW_EXTRA_WEAPONSTATS,SHOW_EXTRA_WEAPONSTATS);
	//FLYOVER_DURATION = `MCM_CH_GetValue(class'MCM_Defaults'.default.FLYOVER_DURATION,FLYOVER_DURATION);
	SHOW_GUARANTEED_HIT =	`MCM_CH_GetValue(class'MCM_Defaults'.default.SHOW_GUARANTEED_HIT,SHOW_GUARANTEED_HIT);
	GRAZE_CRIT_LAYOUT =		`MCM_CH_GetValue(class'MCM_Defaults'.default.GRAZE_CRIT_LAYOUT,GRAZE_CRIT_LAYOUT);
	GRAZE_CRIT_LAYOUT_MCM = getLayoutTextFromIndex(GRAZE_CRIT_LAYOUT);

	//DEBUG
	//DODGE_OFFSET_Y =			`MCM_CH_GetValue(class'MCM_Defaults'.default.DODGE_OFFSET_Y,DODGE_OFFSET_Y);
	//DEBUG
}

simulated function ResetButtonClicked(MCM_API_SettingsPage Page)
{
	ShowHitChance_MCMUI.SetValue(	class'MCM_Defaults'.default.HIT_CHANCE_ENABLED, true);
	VerboseText_MCMUI.SetValue(	class'MCM_Defaults'.default.VERBOSE_TEXT, false);
	DisplayMissChance_MCMUI.SetValue(	class'MCM_Defaults'.default.DISPLAY_MISS_CHANCE, false);
	ShowTemplarMessages_MCMUI.SetValue(	class'MCM_Defaults'.default.SHOW_TEMPLAR_MSG, false);
	BarHeight_MCMUI.SetValue(	class'MCM_Defaults'.default.BAR_HEIGHT, false);
	/*BarOffsetX_MCMUI.SetValue(	class'MCM_Defaults'.default.BAR_OFFSET_X, false);
	BarOffsetY_MCMUI.SetValue(	class'MCM_Defaults'.default.BAR_OFFSET_Y, false);*/
	BarAlpha_MCMUI.SetValue(	class'MCM_Defaults'.default.BAR_ALPHA, false);
	/*BarWidthMult_MCMUI.SetValue(	class'MCM_Defaults'.default.BAR_WIDTH_MULT, false);
	GeneralOffsetY_MCMUI.SetValue(	class'MCM_Defaults'.default.GENERAL_OFFSET_Y, false);
	DodgeOffsetX_MCMUI.SetValue(	class'MCM_Defaults'.default.DODGE_OFFSET_X, false);
	DodgeOffsetY_MCMUI.SetValue(	class'MCM_Defaults'.default.DODGE_OFFSET_Y, false);
	CritOffsetX_MCMUI.SetValue(	class'MCM_Defaults'.default.CRIT_OFFSET_X, false);
	CritOffsetY_MCMUI.SetValue(	class'MCM_Defaults'.default.CRIT_OFFSET_Y, false);*/
	ShowGrazed_MCMUI.SetValue(	class'MCM_Defaults'.default.TH_SHOW_GRAZED, false);
	ShowCrit_MCMUI.SetValue(	class'MCM_Defaults'.default.TH_SHOW_CRIT_DMG, false);
	AimLeftOfCrit_MCMUI.SetValue(	class'MCM_Defaults'.default.TH_AIM_LEFT_OF_CRIT, false);
	AssistBesideHit_MCMUI.SetValue(	class'MCM_Defaults'.default.TH_ASSIST_BESIDE_HIT, false);
	PreviewMinimum_MCMUI.SetValue(	class'MCM_Defaults'.default.TH_PREVIEW_MINIMUM, false);
	PreviewHacking_MCMUI.SetValue(	class'MCM_Defaults'.default.TH_PREVIEW_HACKING, false);
	HitHexColor_MCMUI.SetValue(	getStringColorFromHex(class'MCM_Defaults'.default.HIT_HEX_COLOR), false);
	CritHexColor_MCMUI.SetValue(	getStringColorFromHex(class'MCM_Defaults'.default.CRIT_HEX_COLOR), false);
	DodgeHexColor_MCMUI.SetValue(	getStringColorFromHex(class'MCM_Defaults'.default.DODGE_HEX_COLOR), false);
	MissHexColor_MCMUI.SetValue(	getStringColorFromHex(class'MCM_Defaults'.default.MISS_HEX_COLOR), false);
	AssistHexColor_MCMUI.SetValue(	getStringColorFromHex(class'MCM_Defaults'.default.ASSIST_HEX_COLOR), false);
	ShowAimAssist_MCMUI.SetValue(	class'MCM_Defaults'.default.TH_AIM_ASSIST, false);
	ToolTipAlpha_MCMUI.SetValue(	class'MCM_Defaults'.default.TOOLTIP_ALPHA, false);
	ShowEnemyToolTip_MCMUI.SetValue(	class'MCM_Defaults'.default.ES_TOOLTIP, false);
	ShowExtraWeaponStats_MCMUI.SetValue(	class'MCM_Defaults'.default.SHOW_EXTRA_WEAPONSTATS, false);
	//FlyoverDuration_MCMUI.SetValue (class'MCM_Defaults'.default.FLYOVER_DURATION, false);
	ShowGuaranteedHit_MCMUI.SetValue(class'MCM_Defaults'.default.SHOW_GUARANTEED_HIT, false);
	GrazeCritLayout_MCMUI.SetValue(getLayoutTextFromIndex(class'MCM_Defaults'.default.GRAZE_CRIT_LAYOUT), false);
}

simulated function SaveButtonClicked(MCM_API_SettingsPage Page)
{
 	HIT_HEX_COLOR = getHexColorByString(HIT_HEX_COLOR_MCM);
	CRIT_HEX_COLOR = getHexColorByString(CRIT_HEX_COLOR_MCM);
	DODGE_HEX_COLOR = getHexColorByString(DODGE_HEX_COLOR_MCM);
	MISS_HEX_COLOR = getHexColorByString(MISS_HEX_COLOR_MCM);
	ASSIST_HEX_COLOR = getHexColorByString(ASSIST_HEX_COLOR_MCM);
	GRAZE_CRIT_LAYOUT = getIndexFromLayoutText(GRAZE_CRIT_LAYOUT_MCM);
	self.CONFIG_VERSION = `MCM_CH_GetCompositeVersion();
	self.SaveConfig();
}

function string getHexColorByString(string ColorString)
{
	switch (ColorString)
	{
		case		sBlack:					return "FFFFFF";
		case		sWhite:					return "000000";
		case		sCyan:					return "9acbcb";
		case		sFadedCyan:				return "546f6f";
		case		sFadedYellow:			return "aca68a";
		case		sGray:					return "828282";
		case		sGreen:					return "53b45e";
		case		sRed:					return "bf1e2e";
		case		sYellow:					return "fdce2b";
		case		sPerkYellow:				return "fef4cb";
		case		sCashGreen:				return "5CD16C";
		case		sPurple:					return "b6b3e3";
		case		sOrange:					return "e69831";
		case		sOrangeEngineering:		return "f7941e";
		case		sBlueScience:			return "27aae1";
		case		sObjIconBackground:		return "53b45e";
		default : return "828282";
	}
}

function string getStringColorFromHex(string ColorString)
{
	switch (ColorString)
	{
		case		"FFFFFF"	 : return sBlack;				
		case		"000000"	 : return sWhite;				
		case		"9acbcb"	 : return sCyan;		
		case		"546f6f"	 : return sFadedCyan;		
		case		"aca68a"	 : return sFadedYellow;		
		case		"828282"	 : return sGray;			
		case		"53b45e"	 : return sGreen;				
		case		"bf1e2e"	 : return sRed;		
		case		"fdce2b"	 : return sYellow;		
		case		"fef4cb"	 : return sPerkYellow;			
		case		"5CD16C"	 : return sCashGreen;			
		case		"b6b3e3"	 : return sPurple;				
		case		"e69831"	 : return sOrange;	
		case		"f7941e"	 : return sOrangeEngineering;
		case		"27aae1"	 : return sBlueScience;
		case		"53b45e"	 : return sObjIconBackground;
		default : return sGray;
	}
}

function int getIndexFromLayoutText(string LayoutText)
{
	switch (LayoutText)
	{
		case sLayoutLeft : 
			return 0;
		case sLayoutBalanced :
			return 1;
		case sLayoutRight : 
			return 2;
		default :
			return 1;
	}
}

function string getLayoutTextFromindex(int Index)
{
	switch (Index)
	{
		case 0 : 
			return sLayoutLeft;
		case 1 :
			return sLayoutBalanced;
		case 2 : 
			return sLayoutRight;
		default :
			return sLayoutBalanced;
	}
}
