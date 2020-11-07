//-----------------------------------------------------------
//	Class:	UITacticalHUD_SoldierInfoTooltip_HitChance
//	Author: tjnome / Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------
//`define SL class'StatListLib'.static

class UITacticalHUD_SoldierInfoTooltip_HitChance extends UITacticalHUD_SoldierInfoTooltip;

var	int TOOLTIP_ALPHA;

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

var UIPanel BGBox;
var UIScrollingText Title;
var UIPanel Line;
var UIIcon Icon, RankIcon;

var int TITLE_PADDING, DeadHeight, PaddingForAbilityList, ICON_H_PADDING, ICON_V_PADDING, ICON_SIZE, TEXT_PADDING, RANK_ICON_SIZE, RANK_ICON_H_PADDING, RANK_ICON_V_PADDING;

var localized string KILLS_LABEL;
var localized string ASSIST_LABEL;
var localized string FLANKING_CRIT_LABEL;

simulated function UIPanel InitSoldierStats(optional name InitName, optional name InitLibID)
{
	Super.InitSoldierStats(InitName, InitLibID);

	Title = Spawn(class'UIScrollingText', BodyArea).InitScrollingText('Title');
	//Title.SetPosition(PADDING_LEFT + TITLE_PADDING, PADDING_TOP);
	Title.SetPosition(ICON_SIZE + 2 * ICON_H_PADDING + TEXT_PADDING, PADDING_TOP);
	Title.SetWidth(width - TITLE_PADDING - ICON_SIZE - Title.X);

	Icon = Spawn(class'UIIcon', BodyArea);
	Icon.InitIcon(,,false,true,ICON_SIZE);
	Icon.SetPosition(ICON_H_PADDING, ICON_V_PADDING);

	RankIcon = Spawn(class'UIIcon', BodyArea);
	RankIcon.InitIcon(,,false,true,RANK_ICON_SIZE);
	RankIcon.SetPosition(RANK_ICON_H_PADDING, RANK_ICON_V_PADDING);

	Line = class'UIUtilities_Controls'.static.CreateDividerLineBeneathControl(Icon, , 2);
	Line.SetX(0);
	Line.SetWidth(width);

	DeadHeight=Title.Y + Title.height + PaddingForAbilityList + PADDING_BOTTOM;	

	StatList.SetPosition(PADDING_LEFT, Title.Y + Title.height + PaddingForAbilityList);
	StatList.SetWidth(BodyArea.width-PADDING_RIGHT);
	StatList.SetHeight(BodyArea.Height-DeadHeight);
	StatList.PADDING_RIGHT=class'UIStatList'.default.PADDING_RIGHT/2;
	StatList.OnSizeRealized = OnStatsListSizeRealized;
	BodyMask = Spawn(class'UIMask', BodyArea).InitMask('Mask', StatList).FitMask(StatList); 
	BGBox=GetChild('BGBoxSimple');

	Height=StatsHeight;
	StatsHeight=StatList.Height;
	BGBox.SetAlpha(getTOOLTIP_ALPHA()); // Setting transparency
	BodyArea.Alpha=100; // Stupid fudge!
	return self;
}

`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)

simulated function array<UISummary_ItemStat> GetSoldierStats(XComGameState_Unit kGameStateUnit)
{
	local X2SoldierClassTemplateManager SoldierTemplateManager;

	//Icon.SetForegroundColor(class'UIUtilities_Colors'.const.BLACK_HTML_COLOR);
	//Icon.SetBGColorState(Visualizer.GetMyHUDIconColor());
	if( kGameStateUnit.GetMyTemplateName() == 'AdvPsiWitchM2' )
	{
		SoldierTemplateManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
		 
		Title.SetX(ICON_SIZE);
		Title.SetWidth(width - Title.X - TITLE_PADDING - ICON_H_PADDING - TEXT_PADDING);
		DrawIcons(ICON_SIZE * 2, -ICON_SIZE, -ICON_SIZE, class'UIUtilities_Image'.static.ValidateImagePath(SoldierTemplateManager.FindSoldierClassTemplate('PsiOperative').IconImage), RANK_ICON_SIZE, width - RANK_ICON_SIZE / 2 - TEXT_PADDING, -RANK_ICON_SIZE / 2, class'UIUtilities_Image'.static.ValidateImagePath("img:///UILibrary_Common.rank_fieldmarshall"));
	}
	else 
	{
		if( kGameStateUnit.IsSoldier() )
		{
			Title.SetX(ICON_SIZE);
			Title.SetWidth(width - Title.X - TITLE_PADDING - ICON_H_PADDING - TEXT_PADDING);
			DrawIcons(ICON_SIZE * 2, -ICON_SIZE, -ICON_SIZE, class'UIUtilities_Image'.static.ValidateImagePath(kGameStateUnit.GetSoldierClassTemplate().IconImage), RANK_ICON_SIZE, width - RANK_ICON_SIZE / 2 - TEXT_PADDING, -RANK_ICON_SIZE / 2, class'UIUtilities_Image'.static.ValidateImagePath(class'UIUtilities_Image'.static.GetRankIcon(kGameStateUnit.GetRank(), kGameStateUnit.GetSoldierClassTemplateName())));
		}
		else if( kGameStateUnit.IsCivilian() )
		{
			Title.SetX(TITLE_PADDING);
			Title.SetWidth(width - PADDING_LEFT - TITLE_PADDING - PADDING_RIGHT);
			DrawIcons();
		}
		else // is enemy
		{
			Title.SetX(ICON_SIZE + TEXT_PADDING);
			Title.SetWidth(width - Title.X - TITLE_PADDING);
			DrawIcons(ICON_SIZE, PADDING_LEFT, ICON_V_PADDING, class'UIUtilities_Image'.static.ValidateImagePath(kGameStateUnit.IsAdvent() ? "img:///UILibrary_Common.UIEvent_advent" : "img:///UILibrary_Common.UIEvent_alien"));
		}
	}
	//Icon.LoadIconBG(class'UIUtilities_Image'.static.ValidateImagePath(kGameStateUnit.GetSoldierClassTemplate().IconImage$"_bg"));
	//Icon.SetBGShape(eDiamond);
	//Icon.SetAlpha(85);


	Title.SetHTMLText( class'UIUtilities_Text'.static.StyleText(kGameStateUnit.GetName(eNameType_FullNick), eUITextStyle_Tooltip_Title) );
	return class'StatListLib'.static.GetStats(kGameStateUnit, true);
}

simulated function DrawIcons(optional int iClassIconSize, optional int iClassIconHPadding, optional int iClassIconVPadding, optional string sClassIcon, optional int iRankIconSize, optional int iRankIconHPadding, optional int iRankIconVPadding, optional string sRankIcon)
{

	Icon.Hide();
	RankIcon.Hide();

	if(sClassIcon != "")
	{
		Icon.SetSize(iClassIconSize, iClassIconSize);
		Icon.SetPosition(iClassIconHPadding, iClassIconVPadding);
		Icon.bAnimateOnInit = false;
		Icon.LoadIcon(class'UIUtilities_Image'.static.ValidateImagePath(sClassIcon));
		Icon.HideBG();
		Icon.Show();
	}

	if(sRankIcon != "")
	{
		RankIcon.SetSize(iRankIconSize,iRankIconSize);
		RankIcon.SetPosition(iRankIconHPadding, iRankIconVPadding);
		RankIcon.bAnimateOnInit = false;
		RankIcon.LoadIcon(class'UIUtilities_Image'.static.ValidateImagePath(sRankIcon));
		RankIcon.HideBG();
		RankIcon.Show();
	}
}

simulated function OnStatsListSizeRealized()
{
	StatsHeight=StatList.Height;
	Height=StatsHeight	+ StatList.Y + PADDING_BOTTOM;
	BGBox.SetHeight(Height);

	SetY( -180 - height);
	StatList.SetHeight(StatsHeight);
	BodyMask.SetHeight(StatsHeight);
}


function int getTOOLTIP_ALPHA()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TOOLTIP_ALPHA, class'WOTC_DisplayHitChance_MCMScreen'.default.TOOLTIP_ALPHA);
}

//Defaults: ------------------------------------------------------------------------------
defaultproperties
{
	width = 270;
	height = 390; 
	TITLE_PADDING = 10;
	StatsHeight=390;
//	StatsHeight=325;
	StatsWidth=270;

	//StatsHeight=200;
	//StatsWidth=200;

	PaddingForAbilityList = 0;
	PADDING_LEFT	= 0;
	PADDING_RIGHT	= 0;
	PADDING_TOP		= 5;
	PADDING_BOTTOM	= 5;
	//PADDING_BETWEEN_PANELS = 10;
	ICON_H_PADDING = 4;
	ICON_V_PADDING = 0;
	ICON_SIZE = 32;
	TEXT_PADDING = 4;
	RANK_ICON_SIZE = 48;
	RANK_ICON_H_PADDING = -16;
	RANK_ICON_V_PADDING = 32;
}
