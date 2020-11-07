class X2StrategyElement_TLESoldierPersonalities extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(Personality_TLE1());
	Templates.AddItem(Personality_TLE2());
	Templates.AddItem(Personality_TLE3());
	Templates.AddItem(Personality_TLE4());
	Templates.AddItem(Personality_TLE5());

	return Templates;
}

static function X2SoldierPersonalityTemplate Personality_TLE1()
{
	local X2SoldierPersonalityTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SoldierPersonalityTemplate', Template, 'Personality_TLE1');

	Template.IdleAnimName = 'Idle_TLE1_TG02';
	Template.PostMissionWalkUpAnimName = 'WalkUp_TLE1_TG02';
	Template.PostMissionWalkBackAnimName = 'WalkBack_TLE1_TG02';
	Template.PostMissionGravelyInjuredWalkUpAnimName = 'WalkUp_InjuredKneelB_TG03';
	Template.IdleGravelyInjuredAnimName = 'Idle_InjuredKneelB_TG03';
	Template.PostMissionInjuredWalkUpAnimName = 'WalkUp_InjuredA';
	Template.IdleInjuredAnimName = 'Idle_InjuredA';
	
	return Template;
}

static function X2SoldierPersonalityTemplate Personality_TLE2()
{
	local X2SoldierPersonalityTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SoldierPersonalityTemplate', Template, 'Personality_TLE2');

	Template.IdleAnimName = 'Idle_TLE2_TG02';
	Template.PostMissionWalkUpAnimName = 'WalkUp_TLE2_TG02';
	Template.PostMissionWalkBackAnimName = 'WalkBack_TLE2_TG02';
	Template.PostMissionGravelyInjuredWalkUpAnimName = 'WalkUp_InjuredKneelB_TG03';
	Template.IdleGravelyInjuredAnimName = 'Idle_InjuredKneelB_TG03';
	Template.PostMissionInjuredWalkUpAnimName = 'WalkUp_InjuredA';
	Template.IdleInjuredAnimName = 'Idle_InjuredA';

	return Template;
}

static function X2SoldierPersonalityTemplate Personality_TLE3()
{
	local X2SoldierPersonalityTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SoldierPersonalityTemplate', Template, 'Personality_TLE3');

	Template.IdleAnimName = 'Idle_TLE3_TG02';
	Template.PostMissionWalkUpAnimName = 'WalkUp_TLE3_TG02';
	Template.PostMissionWalkBackAnimName = 'WalkBack_TLE3_TG02';
	Template.PostMissionGravelyInjuredWalkUpAnimName = 'WalkUp_InjuredKneelB_TG03';
	Template.IdleGravelyInjuredAnimName = 'Idle_InjuredKneelB_TG03';
	Template.PostMissionInjuredWalkUpAnimName = 'WalkUp_InjuredA';
	Template.IdleInjuredAnimName = 'Idle_InjuredA';

	return Template;
}

static function X2SoldierPersonalityTemplate Personality_TLE4()
{
	local X2SoldierPersonalityTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SoldierPersonalityTemplate', Template, 'Personality_TLE4');

	Template.IdleAnimName = 'Idle_TLE4_TG02';
	Template.PostMissionWalkUpAnimName = 'WalkUp_TLE4_TG02';
	Template.PostMissionWalkBackAnimName = 'WalkBack_TLE4_TG02';
	Template.PostMissionGravelyInjuredWalkUpAnimName = 'WalkUp_InjuredKneelB_TG03';
	Template.IdleGravelyInjuredAnimName = 'Idle_InjuredKneelB_TG03';
	Template.PostMissionInjuredWalkUpAnimName = 'WalkUp_InjuredA';
	Template.IdleInjuredAnimName = 'Idle_InjuredA';

	return Template;
}

static function X2SoldierPersonalityTemplate Personality_TLE5()
{
	local X2SoldierPersonalityTemplate Template;

	`CREATE_X2TEMPLATE(class'X2SoldierPersonalityTemplate', Template, 'Personality_TLE5');

	Template.IdleAnimName = 'Idle_TLE5_TG02';
	Template.PostMissionWalkUpAnimName = 'WalkUp_TLE5_TG02';
	Template.PostMissionWalkBackAnimName = 'WalkBack_TLE5_TG02';
	Template.PostMissionGravelyInjuredWalkUpAnimName = 'WalkUp_InjuredKneelB_TG03';
	Template.IdleGravelyInjuredAnimName = 'Idle_InjuredKneelB_TG03';
	Template.PostMissionInjuredWalkUpAnimName = 'WalkUp_InjuredA';
	Template.IdleInjuredAnimName = 'Idle_InjuredA';

	return Template;
}