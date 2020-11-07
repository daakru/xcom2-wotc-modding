//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    X2MissionSet_DLC_TLE.uc
//  AUTHOR:  Brian Hess - 12/5/2017
//---------------------------------------------------------------------------------------
//  Copyright (c) 2017 Firaxis Games Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class X2MissionSet_DLC_TLE extends X2MissionSet config(GameCore);

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2MissionTemplate> Templates;

    Templates.AddItem(AddMissionTemplate('ChallengeAbductionGasStation'));
	Templates.AddItem(AddMissionTemplate('ChallengeAbductionCemetery'));
	Templates.AddItem(AddMissionTemplate('ChallengeTerrorBar'));
	Templates.AddItem(AddMissionTemplate('ChallengeAbductionTrainyard'));
	Templates.AddItem(AddMissionTemplate('ChallengeTerrorPoliceStation'));
	Templates.AddItem(AddMissionTemplate('ChallengeAbductionFarm'));
	Templates.AddItem(AddMissionTemplate('ChallengeAbductionDam'));

	Templates.AddItem(AddMissionTemplate('ChallengeAbductionWaterfront'));
	Templates.AddItem(AddMissionTemplate('ChallengeTerrorCoastalRadio'));
	Templates.AddItem(AddMissionTemplate('ChallengeGatherWaterfrontRadio'));
	Templates.AddItem(AddMissionTemplate('ChallengeDestroyWaterfrontRadio'));
	Templates.AddItem(AddMissionTemplate('ChallengeExtractCoastalRadio'));
	Templates.AddItem(AddMissionTemplate('ChallengeHackWaterfrontRadio'));
	Templates.AddItem(AddMissionTemplate('ChallengeSabotageWaterfrontTransmitter'));

	Templates.AddItem(AddMissionTemplate('ChallengeRecoverChair'));
	Templates.AddItem(AddMissionTemplate('ChallengeRecoverRotor'));
	Templates.AddItem(AddMissionTemplate('ChallengeHackPowerGrid'));
	Templates.AddItem(AddMissionTemplate('ChallengeRecoverMissiles'));
	Templates.AddItem(AddMissionTemplate('ChallengeGatherSkyranger'));
	Templates.AddItem(AddMissionTemplate('ChallengeProtectUFODevice'));
	Templates.AddItem(AddMissionTemplate('ChallengeRecoverManual'));

	Templates.AddItem(AddMissionTemplate('ChallengeRescueShen'));
	Templates.AddItem(AddMissionTemplate('ChallengeRescueJaneKelly'));
	Templates.AddItem(AddMissionTemplate('ChallengeSabotageSiegeCannon'));
	Templates.AddItem(AddMissionTemplate('ChallengeRescuePeterOsei'));
	Templates.AddItem(AddMissionTemplate('ChallengeRescueAnaRamirez'));
	Templates.AddItem(AddMissionTemplate('ChallengeExtractTygan'));
	Templates.AddItem(AddMissionTemplate('ChallengeRecoverSweater'));

    return Templates;
}