class X2Item_TLE_QuestItems extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	// IT CAME FROM THE SEA
	Items.AddItem(CreateQuestItemWaterfrontRadio());

	// AVENGER ASSEMBLE
	Items.AddItem(CreateQuestItemPilotSeat());
	Items.AddItem(CreateQuestItemRotorMechanism());
	Items.AddItem(CreateQuestItemAvalancheMissiles());
	Items.AddItem(CreateQuestItemOperatorsManual());
	
	return Items;
}

// #######################################################################################
// -------------------- IT CAME FROM THE SEA ---------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateQuestItemWaterfrontRadio()
{
	local X2QuestItemTemplate Item;

	`CREATE_X2TEMPLATE(class'X2QuestItemTemplate', Item, 'WaterfrontRadio');
	Item.ItemCat = 'quest';

	Item.MissionType.AddItem("ChallengeHackWaterfrontRadio");

	Item.RewardType.AddItem('Reward_Intel');

	Item.IsElectronicReward = true;

	return Item;
}

// #######################################################################################
// -------------------- AVENGER ASSEMBLE -------------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateQuestItemPilotSeat()
{
	local X2QuestItemTemplate Item;

	`CREATE_X2TEMPLATE(class'X2QuestItemTemplate', Item, 'PilotSeat');
	Item.ItemCat = 'quest';

	Item.MissionType.AddItem("ChallengeRecoverMissiles");
	
	Item.RewardType.AddItem('Reward_Supplies');

	return Item;
}

static function X2DataTemplate CreateQuestItemRotorMechanism()
{
	local X2QuestItemTemplate Item;

	`CREATE_X2TEMPLATE(class'X2QuestItemTemplate', Item, 'RotorMechanism');
	Item.ItemCat = 'quest';

	Item.MissionType.AddItem("ChallengeRecoverRotor");
	
	Item.RewardType.AddItem('Reward_Supplies');
	
	return Item;
}

static function X2DataTemplate CreateQuestItemAvalancheMissiles()
{
	local X2QuestItemTemplate Item;

	`CREATE_X2TEMPLATE(class'X2QuestItemTemplate', Item, 'AvalancheMissiles');
	Item.ItemCat = 'quest';

	Item.MissionType.AddItem("ChallengeRecoverChair");

	Item.RewardType.AddItem('Reward_Supplies');

	return Item;
}

static function X2DataTemplate CreateQuestItemOperatorsManual()
{
	local X2QuestItemTemplate Item;

	`CREATE_X2TEMPLATE(class'X2QuestItemTemplate', Item, 'OperatorsManual');
	Item.ItemCat = 'quest';

	Item.MissionType.AddItem("ChallengeRecoverManual");

	Item.RewardType.AddItem('Reward_Supplies');

	return Item;
}
