//---------------------------------------------------------------------------------------
//  FILE:    X2Item_TLE_Weapons.uc
//  AUTHOR:  Russell.Aasland
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2Item_TLE_Weapons extends X2Item config(GameData_WeaponData);

var config array<name> TLE1AssaultRifleUpgrades;
var config array<name> TLE2AssaultRifleUpgrades;
var config array<name> TLE3AssaultRifleUpgrades;
var config array<name> TLE1CannonUpgrades;
var config array<name> TLE2CannonUpgrades;
var config array<name> TLE3CannonUpgrades;
var config array<name> TLE1ShotgunUpgrades;
var config array<name> TLE2ShotgunUpgrades;
var config array<name> TLE3ShotgunUpgrades;
var config array<name> TLE1SniperRifleUpgrades;
var config array<name> TLE2SniperRifleUpgrades;
var config array<name> TLE3SniperRifleUpgrades;

var config int GREMLIN_ISOUNDRANGE;
var config int GREMLIN_IENVIRONMENTDAMAGE;
var config int GREMLIN_HACKBONUS;

var config int GREMLINMK2_ISOUNDRANGE;
var config int GREMLINMK2_IENVIRONMENTDAMAGE;
var config int GREMLINMK2_HACKBONUS;

var config int GREMLINMK3_ISOUNDRANGE;
var config int GREMLINMK3_IENVIRONMENTDAMAGE;
var config int GREMLINMK3_HACKBONUS;

var config array <WeaponDamageValue> GREMLINMK1_ABILITYDAMAGE;
var config array <WeaponDamageValue> GREMLINMK2_ABILITYDAMAGE;
var config array <WeaponDamageValue> GREMLINMK3_ABILITYDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;

	Weapons.AddItem( CreateTLE1AssaultRifle() );
	Weapons.AddItem( CreateTLE2AssaultRifle() );
	Weapons.AddItem( CreateTLE3AssaultRifle() );

	Weapons.AddItem( CreateTLE1Cannon() );
	Weapons.AddItem( CreateTLE2Cannon() );
	Weapons.AddItem( CreateTLE3Cannon() );

	Weapons.AddItem( CreateTLE1Pistol() );
	Weapons.AddItem( CreateTLE2Pistol() );
	Weapons.AddItem( CreateTLE3Pistol() );

	Weapons.AddItem( CreateTLE1Shotgun() );
	Weapons.AddItem( CreateTLE2Shotgun() );
	Weapons.AddItem( CreateTLE3Shotgun() );

	Weapons.AddItem( CreateTLE1SniperRifle() );
	Weapons.AddItem( CreateTLE2SniperRifle() );
	Weapons.AddItem( CreateTLE3SniperRifle() );

	Weapons.AddItem( CreateTLE1Sword() );
	Weapons.AddItem( CreateTLE2Sword() );
	Weapons.AddItem( CreateTLE3Sword() );

	Weapons.AddItem(CreateTemplate_ShenGremlinDrone_Conventional());
	Weapons.AddItem(CreateTemplate_ShenGremlinDrone_Magnetic());
	Weapons.AddItem(CreateTemplate_ShenGremlinDrone_Beam());

	return Weapons;
}

static function bool ApplyWeaponUpgrades(XComGameState_Item ItemState, array<name> WeaponUpgrades)
{
	local X2ItemTemplateManager ItemTemplateMgr;
	local X2WeaponUpgradeTemplate UpgradeTemplate;
	local name WeaponUpgradeName;

	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	foreach WeaponUpgrades(WeaponUpgradeName)
	{
		UpgradeTemplate = X2WeaponUpgradeTemplate(ItemTemplateMgr.FindItemTemplate(WeaponUpgradeName));
		if (UpgradeTemplate != none)
		{
			ItemState.ApplyWeaponUpgradeTemplate(UpgradeTemplate);
		}
	}

	return true;
}

static function bool OnTLE1AssaultRifleAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades( ItemState, default.TLE1AssaultRifleUpgrades);
	}

	return false;
}

static function bool OnTLE2AssaultRifleAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE2AssaultRifleUpgrades);
	}

	return false;
}

static function bool OnTLE3AssaultRifleAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE3AssaultRifleUpgrades);
	}

	return false;
}

static function bool OnTLE1CannonAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE1CannonUpgrades);
	}

	return false;
}

static function bool OnTLE2CannonAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE2CannonUpgrades);
	}

	return false;
}

static function bool OnTLE3CannonAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE3CannonUpgrades);
	}

	return false;
}

static function bool OnTLE1ShotgunAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE1ShotgunUpgrades);
	}

	return false;
}

static function bool OnTLE2ShotgunAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE2ShotgunUpgrades);
	}

	return false;
}

static function bool OnTLE3ShotgunAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE3ShotgunUpgrades);
	}

	return false;
}

static function bool OnTLE1SniperRifleAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE1SniperRifleUpgrades);
	}

	return false;
}

static function bool OnTLE2SniperRifleAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE2SniperRifleUpgrades);
	}

	return false;
}

static function bool OnTLE3SniperRifleAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	if (ItemState.GetMyWeaponUpgradeTemplateNames().Length == 0)
	{
		return ApplyWeaponUpgrades(ItemState, default.TLE3SniperRifleUpgrades);
	}

	return false;
}

static function X2DataTemplate CreateTLE1AssaultRifle()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_AssaultRifle_CV');
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_AR_Base";
	Template.Tier = 0;
	Template.OnAcquiredFn = OnTLE1AssaultRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange =class'X2Item_DefaultWeapons'. default.ASSAULTRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1AssaultRifle.WP_TLE1AssaultRifle";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.fKnockbackDamageAmount = 5.0f;
	Template.fKnockbackDamageRadius = 0.0f;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTLE2AssaultRifle()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_AssaultRifle_MG');
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_AR_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 2;
	Template.OnAcquiredFn = OnTLE2AssaultRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2AssaultRifle.WP_TLE2AssaultRifle";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'AssaultRifle_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_AssaultRifle_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3AssaultRifle()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_AssaultRifle_BM');
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_AR_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = 4;
	Template.OnAcquiredFn = OnTLE3AssaultRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3AssaultRifle.WP_TLE3AssaultRifle";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;

	Template.CreatorTemplateName = 'AssaultRifle_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_AssaultRifle_MG'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTLE1Cannon()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Cannon_CV');
	Template.WeaponPanelImage = "_ConventionalCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Cannon_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = 0;
	Template.OnAcquiredFn = OnTLE1CannonAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Cannon.WP_TLE1Cannon";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTLE2Cannon()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Cannon_MG');
	Template.WeaponPanelImage = "_MagneticCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Cannon_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 3;
	Template.OnAcquiredFn = OnTLE2CannonAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Cannon.WP_TLE2Cannon";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Cannon_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Cannon_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3Cannon()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Cannon_BM');
	Template.WeaponPanelImage = "_BeamCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Cannon_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = 5;
	Template.OnAcquiredFn = OnTLE3CannonAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.LMG_BEAM_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.LMG_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.LMG_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.LMG_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_BEAM_IENVIRONMENTDAMAGE;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Cannon.WP_TLE3Cannon";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Cannon_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Cannon_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTLE1Pistol()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Pistol_CV');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Pistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.InfiniteAmmo = true;
	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');	

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Pistol.WP_TLE1Pistol";

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTLE2Pistol()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Pistol_MG');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Pistol_Laser";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 2;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Pistol.WP_TLE2Pistol";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Pistol_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTLE3Pistol()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Pistol_BM');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Pistol_Plasma";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = 4;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_IENVIRONMENTDAMAGE;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeamA');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Pistol.WP_TLE3Pistol";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Pistol_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTLE1SniperRifle()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_SniperRifle_CV');
	Template.WeaponPanelImage = "_ConventionalSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sniper_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = 0;
	Template.OnAcquiredFn = OnTLE1SniperRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_CONVENTIONAL_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Sniper.WP_TLE1Sniper";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTLE2SniperRifle()
{
	local X2WeaponTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_SniperRifle_MG');
	Template.WeaponPanelImage = "_MagneticSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sniper_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 3;
	Template.OnAcquiredFn = OnTLE2SniperRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_MAGNETIC_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Sniper.WP_TLE2Sniper";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'SniperRifle_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_SniperRifle_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3SniperRifle()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_SniperRifle_BM');
	Template.WeaponPanelImage = "_BeamSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sniper_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = 5;
	Template.OnAcquiredFn = OnTLE3SniperRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_BEAM_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_IENVIRONMENTDAMAGE;
	Template.iTypicalActionCost = 2;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Sniper.WP_TLE3Sniper";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'SniperRifle_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_SniperRifle_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTLE1Shotgun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Shotgun_CV');
	Template.WeaponPanelImage = "_ConventionalShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Shotgun_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = 0;
	Template.OnAcquiredFn = OnTLE1ShotgunAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Shotgun.WP_TLE1Shotgun";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTLE2Shotgun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Shotgun_MG');
	Template.WeaponPanelImage = "_MagneticShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Shotgun_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 3;
	Template.OnAcquiredFn = OnTLE2ShotgunAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Shotgun.WP_TLE2Shotgun";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Shotgun_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Shotgun_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3Shotgun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Shotgun_BM');
	Template.WeaponPanelImage = "_BeamShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Shotgun_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = 5;
	Template.OnAcquiredFn = OnTLE3ShotgunAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Shotgun.WP_TLE3Shotgun";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Shotgun_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Shotgun_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTLE1Sword()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Sword_CV');
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sword";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Sword.WP_TLE1Sword";
	Template.AddDefaultAttachment('R_Back', "", false);
	Template.Tier = 0;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_CRITCHANCE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTLE2Sword()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Sword_MG');
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sword_Laser";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Sword.WP_TLE2Sword";
	Template.AddDefaultAttachment('R_Back', "MagSword.Meshes.SM_MagSword_Sheath", false);
	Template.Tier = 2;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_CRITCHANCE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_STUNCHANCE, false));

	Template.CreatorTemplateName = 'Sword_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Sword_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_STUNCHANCE, , , "%");

	return Template;
}

static function X2DataTemplate CreateTLE3Sword()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'TLE_Sword_BM');
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sword_Plasma";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Sword.WP_TLE3Sword";
	Template.AddDefaultAttachment('R_Back', "BeamSword.Meshes.SM_BeamSword_Sheath", false);
	Template.Tier = 4;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_CRITCHANCE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));

	Template.CreatorTemplateName = 'Sword_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Sword_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTemplate_ShenGremlinDrone_Conventional()
{
	local X2GremlinTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, 'Shen_Gremlin_CV');
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_TLE_Common.Inv_Gremlin_Drone_Shen";
	Template.EquipSound = "Gremlin_Equip";

	Template.CosmeticUnitTemplate = "Shen_Gremlin_CV";
	Template.Tier = 0;

	Template.ExtraDamage = default.GREMLINMK1_ABILITYDAMAGE;
	Template.HackingAttemptBonus = default.GREMLIN_HACKBONUS;
	Template.AidProtocolBonus = 0;
	Template.HealingBonus = 0;
	Template.BaseDamage.Damage = 2;     //  combat protocol
	Template.BaseDamage.Pierce = 1000;  //  ignore armor

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Electrical';

	Template.bHideDamageStat = true;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLIN_HACKBONUS, true);

	return Template;
}

static function X2DataTemplate CreateTemplate_ShenGremlinDrone_Magnetic()
{
	local X2GremlinTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, 'Shen_Gremlin_MG');
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_TLE_Common.Inv_Gremlin_Drone_Shen";
	Template.EquipSound = "Gremlin_Equip";

	Template.CosmeticUnitTemplate = "Shen_Gremlin_MG";
	Template.Tier = 2;

	Template.ExtraDamage = default.GREMLINMK2_ABILITYDAMAGE;
	Template.HackingAttemptBonus = default.GREMLINMK2_HACKBONUS;
	Template.AidProtocolBonus = 10;
	Template.HealingBonus = 1;
	Template.BaseDamage.Damage = 4;     //  combat protocol
	Template.BaseDamage.Pierce = 1000;  //  ignore armor

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Electrical';

	Template.bHideDamageStat = true;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLINMK2_HACKBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_ShenGremlinDrone_Beam()
{
	local X2GremlinTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, 'Shen_Gremlin_BM');
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_TLE_Common.Inv_Gremlin_Drone_Shen";
	Template.EquipSound = "Gremlin_Equip";

	Template.CosmeticUnitTemplate = "Shen_Gremlin_BM";
	Template.Tier = 4;

	Template.ExtraDamage = default.GREMLINMK3_ABILITYDAMAGE;
	Template.HackingAttemptBonus = default.GREMLINMK3_HACKBONUS;
	Template.AidProtocolBonus = 20;
	Template.HealingBonus = 2;
	Template.RevivalChargesBonus = 1;
	Template.ScanningChargesBonus = 1;
	Template.BaseDamage.Damage = 6;     //  combat protocol
	Template.BaseDamage.Pierce = 1000;  //  ignore armor

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Electrical';

	Template.bHideDamageStat = true;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLINMK3_HACKBONUS);

	return Template;
}

defaultproperties
{
	bShouldCreateDifficultyVariants = true
}