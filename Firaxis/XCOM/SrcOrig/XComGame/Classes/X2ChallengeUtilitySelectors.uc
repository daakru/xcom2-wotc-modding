//---------------------------------------------------------------------------------------
//  FILE:    X2ChallengeUtilitySelectors.uc
//  AUTHOR:  Russell Aasland
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2ChallengeUtilitySelectors extends X2ChallengeElement;

static function array<X2DataTemplate> CreateTemplates( )
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem( CreateStandardUtilityItems() );
	Templates.AddItem( CreateBasicUtilityItems() );

	Templates.AddItem( CreateTLEUtilityItems() );
	Templates.AddItem( CreateTLEPCSItems() );

	return Templates;
}

static function X2ChallengeUtility CreateStandardUtilityItems( )
{
	local X2ChallengeUtility	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengeUtility', Template, 'ChallengeStandardUtilityItems');

	Template.UtilitySlot.AddItem( CreateEntry( 'AlienGrenade', 1 ) );

	Template.UtilitySlot2.AddItem( CreateEntry( 'MimicBeacon', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'BattleScanner', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'NanoMedikit', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'ProximityMine', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'CombatStims', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'APRounds', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'TracerRounds', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'IncendiaryRounds', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'TalonRounds', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'VenomRounds', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'BluescreenRounds', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'MindShield', 0 ) );

	Template.GrenadierSlot.AddItem( CreateEntry( 'FirebombMK2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'AlienGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'FlashbangGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'SmokeGrenadeMk2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'GasGrenadeMk2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'AcidGrenadeMk2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'EMPGrenadeMk2', 1 ) );

	Template.HeavyWeapon.AddItem( CreateEntry( 'RocketLauncher', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'ShredderGun', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'FlamethrowerMk2', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'BlasterLauncher', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'PlasmaBlaster', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'ShredstormCannon', 1 ) );

	return Template;
}

static function X2ChallengeUtility CreateTLEPCSItems()
{
	local X2ChallengeUtility	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengeUtility', Template, 'ChallengeTLEPCSItems');

	Template.UtilitySlot.AddItem(CreateEntry('CommonPCSSpeed', 1));
	Template.UtilitySlot.AddItem(CreateEntry('CommonPCSConditioning', 1));
	Template.UtilitySlot.AddItem(CreateEntry('CommonPCSFocus', 1));
	Template.UtilitySlot.AddItem(CreateEntry('CommonPCSPerception', 1));
	Template.UtilitySlot.AddItem(CreateEntry('CommonPCSAgility', 1));
	Template.UtilitySlot.AddItem(CreateEntry('RarePCSSpeed', 1));
	Template.UtilitySlot.AddItem(CreateEntry('RarePCSConditioning', 1));
	Template.UtilitySlot.AddItem(CreateEntry('RarePCSFocus', 1));
	Template.UtilitySlot.AddItem(CreateEntry('RarePCSPerception', 1));
	Template.UtilitySlot.AddItem(CreateEntry('RarePCSAgility', 1));
	Template.UtilitySlot.AddItem(CreateEntry('EpicPCSSpeed', 1));
	Template.UtilitySlot.AddItem(CreateEntry('EpicPCSConditioning', 1));
	Template.UtilitySlot.AddItem(CreateEntry('EpicPCSFocus', 1));
	Template.UtilitySlot.AddItem(CreateEntry('EpicPCSPerception', 1));
	Template.UtilitySlot.AddItem(CreateEntry('EpicPCSAgility', 1));

	return Template;
}

static function X2ChallengeUtility CreateBasicUtilityItems( )
{
	local X2ChallengeUtility	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengeUtility', Template, 'ChallengeBasicUtilityItems');

	Template.SelectUtilityItemFn = BasicUtilitySelector;

	Template.UtilitySlot2.AddItem( CreateEntry( 'NanoMedikit', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'IncendiaryRounds', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'ProximityMine', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'CombatStims', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'BattleScanner', 1 ) );
	Template.UtilitySlot2.AddItem( CreateEntry( 'MimicBeacon', 1 ) );

	return Template;
}

static function X2ChallengeUtility CreateTLEUtilityItems( )
{
	local X2ChallengeUtility	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengeUtility', Template, 'ChallengeTLEUtilityItems');

	// for TLE we'll use the slots to break things up in a reasonable way
	// Utility slot for everything non-grenade
	// GrenadierSlot for all grenades
	// HeavyWeapon for all Heavy Weapons
	Template.UtilitySlot.AddItem( CreateEntry( 'MimicBeacon', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'BattleScanner', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'Medikit', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'NanoMedikit', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'CombatStims', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'APRounds', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'TracerRounds', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'IncendiaryRounds', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'TalonRounds', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'VenomRounds', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'BluescreenRounds', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'MindShield', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'SustainingSphere', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'RefractionField', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'UltrasonicLure', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'NanofiberVest', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'PlatedVest', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'HazmatVest', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'StasisVest', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'Hellweave', 1 ) );
	Template.UtilitySlot.AddItem( CreateEntry( 'SKULLJACK', 1 ) );

	Template.GrenadierSlot.AddItem( CreateEntry( 'AlienGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'FlashbangGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'SmokeGrenadeMk2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'GasGrenadeMk2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'AcidGrenadeMk2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'EMPGrenadeMk2', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'Firebomb', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'FirebombMK2', 1));
	Template.GrenadierSlot.AddItem( CreateEntry( 'FragGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'SmokeGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'GasGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'AcidGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'EMPGrenade', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'ProximityMine', 1 ) );
	Template.GrenadierSlot.AddItem( CreateEntry( 'Frostbomb', 0 ) );
	
	Template.HeavyWeapon.AddItem( CreateEntry( 'RocketLauncher', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'ShredderGun', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'Flamethrower', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'FlamethrowerMk2', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'BlasterLauncher', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'PlasmaBlaster', 1 ) );
	Template.HeavyWeapon.AddItem( CreateEntry( 'ShredstormCannon', 1 ) );

	return Template;
}

static function BasicUtilitySelector( X2ChallengeUtility Selector, array<XComGameState_Unit> XComUnits, XComGameState StartState )
{
	local XComGameState_Unit Unit;
	local int Index;
	local name ItemTemplateName;
	local XComGameState_Item NewItem;
	local X2ArmorTemplate ArmorTemplate;

	foreach XComUnits( Unit )
	{
		// Give them something to fill their utility slot
		if (Unit.GetCurrentStat( eStat_UtilityItems ) > 0)
			class'X2ChallengeUtility'.static.ApplyUtilityItem( 'AlienGrenade', eInvSlot_Utility, Unit, StartState );

		// Give them stuff to fill the rest of their utility slots
		for (Index = 1; Index < Unit.GetCurrentStat( eStat_UtilityItems ) && Index <= Selector.UtilitySlot2.Length; ++Index)
		{
			ItemTemplateName = Selector.UtilitySlot2[ Index - 1 ].templatename;
			class'X2ChallengeUtility'.static.ApplyUtilityItem( ItemTemplateName, eInvSlot_Utility, Unit, StartState );
		}

		if (Unit.GetSoldierClassTemplateName( ) == 'Grenadier')
		{
			class'X2ChallengeUtility'.static.ApplyUtilityItem( 'AlienGrenade', eInvSlot_GrenadePocket, Unit, StartState );
		}

		// if they can carry a heavy weapon, fill that slot
		NewItem = Unit.GetItemInSlot( eInvSlot_Armor );
		ArmorTemplate = X2ArmorTemplate( NewItem.GetMyTemplate( ) );
		if (ArmorTemplate.bHeavyWeapon)
		{
			class'X2ChallengeUtility'.static.ApplyUtilityItem( 'ShredderGun', eInvSlot_HeavyWeapon, Unit, StartState );
		}
	}
}

defaultproperties
{
	bShouldCreateDifficultyVariants = false
}