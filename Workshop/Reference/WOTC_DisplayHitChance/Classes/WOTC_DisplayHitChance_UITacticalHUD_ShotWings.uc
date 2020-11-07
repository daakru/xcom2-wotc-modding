//-----------------------------------------------------------
//	Class:	WOTC_DisplayHitChance_UITacticalHUD_ShotWings
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class WOTC_DisplayHitChance_UITacticalHUD_ShotWings extends UITacticalHUD_ShotWings;

`define MINDAM(WEPDAM) ( `WEPDAM.Damage - `WEPDAM.Spread )
`define MAXDAM(WEPDAM) ( `WEPDAM.Damage + `WEPDAM.Spread + int(bool(`WEPDAM.PlusOne)) )
`define RANGESTRINGN(MIN, MAX)  ( `MIN == `MAX ? string(`MIN) : string(`MIN) $ "-" $ string(`MAX) )
`define RANGESTRING(WEPDAM) `RANGESTRINGN( `MINDAM(`WEPDAM), `MAXDAM(`WEPDAM) )
`define SETCOLOR(VAL) IF(`VAL<0) {eState = eUIState_Bad;prefix="";}else {eState=eUIState_Good;prefix="+";}
`define COLORTEXT(OUTSTR, INSTR) `OUTSTR=class'UIUtilities_Text'.static.GetColoredText(`INSTR, eState)


`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)


//var bool SHOW_ALWAYS_SHOT_BREAKDOWN_HUD;
var bool TH_AIM_ASSIST;
var bool DISPLAY_MISS_CHANCE;

var localized string LOWER_DIFFICULTY_MSG;
var localized string MISS_STREAK_MSG;
var localized string SOLDIER_LOST_BONUS;
var localized string CRIT_DAMAGE_LABEL;

var public UIText CritDetailLabel;
var public UIText CritDetailValue;
var public UIMask CritDetailMask;
var public UIPanel CritDetailBodyArea;
var public UIStatList CritDetailStatList;

struct DamageModifier
{
	var string Label;
	var int Value;
};

simulated function UITacticalHUD_ShotWings InitShotWings(optional name InitName, optional name InitLibID)
{
	local int ArrowButtonWidth, ArrowButtonOffset, StatsWidth, StatsOffset, LineHeight;
	local float LineOffset, ListOffset, TableGap, TmpInt;//Yes, TmpInt is now badly named! It's only used for UI positioning, and UI positions are floats
	local UIPanel HitLine, CritLine, CritDetailLine, DamageLine, HitBG, CritBG, LeftContainer, RightContainer; 

	InitPanel(InitName, InitLibID);

	StatsWidth = 188;
	StatsOffset = 24;
	ArrowButtonWidth = 16;
	ArrowButtonOffset = 4;

	//YOffset =0;// 9;
	LineHeight=class'UIStatList'.default.LineHeight;

	LineOffset=24; //Default 24, Distance from top of Table to header/list divider line
	ListOffset=3.5; //Default=4, Distance from Line to List (Line itself is 2pxl High, so if less than two 2 will overlap line when scrolling)
	TableGap=1.5; //Default=4, Gap between the two tables in one Wing (NOT visible gap between textlines, due to descender/ascender/accent allowances in the Fonts)

	// ----------
	// The wings are actually contained within the ShotHUD so they animate in and anchor properly -sbatista
	LeftWingArea = Spawn(class'UIPanel', UITacticalHUD(Screen).m_kShotHUD); 
	LeftWingArea.bAnimateOnInit = false;
	LeftWingArea.InitPanel('leftWing');
	
	HitBG = Spawn(class'UIPanel', LeftWingArea).InitPanel('wingBG');
	HitBG.bAnimateOnInit = false;
	HitBG.ProcessMouseEvents(LeftWingMouseEvent);

	LeftContainer = Spawn(class'UIPanel', LeftWingArea);
	LeftContainer.bAnimateOnInit = false;
	LeftContainer.InitPanel('wingContainer');

	LeftWingButton = Spawn(class'UIButton', LeftContainer);
	LeftWingButton.LibID = 'X2DrawerButton';
	LeftWingButton.bAnimateOnInit = false;
	LeftWingButton.InitButton(,,OnWingButtonClicked).SetPosition(ArrowButtonOffset, (height - 26) * 0.5);
	LeftWingButton.MC.ChildFunctionString("bg.arrow", "gotoAndStop", bLeftWingOpen ? "right" : "left");

	HitPercent = Spawn(class'UIText', LeftContainer);
	HitPercent.bAnimateOnInit = false;
	HitPercent.InitText('HitPercent');
	HitPercent.SetWidth(StatsWidth); 
	HitPercent.SetPosition(StatsOffset, 0);
	HitLabel = Spawn(class'UIText', LeftContainer);
	HitLabel.bAnimateOnInit = false;
	HitLabel.InitText('HitLabel');
	HitLabel.SetPosition(StatsOffset, 0);

	HitLine = Spawn(class'UIPanel', LeftContainer);
	HitLine.bAnimateOnInit = false;
	HitLine.InitPanel('HitHeaderLine', class'UIUtilities_Controls'.const.MC_GenericPixel);
	HitLine.SetPosition(StatsOffset, LineOffset);
	HitLine.SetSize(StatsWidth, 2);
	HitLine.SetAlpha(50);

	TmpInt = HitLine.Y + ListOffset;

	HitBodyArea = Spawn(class'UIPanel', LeftContainer); 
	HitBodyArea.bAnimateOnInit = false;
	HitBodyArea.InitPanel('HitBodyArea').SetPosition(HitLine.X, TmpInt);
	HitBodyArea.width = StatsWidth; 
	HitBodyArea.height = LineHeight*3;// - TmpInt;

	HitMask = Spawn(class'UIMask', LeftContainer).InitMask(, HitBodyArea);
	HitMask.SetPosition(HitBodyArea.X, HitBodyArea.Y); 
	HitMask.SetSize(StatsWidth, HitBodyArea.height);

	HitStatList = Spawn(class'UIStatList', HitBodyArea);
	HitStatList.bAnimateOnInit = false;
	HitStatList.InitStatList('StatListLeft',,,, HitBodyArea.Width, HitBodyArea.Height, 0, 0);

	TmpInt += LineHeight*3 + TableGap;

	DamagePercent = Spawn(class'UIText', LeftContainer);
	DamagePercent.bAnimateOnInit = false;
	DamagePercent.InitText('DamagePercent');
	DamagePercent.SetWidth(StatsWidth);
	DamagePercent.SetPosition(StatsOffset, TmpInt);
	DamageLabel = Spawn(class'UIText', LeftContainer);
	DamageLabel.bAnimateOnInit = false;
	DamageLabel.InitText('DamageLabel');
	DamageLabel.SetWidth(StatsWidth);
	DamageLabel.SetPosition(StatsOffset, TmpInt);

	DamageLine = Spawn(class'UIPanel', LeftContainer);
	DamageLine.bAnimateOnInit = false;
	DamageLine.InitPanel('DamageHeaderLine', class'UIUtilities_Controls'.const.MC_GenericPixel);
	DamageLine.SetSize(StatsWidth, 2);
	DamageLine.SetPosition(StatsOffset, TmpInt + LineOffset);
	DamageLine.SetAlpha(50);

	TmpInt = DamageLine.Y + ListOffset;

	DamageBodyArea = Spawn(class'UIPanel', LeftContainer);
	DamageBodyArea.bAnimateOnInit = false;
	DamageBodyArea.InitPanel('DamageBodyArea').SetPosition(DamageLine.X, TmpInt);
	DamageBodyArea.width = StatsWidth;
	DamageBodyArea.height = LineHeight*2; //height - TmpInt;

	DamageMask = Spawn(class'UIMask', LeftContainer).InitMask(, DamageBodyArea);
	DamageMask.SetPosition(DamageBodyArea.X, DamageBodyArea.Y);
	DamageMask.SetSize(StatsWidth, DamageBodyArea.height);

	DamageStatList = Spawn(class'UIStatList', DamageBodyArea);
	DamageStatList.bAnimateOnInit = false;
	DamageStatList.InitStatList('DamageStatList', , , , DamageBodyArea.Width, DamageBodyArea.Height, 0, 0);

	// -----------
	// The wings are actually contained within the ShotHUD so they animate in and anchor properly -sbatista
	RightWingArea = Spawn(class'UIPanel', UITacticalHUD(Screen).m_kShotHUD); 
	RightWingArea.bAnimateOnInit = false;
	RightWingArea.InitPanel('rightWing');
	
	CritBG = Spawn(class'UIPanel', RightWingArea);
	CritBG.bAnimateOnInit = false;
	CritBG.InitPanel('wingBG');
	CritBG.ProcessMouseEvents(RightWingMouseEvent);

	RightContainer = Spawn(class'UIPanel', RightWingArea);
	RightContainer.bAnimateOnInit = false;
	RightContainer.InitPanel('wingContainer');

	RightWingButton = Spawn(class'UIButton', RightContainer);
	RightWingButton.LibID = 'X2DrawerButton';
	RightWingButton.bAnimateOnInit = false;
	RightWingButton.InitButton(,,OnWingButtonClicked).SetPosition(-ArrowButtonWidth - ArrowButtonOffset, (height - 26) * 0.5);
	RightWingButton.MC.FunctionString("gotoAndStop", "right");
	RightWingButton.MC.ChildFunctionString("bg.arrow", "gotoAndStop", bRightWingOpen ? "right" : "left");


	CritPercent = Spawn(class'UIText', RightContainer);
	CritPercent.bAnimateOnInit = false;
	CritPercent.InitText('CritPercent');
	CritPercent.SetWidth(StatsWidth); 
	CritPercent.SetPosition(-StatsWidth - StatsOffset, 0);
	CritLabel = Spawn(class'UIText', RightContainer);
	CritLabel.bAnimateOnInit = false;
	CritLabel.InitText('CritLabel');
	CritLabel.SetWidth(StatsWidth);
	CritLabel.SetPosition(-StatsWidth - StatsOffset, 0);

	CritLine = Spawn(class'UIPanel', RightContainer);
	CritLine.bAnimateOnInit = false;
	CritLine.InitPanel('CritHeaderLine', class'UIUtilities_Controls'.const.MC_GenericPixel);
	CritLine.SetSize(StatsWidth, 2);
	CritLine.SetPosition(-StatsWidth - StatsOffset, LineOffset);
	CritLine.SetAlpha(50);

	TmpInt = CritLine.Y + ListOffset;

	CritBodyArea = Spawn(class'UIPanel', RightContainer); 
	CritBodyArea.bAnimateOnInit = false;
	CritBodyArea.InitPanel('CritBodyArea').SetPosition(CritLine.X, TmpInt);
	CritBodyArea.width = StatsWidth;
	CritBodyArea.height = 3*LineHeight; 

	CritMask = Spawn(class'UIMask', RightContainer).InitMask(, CritBodyArea);
	CritMask.SetPosition(CritBodyArea.X, CritBodyArea.Y); 
	CritMask.SetSize(StatsWidth, CritBodyArea.height);

	CritStatList = Spawn(class'UIStatList', CritBodyArea);
	CritStatList.bAnimateOnInit = false;
	CritStatList.InitStatList('CritStatList',,,, CritBodyArea.Width, CritBodyArea.Height, 0, 0);

	TmpInt += LineHeight*3 + TableGap;

	CritDetailValue = Spawn(class'UIText', RightContainer);
	CritDetailValue.bAnimateOnInit = false;
	CritDetailValue.InitText('CritDetailPercent');
	CritDetailValue.SetWidth(StatsWidth); 
	CritDetailValue.SetPosition(-StatsWidth - StatsOffset, TmpInt);
	CritDetailLabel = Spawn(class'UIText', RightContainer);
	CritDetailLabel.bAnimateOnInit = false;
	CritDetailLabel.InitText('CritDetailLabel');
	CritDetailLabel.SetWidth(StatsWidth);
	CritDetailLabel.SetPosition(-StatsWidth - StatsOffset, TmpInt);

	CritDetailLine = Spawn(class'UIPanel', RightContainer);
	CritDetailLine.bAnimateOnInit = false;
	CritDetailLine.InitPanel('CritDetailHeaderLine', class'UIUtilities_Controls'.const.MC_GenericPixel);
	CritDetailLine.SetSize(StatsWidth, 2);
	CritDetailLine.SetPosition(-StatsWidth - StatsOffset, TmpInt + LineOffset);
	CritDetailLine.SetAlpha(50);

	TmpInt = CritDetailLine.Y + ListOffset;

	CritDetailBodyArea = Spawn(class'UIPanel', RightContainer); 
	CritDetailBodyArea.bAnimateOnInit = false;
	CritDetailBodyArea.InitPanel('CritDetailBodyArea').SetPosition(CritDetailLine.X, TmpInt);
	CritDetailBodyArea.width = StatsWidth;
	CritDetailBodyArea.height = LineHeight*2;//height - TmpInt; 

	CritDetailMask = Spawn(class'UIMask', RightContainer).InitMask(, CritDetailBodyArea);
	CritDetailMask.SetPosition(CritDetailBodyArea.X, CritDetailBodyArea.Y); 
	CritDetailMask.SetSize(StatsWidth, CritDetailBodyArea.height);

	CritDetailStatList = Spawn(class'UIStatList', CritDetailBodyArea);
	CritDetailStatList.bAnimateOnInit = false;
	CritDetailStatList.InitStatList('CritDetailStatList',,,, CritDetailBodyArea.Width, CritDetailBodyArea.Height, 0, 0);


	Hide();

	bLeftWingOpen = true;
	bRightWingOpen = true;

	return self; 

//return super.InitShotWings(InitName, InitLibID);
}

`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)

simulated function RefreshData() {
	//local StateObjectReference		kEnemyRef;
	local StateObjectReference		Shooter, Target; 
	local AvailableAction			kAction;
	local AvailableTarget			kTarget;
	local XComGameState_Ability		AbilityState;
	local ShotBreakdown				Breakdown;
	//local UIHackingBreakdown			kHackingBreakdown;
	local WeaponDamageValue			MinDamageValue, MaxDamageValue;
	local int						AllowsShield;
	local int						TargetIndex, iShotBreakdown, AimBonus, HitChance;
	local ShotModifierInfo			ShotInfo;
	local bool						bMultiShots;
	local string						TmpStr;
	local X2TargetingMethod			TargetingMethod;
	local array<UISummary_ItemStat> Stats;
	//local int						CritChance;

	TH_AIM_ASSIST = getTH_AIM_ASSIST();
	DISPLAY_MISS_CHANCE = getDISPLAY_MISS_CHANCE();

	kAction = UITacticalHUD(Screen).m_kAbilityHUD.GetSelectedAction();
	//kEnemyRef = XComPresentationLayer(Movie.Pres).GetTacticalHUD().m_kEnemyTargets.GetSelectedEnemyStateObjectRef();
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(kAction.AbilityObjectRef.ObjectID));


	// Bail if we have  nothing to show -------------------------------------
	if (AbilityState == none) {
		Hide();
		return;
	}

	//Don't show this normal shot breakdown for the hacking action ------------
	//AbilityState.GetUISummary_HackingBreakdown( kHackingBreakdown, kEnemyRef.ObjectID );
	/*if (kHackingBreakdown.bShow) {
		Hide();
		return; 
	}*/

	// Refresh game data  ------------------------------------------------------

	// If no targeted icon, we're actually hovering the shot "to hit" info field, 
	// so use the selected enemy for calculation.
	TargetingMethod = UITacticalHUD(screen).GetTargetingMethod();
	if (TargetingMethod != none)
		TargetIndex = TargetingMethod.GetTargetIndex();
	if (kAction.AvailableTargets.Length > 0 && TargetIndex < kAction.AvailableTargets.Length) {
		kTarget = kAction.AvailableTargets[TargetIndex];
	}

	Shooter = AbilityState.OwnerStateObject; 
	Target = kTarget.PrimaryTarget; 

	iShotBreakdown = AbilityState.LookupShotBreakdown(Shooter, Target, AbilityState.GetReference(), Breakdown);

	// Hide if requested -------------------------------------------------------
	if (Breakdown.HideShotBreakdown || AbilityState.GetMyTemplate().DataName == 'HaywireProtocol') {
		Hide();

		if (bLeftWingOpen) {
			bLeftWingWasOpen = true;
			OnWingButtonClicked(LeftWingButton);
		}

		if (bRightWingOpen) {
			bRightWingWasOpen = true;
			OnWingButtonClicked(RightWingButton);
		}

		LeftWingButton.Hide();
		RightWingButton.Hide();
		return; 
	}
	else {
		UITacticalHUD(screen).m_kShotHUD.MC.FunctionVoid( "ShowHit" );
		UITacticalHUD(screen).m_kShotHUD.MC.FunctionVoid( "ShowCrit" );

		// Fix the issue with vanilia.
		LeftWingButton.Show();
		RightWingButton.Show();

		if (bLeftWingWasOpen && !bLeftWingOpen) {
			OnWingButtonClicked(LeftWingButton);
			bLeftWingWasOpen = false;
		}
		if(bRightWingWasOpen && !bRightWingOpen) {
			OnWingButtonClicked(RightWingButton);
			bRightWingWasOpen = false;
		}
	}

	if (Target.ObjectID == 0) {
		Hide();
		return; 
	}

	// Gameplay special hackery for multi-shot display. -----------------------
	if (iShotBreakdown != Breakdown.FinalHitChance) {
		bMultiShots = true;
		ShotInfo.ModType = eHit_Success;
		ShotInfo.Value = iShotBreakdown - Breakdown.FinalHitChance;
		ShotInfo.Reason = class'XLocalizedData'.default.MultiShotChance;
		Breakdown.Modifiers.AddItem(ShotInfo);
		Breakdown.FinalHitChance = iShotBreakdown;
	}

	// Now update the UI ------------------------------------------------------

	if (bMultiShots)
		HitLabel.SetHtmlText(class'UIUtilities_Text'.static.StyleText(class'XLocalizedData'.default.MultiHitLabel, eUITextStyle_Tooltip_StatLabel));
	else if (DISPLAY_MISS_CHANCE)
		HitLabel.SetHtmlText(class'UIUtilities_Text'.static.StyleText(class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.MISS_CHANCE, eUITextStyle_Tooltip_StatLabel));
	else
		HitLabel.SetHtmlText(class'UIUtilities_Text'.static.StyleText(class'XLocalizedData'.default.HitLabel, eUITextStyle_Tooltip_StatLabel));
	
	//Lets sort from high to low
	Breakdown.Modifiers.Sort(SortModifiers);

	// Smart way to do things -Credit: Sectoidfodder 
	Stats = ProcessBreakdown(Breakdown, eHit_Success);
	AimBonus = 0;

	HitChance = Clamp(((Breakdown.bIsMultishot) ? Breakdown.MultiShotHitChance : Breakdown.FinalHitChance), 0, 100);

	//Check for standarshot
	if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc) != None && TH_AIM_ASSIST) {	
		AimBonus = GetModifiedHitChance(AbilityState, HitChance, Stats);
	}

	Stats.Sort(SortAfterValue);

	if (DISPLAY_MISS_CHANCE)
		TmpStr = (100 - (AimBonus + HitChance)) $ "%";
	else
		TmpStr = (AimBonus + HitChance) $ "%";

	HitPercent.SetHtmlText(class'UIUtilities_Text'.static.StyleText(TmpStr, eUITextStyle_Tooltip_StatValue));
	HitStatList.RefreshData(Stats);

	if(Breakdown.ResultTable[eHit_Crit] >= 0) {
		
		// Added from Vanilla file, seems like a WotC addition needed to display Damages Values on the Right Wing.
		AbilityState.GetDamagePreview(Target, MinDamageValue, MaxDamageValue, AllowsShield);

		DamageLabel.SetHtmlText(class'UIUtilities_Text'.static.StyleText(class'XLocalizedData'.default.DamageLabel, eUITextStyle_Tooltip_StatLabel));
		TmpStr = string(MinDamageValue.Damage) $ "-" $ string(MaxDamageValue.Damage);
		DamagePercent.SetHtmlText(class'UIUtilities_Text'.static.StyleText(TmpStr, eUITextStyle_Tooltip_StatValue));
		DamageStatList.RefreshData(ProcessDamageBreakdown2(MinDamageValue, GetWeaponBreakdown(Target, AbilityState)));

		CritLabel.SetHtmlText(class'UIUtilities_Text'.static.StyleText(class'XLocalizedData'.default.CritLabel, eUITextStyle_Tooltip_StatLabel));
		TmpStr = string(Breakdown.ResultTable[eHit_Crit]) $ "%";
		CritPercent.SetHtmlText(class'UIUtilities_Text'.static.StyleText(TmpStr, eUITextStyle_Tooltip_StatValue));
		CritStatList.RefreshData(ProcessBreakdown(Breakdown, eHit_Crit));

		CritDetailLabel.SetHtmlText(class'UIUtilities_Text'.static.StyleText(CRIT_DAMAGE_LABEL, eUITextStyle_Tooltip_StatLabel));
		TmpStr = string(class'WOTC_DisplayHitChance_UITacticalHUD_ShotHUD'.static.GetCritDamage(AbilityState, Target, Stats));
		CritDetailValue.SetHtmlText(class'UIUtilities_Text'.static.StyleText("+" $ TmpStr, eUITextStyle_Tooltip_StatValue));
		CritDetailStatList.RefreshData(Stats);

		RightWingArea.Show();
	}
	else
		RightWingArea.Hide();
}

simulated function Show()
{
	local int ScrollHeight;

	super.Show();

	if(bIsVisible)
	{
		CritDetailBodyArea.ClearScroll();
		CritDetailBodyArea.MC.SetNum("_alpha", 100);
	
		//This will reset the scrolling upon showing this tooltip.
		ScrollHeight = (CritDetailStatList.height > CritDetailBodyArea.height ) ? CritDetailStatList.height : CritDetailBodyArea.height; 
		CritDetailBodyArea.AnimateScroll(ScrollHeight, CritDetailBodyArea.height);
	}
}

// Custom sort
function int SortAfterValue(UISummary_ItemStat A, UISummary_ItemStat B) {
    return (GetNumber(B.Value) > GetNumber(A.Value)) ? -1 : 0;
}

// This should give me only numbers.
static final function int GetNumber(string s) {
	local string result;
	local int i, c;

	for (i = 0; i < Len(s); i++) {
		c = Asc(Right(s, Len(s) - i));
		if ( c == Clamp(c, 48, 57) ) // 0-9
			result = result $ Chr(c);
	}

	return int(result);
}

// Basicly same function as ModifiedHitChance from X2AbilityToHitCalc_StandardAim
static function int GetModifiedHitChance(XComGameState_Ability AbilityState, int BaseHitChance, optional out array<UISummary_ItemStat> Stats, optional int HistoryIndex=-1) {
	local int CurrentLivingSoldiers, SoldiersLost, ModifiedHitChance, SingleModifiedHitChance;
	local UISummary_ItemStat Item;

	local XComGameStateHistory History;
	local XComGameState_Unit UnitState, Unit;
	local StateObjectReference Shooter;
	local XComGameState_Player ShooterPlayer;
	local X2AbilityToHitCalc_StandardAim StandardAim;

	ModifiedHitChance = BaseHitChance;
	History = `XCOMHISTORY;

	Shooter = AbilityState.OwnerStateObject;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Shooter.ObjectID, , HistoryIndex));
	ShooterPlayer = XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(UnitState.GetAssociatedPlayerID(), , HistoryIndex));
	StandardAim = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);

	if (BaseHitChance > StandardAim.MaxAimAssistScore) {
		return 0;
	}

	// XCom gets 20% bonus to hit for each consecutive miss made already this turn
	if(ShooterPlayer.TeamFlag == eTeam_XCom && !(`XENGINE.IsMultiplayerGame())) {

		foreach History.IterateByClassType(class'XComGameState_Unit', Unit, , , HistoryIndex) {
			if( Unit.GetTeam() == eTeam_XCom && !Unit.bRemovedFromPlay && Unit.IsAlive() && !Unit.GetMyTemplate().bIsCosmetic ) {
				++CurrentLivingSoldiers;
			}
		}
		// Total soldiers lost.
		SoldiersLost = Max(0, StandardAim.NormalSquadSize - CurrentLivingSoldiers);

		//Difficulty multiplier
		ModifiedHitChance = BaseHitChance * `ScaleTacticalArrayFloat(StandardAim.BaseXComHitChanceModifier); // 1.2
		ModifiedHitChance = Clamp(ModifiedHitChance, 0, StandardAim.MaxAimAssistScore);
		SingleModifiedHitChance = ModifiedHitChance - BaseHitChance;

		// DifficultyBonus
		// Fixing name issue later with localization
		if (SingleModifiedHitChance > 0) {
			// Add to Stats (ProcessBreakDown)
			Item.Label = class'UIUtilities_Text'.static.GetColoredText(default.LOWER_DIFFICULTY_MSG, eUIState_Good );
			if (default.DISPLAY_MISS_CHANCE) Item.Value = class'UIUtilities_Text'.static.GetColoredText("-" $ SingleModifiedHitChance $ "%", eUIState_Good );
			else Item.Value = class'UIUtilities_Text'.static.GetColoredText("+" $ SingleModifiedHitChance $ "%", eUIState_Good );
			Stats.AddItem(Item);
		}


		if(BaseHitChance >= StandardAim.ReasonableShotMinimumToEnableAimAssist) { // 50
			SingleModifiedHitChance = ShooterPlayer.MissStreak * `ScaleTacticalArrayInt(StandardAim.MissStreakChanceAdjustment); // 20
			//Miss Bonus!
			// Fixing name issue later with localization
			SingleModifiedHitChance = Clamp(SingleModifiedHitChance, 0, StandardAim.MaxAimAssistScore - ModifiedHitChance);
			if (SingleModifiedHitChance > 0 && ModifiedHitChance <= StandardAim.MaxAimAssistScore) {
				// add the chance to total!
				ModifiedHitChance += SingleModifiedHitChance;
				
				// Add to Stats (ProcessBreakDown)
				Item.Label = class'UIUtilities_Text'.static.GetColoredText(default.MISS_STREAK_MSG, eUIState_Good );
				if (default.DISPLAY_MISS_CHANCE) Item.Value = class'UIUtilities_Text'.static.GetColoredText("-" $ SingleModifiedHitChance $ "%", eUIState_Good );
				else Item.Value = class'UIUtilities_Text'.static.GetColoredText("+" $ SingleModifiedHitChance $ "%", eUIState_Good );
				Stats.AddItem(Item);
			}

			SingleModifiedHitChance = SoldiersLost * `ScaleTacticalArrayInt(StandardAim.SoldiersLostXComHitChanceAdjustment);

			// Squady lost bonus
			// Fixing name issue later with localization
			SingleModifiedHitChance = Clamp(SingleModifiedHitChance, 0, StandardAim.MaxAimAssistScore - ModifiedHitChance);
			if (SingleModifiedHitChance > 0 && ModifiedHitChance <= StandardAim.MaxAimAssistScore) {
				
				// add the chance to total!
				ModifiedHitChance += SingleModifiedHitChance;
				// Add to Stats (ProcessBreakDown)
				Item.Label = class'UIUtilities_Text'.static.GetColoredText(default.SOLDIER_LOST_BONUS, eUIState_Good );
				if (default.DISPLAY_MISS_CHANCE) Item.Value = class'UIUtilities_Text'.static.GetColoredText("-" $ SingleModifiedHitChance $ "%", eUIState_Good );
				else Item.Value = class'UIUtilities_Text'.static.GetColoredText("+" $ SingleModifiedHitChance $ "%", eUIState_Good );
				Stats.AddItem(Item);
			}
		}
	}

	ModifiedHitChance = Clamp(ModifiedHitChance, 0, StandardAim.MaxAimAssistScore);

	// Important to only get the change.
	return ModifiedHitChance - BaseHitChance;;
}

simulated function array<UISummary_ItemStat> ProcessDamageBreakdown2(const out WeaponDamageValue DamageValue, array<UISummary_ItemStat> StartingStats)
{
	local array<UISummary_ItemStat> Stats;
	local UISummary_ItemStat Item;
	local int i, index;
	local array<DamageModifier> DamageModifiers;
	local DamageModifier DmgModifier;
	local string strLabel, strValue, strPrefix;
	local EUIState eState;

	Stats=StartingStats;
	for( i = 0; i < DamageValue.BonusDamageInfo.Length; i++ )
	{
		if( DamageValue.BonusDamageInfo[i].Value < 0 )
		{
			eState = eUIState_Bad;
			strPrefix = "";
		}
		else
		{
			eState = eUIState_Good;
			strPrefix = "+";
		}
		DmgModifier.Label = class'Helpers'.static.GetMessageFromDamageModifierInfo(DamageValue.BonusDamageInfo[i]);
		DmgModifier.Value = DamageValue.BonusDamageInfo[i].Value;

		strLabel = class'UIUtilities_Text'.static.GetColoredText(DmgModifier.Label, eState);
		strValue = class'UIUtilities_Text'.static.GetColoredText(strPrefix $ string(DamageValue.BonusDamageInfo[i].Value), eState);

		index = DamageModifiers.Find('Label', DmgModifier.Label);
		if(index != INDEX_NONE && DmgModifier.Label!="")
		{
			DamageModifiers[index].Value += DmgModifier.Value;
			strValue = class'UIUtilities_Text'.static.GetColoredText(strPrefix $ string(DamageModifiers[index].Value), eState);
			if(Stats.Find('Label', strLabel) != INDEX_NONE)
			{
				Stats[Stats.Find('Label', strLabel)].Value = strValue;
			}
		}
		else
		{
			Item.Label = strLabel;
			Item.Value = strValue;
			Stats.AddItem(Item);
			DamageModifiers.AddItem(DmgModifier);
		}
	}
	//for (i=i;i<4;i++)
	//{
		//Item.Label="Fluff";
		//Item.Value="500";
		//Stats.AddItem(Item);
	//}
	return Stats;
}

simulated function array<UISummary_ItemStat> ProcessBreakdown(ShotBreakdown Breakdown, int eHitType) {
	local array<UISummary_ItemStat> Stats; 
	local UISummary_ItemStat Item; 
	local int i, Value; 
	local string strLabel, strValue, strPrefix; 
	local EUIState eState;

	for( i=0; i < Breakdown.Modifiers.Length; i++) {	
		
		// Since 20% Chances of added chances to Hit are actually -20% chances to miss, just have to invert signs when Display Miss Chance is selected
		// but keeping the colour as -20% to Miss is actually a bonus which should be displayed in green
		//Value = (100 - Breakdown.Modifiers[i].Value);
		Value = (Breakdown.Modifiers[i].Value);
		
		if (Value < 0) {
			eState = eUIState_Bad;
			if (DISPLAY_MISS_CHANCE && eHitType != eHit_Crit)
			{
				Value = -Value;
				strPrefix = "+";
			}
			else 	strPrefix = "";
		}
		else {
			eState = eUIState_Good; 
			if (DISPLAY_MISS_CHANCE && eHitType != eHit_Crit)
			{
				strPrefix = "-";
			}
			else 	strPrefix = "+";
		}

		strLabel = class'UIUtilities_Text'.static.GetColoredText( Breakdown.Modifiers[i].Reason, eState );
		strValue = class'UIUtilities_Text'.static.GetColoredText( strPrefix $ string(Value) $ "%", eState );

		if (Breakdown.Modifiers[i].ModType == eHitType) {
			Item.Label = strLabel; 
			Item.Value = strValue;
			Stats.AddItem(Item);
		}
	}

	if (eHitType == eHit_Crit && Stats.length == 1 && Breakdown.ResultTable[eHit_Crit] == 0)
		Stats.length = 0; 

	return Stats; 
}


function bool getTH_AIM_ASSIST()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_AIM_ASSIST, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_AIM_ASSIST);
}

function bool getDISPLAY_MISS_CHANCE()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DISPLAY_MISS_CHANCE, class'WOTC_DisplayHitChance_MCMScreen'.default.DISPLAY_MISS_CHANCE);
}

simulated static function array<UISummary_ItemStat> GetWeaponBreakdown(StateObjectReference TargetRef, XComGameState_Ability AbilityState, optional bool bCrit=false, optional out int CritDamage, optional out int bShouldContinue, optional out X2Effect_ApplyWeaponDamage WepDamEffect)
{
	local XComGameStateHistory History;
	local XComGameState_Unit TargetUnit, SourceUnit;
	local XComGameState_Item SourceWeapon, LoadedAmmo;
	local WeaponDamageValue BaseDamageValue, ExtraDamageValue, AmmoDamageValue, BonusEffectDamageValue, UpgradeDamageValue;
	local X2Condition ConditionIter;
	local name AvailableCode;
	local X2AmmoTemplate AmmoTemplate;
	local int AllowsShield;
	local name DamageType;
	local array<X2WeaponUpgradeTemplate> WeaponUpgradeTemplates;
	local X2WeaponUpgradeTemplate WeaponUpgradeTemplate;
	local array<Name> AppliedDamageTypes;
	local bool bDoesDamageIgnoreShields;

	local UISummary_ItemStat Item;
	local array <UISummary_ItemStat> Stats;
	//local X2Effect_ApplyWeaponDamage WepDamEffect;
	local X2Effect Effect;
	local array<X2Effect> TargetEffects;
	local EUIState eState;
	local string prefix;

	local X2AbilityTemplate AbilityTemplate;
	local WeaponDamageValue MinDamagePreview, MaxDamagePreview;

	History = `XCOMHISTORY;
	
	AbilityTemplate = AbilityState.GetMyTemplate();
	AllowsShield = 0;

	if (AbilityTemplate.DamagePreviewFn != none)
	{
		bShouldContinue=int(!AbilityTemplate.DamagePreviewFn(AbilityState, TargetRef, MinDamagePreview, MaxDamagePreview, AllowsShield));
		if (bCrit && MaxDamagePreview.Crit!=0)
		{
			CritDamage+=MaxDamagePreview.Crit;
			Item.Value=string(MaxDamagePreview.Crit);
			Item.Label=AbilityState.GetMyFriendlyName();
			Stats.AddItem(Item);
		}
		if (bShouldContinue==0) return Stats;
	}

	bShouldContinue=0;

	TargetEffects = AbilityState.GetMyTemplate().AbilityTargetEffects;
	if (bCrit)
	{
		foreach TargetEffects(Effect)
		{
			if (X2Effect_ApplyWeaponDamage(Effect)==none)
			{
				MaxDamagePreview.Crit=0;
				Effect.GetDamagePreview(TargetRef, AbilityState, true, MinDamagePreview , MaxDamagePreview, AllowsShield);
				if ( MaxDamagePreview.Crit!=0 )
				{
					CritDamage+=MaxDamagePreview.Crit;
					Item.Value=string(MaxDamagePreview.Crit);
					Item.Label=AbilityState.GetMyFriendlyName();
					Stats.AddItem(Item);
				}
			}
			else
			{
				if (!WepDamEffect.bApplyOnHit) WepDamEffect=X2Effect_ApplyWeaponDamage(Effect);
			}
		}
	}
	else 
	{
		foreach TargetEffects(Effect)
		{
			WepDamEffect=X2Effect_ApplyWeaponDamage(Effect);
			if (WepDamEffect.bApplyOnHit) break;
		}
	}

	if (WepDamEffect==none) return Stats;

	if (AbilityState.SourceAmmo.ObjectID > 0)
		SourceWeapon = AbilityState.GetSourceAmmo();
	else
		SourceWeapon = AbilityState.GetSourceWeapon();

	If (SourceWeapon==none) return Stats;

	TargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetRef.ObjectID));
	SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));

	if (TargetUnit != None)
	{
		foreach WepDamEffect.TargetConditions(ConditionIter)
		{
			AvailableCode = ConditionIter.AbilityMeetsCondition(AbilityState, TargetUnit);
			if (AvailableCode != 'AA_Success')
				return Stats;
			AvailableCode = ConditionIter.MeetsCondition(TargetUnit);
			if (AvailableCode != 'AA_Success')
				return Stats;
			AvailableCode = ConditionIter.MeetsConditionWithSource(TargetUnit, SourceUnit);
			if (AvailableCode != 'AA_Success')
				return Stats;
		}
		foreach WepDamEffect.DamageTypes(DamageType)
		{
			if (TargetUnit.IsImmuneToDamage(DamageType))
				return Stats;
		}
	}
	
	if (WepDamEffect.bAlwaysKillsCivilians && TargetUnit != None && TargetUnit.GetTeam() == eTeam_Neutral)
		return Stats;

	if (!WepDamEffect.bIgnoreBaseDamage)
	{
		SourceWeapon.GetBaseWeaponDamageValue(TargetUnit, BaseDamageValue);
		WepDamEffect.ModifyDamageValue(BaseDamageValue, TargetUnit, AppliedDamageTypes);
	}
	if (WepDamEffect.DamageTag != '')
	{
		SourceWeapon.GetWeaponDamageValue(TargetUnit, WepDamEffect.DamageTag, ExtraDamageValue);
		WepDamEffect.ModifyDamageValue(ExtraDamageValue, TargetUnit, AppliedDamageTypes);
	}
	if (SourceWeapon.HasLoadedAmmo() && !WepDamEffect.bIgnoreBaseDamage)
	{
		LoadedAmmo = XComGameState_Item(History.GetGameStateForObjectID(SourceWeapon.LoadedAmmo.ObjectID));
		AmmoTemplate = X2AmmoTemplate(LoadedAmmo.GetMyTemplate()); 
		if (AmmoTemplate != None)
		{
			AmmoTemplate.GetTotalDamageModifier(LoadedAmmo, SourceUnit, TargetUnit, AmmoDamageValue);
			bDoesDamageIgnoreShields = AmmoTemplate.bBypassShields || bDoesDamageIgnoreShields;
		}
		else
		{
			LoadedAmmo.GetBaseWeaponDamageValue(TargetUnit, AmmoDamageValue);
		}
		WepDamEffect.ModifyDamageValue(AmmoDamageValue, TargetUnit, AppliedDamageTypes);
	}

	eState=eUIState_Good;
	if (bCrit)
	{
		Item.Value=string(BaseDamageValue.Crit+ExtradamageValue.Crit);
		CritDamage+=BaseDamageValue.Crit+ExtradamageValue.Crit;
	}
	else Item.Value=`RANGESTRINGN( `MINDAM(BaseDamageValue) + `MINDAM(ExtraDamageValue), `MAXDAM(BaseDamageValue) + `MAXDAM(ExtraDamageValue) );
	if (Item.Value!="0")
	{
		if (bCrit) `COLORTEXT( Item.Value, "+" $ Item.Value);
		else `COLORTEXT( Item.Value, Item.Value);
		`COLORTEXT( Item.Label, SourceWeapon.GetMyTemplate().GetItemFriendlyName(SourceWeapon.ObjectID));
		Stats.additem(Item);
	}

	if (bCrit)
	{
		Item.Value=string(BonusEffectDamageValue.Crit);
		CritDamage+=BonusEffectDamageValue.Crit;
	}
	else Item.Value=`RANGESTRING(BonusEffectDamageValue);
	if (Item.Value!="0")
	{
		`SETCOLOR(BonusEffectDamageValue.Damage);
		`COLORTEXT( Item.Value, prefix $ Item.Value);
		`COLORTEXT(Item.Label, AbilityState.GetMyFriendlyName());
		Stats.additem(Item);
	}

	if (bCrit)
	{
		Item.Value=string(AmmoDamageValue.Crit);
		CritDamage+=AmmoDamageValue.Crit;
	}
	else Item.Value=`RANGESTRING(AmmoDamageValue);
	if (Item.Value!="0")
	{
		`SETCOLOR(AmmoDamageValue.Damage);
		`COLORTEXT( Item.Value, prefix $ Item.Value);
		`COLORTEXT(Item.Label, LoadedAmmo.GetMyTemplate().GetItemFriendlyName(LoadedAmmo.ObjectID));
		Stats.additem(Item);
	}

	if (WepDamEffect.bAllowWeaponUpgrade)
	{
		WeaponUpgradeTemplates = SourceWeapon.GetMyWeaponUpgradeTemplates();
		foreach WeaponUpgradeTemplates(WeaponUpgradeTemplate)
		{
			if (WeaponUpgradeTemplate.BonusDamage.Tag == WepDamEffect.DamageTag)
			{
				UpgradeDamageValue = WeaponUpgradeTemplate.BonusDamage;

				WepDamEffect.ModifyDamageValue(UpgradeDamageValue, TargetUnit, AppliedDamageTypes);

				if (bCrit)
				{
					Item.Value=string(UpgradeDamageValue.Crit);
					CritDamage+=UpgradeDamageValue.Crit;
				}
				else Item.Value=`RANGESTRING(UpgradeDamageValue);
				if (Item.Value!="0")
				{
					`SETCOLOR(UpgradeDamageValue.Damage);
					`COLORTEXT( Item.Value,prefix $ Item.Value);
					`COLORTEXT(Item.Label, WeaponUpgradeTemplate.GetItemFriendlyName());
					Stats.additem(Item);
				}

			}
		}
	}
	bShouldContinue=1;
	return Stats;
}


defaultproperties
{
	Height = 160;
	bLeftWingOpen = false;
	bRightWingOpen = false;
	MCName = "shotWingsMC";
}


