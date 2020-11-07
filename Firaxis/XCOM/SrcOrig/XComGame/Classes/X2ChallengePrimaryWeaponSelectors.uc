//---------------------------------------------------------------------------------------
//  FILE:    X2ChallengePrimaryWeaponSelectors.uc
//  AUTHOR:  Russell Aasland
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2ChallengePrimaryWeaponSelectors extends X2ChallengeElement;

//---------------------------------------------------------------------------------------
static function array<X2DataTemplate> CreateTemplates( )
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateConventionalWeapons());
	Templates.AddItem(CreateMagneticWeapons());
	Templates.AddItem(CreateBeamWeapons());
	Templates.AddItem(CreateRandomMix());

	Templates.AddItem(CreateTLERandomMix());

	return Templates;
}

//---------------------------------------------------------------------------------------
static function X2ChallengePrimaryWeapon CreateConventionalWeapons()
{
	local X2ChallengePrimaryWeapon	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengePrimaryWeapon', Template, 'ChallengePrimaryConventionalWeapons');

	Template.Weight = 7;

	Template.PrimaryWeapons.Length = 8;

	Template.PrimaryWeapons[0].SoldierClassName = 'Sharpshooter';
	Template.PrimaryWeapons[0].PrimaryWeapons.AddItem(CreateEntry('SniperRifle_CV', 1));

	Template.PrimaryWeapons[1].SoldierClassName = 'Grenadier';
	Template.PrimaryWeapons[1].PrimaryWeapons.AddItem(CreateEntry('Cannon_CV', 1));

	Template.PrimaryWeapons[2].SoldierClassName = 'Specialist';
	Template.PrimaryWeapons[2].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_CV', 1));

	Template.PrimaryWeapons[3].SoldierClassName = 'Ranger';
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('Shotgun_CV', 2));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_CV', 1));

	Template.PrimaryWeapons[4].SoldierClassName = 'PsiOperative';
	Template.PrimaryWeapons[4].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_CV', 1));

	Template.PrimaryWeapons[5].SoldierClassName = 'Reaper';
	Template.PrimaryWeapons[5].PrimaryWeapons.AddItem(CreateEntry('VektorRifle_CV', 1));

	Template.PrimaryWeapons[6].SoldierClassName = 'Templar';
	Template.PrimaryWeapons[6].PrimaryWeapons.AddItem(CreateEntry('ShardGauntlet_CV', 1));

	Template.PrimaryWeapons[7].SoldierClassName = 'Skirmisher';
	Template.PrimaryWeapons[7].PrimaryWeapons.AddItem(CreateEntry('Bullpup_CV', 1));

	return Template;
}

//---------------------------------------------------------------------------------------
static function X2ChallengePrimaryWeapon CreateMagneticWeapons()
{
	local X2ChallengePrimaryWeapon	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengePrimaryWeapon', Template, 'ChallengePrimaryMagneticWeapons');

	Template.Weight = 10;

	Template.PrimaryWeapons.Length = 8;

	Template.PrimaryWeapons[0].SoldierClassName = 'Sharpshooter';
	Template.PrimaryWeapons[0].PrimaryWeapons.AddItem(CreateEntry('SniperRifle_MG', 1));

	Template.PrimaryWeapons[1].SoldierClassName = 'Grenadier';
	Template.PrimaryWeapons[1].PrimaryWeapons.AddItem(CreateEntry('Cannon_MG', 1));

	Template.PrimaryWeapons[2].SoldierClassName = 'Specialist';
	Template.PrimaryWeapons[2].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_MG', 1));

	Template.PrimaryWeapons[3].SoldierClassName = 'Ranger';
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('Shotgun_MG', 2));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_MG', 1));

	Template.PrimaryWeapons[4].SoldierClassName = 'PsiOperative';
	Template.PrimaryWeapons[4].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_MG', 1));

	Template.PrimaryWeapons[5].SoldierClassName = 'Reaper';
	Template.PrimaryWeapons[5].PrimaryWeapons.AddItem(CreateEntry('VektorRifle_MG', 1));

	Template.PrimaryWeapons[6].SoldierClassName = 'Templar';
	Template.PrimaryWeapons[6].PrimaryWeapons.AddItem(CreateEntry('ShardGauntlet_MG', 1));

	Template.PrimaryWeapons[7].SoldierClassName = 'Skirmisher';
	Template.PrimaryWeapons[7].PrimaryWeapons.AddItem(CreateEntry('Bullpup_MG', 1));

	return Template;
}

//---------------------------------------------------------------------------------------
static function X2ChallengePrimaryWeapon CreateBeamWeapons()
{
	local X2ChallengePrimaryWeapon	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengePrimaryWeapon', Template, 'ChallengePrimaryBeamWeapons');

	Template.Weight = 7;

	Template.PrimaryWeapons.Length = 8;

	Template.PrimaryWeapons[0].SoldierClassName = 'Sharpshooter';
	Template.PrimaryWeapons[0].PrimaryWeapons.AddItem(CreateEntry('SniperRifle_BM', 1));

	Template.PrimaryWeapons[1].SoldierClassName = 'Grenadier';
	Template.PrimaryWeapons[1].PrimaryWeapons.AddItem(CreateEntry('Cannon_BM', 1));

	Template.PrimaryWeapons[2].SoldierClassName = 'Specialist';
	Template.PrimaryWeapons[2].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_BM', 1));

	Template.PrimaryWeapons[3].SoldierClassName = 'Ranger';
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('Shotgun_BM', 2));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_BM', 1));

	Template.PrimaryWeapons[4].SoldierClassName = 'PsiOperative';
	Template.PrimaryWeapons[4].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_BM', 1));

	Template.PrimaryWeapons[5].SoldierClassName = 'Reaper';
	Template.PrimaryWeapons[5].PrimaryWeapons.AddItem(CreateEntry('VektorRifle_BM', 1));

	Template.PrimaryWeapons[6].SoldierClassName = 'Templar';
	Template.PrimaryWeapons[6].PrimaryWeapons.AddItem(CreateEntry('ShardGauntlet_BM', 1));

	Template.PrimaryWeapons[7].SoldierClassName = 'Skirmisher';
	Template.PrimaryWeapons[7].PrimaryWeapons.AddItem(CreateEntry('Bullpup_BM', 1));

	return Template;
}

//---------------------------------------------------------------------------------------
static function X2ChallengePrimaryWeapon CreateRandomMix()
{
	local X2ChallengePrimaryWeapon	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengePrimaryWeapon', Template, 'ChallengePrimaryRandom');

	Template.Weight = 5;

	Template.PrimaryWeapons.Length = 8;

	Template.PrimaryWeapons[0].SoldierClassName = 'Sharpshooter';
	Template.PrimaryWeapons[0].PrimaryWeapons.AddItem(CreateEntry('SniperRifle_CV', 1));
	Template.PrimaryWeapons[0].PrimaryWeapons.AddItem(CreateEntry('SniperRifle_MG', 1));
	Template.PrimaryWeapons[0].PrimaryWeapons.AddItem(CreateEntry('SniperRifle_BM', 1));

	Template.PrimaryWeapons[1].SoldierClassName = 'Grenadier';
	Template.PrimaryWeapons[1].PrimaryWeapons.AddItem(CreateEntry('Cannon_CV', 1));
	Template.PrimaryWeapons[1].PrimaryWeapons.AddItem(CreateEntry('Cannon_MG', 1));
	Template.PrimaryWeapons[1].PrimaryWeapons.AddItem(CreateEntry('Cannon_BM', 1));

	Template.PrimaryWeapons[2].SoldierClassName = 'Specialist';
	Template.PrimaryWeapons[2].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_CV', 1));
	Template.PrimaryWeapons[2].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_MG', 1));
	Template.PrimaryWeapons[2].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_BM', 1));

	Template.PrimaryWeapons[3].SoldierClassName = 'Ranger';
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('Shotgun_CV', 2));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('Shotgun_MG', 2));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('Shotgun_BM', 2));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_CV', 1));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_MG', 1));
	Template.PrimaryWeapons[3].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_BM', 1));

	Template.PrimaryWeapons[4].SoldierClassName = 'PsiOperative';
	Template.PrimaryWeapons[4].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_CV', 1));
	Template.PrimaryWeapons[4].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_MG', 1));
	Template.PrimaryWeapons[4].PrimaryWeapons.AddItem(CreateEntry('AssaultRifle_BM', 1));

	Template.PrimaryWeapons[5].SoldierClassName = 'Reaper';
	Template.PrimaryWeapons[5].PrimaryWeapons.AddItem(CreateEntry('VektorRifle_CV', 1));
	Template.PrimaryWeapons[5].PrimaryWeapons.AddItem(CreateEntry('VektorRifle_MG', 1));
	Template.PrimaryWeapons[5].PrimaryWeapons.AddItem(CreateEntry('VektorRifle_BM', 1));

	Template.PrimaryWeapons[6].SoldierClassName = 'Templar';
	Template.PrimaryWeapons[6].PrimaryWeapons.AddItem(CreateEntry('ShardGauntlet_CV', 1));
	Template.PrimaryWeapons[6].PrimaryWeapons.AddItem(CreateEntry('ShardGauntlet_MG', 1));
	Template.PrimaryWeapons[6].PrimaryWeapons.AddItem(CreateEntry('ShardGauntlet_BM', 1));

	Template.PrimaryWeapons[7].SoldierClassName = 'Skirmisher';
	Template.PrimaryWeapons[7].PrimaryWeapons.AddItem(CreateEntry('Bullpup_CV', 1));
	Template.PrimaryWeapons[7].PrimaryWeapons.AddItem(CreateEntry('Bullpup_MG', 1));
	Template.PrimaryWeapons[7].PrimaryWeapons.AddItem(CreateEntry('Bullpup_BM', 1));

	return Template;
}

//---------------------------------------------------------------------------------------
static function X2ChallengePrimaryWeapon CreateTLERandomMix( )
{
	local X2ChallengePrimaryWeapon	Template;

	`CREATE_X2TEMPLATE(class'X2ChallengePrimaryWeapon', Template, 'TLEPrimaryRandom');

	Template.Weight = 0;

	Template.PrimaryWeapons.Length = 10;

	Template.PrimaryWeapons[ 0 ].SoldierClassName = 'Sharpshooter';
	Template.PrimaryWeapons[ 0 ].PrimaryWeapons.AddItem( CreateEntry( 'SniperRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 0 ].PrimaryWeapons.AddItem( CreateEntry( 'SniperRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 0 ].PrimaryWeapons.AddItem( CreateEntry( 'SniperRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 0 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_SniperRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 0 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_SniperRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 0 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_SniperRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 0 ].PrimaryWeapons.AddItem( CreateEntry( 'ChosenSniperRifle_XCOM', 0 ) );

	Template.PrimaryWeapons[ 1 ].SoldierClassName = 'Grenadier';
	Template.PrimaryWeapons[ 1 ].PrimaryWeapons.AddItem( CreateEntry( 'Cannon_CV', 1 ) );
	Template.PrimaryWeapons[ 1 ].PrimaryWeapons.AddItem( CreateEntry( 'Cannon_MG', 1 ) );
	Template.PrimaryWeapons[ 1 ].PrimaryWeapons.AddItem( CreateEntry( 'Cannon_BM', 1 ) );
	Template.PrimaryWeapons[ 1 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_Cannon_CV', 1 ) );
	Template.PrimaryWeapons[ 1 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_Cannon_MG', 1 ) );
	Template.PrimaryWeapons[ 1 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_Cannon_BM', 1 ) );

	Template.PrimaryWeapons[ 2 ].SoldierClassName = 'Specialist';
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'ChosenRifle_XCOM', 0 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_CV', 0 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_MG', 0 ) );
	Template.PrimaryWeapons[ 2 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_BM', 0 ) );

	Template.PrimaryWeapons[ 3 ].SoldierClassName = 'Ranger';
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'Shotgun_CV', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'Shotgun_MG', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'Shotgun_BM', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_Shotgun_CV', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_Shotgun_MG', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_Shotgun_BM', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'ChosenRifle_XCOM', 0 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'ChosenShotgun_XCOM', 0 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_CV', 0 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_MG', 0 ) );
	Template.PrimaryWeapons[ 3 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_BM', 0 ) );

	Template.PrimaryWeapons[ 4 ].SoldierClassName = 'PsiOperative';
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'ChosenRifle_XCOM', 0 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_CV', 0 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_MG', 0 ) );
	Template.PrimaryWeapons[ 4 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_BM', 0 ) );

	Template.PrimaryWeapons[ 5 ].SoldierClassName = 'Reaper';
	Template.PrimaryWeapons[ 5 ].PrimaryWeapons.AddItem( CreateEntry( 'VektorRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 5 ].PrimaryWeapons.AddItem( CreateEntry( 'VektorRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 5 ].PrimaryWeapons.AddItem( CreateEntry( 'VektorRifle_BM', 1 ) );

	Template.PrimaryWeapons[ 6 ].SoldierClassName = 'Templar';
	Template.PrimaryWeapons[ 6 ].PrimaryWeapons.AddItem( CreateEntry( 'ShardGauntlet_CV', 1 ) );
	Template.PrimaryWeapons[ 6 ].PrimaryWeapons.AddItem( CreateEntry( 'ShardGauntlet_MG', 1 ) );
	Template.PrimaryWeapons[ 6 ].PrimaryWeapons.AddItem( CreateEntry( 'ShardGauntlet_BM', 1 ) );

	Template.PrimaryWeapons[ 7 ].SoldierClassName = 'Skirmisher';
	Template.PrimaryWeapons[ 7 ].PrimaryWeapons.AddItem( CreateEntry( 'Bullpup_CV', 1 ) );
	Template.PrimaryWeapons[ 7 ].PrimaryWeapons.AddItem( CreateEntry( 'Bullpup_MG', 1 ) );
	Template.PrimaryWeapons[ 7 ].PrimaryWeapons.AddItem( CreateEntry( 'Bullpup_BM', 1 ) );

	Template.PrimaryWeapons[ 8 ].SoldierClassName = 'Spark';
	Template.PrimaryWeapons[ 8 ].PrimaryWeapons.AddItem( CreateEntry( 'SparkRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 8 ].PrimaryWeapons.AddItem( CreateEntry( 'SparkRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 8 ].PrimaryWeapons.AddItem( CreateEntry( 'SparkRifle_BM', 1 ) );

	Template.PrimaryWeapons[ 9 ].SoldierClassName = 'Rookie';
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_CV', 1 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_MG', 1 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'TLE_AssaultRifle_BM', 1 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'ChosenRifle_XCOM', 0 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_CV', 0 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_MG', 0 ) );
	Template.PrimaryWeapons[ 9 ].PrimaryWeapons.AddItem( CreateEntry( 'AlienHunterRifle_BM', 0 ) );

	return Template;
}

defaultproperties
{
	bShouldCreateDifficultyVariants = false
}