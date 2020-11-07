//-----------------------------------------------------------
//	Class:	WOTC_DisplayHitChance_UITacticalHUD_ShotHUD
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class WOTC_DisplayHitChance_UITacticalHUD_ShotHUD extends UITacticalHUD_ShotHUD config(ShotHUD);

`include(WOTC_DisplayHitChance\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

var array <UIBGBox> BarBoxes;
var UIText GrimyTextDodge, GrimyTextDodgeHeader, GrimyTextCrit, GrimyTextCritHeader;
var int BAR_HEIGHT, BAR_OFFSET_X, BAR_OFFSET_Y, BAR_WIDTH_MULT, GENERAL_OFFSET_Y;
var int DODGE_OFFSET_X, DODGE_OFFSET_Y, CRIT_OFFSET_X, CRIT_OFFSET_Y;
var int MAX_ABILITIES_PER_ROW;
var int LabelFontSize, ValueFontSize, TEXTWIDTH;
var int BAR_ALPHA;
var string HIT_HEX_COLOR, CRIT_HEX_COLOR, DODGE_HEX_COLOR, MISS_HEX_COLOR, ASSIST_HEX_COLOR;
var int GRAZE_CRIT_LAYOUT;
var float LabelsOffset;

//FIX
var bool TH_AIM_ASSIST;
var bool DISPLAY_MISS_CHANCE;
var bool TH_SHOW_GRAZED;
var bool TH_SHOW_CRIT_DMG;
var bool TH_AIM_LEFT_OF_CRIT;
var bool TH_ASSIST_BESIDE_HIT;
var bool TH_PREVIEW_MINIMUM;
var bool TH_PREVIEW_HACKING;

var localized string CRIT_DAMAGE_LABEL, GRAZE_CHANCE_LABEL, MISS_CHANCE_LABEL;

struct OffsetProperties
{
	var int GrazeOffsetX;
	var int GrazeOffsetY;
	var int CritDOffsetX;
	var int CritDOffsetY;
	var string GrazeTextAlign;
	var string CritDTextAlign;
};

struct ResOffsetSt
{
	var string Res;
	var float offset;
	var int ResX;
	var int ResY;
};

var config array<OffsetProperties> Offsets;
var config array<ResOffsetSt> ResOffset;

simulated function initValues()
{
	local int Index;
	local int ResX, ResY;
	local int RenderWidth, RenderHeight, FullWidth, FullHeight, AlreadyAdjustedVerticalSafeZone;
	local float RenderAspectRatio, FullAspectRatio;
	local string searchString, searchString2;

	LabelsOffset = 0;
	Movie.GetScreenDimensions(RenderWidth, RenderHeight, RenderAspectRatio, FullWidth, FullHeight, FullAspectRatio, AlreadyAdjustedVerticalSafeZone);
	ResX = RenderWidth;
	ResY = RenderHeight;
	searchString = "p" $ ResX $ "x" $ ResY;

	Index = ResOffset.Find('Res', searchString);

	if(Index == INDEX_NONE)
	{
		FindClosestRes(ResX, ResY);
		searchString2 = "p" $ ResX $ "x" $ ResY;
		Index = ResOffset.Find('Res', searchString2);
	}

	if(Index != INDEX_NONE)
	{
		LabelsOffset = ResOffset[Index].offset;
	}
	//DEBUG
	//LabelsOffset = getDODGE_OFFSET_Y();
	//Offsets[2].CritDOffsetX = 272;

	/*`redscreen(`showvar(searchString));
	`redscreen(`showvar(searchString2));
	`redscreen(`showvar(RenderWidth));
	`redscreen(`showvar(RenderHeight));
	`redscreen(`showvar(FullWidth));
	`redscreen(`showvar(FullHeight));
	`redscreen(`showvar(ResX));
	`redscreen(`showvar(ResY));
	`redscreen(`showvar(LabelsOffset));*/
	//DEBUG

	// Init MCM Config Variables
	/*BAR_WIDTH_MULT = getBAR_WIDTH_MULT();*/
	BAR_HEIGHT = getBAR_HEIGHT();
	/*BAR_OFFSET_X = getBAR_OFFSET_X();
	BAR_OFFSET_Y = getBAR_OFFSET_Y();*/
	BAR_ALPHA = getBAR_ALPHA();
	/*GENERAL_OFFSET_Y = getGENERAL_OFFSET_Y();
	DODGE_OFFSET_X = getDODGE_OFFSET_X();
	DODGE_OFFSET_Y = getDODGE_OFFSET_Y();
	CRIT_OFFSET_X = getCRIT_OFFSET_X();
	CRIT_OFFSET_Y = getCRIT_OFFSET_Y();*/
	HIT_HEX_COLOR = getHIT_HEX_COLOR();
	CRIT_HEX_COLOR = getCRIT_HEX_COLOR();
	DODGE_HEX_COLOR = getDODGE_HEX_COLOR();
	MISS_HEX_COLOR = getMISS_HEX_COLOR();
	ASSIST_HEX_COLOR = getASSIST_HEX_COLOR();
	TH_AIM_ASSIST = GetTH_AIM_ASSIST();
	GRAZE_CRIT_LAYOUT = getGRAZE_CRIT_LAYOUT();	

	DODGE_OFFSET_X = Offsets[GRAZE_CRIT_LAYOUT].GrazeOffsetX;
	DODGE_OFFSET_Y = Offsets[GRAZE_CRIT_LAYOUT].GrazeOffsetY;
	CRIT_OFFSET_X = Offsets[GRAZE_CRIT_LAYOUT].CritDOffsetX;
	CRIT_OFFSET_Y = Offsets[GRAZE_CRIT_LAYOUT].CritDOffsetY;
	// End of Init
}

simulated function FindClosestRes(out int ResX, out int ResY)
{
	local ResOffsetSt ResOffsetItem;
	local int tempInt, smallestDiff, i, tempResX, tempResY;
	
	foreach ResOffset(ResOffsetItem, i)
	{
		tempInt = Abs(ResY - ResOffsetItem.ResY);
		if ((tempResY == 0) || (tempResY != 0 && tempInt < smallestDiff))
		{
			smallestDiff = tempInt;
			tempResY = ResOffsetItem.ResY;
		}
	}
	foreach ResOffset(ResOffsetItem, i)
	{
		if (tempResY == ResOffsetItem.ResY)
		{
			tempInt = Abs(ResX - ResOffsetItem.ResX);
			if ((tempResX == 0) || (tempResX != 0 && tempInt < smallestDiff))
			{
				smallestDiff = tempInt;
				tempResX = ResOffsetItem.ResX;
			}
		}
	}
	ResX = tempResX;
	ResY = tempResY;
}

simulated function Update() {

    local bool isValidShot;
    local string ShotName, ShotDescription, ShotDamage;
    local int HitChance, CritChance, TargetIndex, MinDamage, MaxDamage, AllowsShield, AimBonus;
    local ShotBreakdown kBreakdown;
    local StateObjectReference Shooter, Target, EmptyRef;
    local XComGameState_Ability SelectedAbilityState;
    local X2AbilityTemplate SelectedAbilityTemplate;
    local AvailableAction SelectedUIAction;
    local AvailableTarget kTarget;
    local XGUnit ActionUnit;
    local UITacticalHUD TacticalHUD;
    local UIUnitFlag UnitFlag;
    local WeaponDamageValue MinDamageValue, MaxDamageValue;
    local X2TargetingMethod TargetingMethod;
    local bool WillBreakConcealment, WillEndTurn;
	
    // New from Grimy Shot Bar
    local int GrimyCritDmg;
    local string FontString;
   
	local int offsetX, Current, i;
	local int Chance[3];

	initValues();

    TacticalHUD = UITacticalHUD(Screen);
 
    // Remove the shotbar box when you aren't looking at it
	for (i=0; i<BarBoxes.length; i++)
	{
		if ( BarBoxes[i] != none ) BarBoxes[i].Remove();
	}
	BarBoxes.length=0;

	if ( GrimyTextDodge != none )
	{
		GrimyTextDodge.Remove();
	}
	if ( GrimyTextDodgeHeader != none )
	{
		GrimyTextDodgeHeader.Remove();
	}
	if ( GrimyTextCrit != none )
	{
		GrimyTextCrit.Remove();
	}
	if ( GrimyTextCritHeader != none )
	{
		GrimyTextCritHeader.Remove();
	}

    SelectedUIAction = TacticalHUD.GetSelectedAction();
    if (SelectedUIAction.AbilityObjectRef.ObjectID > 0)
	{ //If we do not have a valid action selected, ignore this update request
        SelectedAbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(SelectedUIAction.AbilityObjectRef.ObjectID));
        SelectedAbilityTemplate = SelectedAbilityState.GetMyTemplate();
        ActionUnit = XGUnit(`XCOMHISTORY.GetGameStateForObjectID(SelectedAbilityState.OwnerStateObject.ObjectID).GetVisualizer());
        TargetingMethod = TacticalHUD.GetTargetingMethod();
        if( TargetingMethod != None )
		{
            TargetIndex = TargetingMethod.GetTargetIndex();
            if( SelectedUIAction.AvailableTargets.Length > 0 && TargetIndex < SelectedUIAction.AvailableTargets.Length )
                kTarget = SelectedUIAction.AvailableTargets[TargetIndex];
        }
 
        //Update L3 help and OK button based on ability.
        //*********************************************************************************
        if (SelectedUIAction.bFreeAim)
		{
            AS_SetButtonVisibility(Movie.IsMouseActive(), false);
            isValidShot = true;
        }
        else if (SelectedUIAction.AvailableTargets.Length == 0 || SelectedUIAction.AvailableTargets[0].PrimaryTarget.ObjectID < 1)
		{
            AS_SetButtonVisibility(Movie.IsMouseActive(), false);
            isValidShot = false;
        }
        else
		{
            AS_SetButtonVisibility(Movie.IsMouseActive(), Movie.IsMouseActive());
            isValidShot = true;
        }
 
        //Set shot name / help text
        //*********************************************************************************
        ShotName = SelectedAbilityState.GetMyFriendlyName();
 
        if (SelectedUIAction.AvailableCode == 'AA_Success')
		{
            ShotDescription = SelectedAbilityState.GetMyHelpText();
            if (ShotDescription == "") ShotDescription = "Missing 'LocHelpText' from ability template.";
        }
        else
		{
            ShotDescription = class'X2AbilityTemplateManager'.static.GetDisplayStringForAvailabilityCode(SelectedUIAction.AvailableCode);
        }
 
 
        WillBreakConcealment = SelectedAbilityState.MayBreakConcealmentOnActivation(kTarget.PrimaryTarget.ObjectID);
        WillEndTurn = SelectedAbilityState.WillEndTurn();
 
        AS_SetShotInfo(ShotName, ShotDescription, WillBreakConcealment, WillEndTurn);
 
        // Display Hack Info if relevant
        AS_SetShotInfo(ShotName, UpdateHackDescription(SelectedAbilityTemplate, SelectedAbilityState, kTarget, ShotDescription, SelectedAbilityState.OwnerStateObject), WillBreakConcealment, WillEndTurn);
 
        // Disable Shot Button if we don't have a valid target.
        AS_SetShotButtonDisabled(!isValidShot);
 
        ResetDamageBreakdown();
 
        // In the rare case that this ability is self-targeting, but has a multi-target effect on units around it,
        // look at the damage preview, just not against the target (self).
        if (SelectedAbilityTemplate.AbilityTargetStyle.IsA('X2AbilityTarget_Self')
			&& SelectedAbilityTemplate.AbilityMultiTargetStyle != none
			&& SelectedAbilityTemplate.AbilityMultiTargetEffects.Length > 0 )
		{
			SelectedAbilityState.GetDamagePreview(EmptyRef, MinDamageValue, MaxDamageValue, AllowsShield);
		}
        else SelectedAbilityState.GetDamagePreview(kTarget.PrimaryTarget, MinDamageValue, MaxDamageValue, AllowsShield);

        MinDamage = MinDamageValue.Damage;
        MaxDamage = MaxDamageValue.Damage;
       
        if (MinDamage > 0 && MaxDamage > 0)
		{
            if (MinDamage == MaxDamage)
                ShotDamage = String(MinDamage);
            else
                ShotDamage = MinDamage $ "-" $ MaxDamage;
 
            AddDamage(class'UIUtilities_Text'.static.GetColoredText(ShotDamage, eUIState_Good, 36), true);
        }
 
        //Set up percent to hit / crit values
        //*********************************************************************************
       
        if (SelectedAbilityTemplate.AbilityToHitCalc != none && SelectedAbilityState.iCooldown == 0)
		{
            Shooter = SelectedAbilityState.OwnerStateObject;
            Target = kTarget.PrimaryTarget;
 
			//Mr. Nice: these three lines from Firaxis original)
           /*****************************************************/
            SelectedAbilityState.LookupShotBreakdown(Shooter, Target, SelectedAbilityState.GetReference(), kBreakdown);
            HitChance = Clamp(((kBreakdown.bIsMultishot) ? kBreakdown.MultiShotHitChance : kBreakdown.FinalHitChance), 0, 100);
            CritChance = kBreakdown.ResultTable[eHit_Crit];
           /*****************************************************/

 			
			// If User selected to display the Modified Hit Chance
			if (X2AbilityToHitCalc_StandardAim(SelectedAbilityState.GetMyTemplate().AbilityToHitCalc) != None && TH_AIM_ASSIST) {	
				AimBonus = class'WOTC_DisplayHitChance_UITacticalHUD_ShotWings'.static.GetModifiedHitChance(SelectedAbilityState, HitChance);
				HitChance += AimBonus;
				//Wierd treatment of aim bonus means you can't just add it to hitchance for bar breakdown yet;
				//GrimyHitChance += AimBonus;
			}

			if (TacticalHUD.m_kAbilityHUD.ActiveAbilities > MAX_ABILITIES_PER_ROW)
			{
				BAR_OFFSET_Y = default.BAR_OFFSET_Y + GENERAL_OFFSET_Y;
				DODGE_OFFSET_Y = Offsets[GRAZE_CRIT_LAYOUT].GrazeOffsetY + GENERAL_OFFSET_Y;
				CRIT_OFFSET_Y = Offsets[GRAZE_CRIT_LAYOUT].CritDOffsetY + GENERAL_OFFSET_Y;
			}
			else
			{
				BAR_OFFSET_Y = default.BAR_OFFSET_Y;
				DODGE_OFFSET_Y = Offsets[GRAZE_CRIT_LAYOUT].GrazeOffsetY;
				CRIT_OFFSET_Y = Offsets[GRAZE_CRIT_LAYOUT].CritDOffsetY;
			}
 
            if (HitChance > -1 && !kBreakdown.HideShotBreakdown) {
				
			   //Mr. Nice: If you're going to replicate the % results from RollforAbilityHit, then copy it's code structure!
			   // Note RollforabilityHit() is an empty function is the basic X2AbilitytoHitCalc class, below is _StandardAim drived
			   // In principle, other X2AbilitytoHitCalc implementations could use shotbreakdown differently, or even not use it at all!
				//GrimyHitChance = ((kBreakdown.bIsMultishot) ? kBreakdown.MultiShotHitChance : kBreakdown.FinalHitChance);
				for (i = 0; i < eHit_Miss; ++i)     //  If we don't match a result before miss, then it's a miss.
				{
					Chance[i]= max(0, min(Current + kBreakdown.ResultTable[i], 100) - max(Current, 0) );
					Current += kBreakdown.ResultTable[i];
				}
				
                // Generate a display for dodge chance
                if (GetTH_SHOW_GRAZED() && Chance[eHit_Graze] > 0)
				{
                    FontString = Chance[eHit_Graze] $ "%";
                    FontString = class'UIUtilities_Text'.static.GetColoredText(FontString, eUIState_Normal, , Offsets[GRAZE_CRIT_LAYOUT].GrazeTextAlign);
                    FontString = class'UIUtilities_Text'.static.AddFontInfo(FontString,false,true, , ValueFontSize);
					GrimyTextDodge = Spawn(class'UIText', self);
					GrimyTextDodge.InitText('GrimyText1');
					GrimyTextDodge.AnchorBottomCenter();
					GrimyTextDodge.SetPosition(DODGE_OFFSET_X -TEXTWIDTH*int(Offsets[GRAZE_CRIT_LAYOUT].GrazeTextAlign=="right"),DODGE_OFFSET_Y - 0.8);
					GrimyTextDodge.SetWidth(TEXTWIDTH);
					GrimyTextDodge.SetText(FontString);
					GrimyTextDodge.Show();
 
                    FontString = GRAZE_CHANCE_LABEL;
                    //FontString = class'UIUtilities_Text'.static.GetSizedText(FontString,LabelFontSize);
                    FontString = class'UIUtilities_Text'.static.GetColoredText(FontString,eUIState_Header,LabelFontSize ,Offsets[GRAZE_CRIT_LAYOUT].GrazeTextAlign);
					GrimyTextDodgeHeader = Spawn(class'UIText', self);
					GrimyTextDodgeHeader.InitText('GrimyText2');
					GrimyTextDodgeHeader.AnchorBottomCenter();
                    GrimyTextDodgeHeader.SetPosition(DODGE_OFFSET_X -TEXTWIDTH*int(Offsets[GRAZE_CRIT_LAYOUT].GrazeTextAlign=="right"),DODGE_OFFSET_Y + LabelsOffset);
					GrimyTextDodgeHeader.SetWidth(TEXTWIDTH);
					GrimyTextDodgeHeader.SetText(FontString);
					GrimyTextDodgeHeader.Show();
                }
 
                // Generate a display for Crit Damage
                GrimyCritDmg = GetCritDamage(SelectedAbilityState, Target);
                if (GetTH_SHOW_CRIT_DMG() && GrimyCritDmg > 0 )
				{
                    FontString = "+" $ string(GrimyCritDmg);
                    //FontString = class'UIUtilities_Text'.static.GetSizedText(FontString,ValueFontSize);
                    FontString = class'UIUtilities_Text'.static.GetColoredText(FontString, eUIState_Normal, , Offsets[GRAZE_CRIT_LAYOUT].CritDTextAlign);
                    FontString = class'UIUtilities_Text'.static.AddFontInfo(FontString,false,true, , ValueFontSize);
					GrimyTextCrit = Spawn(class'UIText', self);
					GrimyTextCrit.InitText('GrimyText3');
					GrimyTextCrit.AnchorBottomCenter();
                    //if (GrimyCritDmg > 9) //If the string is too long, shift it left by 15 pixels (~1 digit)
                        GrimyTextCrit.SetPosition(CRIT_OFFSET_X-TEXTWIDTH*int(Offsets[GRAZE_CRIT_LAYOUT].CritDTextAlign=="right"),CRIT_OFFSET_Y - 0.8);
					GrimyTextCrit.SetWidth(TEXTWIDTH);
                    //else GrimyTextCrit.SetPosition(CRIT_OFFSET_X+15,CRIT_OFFSET_Y - 0.8);
					GrimyTextCrit.SetText(FontString);
					GrimyTextCrit.Show();
 
                    FontString = CRIT_DAMAGE_LABEL;
//                    FontString = class'UIUtilities_Text'.static.GetSizedText(FontString,LabelFontSize);
                    FontString = class'UIUtilities_Text'.static.GetColoredText(FontString,eUIState_Header, LabelFontSize, Offsets[GRAZE_CRIT_LAYOUT].CritDTextAlign);
					GrimyTextCritHeader = Spawn(class'UIText', self);
					GrimyTextCritHeader.InitText('GrimyText4');
					GrimyTextCritHeader.AnchorBottomCenter();
                    GrimyTextCritHeader.SetPosition(CRIT_OFFSET_X-TEXTWIDTH*int(Offsets[GRAZE_CRIT_LAYOUT].CritDTextAlign=="right"),CRIT_OFFSET_Y + LabelsOffset);
                    GrimyTextCritHeader.SetWidth(TEXTWIDTH);
					GrimyTextCritHeader.SetText(FontString);
					GrimyTextCritHeader.Show();
                }


                // Generate the shot breakdown bar
                if (BAR_HEIGHT > 0)
				{
					if (!TH_AIM_ASSIST)	Chance[eHit_Success] += AimBonus; //Assist bonus directly adds to eHit_Success changes;
					offsetX = BAR_WIDTH_MULT * (-50) + BAR_OFFSET_X;
					//Mr. Nice: offsetX is an out parameter, and is incremented in DrawBox() as required.
					switch(int(GetTH_AIM_LEFT_OF_CRIT()) + 2* int(GetTH_ASSIST_BESIDE_HIT()))
					{
						case 1+0:
							Drawbox(Chance[eHit_Success], HIT_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Crit], CRIT_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Graze], DODGE_HEX_COLOR, offsetX);
							if (TH_AIM_ASSIST) Drawbox(AimBonus, ASSIST_HEX_COLOR, offsetX);
						break;
						case 1+2:
							Drawbox(Chance[eHit_Success], HIT_HEX_COLOR, offsetX);
							if (TH_AIM_ASSIST) Drawbox(AimBonus, ASSIST_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Crit], CRIT_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Graze], DODGE_HEX_COLOR, offsetX);
						break;
						case 0+0:
							Drawbox(Chance[eHit_Crit], CRIT_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Success], HIT_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Graze], DODGE_HEX_COLOR, offsetX);
							if (TH_AIM_ASSIST) Drawbox(AimBonus, ASSIST_HEX_COLOR, offsetX);
						break;
						case 0+2:
							Drawbox(Chance[eHit_Crit], CRIT_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Success], HIT_HEX_COLOR, offsetX);
							if (TH_AIM_ASSIST) Drawbox(AimBonus, ASSIST_HEX_COLOR, offsetX);
							Drawbox(Chance[eHit_Graze], DODGE_HEX_COLOR, offsetX);
						break;
					}
                    if (BAR_WIDTH_MULT*(1-HitChance) < 500)
						Drawbox(100 - HitChance, MISS_HEX_COLOR, offsetX);
				}

				if (GetDISPLAY_MISS_CHANCE())
				{
					HitChance = 100 - HitChance;//Mr. Nice: moved from earlier in function. Otherwise messes up shotbar, was draw even in PI version of shotbar
	                // DEBUG TEST
					//if (HitChance == 0) AS_SetShotChance(class'UIUtilities_Text'.static.GetColoredText(class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.MISS_CHANCE, eUIState_Header), HitChance + 0.0);
					AS_SetShotChance(class'UIUtilities_Text'.static.GetColoredText(class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.MISS_CHANCE, eUIState_Header), HitChance);
					if (HitChance == 0)
					{
						/*MC.SetBool("._visible", true);
						MC.SetString("shotLabel.htmlText", class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.MISS_CHANCE);
						MC.SetString("shotValue.htmlText", HitChance @ "%");*/
						MC.ChildSetBool("statsHit", "_visible", true);
						MC.ChildSetString("statsHit.shotLabel", "htmlText", class'X2Action_ApplyWeaponDamageToUnit_HITCHANCE'.default.MISS_CHANCE);
						MC.ChildSetString("statsHit.shotValue", "htmlText", HitChance @ "%");
					}
				}

                else AS_SetShotChance(class'UIUtilities_Text'.static.GetColoredText(m_sShotChanceLabel, eUIState_Header), HitChance);
                AS_SetCriticalChance(class'UIUtilities_Text'.static.GetColoredText(m_sCritChanceLabel, eUIState_Header), CritChance);
                TacticalHUD.SetReticleAimPercentages(float(HitChance) / 100.0f, float(CritChance) / 100.0f);
            }
            else
			{
                AS_SetShotChance("", -1);
                AS_SetCriticalChance("", -1);
                TacticalHUD.SetReticleAimPercentages(-1, -1);
            }
        }
        else
		{
            AS_SetShotChance("", -1);
            AS_SetCriticalChance("", -1);
        }
        TacticalHUD.m_kShotInfoWings.Show();
 
        //Show preview points, must be negative
        UnitFlag = XComPresentationLayer(Owner.Owner).m_kUnitFlagManager.GetFlagForObjectID(Target.ObjectID);
        if(UnitFlag != none)
		{
            if (GetTH_PREVIEW_MINIMUM())
                SetAbilityMinDamagePreview(UnitFlag, SelectedAbilityState, kTarget.PrimaryTarget);
            else
				XComPresentationLayer(Owner.Owner).m_kUnitFlagManager.SetAbilityDamagePreview(UnitFlag, SelectedAbilityState, kTarget.PrimaryTarget);
        }
 
        //@TODO - jbouscher - ranges need to be implemented in a template friendly way.
        //Hide any current range meshes before we evaluate their visibility state
        if (!ActionUnit.GetPawn().RangeIndicator.HiddenGame) ActionUnit.RemoveRanges();
    }
 
    if (`REPLAY.bInTutorial)
		{
        if (SelectedAbilityTemplate != none && `TUTORIAL.IsNextAbility(SelectedAbilityTemplate.DataName) && `TUTORIAL.IsTarget(Target.ObjectID))
            ShowShine();
        else HideShine();
    }
	RefreshTooltips();
}

simulated function DrawBox (int Chance, string colour, out int offsetX)
{
	local int bWidth;
	local UIBGBox BarBox;

	if (Chance <=0) return;

	bWidth=Chance*BAR_WIDTH_MULT;
	
	BarBox=Spawn(class'UIBGBox', self)
		.InitBG(, offsetX, BAR_OFFSET_Y, bWidth, BAR_HEIGHT)
		.SetBGColor("gray_highlight");
	BarBox.SetColor(colour)
		.AnchorBottomCenter()
		.SetAlpha(BAR_ALPHA);
	BarBox.Show();

	BarBoxes.AddItem(BarBox);
	offsetX += bWidth;
}

`MCM_CH_VersionChecker(class'MCM_Defaults'.default.VERSION, class'WOTC_DisplayHitChance_MCMScreen'.default.CONFIG_VERSION)


// GRIMY - Added this function to calculate crit damage from a weapon.
// It doesn't scan for abilities and ammo types though, those are unfortunately often stored in if conditions
// 2017-12-09: For the time being with partial rewrite of base game files for WotC, Crit Damages from AMMO ARE BEING TAKEN into account :-)
static function int GetCritDamage(XcomGameState_Ability AbilityState, StateObjectReference TargetRef, optional out array<UISummary_ItemStat> ItemsStat) {
	local XComGameStateHistory History;
	local XComGameState_Unit SourceUnit, TargetUnit;
	local StateObjectReference EffectRef;
	local XComGameState_Effect EffectState;
	local XComGameState_Item ItemState;
	local X2Effect_Persistent EffectTemplate;
	local EffectAppliedData TestEffectParams;
	local int CritDamage;
	local WeaponDamageValue WeaponDamage;
	local UISummary_ItemStat ItemStat;
	local int eState, Value_Crit, Value_Success, EffectDmg;
	local string strPrefix, strLabel;
	local X2Effect_ApplyWeaponDamage WepDamEffect;
	local int iContinue;

	
	History = `XCOMHISTORY;
	SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	TargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetRef.ObjectID));

	TestEffectParams.AbilityInputContext.AbilityRef = AbilityState.GetReference();
	TestEffectParams.AbilityInputContext.AbilityTemplateName = AbilityState.GetMyTemplateName();
	TestEffectParams.ItemStateObjectRef = AbilityState.SourceWeapon;
	TestEffectParams.AbilityStateObjectRef = AbilityState.GetReference();
	TestEffectParams.SourceStateObjectRef = SourceUnit.GetReference();
	TestEffectParams.PlayerStateObjectRef = SourceUnit.ControllingPlayer;
	TestEffectParams.TargetStateObjectRef = TargetRef;
	//TestEffectParams.AbilityResultContext.HitResult = eHit_Crit;

	ItemState = AbilityState.GetSourceWeapon();
	ItemState.GetBaseWeaponDamageValue(ItemState, WeaponDamage);

	ItemsStat.Length = 0;

	// Add in the Weapon Base Crit Damage
	//ItemStat.Label = class'UIUtilities_Text'.static.GetColoredText(class'XLocalizedData'.default.WeaponCritBonus, eUIState_Good);
	//ItemStat.Value = class'UIUtilities_Text'.static.GetColoredText("+" $ CritDamage, eUIState_Good);
	//ItemsStat.AddItem(ItemStat);
	ItemsStat=class'WOTC_DisplayHitChance_UITacticalHUD_ShotWings'.static.GetWeaponBreakdown(TargetRef, AbilityState, true, CritDamage, iContinue, WepDamEffect);
	if(!bool(iContinue)) return CritDamage;

	foreach SourceUnit.AffectedByEffects(EffectRef)
	{
		EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
		EffectTemplate = EffectState.GetX2Effect();

		TestEffectParams.AbilityResultContext.HitResult = eHit_Crit;
		Value_Crit = EffectTemplate.GetAttackingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, WeaponDamage.Damage);

		TestEffectParams.AbilityResultContext.HitResult = eHit_Success;
		Value_Success = EffectTemplate.GetAttackingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, WeaponDamage.Damage);

		if (Value_Crit - Value_Success != 0)
		{
			CritDamage+=Value_Crit;
			if (Value_Crit<0)
			{
				eState=eUIState_Bad;
				strPrefix="";
			}
			else 
			{
				eState = eUIState_Good; 
				strPrefix = "+";
			}
			strLabel = EffectTemplate.GetSpecialDamageMessageName();
			ItemStat.Label = class'UIUtilities_Text'.static.GetColoredText(strLabel, eState);
			ItemStat.Value = class'UIUtilities_Text'.static.GetColoredText(strPrefix $ Value_Crit, eState );
			ItemsStat.AddItem(ItemStat);	
		}
	}

	TestEffectParams.AbilityResultContext.HitResult = eHit_Crit;
	
	if (TargetUnit != none)
	{
		foreach TargetUnit.AffectedByEffects(EffectRef)
		{
			EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
			EffectTemplate = EffectState.GetX2Effect();
			EffectDmg = EffectTemplate.GetBaseDefendingDamageModifier (EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, WeaponDamage.Damage, WepDamEffect);
			EffectDmg += EffectTemplate.GetDefendingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, WeaponDamage.Damage, WepDamEffect);
			if (EffectDmg != 0)
			{
				CritDamage+=EffectDmg;
				if (EffectDmg<0)
				{
					eState=eUIState_Bad;
					strPrefix="";
				}
				else 
				{
					eState = eUIState_Good; 
					strPrefix = "+";
				}
				strLabel = EffectTemplate.GetSpecialDamageMessageName();
				ItemStat.Label = class'UIUtilities_Text'.static.GetColoredText(strLabel, eState);
				ItemStat.Value = class'UIUtilities_Text'.static.GetColoredText(strPrefix $ EffectDmg, eState );
				ItemsStat.AddItem(ItemStat);	
			}
		}
	}


	// When it checks for extra damage for eHit_Crit, it includes extra damage which applies to all hits.
	// To correctly get bonus damage just for crits, you have to total and take away extra damage for normal hits, ie eHit_Success (Mr. Nice, thank you ^^)
	/*TestEffectParams.AbilityResultContext.HitResult = eHit_Success;
	foreach SourceUnit.AffectedByEffects(EffectRef) {
		EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
		EffectTemplate = EffectState.GetX2Effect();

		CritDamage -= EffectTemplate.GetAttackingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, WeaponDamage.Damage);

		// Added this loop afterwards to remove unwanted items (passives abilites / Etc...) from the array
		for (i = 0; i < ItemsStat.Length; ++i)
		{
			if ( string(EffectTemplate.EffectName) == UISummary_ItemStat(ItemsStat[--i]).Label ) ItemsStat.remove(--i);
		}
	}*/

	
    return CritDamage;
}
 
// GRIMY - Added this to do a minimum damage preview.
// Recreated the preview function in order to minimize # of files edited, and thus conflicts
static function SetAbilityMinDamagePreview(UIUnitFlag kFlag, XComGameState_Ability AbilityState, StateObjectReference TargetObject) {
    local XComGameState_Unit FlagUnit;
    local int shieldPoints, AllowedShield;
    local int possibleHPDamage, possibleShieldDamage;
    local WeaponDamageValue MinDamageValue;
    local WeaponDamageValue MaxDamageValue;
 
    if(kFlag == none || AbilityState == none) {
        return;
    }
 
    AbilityState.GetDamagePreview(TargetObject, MinDamageValue, MaxDamageValue, AllowedShield);
 
    FlagUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kFlag.StoredObjectID));
    shieldPoints = FlagUnit != none ? int(FlagUnit.GetCurrentStat(eStat_ShieldHP)) : 0;
 
    possibleHPDamage = MinDamageValue.Damage;
    possibleShieldDamage = 0;
 
    // MaxHP contains extra HP points given by shield
    if(shieldPoints > 0 && AllowedShield > 0) {
        possibleShieldDamage = min(shieldPoints, MinDamageValue.Damage);
        possibleShieldDamage = min(possibleShieldDamage, AllowedShield);
        possibleHPDamage = MinDamageValue.Damage - possibleShieldDamage;
    }
 
    if (!AbilityState.DamageIgnoresArmor() && FlagUnit != none)
        possibleHPDamage -= max(0,FlagUnit.GetArmorMitigationForUnitFlag() - MinDamageValue.Pierce);
 
    kFlag.SetShieldPointsPreview( possibleShieldDamage );
    kFlag.SetHitPointsPreview( possibleHPDamage );
    kFlag.SetArmorPointsPreview(MinDamageValue.Shred, MinDamageValue.Pierce);
}
 
function string UpdateHackDescription( X2AbilityTemplate SelectedAbilityTemplate, XComGameState_Ability SelectedAbilityState, AvailableTarget kTarget, string ShotDescription, StateObjectReference Shooter) {
    local string FontString;
    local XComGameState_InteractiveObject HackObject;
    local XComGameState_Unit HackUnit;
    local X2HackRewardTemplateManager HackManager;
    local array<name> HackRewards;
    local int HackOffense, HackDefense;
    local array<X2HackRewardTemplate> HackRewardTemplates;
    local X2HackRewardTemplate HackRewardInterator;
    local array<int> HackRollMods;
 
    if (GetTH_PREVIEW_HACKING()) {
        if (SelectedAbilityTemplate.DataName == 'Hack' || SelectedAbilityTemplate.DataName == 'Hack_Chest' || SelectedAbilityTemplate.DataName == 'Hack_Workstation' || SelectedAbilityTemplate.DataName == 'Hack_ObjectiveChest' || SelectedAbilityTemplate.DataName == 'Hack_ElevatorControl' || SelectedAbilityTemplate.DataName == 'IntrusionProtocol' || SelectedAbilityTemplate.DataName == 'IntrusionProtocol_Chest' || SelectedAbilityTemplate.DataName == 'IntrusionProtocol_Workstation' || SelectedAbilityTemplate.DataName == 'IntrusionProtocol_ObjectiveChest' || SelectedAbilityTemplate.DataName == 'SKULLJACKAbility' || SelectedAbilityTemplate.DataName == 'SKULLMINEAbility') {
            HackObject = XComGameState_InteractiveObject(`XCOMHISTORY.GetGameStateForObjectID(kTarget.PrimaryTarget.ObjectID));
            HackRewards = HackObject.GetHackRewards(SelectedAbilityTemplate.DataName);
            if (HackRewards.Length > 0) {
                HackManager = class'X2HackRewardTemplateManager'.static.GetHackRewardTemplateManager();
                HackRewardTemplates.additem(HackManager.FindHackRewardTemplate(HackRewards[0]));
                HackRewardTemplates.additem(HackManager.FindHackRewardTemplate(HackRewards[1]));
                HackRewardTemplates.additem(HackManager.FindHackRewardTemplate(HackRewards[2]));
               
                HackOffense = class'X2AbilityToHitCalc_Hacking'.static.GetHackAttackForUnit(XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Shooter.ObjectID)), SelectedAbilityState);
                HackDefense = class'X2AbilityToHitCalc_Hacking'.static.GetHackDefenseForTarget(HackObject);
               
                HackRollMods = HackObject.GetHackRewardRollMods();
                if (HackRollMods.length == 0) {
                    foreach HackRewardTemplates(HackRewardInterator) {
                        HackRollMods.AddItem(`SYNC_RAND_STATIC(HackRewardInterator.HackSuccessVariance * 2) - HackRewardInterator.HackSuccessVariance);
                    }
                    HackObject.SetHackRewardRollMods(HackRollMods);
                }
                   
                FontString = ShotDescription;
                FontString = FontString $ "\n" $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[0].GetFriendlyName(),eUIState_Bad);
                FontString = FontString $ " - " $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[1].GetFriendlyName(),eUIState_Good);
                FontString = FontString $ ": " $ class'UIUtilities_Text'.static.GetColoredText( string(Clamp((100.0 - (HackRewardTemplates[1].MinHackSuccess + HackObject.HackRollMods[1])) * HackOffense / HackDefense, 0.0, 100.0)) $ "%", eUIState_Good);
                FontString = FontString $ ", " $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[2].GetFriendlyName(),eUIState_Good);
                FontString = FontString $ ": " $ class'UIUtilities_Text'.static.GetColoredText( string(Clamp((100.0 - (HackRewardTemplates[2].MinHackSuccess + HackObject.HackRollMods[2])) * HackOffense / HackDefense, 0.0, 100.0)) $ "%", eUIState_Good);
                return FontString;
            }
        }
        else if (SelectedAbilityTemplate.DataName == 'HaywireProtocol') {
            HackUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kTarget.PrimaryTarget.ObjectID));
               
            HackOffense = class'X2AbilityToHitCalc_Hacking'.static.GetHackAttackForUnit(XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Shooter.ObjectID)), SelectedAbilityState);
            HackDefense = class'X2AbilityToHitCalc_Hacking'.static.GetHackDefenseForTarget(HackUnit);
 
            HackManager = class'X2HackRewardTemplateManager'.static.GetHackRewardTemplateManager();
           
            if ( HackUnit.GetMyTemplate().bIsTurret ) {
                HackRewardTemplates.AddItem(HackManager.FindHackRewardTemplate('BuffEnemy'));
                HackRewardTemplates.AddItem(HackManager.FindHackRewardTemplate('ShutdownTurret'));
                HackRewardTemplates.AddItem(HackManager.FindHackRewardTemplate('ControlTurret'));
 
                HackRollMods = HackObject.GetHackRewardRollMods();
                if (HackRollMods.length == 0) {
                    foreach HackRewardTemplates(HackRewardInterator)
                    {
                        HackRollMods.AddItem(`SYNC_RAND_STATIC(HackRewardInterator.HackSuccessVariance * 2) - HackRewardInterator.HackSuccessVariance);
                    }
                    HackObject.SetHackRewardRollMods(HackRollMods);
                }
 
                FontString = ShotDescription;
                FontString = FontString $ "\n" $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[0].GetFriendlyName(),eUIState_Bad);
                FontString = FontString $ " - " $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[1].GetFriendlyName(),eUIState_Good);
                FontString = FontString $ ": " $ class'UIUtilities_Text'.static.GetColoredText( string(Clamp((100.0 - (HackRewardTemplates[1].MinHackSuccess)) * HackOffense / HackDefense, 0.0, 100.0)) $ "%", eUIState_Good);
                FontString = FontString $ ", " $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[2].GetFriendlyName(),eUIState_Good);
                FontString = FontString $ ": " $ class'UIUtilities_Text'.static.GetColoredText( string(Clamp((100.0 - (HackRewardTemplates[2].MinHackSuccess + HackObject.HackRollMods[2])) * HackOffense / HackDefense, 0.0, 100.0)) $ "%", eUIState_Good);
                return FontString;
            }
            else {
                HackRewardTemplates.AddItem(HackManager.FindHackRewardTemplate('BuffEnemy'));
                HackRewardTemplates.AddItem(HackManager.FindHackRewardTemplate('ShutdownRobot'));
                HackRewardTemplates.AddItem(HackManager.FindHackRewardTemplate('ControlRobot'));
 
                HackRollMods = HackObject.GetHackRewardRollMods();
                if (HackRollMods.length == 0) {
                    foreach HackRewardTemplates(HackRewardInterator) {
                        HackRollMods.AddItem(`SYNC_RAND_STATIC(HackRewardInterator.HackSuccessVariance * 2) - HackRewardInterator.HackSuccessVariance);
                    }
                    HackObject.SetHackRewardRollMods(HackRollMods);
                }
 
                FontString = ShotDescription;
                FontString = FontString $ "\n" $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[0].GetFriendlyName(),eUIState_Bad);
                FontString = FontString $ " - " $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[1].GetFriendlyName(),eUIState_Good);
                FontString = FontString $ ": " $ class'UIUtilities_Text'.static.GetColoredText( string(Clamp((100.0 - (HackRewardTemplates[1].MinHackSuccess + HackObject.HackRollMods[1])) * HackOffense / HackDefense, 0.0, 100.0)) $ "%", eUIState_Good);
                FontString = FontString $ ", " $ class'UIUtilities_Text'.static.GetColoredText(HackRewardTemplates[2].GetFriendlyName(),eUIState_Good);
                FontString = FontString $ ": " $ class'UIUtilities_Text'.static.GetColoredText( string(Clamp((100.0 - (HackRewardTemplates[2].MinHackSuccess + HackObject.HackRollMods[2])) * HackOffense / HackDefense, 0.0, 100.0)) $ "%", eUIState_Good);
                return FontString;
            }
        }
    }
    return ShotDescription;
}

function bool GetTH_AIM_ASSIST() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_AIM_ASSIST, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_AIM_ASSIST);
}

function bool GetDISPLAY_MISS_CHANCE() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DISPLAY_MISS_CHANCE, class'WOTC_DisplayHitChance_MCMScreen'.default.DISPLAY_MISS_CHANCE);
}

function bool GetTH_SHOW_GRAZED() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_SHOW_GRAZED, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_SHOW_GRAZED);
}

function bool GetTH_SHOW_CRIT_DMG() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_SHOW_CRIT_DMG, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_SHOW_CRIT_DMG);
}

function bool GetTH_AIM_LEFT_OF_CRIT() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_AIM_LEFT_OF_CRIT, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_AIM_LEFT_OF_CRIT);
}

function bool GetTH_PREVIEW_MINIMUM() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_PREVIEW_MINIMUM, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_PREVIEW_MINIMUM);
}

function bool GetTH_PREVIEW_HACKING() {
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_PREVIEW_HACKING, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_PREVIEW_HACKING);
}

function int getBAR_HEIGHT()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_HEIGHT, class'WOTC_DisplayHitChance_MCMScreen'.default.BAR_HEIGHT);
}

/*function int getBAR_OFFSET_X()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_OFFSET_X, class'WOTC_DisplayHitChance_MCMScreen'.default.BAR_OFFSET_X);
}

function int getBAR_OFFSET_Y()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_OFFSET_Y, class'WOTC_DisplayHitChance_MCMScreen'.default.BAR_OFFSET_Y);
}*/

function int getBAR_ALPHA()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_ALPHA, class'WOTC_DisplayHitChance_MCMScreen'.default.BAR_ALPHA);
}

/*function int getBAR_WIDTH_MULT()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.BAR_WIDTH_MULT, class'WOTC_DisplayHitChance_MCMScreen'.default.BAR_WIDTH_MULT);
}

function int getGENERAL_OFFSET_Y()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.GENERAL_OFFSET_Y, class'WOTC_DisplayHitChance_MCMScreen'.default.GENERAL_OFFSET_Y);
}

function int getDODGE_OFFSET_X()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DODGE_OFFSET_X, class'WOTC_DisplayHitChance_MCMScreen'.default.DODGE_OFFSET_X);
}

function int getCRIT_OFFSET_X()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.CRIT_OFFSET_X, class'WOTC_DisplayHitChance_MCMScreen'.default.CRIT_OFFSET_X);
}

function int getCRIT_OFFSET_Y()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.CRIT_OFFSET_Y, class'WOTC_DisplayHitChance_MCMScreen'.default.CRIT_OFFSET_Y);
}*/

function string getHIT_HEX_COLOR()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.HIT_HEX_COLOR, class'WOTC_DisplayHitChance_MCMScreen'.default.HIT_HEX_COLOR);
}

function string getCRIT_HEX_COLOR()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.CRIT_HEX_COLOR, class'WOTC_DisplayHitChance_MCMScreen'.default.CRIT_HEX_COLOR);
}

function string getDODGE_HEX_COLOR()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DODGE_HEX_COLOR, class'WOTC_DisplayHitChance_MCMScreen'.default.DODGE_HEX_COLOR);
}

function string getMISS_HEX_COLOR()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.MISS_HEX_COLOR, class'WOTC_DisplayHitChance_MCMScreen'.default.MISS_HEX_COLOR);
}

function string getASSIST_HEX_COLOR()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.ASSIST_HEX_COLOR, class'WOTC_DisplayHitChance_MCMScreen'.default.ASSIST_HEX_COLOR);
}

function int getGRAZE_CRIT_LAYOUT()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.GRAZE_CRIT_LAYOUT, class'WOTC_DisplayHitChance_MCMScreen'.default.GRAZE_CRIT_LAYOUT);
}

function bool getTH_ASSIST_BESIDE_HIT()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.TH_ASSIST_BESIDE_HIT, class'WOTC_DisplayHitChance_MCMScreen'.default.TH_ASSIST_BESIDE_HIT);
}


//DEBUG
/*function float getDODGE_OFFSET_Y()
{
	return `MCM_CH_GetValue(class'MCM_Defaults'.default.DODGE_OFFSET_Y, class'WOTC_DisplayHitChance_MCMScreen'.default.DODGE_OFFSET_Y);
}*/
//DEBUG


defaultproperties
{
	//TH_AIM_ASSIST=true;
	//ASSIST_HEX_COLOR="b6b3e3" ; //PURPLE

	// ShotBar position, size, and offset settings, should not be altered whatsoever
	// so created those default values inside the class to not expose them in MCM any more
	BAR_WIDTH_MULT = 3;
	BAR_HEIGHT = 10;
	BAR_OFFSET_X = 0;
	BAR_OFFSET_Y = -122;
	GENERAL_OFFSET_Y = -32;
	LabelsOffset = -23;
	LabelFontSize = 18;
	ValueFontSize = 28;
	MAX_ABILITIES_PER_ROW = 15;
	TEXTWIDTH=100;
}