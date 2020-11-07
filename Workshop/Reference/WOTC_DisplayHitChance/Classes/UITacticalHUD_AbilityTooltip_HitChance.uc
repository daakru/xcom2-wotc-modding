//-----------------------------------------------------------
//	Class:	UITacticalHUD_AbilityTooltip_HitChance
//	Author: tjnome / Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class UITacticalHUD_AbilityTooltip_HitChance extends UITacticalHUD_AbilityTooltip;

//var int TOOLTIP_ALPHA; Not actually used.

var UIAbilityList_HitChance	XCOMAbilityList;
var UIMask					XCOMAbilityListMask;

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

simulated function UIPanel InitAbility(optional name InitName, 
										 optional name InitLibID,
										 optional int InitX = 0, //Necessary for anchoring
										 optional int InitY = 0, //Necessary for anchoring
										 optional int InitWidth = 0)
{
	//Super.InitAbility(InitName, InitLibID, InitX, InitY, InitWidth);
	InitPanel(InitName, InitLibID);

	Hide();

	SetPosition(InitX, InitY);
	InitAnchorX = X; 
	InitAnchorY = Y; 

	if( InitWidth != 0 )
		width = InitWidth;

	//---------------------

	BG = Spawn(class'UIPanel', self).InitPanel('BGBoxSimplAbilities', class'UIUtilities_Controls'.const.MC_X2BackgroundSimple).SetPosition(0, 0).SetSize(width, height);
	BG.SetAlpha(getTOOLTIP_ALPHA()); // Setting transparency

	// --------------------

	XCOMAbilityList = Spawn(class'UIAbilityList_HitChance', self);
	XCOMAbilityList.InitAbilityList('XCOMAbilityList',
		, 
		PADDING_LEFT, 
		PADDING_TOP, 
		width-PADDING_LEFT-PADDING_RIGHT, 
		height-PADDING_TOP-PADDING_BOTTOM,
		height-PADDING_TOP-PADDING_BOTTOM);
	XCOMAbilityList.OnSizeRealized=OnAbilitySizeRealized;
	XcomAbilityList.MaxHeight=MAX_HEIGHT-PADDING_TOP-PADDING_BOTTOM;
	XCOMAbilityListMask=Spawn(class'UIMask', self).InitMask('XCOMAbilityMask', XCOMAbilityList).FitMask(XCOMAbilityList); 

	return self; 
}

`MCM_CH_STATICVersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)

simulated function RefreshData()
{
	local XComGameState_Ability	kGameStateAbility;
	local int					iTargetIndex; 
	local array<string>			Path; 
	local array<UISummary_Ability> UIAbilities;

	if( XComTacticalController(PC) == None )
	{	
		Data = DEBUG_GetUISummary_Ability();
		RefreshDisplay();	
		return; 
	}

	Path = SplitString( currentPath, "." );	

	if (Path.Length > 5)
	{
		iTargetIndex = int(GetRightMost(Path[5]));
		kGameStateAbility = UITacticalHUD(Movie.Stack.GetScreen(class'UITacticalHUD')).m_kAbilityHUD.GetAbilityAtIndex(iTargetIndex);
	}
	
	if( kGameStateAbility == none )
	{
		HideTooltip();
		return; 
	}

	Data = XCOMAbilityList.GetUISummary_Ability(kGameStateAbility);
	UIAbilities.AddItem(Data);
	XCOMAbilityList.RefreshData(UIAbilities);
	//RefreshDisplay();	
}

static function	UISummary_Ability GetUISummary_Ability(XComGameState_Ability kGameStateAbility, optional XComGameState_Unit UnitState)
{
	local UISummary_Ability AbilityData;
	local X2AbilityTemplate	AbilityTemplate;
	local X2AbilityCost		Cost;

	AbilityData=kGameStateAbility.GetUISummary_Ability(UnitState);

	AbilityTemplate=kGameStateAbility.GetMyTemplate();

	foreach AbilityTemplate.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_ActionPoints') && !X2AbilityCost_ActionPoints(Cost).bFreeCost)
		AbilityData.ActionCost += X2AbilityCost_ActionPoints(Cost).GetPointCost(kGameStateAbility, UnitState);
	}

	
	if (UnitState==none)
		UnitState=XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kGameStateAbility.OwnerStateObject.ObjectID));

	if (UnitState==none) return AbilityData;

	AbilityData.CooldownTime = AbilityTemplate.AbilityCooldown.GetNumTurns(kGameStateAbility, UnitState, none, none);
	AbilityData.bEndsTurn = AbilityTemplate.WillEndTurn(kGameStateAbility, UnitState); // Will End Turn
	AbilityData.Icon = kGameStateAbility.GetMyIconImage();

	return AbilityData;
}

simulated function OnAbilitySizeRealized()
{
	Height = XcomAbilityList.MaskHeight +PADDING_TOP+PADDING_BOTTOM;
	BG.SetHeight( Height );
	SetY( InitAnchorY - height );
	XComAbilityListMask.SetHeight(XComAbilityList.MaskHeight);
}

static function int getTOOLTIP_ALPHA()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TOOLTIP_ALPHA, class'WOTC_DisplayHitChance_MCMScreen'.default.TOOLTIP_ALPHA);
}

defaultproperties
{
	//height = 200; 
}

