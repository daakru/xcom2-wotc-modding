// This is an Unreal Script

class HitCalcLib2 extends X2AbilityToHitCalc_StandardAim;

static function int GetHitChanceStandardAim(X2AbilityToHitCalc_StandardAim HitCalc, XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional int HistoryIndex=-1)
{
	local XComGameState_Unit UnitState, TargetState;
	local XComGameState_Item SourceWeapon;
	local GameRulesCache_VisibilityInfo VisInfo;
	local array<X2WeaponUpgradeTemplate> WeaponUpgrades;
	local int i, iWeaponMod, iRangeModifier, Tiles;
	local ShotBreakdown EmptyShotBreakdown;
	local array<ShotModifierInfo> EffectModifiers;
	local StateObjectReference EffectRef;
	local XComGameState_Effect EffectState;
	local XComGameStateHistory History;
	local bool bFlanking, bIgnoreGraze, bSquadsight;
	local string IgnoreGrazeReason;
	local X2AbilityTemplate AbilityTemplate;
	local array<XComGameState_Effect> StatMods;
	local array<float> StatModValues;
	local X2Effect_Persistent PersistentEffect;
	local array<X2Effect_Persistent> UniqueToHitEffects;
	local float FinalAdjust, CoverValue, AngleToCoverModifier, Alpha;
	local bool bShouldAddAngleToCoverBonus;
	local TTile UnitTileLocation, TargetTileLocation;
	local ECoverType NextTileOverCoverType;
	local int TileDistance;

	`log("=" $ GetFuncName() $ "=", false, 'XCom_HitRolls');

	//  @TODO gameplay handle non-unit targets
	//`redscreen("Welcome to the Party, Victor!!!!!");
	History = `XCOMHISTORY;
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID( kAbility.OwnerStateObject.ObjectID,, HistoryIndex ));
	TargetState = XComGameState_Unit(History.GetGameStateForObjectID( kTarget.PrimaryTarget.ObjectID,, HIstoryIndex ));
	if (kAbility != none)
	{
		AbilityTemplate = kAbility.GetMyTemplate();
		SourceWeapon = kAbility.GetSourceWeapon();			
	}

	//  reset shot breakdown
	m_ShotBreakdown = EmptyShotBreakdown;

	//  check for a special guaranteed hit
	m_ShotBreakdown.SpecialGuaranteedHit = UnitState.CheckSpecialGuaranteedHit(kAbility, SourceWeapon, TargetState);
	m_ShotBreakdown.SpecialCritLabel = UnitState.CheckSpecialCritLabel(kAbility, SourceWeapon, TargetState);

	//  add all of the built-in modifiers
	if (HitCalc.bGuaranteedHit || m_ShotBreakdown.SpecialGuaranteedHit != '')
	{
		//  call the super version to bypass our check to ignore success mods for guaranteed hits
		SuperAddModifier(100, AbilityTemplate.LocFriendlyName, m_ShotBreakdown, eHit_Success);
	}
	else if (HitCalc.bIndirectFire)
	{
		m_ShotBreakdown.HideShotBreakdown = true;
		HitCalc.AddModifier(100, AbilityTemplate.LocFriendlyName, m_ShotBreakdown, eHit_Success);
	}

	HitCalc.AddModifier(HitCalc.BuiltInHitMod, AbilityTemplate.LocFriendlyName, m_ShotBreakdown, eHit_Success);
	HitCalc.AddModifier(HitCalc.BuiltInCritMod, AbilityTemplate.LocFriendlyName, m_ShotBreakdown, eHit_Crit);

	if (UnitState != none && TargetState == none)
	{
		// when targeting non-units, we have a 100% chance to hit. They can't dodge or otherwise
		// mess up our shots
		m_ShotBreakdown.HideShotBreakdown = true;
		HitCalc.AddModifier(100, class'XLocalizedData'.default.OffenseStat, m_ShotBreakdown, eHit_Success);
	}
	else if (UnitState != none && TargetState != none)
	{				
		if (!HitCalc.bIndirectFire)
		{
			// StandardAim (with direct fire) will require visibility info between source and target (to check cover). 
			if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(UnitState.ObjectID, TargetState.ObjectID, VisInfo, HistoryIndex))
			{	
				if (UnitState.CanFlank() && TargetState.GetMyTemplate().bCanTakeCover && VisInfo.TargetCover == CT_None)
					bFlanking = true;
				if (VisInfo.bClearLOS && !VisInfo.bVisibleGameplay)
					bSquadsight = true;

				//  Add basic offense and defense values
				HitCalc.AddModifier(UnitState.GetBaseStat(eStat_Offense), class'XLocalizedData'.default.OffenseStat, m_ShotBreakdown, eHit_Success);
				UnitState.GetStatModifiers(eStat_Offense, StatMods, StatModValues);
				for (i = 0; i < StatMods.Length; ++i)
				{
					HitCalc.AddModifier(int(StatModValues[i]), StatMods[i].GetX2Effect().FriendlyName, m_ShotBreakdown, eHit_Success);
				}
				//  Flanking bonus (do not apply to overwatch shots)
				if (bFlanking && !HitCalc.bReactionFire && !HitCalc.bMeleeAttack)
				{
					HitCalc.AddModifier(UnitState.GetCurrentStat(eStat_FlankingAimBonus), class'XLocalizedData'.default.FlankingAimBonus, m_ShotBreakdown, eHit_Success);
				}
				//  Squadsight penalty
				if (bSquadsight)
				{
					Tiles = UnitState.TileDistanceBetween(TargetState);
					//  remove number of tiles within visible range (which is in meters, so convert to units, and divide that by tile size)
					Tiles -= UnitState.GetVisibilityRadius() * class'XComWorldData'.const.WORLD_METERS_TO_UNITS_MULTIPLIER / class'XComWorldData'.const.WORLD_StepSize;
					if (Tiles > 0)      //  pretty much should be since a squadsight target is by definition beyond sight range. but... 
						HitCalc.AddModifier(default.SQUADSIGHT_DISTANCE_MOD * Tiles, class'XLocalizedData'.default.SquadsightMod, m_ShotBreakdown, eHit_Success);
					else if (Tiles == 0)	//	right at the boundary, but squadsight IS being used so treat it like one tile
						HitCalc.AddModifier(default.SQUADSIGHT_DISTANCE_MOD, class'XLocalizedData'.default.SquadsightMod, m_ShotBreakdown, eHit_Success);
				}

				//  Check for modifier from weapon 				
				if (SourceWeapon != none)
				{
					iWeaponMod = SourceWeapon.GetItemAimModifier();
					HitCalc.AddModifier(iWeaponMod, class'XLocalizedData'.default.WeaponAimBonus, m_ShotBreakdown, eHit_Success);

					WeaponUpgrades = SourceWeapon.GetMyWeaponUpgradeTemplates();
					for (i = 0; i < WeaponUpgrades.Length; ++i)
					{
						if (WeaponUpgrades[i].AddHitChanceModifierFn != None)
						{
							if (WeaponUpgrades[i].AddHitChanceModifierFn(WeaponUpgrades[i], VisInfo, iWeaponMod))
							{
								HitCalc.AddModifier(iWeaponMod, WeaponUpgrades[i].GetItemFriendlyName(), m_ShotBreakdown, eHit_Success);
							}
						}
					}
				}
				//  Target defense
				HitCalc.AddModifier(-TargetState.GetCurrentStat(eStat_Defense), class'XLocalizedData'.default.DefenseStat, m_ShotBreakdown, eHit_Success);
				
				//  Add weapon range
				if (SourceWeapon != none)
				{
					iRangeModifier = HitCalc.GetWeaponRangeModifier(UnitState, TargetState, SourceWeapon);
					HitCalc.AddModifier(iRangeModifier, class'XLocalizedData'.default.WeaponRange, m_ShotBreakdown, eHit_Success);
				}			
				//  Cover modifiers
				if (HitCalc.bMeleeAttack)
				{
					HitCalc.AddModifier(HitCalc.MELEE_HIT_BONUS, class'XLocalizedData'.default.MeleeBonus, m_ShotBreakdown, eHit_Success);
				}
				else
				{
					//  Add cover penalties
					if (TargetState.CanTakeCover())
					{
						// if any cover is being taken, factor in the angle to attack
						if( VisInfo.TargetCover != CT_None && !HitCalc.bIgnoreCoverBonus )
						{
							switch( VisInfo.TargetCover )
							{
							case CT_MidLevel:           //  half cover
								HitCalc.AddModifier(-HitCalc.LOW_COVER_BONUS, class'XLocalizedData'.default.TargetLowCover, m_ShotBreakdown, eHit_Success);
								CoverValue = HitCalc.LOW_COVER_BONUS;
								break;
							case CT_Standing:           //  full cover
								HitCalc.AddModifier(-HitCalc.HIGH_COVER_BONUS, class'XLocalizedData'.default.TargetHighCover, m_ShotBreakdown, eHit_Success);
								CoverValue = HitCalc.HIGH_COVER_BONUS;
								break;
							}

							TileDistance = UnitState.TileDistanceBetween(TargetState);

							// from Angle 0 -> MIN_ANGLE_TO_COVER, receive full MAX_ANGLE_BONUS_MOD
							// As Angle increases from MIN_ANGLE_TO_COVER -> MAX_ANGLE_TO_COVER, reduce bonus received by lerping MAX_ANGLE_BONUS_MOD -> MIN_ANGLE_BONUS_MOD
							// Above MAX_ANGLE_TO_COVER, receive no bonus

							//`assert(VisInfo.TargetCoverAngle >= 0); // if the target has cover, the target cover angle should always be greater than 0
							if( VisInfo.TargetCoverAngle < HitCalc.MAX_ANGLE_TO_COVER && TileDistance <= HitCalc.MAX_TILE_DISTANCE_TO_COVER )
							{
								bShouldAddAngleToCoverBonus = (UnitState.GetTeam() == eTeam_XCom);

								// We have to avoid the weird visual situation of a unit standing behind low cover 
								// and that low cover extends at least 1 tile in the direction of the attacker.
								if( (HitCalc.SHOULD_DISABLE_BONUS_ON_ANGLE_TO_EXTENDED_LOW_COVER && VisInfo.TargetCover == CT_MidLevel) ||
									(HitCalc.SHOULD_ENABLE_PENALTY_ON_ANGLE_TO_EXTENDED_HIGH_COVER && VisInfo.TargetCover == CT_Standing) )
								{
									UnitState.GetKeystoneVisibilityLocation(UnitTileLocation);
									TargetState.GetKeystoneVisibilityLocation(TargetTileLocation);
									NextTileOverCoverType = HitCalc.NextTileOverCoverInSameDirection(UnitTileLocation, TargetTileLocation);

									if( HitCalc.SHOULD_DISABLE_BONUS_ON_ANGLE_TO_EXTENDED_LOW_COVER && VisInfo.TargetCover == CT_MidLevel && NextTileOverCoverType == CT_MidLevel )
									{
										bShouldAddAngleToCoverBonus = false;
									}
									else if( HitCalc.SHOULD_ENABLE_PENALTY_ON_ANGLE_TO_EXTENDED_HIGH_COVER && VisInfo.TargetCover == CT_Standing && NextTileOverCoverType == CT_Standing )
									{
										bShouldAddAngleToCoverBonus = false;

										Alpha = FClamp((VisInfo.TargetCoverAngle - HitCalc.MIN_ANGLE_TO_COVER) / (HitCalc.MAX_ANGLE_TO_COVER - HitCalc.MIN_ANGLE_TO_COVER), 0.0, 1.0);
										AngleToCoverModifier = Lerp(HitCalc.MAX_ANGLE_PENALTY,
											HitCalc.MIN_ANGLE_PENALTY,
											Alpha);
										HitCalc.AddModifier(Round(-1.0 * AngleToCoverModifier), class'XLocalizedData'.default.BadAngleToTargetCover, m_ShotBreakdown, eHit_Success);
									}
								}

								if( bShouldAddAngleToCoverBonus )
								{
									Alpha = FClamp((VisInfo.TargetCoverAngle - HitCalc.MIN_ANGLE_TO_COVER) / (HitCalc.MAX_ANGLE_TO_COVER - HitCalc.MIN_ANGLE_TO_COVER), 0.0, 1.0);
									AngleToCoverModifier = Lerp(HitCalc.MAX_ANGLE_BONUS_MOD,
																HitCalc.MIN_ANGLE_BONUS_MOD,
																Alpha);
									HitCalc.AddModifier(Round(CoverValue * AngleToCoverModifier), class'XLocalizedData'.default.AngleToTargetCover, m_ShotBreakdown, eHit_Success);
								}
							}
						}
					}
					//  Add height advantage
					if (UnitState.HasHeightAdvantageOver(TargetState, true))
					{
						HitCalc.AddModifier(class'X2TacticalGameRuleset'.default.UnitHeightAdvantageBonus, class'XLocalizedData'.default.HeightAdvantage, m_ShotBreakdown, eHit_Success);
					}

					//  Check for height disadvantage
					if (TargetState.HasHeightAdvantageOver(UnitState, false))
					{
						HitCalc.AddModifier(class'X2TacticalGameRuleset'.default.UnitHeightDisadvantagePenalty, class'XLocalizedData'.default.HeightDisadvantage, m_ShotBreakdown, eHit_Success);
					}
				}
			}

			if (UnitState.IsConcealed())
			{
				`log("Shooter is concealed, target cannot dodge.",false, 'XCom_HitRolls');
			}
			else
			{
				if (SourceWeapon == none || SourceWeapon.CanWeaponBeDodged())
				{
					if (TargetState.CanDodge(UnitState, kAbility))
					{
						HitCalc.AddModifier(TargetState.GetCurrentStat(eStat_Dodge), class'XLocalizedData'.default.DodgeStat, m_ShotBreakdown, eHit_Graze);
					}
					else
					{
						`log("Target cannot dodge due to some gameplay effect.", false, 'XCom_HitRolls');
					}
				}					
			}
		}					

		//  Now check for critical chances.
		if (HitCalc.bAllowCrit)
		{
			HitCalc.AddModifier(UnitState.GetBaseStat(eStat_CritChance), class'XLocalizedData'.default.CharCritChance, m_ShotBreakdown, eHit_Crit);
			UnitState.GetStatModifiers(eStat_CritChance, StatMods, StatModValues);
			for (i = 0; i < StatMods.Length; ++i)
			{
				HitCalc.AddModifier(int(StatModValues[i]), StatMods[i].GetX2Effect().FriendlyName, m_ShotBreakdown, eHit_Crit);
			}
			if (bSquadsight)
			{
				HitCalc.AddModifier(default.SQUADSIGHT_CRIT_MOD, class'XLocalizedData'.default.SquadsightMod, m_ShotBreakdown, eHit_Crit);
			}

			if (SourceWeapon !=  none)
			{
				HitCalc.AddModifier(SourceWeapon.GetItemCritChance(), class'XLocalizedData'.default.WeaponCritBonus, m_ShotBreakdown, eHit_Crit);
			}
			if (bFlanking && !HitCalc.bMeleeAttack)
			{
				if (`XENGINE.IsMultiplayerGame())
				{
					HitCalc.AddModifier(default.MP_FLANKING_CRIT_BONUS, class'XLocalizedData'.default.FlankingCritBonus, m_ShotBreakdown, eHit_Crit);
				}				
				else
				{
					HitCalc.AddModifier(UnitState.GetCurrentStat(eStat_FlankingCritChance), class'XLocalizedData'.default.FlankingCritBonus, m_ShotBreakdown, eHit_Crit);
				}
			}
		}
		foreach UnitState.AffectedByEffects(EffectRef)
		{
			EffectModifiers.Length = 0;
			EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID,, HistoryIndex));
			if (EffectState == none)
				continue;

			PersistentEffect = EffectState.GetX2Effect();
			if (PersistentEffect == none)
				continue;

			if (UniqueToHitEffects.Find(PersistentEffect) != INDEX_NONE)
				continue;
			PersistentEffect.GetToHitModifiers(EffectState, UnitState, TargetState, kAbility, HitCalc.Class, HitCalc.bMeleeAttack, bFlanking, HitCalc.bIndirectFire, EffectModifiers);
			if (EffectModifiers.Length > 0)
			{
				if (PersistentEffect.UniqueToHitModifiers())
					UniqueToHitEffects.AddItem(PersistentEffect);

				for (i = 0; i < EffectModifiers.Length; ++i)
				{
					if (!HitCalc.bAllowCrit && EffectModifiers[i].ModType == eHit_Crit)
					{
						if (!PersistentEffect.AllowCritOverride())
							continue;
					}
					HitCalc.AddModifier(EffectModifiers[i].Value, EffectModifiers[i].Reason, m_ShotBreakdown, EffectModifiers[i].ModType);
				}
			}
			if (PersistentEffect.ShotsCannotGraze())
			{
				bIgnoreGraze = true;
				IgnoreGrazeReason = PersistentEffect.FriendlyName;
			}
		}
		UniqueToHitEffects.Length = 0;
		if (TargetState.AffectedByEffects.Length > 0)
		{
			foreach TargetState.AffectedByEffects(EffectRef)
			{
				EffectModifiers.Length = 0;
				EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID,, HistoryIndex));
				if (EffectState == none)
					continue;

				PersistentEffect = EffectState.GetX2Effect();
				if (PersistentEffect == none)
					continue;

				if (UniqueToHitEffects.Find(PersistentEffect) != INDEX_NONE)
					continue;

				PersistentEffect.GetToHitAsTargetModifiers(EffectState, UnitState, TargetState, kAbility, HitCalc.Class, HitCalc.bMeleeAttack, bFlanking, HitCalc.bIndirectFire, EffectModifiers);
				if (EffectModifiers.Length > 0)
				{
					if (PersistentEffect.UniqueToHitAsTargetModifiers())
						UniqueToHitEffects.AddItem(PersistentEffect);

					for (i = 0; i < EffectModifiers.Length; ++i)
					{
						if (!HitCalc.bAllowCrit && EffectModifiers[i].ModType == eHit_Crit)
							continue;
						if (bIgnoreGraze && EffectModifiers[i].ModType == eHit_Graze)
							continue;
						HitCalc.AddModifier(EffectModifiers[i].Value, EffectModifiers[i].Reason, m_ShotBreakdown, EffectModifiers[i].ModType);
					}
				}
			}
		}
		//  Remove graze if shooter ignores graze chance.
		if (bIgnoreGraze)
		{
			HitCalc.AddModifier(-m_ShotBreakdown.ResultTable[eHit_Graze], IgnoreGrazeReason, m_ShotBreakdown, eHit_Graze);
		}
		//  Remove crit from reaction fire. Must be done last to remove all crit.
		if (HitCalc.bReactionFire)
		{
			HitCalc.AddReactionCritModifier(UnitState, TargetState, m_ShotBreakdown, false);
		}
	}

	//  Final multiplier based on end Success chance
	if (HitCalc.bReactionFire && !HitCalc.bGuaranteedHit)
	{
		FinalAdjust = m_ShotBreakdown.ResultTable[eHit_Success] * HitCalc.GetReactionAdjust(UnitState, TargetState);
		HitCalc.AddModifier(-int(FinalAdjust), AbilityTemplate.LocFriendlyName, m_ShotBreakdown, eHit_Success);
		HitCalc.AddReactionFlatModifier(UnitState, TargetState, m_ShotBreakdown, false);
	}
	else if (HitCalc.FinalMultiplier != 1.0f)
	{
		FinalAdjust = m_ShotBreakdown.ResultTable[eHit_Success] * HitCalc.FinalMultiplier;
		HitCalc.AddModifier(-int(FinalAdjust), AbilityTemplate.LocFriendlyName, m_ShotBreakdown, eHit_Success);
	}

	HitCalc.FinalizeHitChance(m_ShotBreakdown);
	return m_ShotBreakdown.FinalHitChance;
}


static function SuperAddModifier(const int ModValue, const string ModReason, out ShotBreakdown m_ShotBreakdown, EAbilityHitResult ModType=eHit_Success)
{
	local ShotModifierInfo Mod;

	switch(ModType)
	{
	case eHit_Miss:
		//  Miss should never be modified, only Success
		`assert(false);
		return;
	}

	if (ModValue != 0)
	{
		Mod.ModType = ModType;
		Mod.Value = ModValue;
		Mod.Reason = ModReason;
		m_ShotBreakdown.Modifiers.AddItem(Mod);
		m_ShotBreakdown.ResultTable[ModType] += ModValue;
		m_ShotBreakdown.FinalHitChance = m_ShotBreakdown.ResultTable[eHit_Success];
	}
	`log("Modifying" @ ModType @ (ModValue >= 0 ? "+" : "") $ ModValue @ "(" $ ModReason $ "), New hit chance:" @ m_ShotBreakdown.FinalHitChance, false, 'XCom_HitRolls');
}
