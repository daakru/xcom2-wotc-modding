class X2Item_TLE_Armor extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Armors;

	Armors.AddItem(CreateRangerKevlar());
	Armors.AddItem(CreateRangerPlated());
	Armors.AddItem(CreateRangerPowered());

	Armors.AddItem(CreateSpecialistKevlar());
	Armors.AddItem(CreateSpecialistPlated());
	Armors.AddItem(CreateSpecialistPowered());

	Armors.AddItem(CreateGrenadierKevlar());
	Armors.AddItem(CreateGrenadierPlated());
	Armors.AddItem(CreateGrenadierPowered());

	Armors.AddItem(CreateSharpshooterKevlar());
	Armors.AddItem(CreateSharpshooterPlated());
	Armors.AddItem(CreateSharpshooterPowered());

	Armors.AddItem(CreatePsiOperativeKevlar());
	Armors.AddItem(CreatePsiOperativePlated());
	Armors.AddItem(CreatePsiOperativePowered());

	return Armors;
}

static function X2DataTemplate CreateRangerKevlar()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'RangerKevlarArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_Kevlar_Assault";
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.ArmorTechCat = 'conventional';
	Template.ArmorClass = 'basic';
	Template.Tier = 0;
	Template.AkAudioSoldierArmorSwitch = 'Conventional';
	Template.EquipSound = "StrategyUI_Armor_Equip_Conventional";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, 0, true);

	Template.ArmorCat = 'ranger';

	return Template;
}

static function X2DataTemplate CreateRangerPlated()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'RangerPlatedArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PLT_Assault";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 20;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPlatedArmorStats');
	Template.ArmorTechCat = 'plated';
	Template.ArmorClass = 'medium';
	Template.Tier = 1;
	Template.AkAudioSoldierArmorSwitch = 'Predator';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PlatedMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Plated";

	Template.CreatorTemplateName = 'MediumPlatedArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'RangerKevlarArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_PLATED_HEALTH_BONUS, true);

	Template.ArmorCat = 'ranger';

	return Template;
}

static function X2DataTemplate CreateRangerPowered()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'RangerPoweredArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PWR_Assault";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 60;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPoweredArmorStats');
	Template.ArmorTechCat = 'powered';
	Template.ArmorClass = 'medium';
	Template.Tier = 3;
	Template.AkAudioSoldierArmorSwitch = 'Warden';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PoweredMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.CreatorTemplateName = 'MediumPoweredArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'RangerPlatedArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_MITIGATION_AMOUNT);

	Template.ArmorCat = 'ranger';

	return Template;
}

static function X2DataTemplate CreateSpecialistKevlar()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'SpecialistKevlarArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_Kevlar_Support";
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.ArmorTechCat = 'conventional';
	Template.ArmorClass = 'basic';
	Template.Tier = 0;
	Template.AkAudioSoldierArmorSwitch = 'Conventional';
	Template.EquipSound = "StrategyUI_Armor_Equip_Conventional";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, 0, true);

	Template.ArmorCat = 'specialist';

	return Template;
}

static function X2DataTemplate CreateSpecialistPlated()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'SpecialistPlatedArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PLT_Support";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 20;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPlatedArmorStats');
	Template.ArmorTechCat = 'plated';
	Template.ArmorClass = 'medium';
	Template.Tier = 1;
	Template.AkAudioSoldierArmorSwitch = 'Predator';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PlatedMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Plated";

	Template.CreatorTemplateName = 'MediumPlatedArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SpecialistKevlarArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_PLATED_HEALTH_BONUS, true);

	Template.ArmorCat = 'specialist';

	return Template;
}

static function X2DataTemplate CreateSpecialistPowered()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'SpecialistPoweredArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PWR_Support";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 60;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPoweredArmorStats');
	Template.ArmorTechCat = 'powered';
	Template.ArmorClass = 'medium';
	Template.Tier = 3;
	Template.AkAudioSoldierArmorSwitch = 'Warden';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PoweredMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.CreatorTemplateName = 'MediumPoweredArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SpecialistPlatedArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_MITIGATION_AMOUNT);

	Template.ArmorCat = 'specialist';

	return Template;
}

static function X2DataTemplate CreateGrenadierKevlar()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'GrenadierKevlarArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_Kevlar_Heavy";
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.ArmorTechCat = 'conventional';
	Template.ArmorClass = 'basic';
	Template.Tier = 0;
	Template.AkAudioSoldierArmorSwitch = 'Conventional';
	Template.EquipSound = "StrategyUI_Armor_Equip_Conventional";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, 0, true);

	Template.ArmorCat = 'grenadier';

	return Template;
}

static function X2DataTemplate CreateGrenadierPlated()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'GrenadierPlatedArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PLT_Heavy";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 20;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPlatedArmorStats');
	Template.ArmorTechCat = 'plated';
	Template.ArmorClass = 'medium';
	Template.Tier = 1;
	Template.AkAudioSoldierArmorSwitch = 'Predator';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PlatedMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Plated";

	Template.CreatorTemplateName = 'MediumPlatedArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'GrenadierKevlarArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_PLATED_HEALTH_BONUS, true);

	Template.ArmorCat = 'grenadier';

	return Template;
}

static function X2DataTemplate CreateGrenadierPowered()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'GrenadierPoweredArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PWR_Heavy";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 60;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPoweredArmorStats');
	Template.ArmorTechCat = 'powered';
	Template.ArmorClass = 'medium';
	Template.Tier = 3;
	Template.AkAudioSoldierArmorSwitch = 'Warden';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PoweredMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.CreatorTemplateName = 'MediumPoweredArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'GrenadierPlatedArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_MITIGATION_AMOUNT);

	Template.ArmorCat = 'grenadier';

	return Template;
}

static function X2DataTemplate CreateSharpshooterKevlar()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'SharpshooterKevlarArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_Kevlar_Sniper";
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.ArmorTechCat = 'conventional';
	Template.ArmorClass = 'basic';
	Template.Tier = 0;
	Template.AkAudioSoldierArmorSwitch = 'Conventional';
	Template.EquipSound = "StrategyUI_Armor_Equip_Conventional";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, 0, true);

	Template.ArmorCat = 'sharpshooter';

	return Template;
}

static function X2DataTemplate CreateSharpshooterPlated()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'SharpshooterPlatedArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PLT_Sniper";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 20;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPlatedArmorStats');
	Template.ArmorTechCat = 'plated';
	Template.ArmorClass = 'medium';
	Template.Tier = 1;
	Template.AkAudioSoldierArmorSwitch = 'Predator';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PlatedMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Plated";

	Template.CreatorTemplateName = 'MediumPlatedArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SparpshooterKevlarArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_PLATED_HEALTH_BONUS, true);

	Template.ArmorCat = 'sharpshooter';

	return Template;
}

static function X2DataTemplate CreateSharpshooterPowered()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'SharpshooterPoweredArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PWR_Sniper";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 60;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPoweredArmorStats');
	Template.ArmorTechCat = 'powered';
	Template.ArmorClass = 'medium';
	Template.Tier = 3;
	Template.AkAudioSoldierArmorSwitch = 'Warden';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PoweredMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.CreatorTemplateName = 'MediumPoweredArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SharpshooterPlatedArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_MITIGATION_AMOUNT);

	Template.ArmorCat = 'sharpshooter';

	return Template;
}

static function X2DataTemplate CreatePsiOperativeKevlar()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'PsiOperativeKevlarArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_Kevlar_Support";
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.ArmorTechCat = 'conventional';
	Template.ArmorClass = 'basic';
	Template.Tier = 0;
	Template.AkAudioSoldierArmorSwitch = 'Conventional';
	Template.EquipSound = "StrategyUI_Armor_Equip_Conventional";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, 0, true);

	Template.ArmorCat = 'psioperative';

	return Template;
}

static function X2DataTemplate CreatePsiOperativePlated()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'PsiOperativePlatedArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PLT_Support";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 20;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPlatedArmorStats');
	Template.ArmorTechCat = 'plated';
	Template.ArmorClass = 'medium';
	Template.Tier = 1;
	Template.AkAudioSoldierArmorSwitch = 'Predator';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PlatedMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Plated";

	Template.CreatorTemplateName = 'MediumPlatedArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PsiOperativeKevlarArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_PLATED_HEALTH_BONUS, true);

	Template.ArmorCat = 'psioperative';

	return Template;
}

static function X2DataTemplate CreatePsiOperativePowered()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'PsiOperativePoweredArmor');
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Inv_PWR_Support";
	Template.ItemCat = 'armor';
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.TradingPostValue = 60;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('MediumPoweredArmorStats');
	Template.ArmorTechCat = 'powered';
	Template.ArmorClass = 'medium';
	Template.Tier = 3;
	Template.AkAudioSoldierArmorSwitch = 'Warden';
	Template.EquipNarrative = "X2NarrativeMoments.Strategy.CIN_ArmorIntro_PoweredMedium";
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.CreatorTemplateName = 'MediumPoweredArmor_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PsiOperativePlatedArmor'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ItemGrantedAbilitySet'.default.MEDIUM_POWERED_MITIGATION_AMOUNT);

	Template.ArmorCat = 'psioperative';

	return Template;
}