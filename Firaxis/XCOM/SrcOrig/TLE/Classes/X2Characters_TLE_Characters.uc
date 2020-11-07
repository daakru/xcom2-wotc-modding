//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    X2Characters_TLE_Characters.uc
//  AUTHOR:  Brian Hess - 3/8/2018
//---------------------------------------------------------------------------------------
//  Copyright (c) 2018 Firaxis Games Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class X2Characters_TLE_Characters extends X2Character config(GameData_CharacterStats);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	// Enemy Templates
	Templates.AddItem( CreatePsiZombieCivilian_Template() );
	Templates.AddItem( CreateNeonateChryssalid_Template() );
	// Soldier Templates
	Templates.AddItem( CreateJohnBradford_Template() );
	Templates.AddItem( CreateLilyShen_Template() );
	Templates.AddItem( CreateJaneKelly_Template() );
	Templates.AddItem( CreatePeterOsei_Template() );
	Templates.AddItem( CreateAnaRamirez_Template() );
	// ROV-R Templates
	Templates.AddItem( CreateShenGremlinMk1_Template() );
	Templates.AddItem( CreateShenGremlinMk2_Template() );
	Templates.AddItem( CreateShenGremlinMk3_Template() );
	// VIP Templates
	Templates.AddItem( CreatePirateDJ_VIPTemplate() );
	Templates.AddItem( CreateBlackMarketTrader_VIPTemplate() );
	Templates.AddItem( CreateLilyShen_VIPTemplate() );
	Templates.AddItem( CreateJaneKelly_VIPTemplate() );
	Templates.AddItem( CreatePeterOsei_VIPTemplate() );
	Templates.AddItem( CreateAnaRamirez_VIPTemplate() );
	Templates.AddItem( CreateTygan_VIPTemplate() );

	return Templates;
}

static function X2CharacterTemplate CreateSpeakerTemplate(Name CharacterName, optional string CharacterSpeakerName = "", optional string CharacterSpeakerPortrait = "", optional EGender Gender = eGender_Female)
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, CharacterName);
	CharTemplate.CharacterGroupName = 'Speaker';
	if (CharTemplate.strCharacterName == "")
	{
		CharTemplate.strCharacterName = CharacterSpeakerName;
	}
	CharTemplate.SpeakerPortrait = CharacterSpeakerPortrait;
	CharTemplate.DefaultAppearance.iGender = int(Gender);

	CharTemplate.bShouldCreateDifficultyVariants = false;

	return CharTemplate;
}
// Enemy Templates

static function X2CharacterTemplate CreatePsiZombieCivilian_Template()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = class'X2Character_DefaultCharacters'.static.CreateTemplate_PsiZombie('PsiZombieCivilian');

	CharTemplate.strPawnArchetypes.Length = 0;
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_PsiZombieCivilian.ARC_PsiZombieCivilian_M");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_PsiZombieCivilian.ARC_PsiZombieCivilian_F");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_PsiZombieCivilian.ARC_PsiZombieCivilian_F_1");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_PsiZombieCivilian.ARC_PsiZombieCivilian_F_2");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_PsiZombieCivilian.ARC_PsiZombieCivilian_M_1");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_PsiZombieCivilian.ARC_PsiZombieCivilian_M_2");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_PsiZombieCivilian.ARC_PsiZombieCivilian_M_3");

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateNeonateChryssalid_Template()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'NeonateChryssalid');
	CharTemplate.CharacterGroupName = 'Chryssalid';
	CharTemplate.DefaultLoadout = 'Chryssalid_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_NeonateChryssalid.ARC_GameUnit_NeonateChryssalid");
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Chryssalid_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Chryssalid");

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsMeleeOnly = true;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strScamperBT = "ChryssalidScamperRoot";

	CharTemplate.Abilities.AddItem('ChryssalidSlash');
	CharTemplate.Abilities.AddItem('ChryssalidBurrow');
	CharTemplate.Abilities.AddItem('ChyssalidPoison');
	CharTemplate.Abilities.AddItem('ChryssalidImmunities');
	CharTemplate.Abilities.AddItem('DarkEventAbility_Barrier');

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Cryssalid');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

// Soldier Templates

static function X2CharacterTemplate CreateJohnBradford_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'NarrativeCentral');
	CharTemplate.UnitSize = 1;
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = true;
	CharTemplate.strMatineePackages.AddItem("CIN_Soldier");
	CharTemplate.strIntroMatineeSlotPrefix = "Char";
	CharTemplate.strLoadingMatineeSlotPrefix = "Soldier";

	CharTemplate.DefaultLoadout = 'NarrativeCentral_Loadout';
	CharTemplate.RequiredLoadout = 'RequiredSoldier';
	CharTemplate.Abilities.AddItem('Loot');
	CharTemplate.Abilities.AddItem('Interact_StasisTube');
	CharTemplate.Abilities.AddItem('Interact_SweaterTube');
	CharTemplate.Abilities.AddItem('CarryUnit');
	CharTemplate.Abilities.AddItem('PutDownUnit');
	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('PlaceEvacZone');
	CharTemplate.Abilities.AddItem('LiftOffAvenger');
	CharTemplate.Abilities.AddItem('Knockout');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.Abilities.AddItem('Panicked');
	CharTemplate.Abilities.AddItem('DisableConsumeAllPoints');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('LadderUnkillable');
	CharTemplate.Abilities.AddItem('Interact_PlantBomb');

	CharTemplate.bShouldCreateDifficultyVariants = false;

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'XCom_Soldier_M';
	CharTemplate.DefaultAppearance.nmHead = 'Central';
	CharTemplate.DefaultAppearance.nmHaircut = 'Central_Hair';
	CharTemplate.DefaultAppearance.nmBeard = 'Central_Beard';
	CharTemplate.DefaultAppearance.iArmorTint = 0;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = 2;
	CharTemplate.DefaultAppearance.iGender = 1;
	CharTemplate.DefaultAppearance.nmArms = 'CnvMed_std_B_M';
	CharTemplate.DefaultAppearance.nmArms_Underlay = 'CnvUnderlay_Std_Arms_A_M';
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes_2';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_USA';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_M';
	CharTemplate.DefaultAppearance.nmLegs = 'CnvMed_Std_D_M';
	CharTemplate.DefaultAppearance.nmLegs_Underlay = 'CnvUnderlay_Std_Legs_A_M';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'CnvMed_Std_C_M';
	CharTemplate.DefaultAppearance.nmTorso_Underlay = 'CnvUnderlay_Std_Torsos_A_M';
	CharTemplate.DefaultAppearance.nmWeaponPattern = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmVoice = 'TLE_CentralVoice1_Localized';

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_XCom;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;
}

static function X2CharacterTemplate CreateLilyShen_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'LadderShen');
	CharTemplate.UnitSize = 1;
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = true;
	CharTemplate.strMatineePackages.AddItem("CIN_Soldier");
	CharTemplate.strIntroMatineeSlotPrefix = "Char";
	CharTemplate.strLoadingMatineeSlotPrefix = "Soldier";

	CharTemplate.DefaultLoadout = 'LadderShen_Loadout';
	CharTemplate.RequiredLoadout = 'RequiredSoldier';
	CharTemplate.Abilities.AddItem('Loot');
	CharTemplate.Abilities.AddItem('Interact_StasisTube');
	CharTemplate.Abilities.AddItem('CarryUnit');
	CharTemplate.Abilities.AddItem('PutDownUnit');
	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('PlaceEvacZone');
	CharTemplate.Abilities.AddItem('LiftOffAvenger');
	CharTemplate.Abilities.AddItem('Knockout');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.Abilities.AddItem('Panicked');
	CharTemplate.Abilities.AddItem('DisableConsumeAllPoints');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('LadderUnkillable');
	CharTemplate.Abilities.AddItem('Interact_PlantBomb');

	CharTemplate.bShouldCreateDifficultyVariants = false;

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'XCom_Soldier_F';
	CharTemplate.DefaultAppearance.nmHead = 'Shen_Head';
	CharTemplate.DefaultAppearance.nmHaircut = 'Shen_Hair';
	CharTemplate.DefaultAppearance.nmBeard = '';
	CharTemplate.DefaultAppearance.iArmorTint = 97;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = 3;
	CharTemplate.DefaultAppearance.iGender = 2;
	CharTemplate.DefaultAppearance.iAttitude = 3;
	CharTemplate.DefaultAppearance.nmArms = 'TLE_Shen_Arms';
	CharTemplate.DefaultAppearance.nmArms_Underlay = 'CnvMed_Underlay_A_F';
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes_2';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_USA'; // Taiwanese-American -acheng
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_F';
	CharTemplate.DefaultAppearance.nmLegs = 'CnvMed_Std_A_F';
	CharTemplate.DefaultAppearance.nmLegs_Underlay = 'CnvUnderlay_Std_A_F';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'DLC_3_Tattoo_Arms_01';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'CnvMed_Std_A_F';
	CharTemplate.DefaultAppearance.nmTorso_Underlay = 'CnvUnderlay_Std_A_F';
	CharTemplate.DefaultAppearance.nmWeaponPattern = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.iWeaponTint = 3;
	CharTemplate.DefaultAppearance.nmVoice = 'TLE_ShenVoice1_Localized';

	CharTemplate.DefaultSoldierClass = 'TLE_ChiefEngineer';
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_XCom;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;
}

static function X2CharacterTemplate CreateJaneKelly_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'JaneKelly');
	CharTemplate.UnitSize = 1;
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = true;
	CharTemplate.strMatineePackages.AddItem("CIN_Soldier");
	CharTemplate.strIntroMatineeSlotPrefix = "Char";
	CharTemplate.strLoadingMatineeSlotPrefix = "Soldier";

	CharTemplate.DefaultLoadout = 'RookieSoldier';
	CharTemplate.RequiredLoadout = 'RequiredSoldier';
	CharTemplate.Abilities.AddItem('Loot');
	CharTemplate.Abilities.AddItem('Interact_StasisTube');
	CharTemplate.Abilities.AddItem('CarryUnit');
	CharTemplate.Abilities.AddItem('PutDownUnit');
	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('PlaceEvacZone');
	CharTemplate.Abilities.AddItem('LiftOffAvenger');
	CharTemplate.Abilities.AddItem('Knockout');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.Abilities.AddItem('Panicked');
	CharTemplate.Abilities.AddItem('DisableConsumeAllPoints');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('LadderUnkillable');
	CharTemplate.Abilities.AddItem('Interact_PlantBomb');

	CharTemplate.bShouldCreateDifficultyVariants = false;

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'XCom_Soldier_F';
	CharTemplate.DefaultAppearance.nmHead = 'LatFem_C';
	CharTemplate.DefaultAppearance.nmHaircut = 'FemHair_F';
	CharTemplate.DefaultAppearance.nmBeard = '';
	CharTemplate.DefaultAppearance.iArmorTint = 6;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = -1;
	CharTemplate.DefaultAppearance.iGender = 2;
	CharTemplate.DefaultAppearance.iAttitude = 0;
	CharTemplate.DefaultAppearance.nmArms = 'CnvMed_Std_F_F';
	CharTemplate.DefaultAppearance.nmArms_Underlay = 'CnvMed_Underlay_A_F';
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_Ireland';
	CharTemplate.DefaultAppearance.nmHelmet = 'Hat_A_Ballcap_F';
	CharTemplate.DefaultAppearance.nmLegs = 'CnvMed_Std_C_F';
	CharTemplate.DefaultAppearance.nmLegs_Underlay = 'CnvUnderlay_Std_A_F';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'CnvMed_Std_C_F';
	CharTemplate.DefaultAppearance.nmTorso_Underlay = 'CnvUnderlay_Std_A_F';
	CharTemplate.DefaultAppearance.nmWeaponPattern = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.iWeaponTint = -1;
	CharTemplate.DefaultAppearance.nmVoice = 'FemaleVoice1_English_US';

	CharTemplate.DefaultSoldierClass = 'Ranger';
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_XCom;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;
}

static function X2CharacterTemplate CreatePeterOsei_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'PeterOsei');
	CharTemplate.UnitSize = 1;
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = true;
	CharTemplate.strMatineePackages.AddItem("CIN_Soldier");
	CharTemplate.strIntroMatineeSlotPrefix = "Char";
	CharTemplate.strLoadingMatineeSlotPrefix = "Soldier";

	CharTemplate.DefaultLoadout = 'RookieSoldier';
	CharTemplate.RequiredLoadout = 'RequiredSoldier';
	CharTemplate.Abilities.AddItem('Loot');
	CharTemplate.Abilities.AddItem('Interact_StasisTube');
	CharTemplate.Abilities.AddItem('CarryUnit');
	CharTemplate.Abilities.AddItem('PutDownUnit');
	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('PlaceEvacZone');
	CharTemplate.Abilities.AddItem('LiftOffAvenger');
	CharTemplate.Abilities.AddItem('Knockout');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.Abilities.AddItem('Panicked');
	CharTemplate.Abilities.AddItem('DisableConsumeAllPoints');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('LadderUnkillable');
	CharTemplate.Abilities.AddItem('Interact_PlantBomb');

	CharTemplate.bShouldCreateDifficultyVariants = false;

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'XCom_Soldier_M';
	CharTemplate.DefaultAppearance.nmHead = 'AfrMale_C';
	CharTemplate.DefaultAppearance.nmHaircut = 'MaleHair_Buzzcut';
	CharTemplate.DefaultAppearance.nmBeard = 'ShortSideburns';
	CharTemplate.DefaultAppearance.iArmorTint = 4;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = 5;
	CharTemplate.DefaultAppearance.iGender = 1;
	CharTemplate.DefaultAppearance.iAttitude = 0;
	CharTemplate.DefaultAppearance.nmArms = 'CnvMed_Std_D_M';
	CharTemplate.DefaultAppearance.nmArms_Underlay = 'CnvUnderlay_Std_Arms_A_M';
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Shades';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_Nigeria';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_M';
	CharTemplate.DefaultAppearance.nmLegs = 'CnvMed_Std_B_M';
	CharTemplate.DefaultAppearance.nmLegs_Underlay = 'CnvUnderlay_Std_Legs_A_M';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'CnvMed_Std_D_M';
	CharTemplate.DefaultAppearance.nmTorso_Underlay = 'CnvUnderlay_Std_Torsos_A_M';
	CharTemplate.DefaultAppearance.nmWeaponPattern = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.iWeaponTint = -1;
	CharTemplate.DefaultAppearance.nmVoice = 'MaleVoice1_English_US';

	CharTemplate.DefaultSoldierClass = 'Grenadier';
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_XCom;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;
}

static function X2CharacterTemplate CreateAnaRamirez_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AnaRamirez');
	CharTemplate.UnitSize = 1;
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = true;
	CharTemplate.strMatineePackages.AddItem("CIN_Soldier");
	CharTemplate.strIntroMatineeSlotPrefix = "Char";
	CharTemplate.strLoadingMatineeSlotPrefix = "Soldier";

	CharTemplate.DefaultLoadout = 'RookieSoldier';
	CharTemplate.RequiredLoadout = 'RequiredSoldier';
	CharTemplate.Abilities.AddItem('Loot');
	CharTemplate.Abilities.AddItem('Interact_StasisTube');
	CharTemplate.Abilities.AddItem('CarryUnit');
	CharTemplate.Abilities.AddItem('PutDownUnit');
	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('PlaceEvacZone');
	CharTemplate.Abilities.AddItem('LiftOffAvenger');
	CharTemplate.Abilities.AddItem('Knockout');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.Abilities.AddItem('Panicked');
	CharTemplate.Abilities.AddItem('DisableConsumeAllPoints');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('LadderUnkillable');
	CharTemplate.Abilities.AddItem('Interact_PlantBomb');

	CharTemplate.bShouldCreateDifficultyVariants = false;

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'XCom_Soldier_F';
	CharTemplate.DefaultAppearance.nmHead = 'LatFem_C';
	CharTemplate.DefaultAppearance.nmHaircut = 'Female_LongWavy';
	CharTemplate.DefaultAppearance.nmBeard = '';
	CharTemplate.DefaultAppearance.iArmorTint = 31;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = 10;
	CharTemplate.DefaultAppearance.iGender = 2;
	CharTemplate.DefaultAppearance.iAttitude = 0;
	CharTemplate.DefaultAppearance.nmArms = 'CnvMed_Std_F_F';
	CharTemplate.DefaultAppearance.nmArms_Underlay = 'CnvMed_Underlay_A_F';
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_Mexicon';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_F';
	CharTemplate.DefaultAppearance.nmLegs = 'CnvMed_Std_C_F';
	CharTemplate.DefaultAppearance.nmLegs_Underlay = 'CnvUnderlay_Std_A_F';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'CnvMed_Std_C_F';
	CharTemplate.DefaultAppearance.nmTorso_Underlay = 'CnvUnderlay_Std_A_F';
	CharTemplate.DefaultAppearance.nmWeaponPattern = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.iWeaponTint = -1;
	CharTemplate.DefaultAppearance.nmVoice = 'FemaleVoice1_English_US';

	CharTemplate.DefaultSoldierClass = 'Sharpshooter';
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_XCom;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;
}

// ROV-R Templates

static function X2CharacterTemplate CreateShenGremlinMk1_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'Shen_Gremlin_CV');
	CharTemplate.CharacterBaseStats[eStat_HP] = 1;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 1;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.AvengerOffset.X = 45;
	CharTemplate.AvengerOffset.Y = 90;
	CharTemplate.AvengerOffset.Z = -20;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanUse_eTraversal_Launch = true;
	CharTemplate.bCanUse_eTraversal_Flying = true;
	CharTemplate.bCanUse_eTraversal_Land = true;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bIsAfraidOfFire = false;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bIsCosmetic = true;
	CharTemplate.bDisplayUIUnitFlag=false;
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_GremlinShen.ARC_GameUnit_GremlinShen");
	CharTemplate.bAllowRushCam = false;
	CharTemplate.SoloMoveSpeedModifier = 2.0f;

	CharTemplate.HQIdleAnim = "HL_Idle";
	CharTemplate.HQOffscreenAnim = "HL_FlyUpStart";
	CharTemplate.HQOnscreenAnimPrefix = "HL_FlyDwn";
	CharTemplate.HQOnscreenOffset.X = 0;
	CharTemplate.HQOnscreenOffset.Y = 0;
	CharTemplate.HQOnscreenOffset.Z = 96.0f;

	CharTemplate.Abilities.AddItem('Panicked');

	return CharTemplate;
}

static function X2CharacterTemplate CreateShenGremlinMk2_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'Shen_Gremlin_MG');
	CharTemplate.CharacterBaseStats[eStat_HP] = 1;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 1;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.AvengerOffset.X = 45;
	CharTemplate.AvengerOffset.Y = 90;
	CharTemplate.AvengerOffset.Z = -20;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanUse_eTraversal_Launch = true;
	CharTemplate.bCanUse_eTraversal_Flying = true;
	CharTemplate.bCanUse_eTraversal_Land = true;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bIsAfraidOfFire = false;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bIsCosmetic = true;
	CharTemplate.bDisplayUIUnitFlag=false;
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_GremlinShen.ARC_GameUnit_GremlinShen");
	CharTemplate.bAllowRushCam = false;
	CharTemplate.SoloMoveSpeedModifier = 2.0f;

	CharTemplate.HQIdleAnim = "HL_Idle";
	CharTemplate.HQOffscreenAnim = "HL_FlyUpStart";
	CharTemplate.HQOnscreenAnimPrefix = "HL_FlyDwn";
	CharTemplate.HQOnscreenOffset.X = 0;
	CharTemplate.HQOnscreenOffset.Y = 0;
	CharTemplate.HQOnscreenOffset.Z = 96.0f;

	CharTemplate.Abilities.AddItem('Panicked');

	return CharTemplate;
}

static function X2CharacterTemplate CreateShenGremlinMk3_Template()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'Shen_Gremlin_BM');
	CharTemplate.CharacterBaseStats[eStat_HP] = 1;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 1;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.AvengerOffset.X = 45;
	CharTemplate.AvengerOffset.Y = 90;
	CharTemplate.AvengerOffset.Z = -20;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanUse_eTraversal_Launch = true;
	CharTemplate.bCanUse_eTraversal_Flying = true;
	CharTemplate.bCanUse_eTraversal_Land = true;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bIsAfraidOfFire = false;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bIsCosmetic = true;
	CharTemplate.bDisplayUIUnitFlag=false;
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_GremlinShen.ARC_GameUnit_GremlinShen");
	CharTemplate.bAllowRushCam = false;
	CharTemplate.SoloMoveSpeedModifier = 2.0f;

	CharTemplate.HQIdleAnim = "HL_Idle";
	CharTemplate.HQOffscreenAnim = "HL_FlyUpStart";
	CharTemplate.HQOnscreenAnimPrefix = "HL_FlyDwn";
	CharTemplate.HQOnscreenOffset.X = 0;
	CharTemplate.HQOnscreenOffset.Y = 0;
	CharTemplate.HQOnscreenOffset.Z = 96.0f;

	CharTemplate.Abilities.AddItem('Panicked');

	return CharTemplate;
}

// VIP Templates

static function X2CharacterTemplate CreatePirateDJ_VIPTemplate()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'PirateDJ_VIP');
	CharTemplate.CharacterBaseStats[eStat_HP] = 5;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 14;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.CanFlankUnits = false;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = true;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bUsePoolVIPs = true;

	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.strBehaviorTree = "VIPCowardRoot";

	CharTemplate.strPanicBT = "";

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'PirateDJVIP';
	CharTemplate.DefaultAppearance.nmHead = 'PirateDJVIP_Head';
	CharTemplate.DefaultAppearance.nmHaircut = 'PirateDJVIP_Hair';
	CharTemplate.DefaultAppearance.iHairColor = 22;
	CharTemplate.DefaultAppearance.nmHelmet = 'PirateDJVIP_Helmet';
	CharTemplate.DefaultAppearance.nmBeard = 'MaleBeard_Blank';
	CharTemplate.DefaultAppearance.iGender = 1;
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'PirateVIP_Glasses';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_USA';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_M';
	CharTemplate.DefaultAppearance.nmTorso = 'PirateDJVIP_Torso';
	CharTemplate.DefaultAppearance.iArmorTint = 97;

	CharTemplate.SpeakerPortrait = "img:///UILibrary_XPACK_Common.Head_Radio";

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_VIP;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;

}

static function X2CharacterTemplate CreateBlackMarketTrader_VIPTemplate()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'BlackMarketTrader_VIP');
	CharTemplate.CharacterBaseStats[eStat_HP] = 5;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 14;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.CanFlankUnits = false;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = true;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bUsePoolVIPs = true;

	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.strBehaviorTree = "VIPCowardRoot";

	CharTemplate.strPanicBT = "";

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'BlackMarketTrader';
	CharTemplate.DefaultAppearance.nmHead = 'BlackMarketTrader_Head';
	CharTemplate.DefaultAppearance.nmHaircut = 'BlackMarketTrader_Hair';
	CharTemplate.DefaultAppearance.iHairColor = 14;
	CharTemplate.DefaultAppearance.iGender = 2;
	CharTemplate.DefaultAppearance.iRace = 1;
	CharTemplate.DefaultAppearance.iSkinColor = 5;
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_F';
	CharTemplate.DefaultAppearance.nmTorso = 'BlackMarketTrader_Torso';
	CharTemplate.DefaultAppearance.nmVoice = 'FemaleVoice1_English_US';
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_VIP;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;

}

static function X2CharacterTemplate CreateLilyShen_VIPTemplate()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'LilyShen_VIP');
	CharTemplate.CharacterBaseStats[eStat_HP] = 5;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 14;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.CanFlankUnits = false;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = true;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bUsePoolVIPs = true;
	
	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.strBehaviorTree = "VIPCowardRoot";

	CharTemplate.strPanicBT = "";

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'ShenVIP';
	CharTemplate.DefaultAppearance.nmHead = 'ShenVIP_Head';
	CharTemplate.DefaultAppearance.nmHaircut = 'ShenVIP_Hair';
	CharTemplate.DefaultAppearance.nmBeard = '';
	CharTemplate.DefaultAppearance.iArmorTint = 97;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = 3;
	CharTemplate.DefaultAppearance.iGender = 2;
	CharTemplate.DefaultAppearance.iAttitude = 3;
	CharTemplate.DefaultAppearance.nmArms = 'ShenVIP_Arms_A';
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes_2';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_USA';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_F';
	CharTemplate.DefaultAppearance.nmLegs = 'ShenVIP_Legs_A';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'DLC_3_Tattoo_Arms_01';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'ShenVIP_Torso_A';
	CharTemplate.DefaultAppearance.nmVoice = 'TLE_ShenVoice1_Localized';

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_VIP;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;

}

static function X2CharacterTemplate CreateJaneKelly_VIPTemplate()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'JaneKelly_VIP');
	CharTemplate.CharacterBaseStats[eStat_HP] = 5;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 14;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.CanFlankUnits = false;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = true;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bUsePoolVIPs = true;

	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.strBehaviorTree = "VIPCowardRoot";

	CharTemplate.strPanicBT = "";

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'FriendlyVIPCivilian_F';
	CharTemplate.DefaultAppearance.nmHead = 'LatFem_C';
	CharTemplate.DefaultAppearance.nmHaircut = 'FemHair_F';
	CharTemplate.DefaultAppearance.nmBeard = '';
	CharTemplate.DefaultAppearance.iArmorTint = 6;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = -1;
	CharTemplate.DefaultAppearance.iGender = 2;
	CharTemplate.DefaultAppearance.iAttitude = 0;
	CharTemplate.DefaultAppearance.nmArms = 'Jane_Arms';
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_Ireland';
	CharTemplate.DefaultAppearance.nmHelmet = 'Hat_A_Ballcap_F';
	CharTemplate.DefaultAppearance.nmLegs = 'Jane_Legs';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'Jane_Torso';
	CharTemplate.DefaultAppearance.nmVoice = 'FemaleVoice1_English_US';
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_VIP;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;

}

static function X2CharacterTemplate CreatePeterOsei_VIPTemplate()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'PeterOsei_VIP');
	CharTemplate.CharacterBaseStats[eStat_HP] = 5;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 14;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.CanFlankUnits = false;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = true;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bUsePoolVIPs = true;

	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.strBehaviorTree = "VIPCowardRoot";

	CharTemplate.strPanicBT = "";

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'FriendlyVIPCivilian_M';
	CharTemplate.DefaultAppearance.nmHead = 'AfrMale_C';
	CharTemplate.DefaultAppearance.nmHaircut = 'MaleHair_Buzzcut';
	CharTemplate.DefaultAppearance.nmBeard = 'ShortSideburns';
	CharTemplate.DefaultAppearance.iArmorTint = 4;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = 5;
	CharTemplate.DefaultAppearance.iGender = 1;
	CharTemplate.DefaultAppearance.iAttitude = 0;
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_Nigeria';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_M';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'MilitaryVIPCivilian_Neutral_M';
	CharTemplate.DefaultAppearance.nmVoice = 'MaleVoice1_English_US';

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_VIP;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;

}

static function X2CharacterTemplate CreateAnaRamirez_VIPTemplate()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AnaRamirez_VIP');
	CharTemplate.CharacterBaseStats[eStat_HP] = 5;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 14;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.CanFlankUnits = false;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = true;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bUsePoolVIPs = true;

	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.strBehaviorTree = "VIPCowardRoot";

	CharTemplate.strPanicBT = "";

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'FriendlyVIPCivilian_F';
	CharTemplate.DefaultAppearance.nmHead = 'LatFem_C';
	CharTemplate.DefaultAppearance.nmHaircut = 'Female_LongWavy';
	CharTemplate.DefaultAppearance.nmBeard = '';
	CharTemplate.DefaultAppearance.iArmorTint = 31;
	CharTemplate.DefaultAppearance.iArmorTintSecondary = 10;
	CharTemplate.DefaultAppearance.iGender = 2;
	CharTemplate.DefaultAppearance.iAttitude = 0;
	CharTemplate.DefaultAppearance.nmEye = 'DefaultEyes';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'Prop_FaceUpper_Blank';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_Mexicon';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_F';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'MilitaryVIPCivilian_Neutral_F';
	CharTemplate.DefaultAppearance.nmVoice = 'FemaleVoice1_English_US';

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_VIP;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;

}

static function X2CharacterTemplate CreateTygan_VIPTemplate()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'Tygan_VIP');
	CharTemplate.CharacterBaseStats[eStat_HP] = 5;
	CharTemplate.CharacterBaseStats[eStat_Offense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Defense] = 0;
	CharTemplate.CharacterBaseStats[eStat_Mobility] = 12;
	CharTemplate.CharacterBaseStats[eStat_SightRadius] = 14;
	CharTemplate.CharacterBaseStats[eStat_Will] = 50;
	CharTemplate.CharacterBaseStats[eStat_FlightFuel] = 0;
	CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 1;
	CharTemplate.CharacterBaseStats[eStat_AlertLevel] = 2;
	CharTemplate.UnitSize = 1;
	CharTemplate.CanFlankUnits = false;
	CharTemplate.BehaviorClass = class'XGAIBehavior_Civilian';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCarried = true;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = true;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bUsePoolVIPs = true;
	
	CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.strBehaviorTree = "VIPCowardRoot";

	CharTemplate.strPanicBT = "";

	CharTemplate.bHasFullDefaultAppearance = true;
	CharTemplate.DefaultAppearance.nmPawn = 'TyganVIP';
	CharTemplate.DefaultAppearance.nmHead = 'TyganVIP_Head';
	CharTemplate.DefaultAppearance.nmHaircut = 'MaleHair_Blank';
	CharTemplate.DefaultAppearance.nmBeard = 'MaleBeard_Blank';
	CharTemplate.DefaultAppearance.iGender = 1;
	CharTemplate.DefaultAppearance.nmArms = 'TyganVIP_Arms_A';
	CharTemplate.DefaultAppearance.nmFacePropLower = 'Prop_FaceLower_Blank';
	CharTemplate.DefaultAppearance.nmFacePropUpper = 'TyganVIP_Glasses';
	CharTemplate.DefaultAppearance.nmFlag = 'Country_USA';
	CharTemplate.DefaultAppearance.nmHelmet = 'Helmet_0_NoHelmet_M';
	CharTemplate.DefaultAppearance.nmLegs = 'TyganVIP_Legs_A';
	CharTemplate.DefaultAppearance.nmPatterns = 'Pat_Nothing';
	CharTemplate.DefaultAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	CharTemplate.DefaultAppearance.nmTeeth = 'DefaultTeeth';
	CharTemplate.DefaultAppearance.nmTorso = 'TyganVIP_Torso_A';
	CharTemplate.DefaultAppearance.nmWeaponPattern = 'Pat_Nothing';

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_VIP;
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator';

	return CharTemplate;

}