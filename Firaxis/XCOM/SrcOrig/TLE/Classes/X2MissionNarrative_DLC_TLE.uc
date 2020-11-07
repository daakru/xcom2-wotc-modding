//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    X2MissionNarrative_DLC_TLE.uc
//  AUTHOR:  Brian Hess - 12/5/2017
//---------------------------------------------------------------------------------------
//  Copyright (c) 2017 Firaxis Games Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class X2MissionNarrative_DLC_TLE extends X2MissionNarrative;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2MissionNarrativeTemplate> Templates;

    Templates.AddItem(AddDefaultChallengeAbductionGasStationMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeAbductionCemeteryMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeTerrorBarMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeAbductionTrainyardMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeTerrorPoliceStationMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeAbductionFarmMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeAbductionDamMissionNarrativeTemplate());

	Templates.AddItem(AddDefaultChallengeAbductionWaterfrontMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeTerrorCoastalRadioMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeDestroyWaterfrontRadioMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeGatherWaterfrontRadioMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeExtractCoastalRadioMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeHackWaterfrontRadioMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeSabotageWaterfrontTransmitterMissionNarrativeTemplate());

	Templates.AddItem(AddDefaultChallengeRecoverChairMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeRecoverRotorMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeRecoverMissilesMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeHackPowerGridMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeGatherSkyrangerMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeProtectUFODeviceMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeRecoverManualMissionNarrativeTemplate());

	Templates.AddItem(AddDefaultChallengeRescueShenMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeRescueJaneKellyMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeSabotageSiegeCannonMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeRescuePeterOseiMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeRescueAnaRamirezMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeExtractTyganMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultChallengeRecoverSweaterMissionNarrativeTemplate());

	return Templates;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeAbductionGasStationMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeAbductionGasStation');

	Template.MissionType = "ChallengeAbductionGasStation";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Blast_GasStation_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Blast_GasStation_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Blast_GasStation_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Blast_GasStation_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Blast_GasStation_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Blast_GasStation_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Blast_GasStation_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Blast_GasStation_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Blast_GasStation_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Blast_GasStation_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Blast_GasStation_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Blast_GasStation_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Blast_GasStation_Musings_F";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeAbductionCemeteryMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeAbductionCemetery');

	Template.MissionType = "ChallengeAbductionCemetery";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Blast_Cemetery_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Blast_Cemetery_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Blast_Cemetery_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Blast_Cemetery_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Blast_Cemetery_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Blast_Cemetery_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Blast_Cemetery_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Blast_Cemetery_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Blast_Cemetery_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Blast_Cemetery_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Blast_Cemetery_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Blast_Cemetery_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Blast_Cemetery_Musings_F";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeTerrorBarMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeTerrorBar');

	Template.MissionType = "ChallengeTerrorBar";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Blast_Bar_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Blast_Bar_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Blast_Bar_TotalVictory_A";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Blast_Bar_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Blast_Bar_PartialVictory_A";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Blast_Bar_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Blast_Bar_Failure_A";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Blast_Bar_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Blast_Bar_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Blast_Bar_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Blast_Bar_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Blast_Bar_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Blast_Bar_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Blast_Bar_CiviliansSaved";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Blast_Bar_CiviliansWipe";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeAbductionTrainyardMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeAbductionTrainyard');

	Template.MissionType = "ChallengeAbductionTrainyard";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Blast_Trainyard_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Blast_Trainyard_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Blast_Trainyard_TotalVictory_A";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Blast_Trainyard_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Blast_Trainyard_PartialVictory_A";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Blast_Trainyard_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Blast_Trainyard_Failure_A";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Blast_Trainyard_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Blast_Trainyard_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Blast_Trainyard_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Blast_Trainyard_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Blast_Trainyard_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Blast_Trainyard_Musings_F";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeTerrorPoliceStationMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeTerrorPoliceStation');

	Template.MissionType = "ChallengeTerrorPoliceStation";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Blast_PoliceStation_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Blast_PoliceStation_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Blast_PoliceStation_TotalVictory_A";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Blast_PoliceStation_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Blast_PoliceStation_PartialVictory_A";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Blast_PoliceStation_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Blast_PoliceStation_Failure_A";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Blast_PoliceStation_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Blast_PoliceStation_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Blast_PoliceStation_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Blast_PoliceStation_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Blast_PoliceStation_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Blast_PoliceStation_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Blast_PoliceStation_CiviliansSaved";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Blast_PoliceStation_CiviliansWipe";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeAbductionFarmMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeAbductionFarm');

	Template.MissionType = "ChallengeAbductionFarm";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Blast_Farm_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Blast_Farm_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Blast_Farm_TotalVictory_A";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Blast_Farm_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Blast_Farm_PartialVictory_A";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Blast_Farm_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Blast_Farm_Failure_A";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Blast_Farm_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Blast_Farm_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Blast_Farm_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Blast_Farm_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Blast_Farm_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Blast_Farm_Musings_F";
	
	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeAbductionDamMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeAbductionDam');

	Template.MissionType = "ChallengeAbductionDam";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Blast_Dam_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Blast_Dam_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Blast_Dam_TotalVictory_A";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Blast_Dam_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Blast_Dam_PartialVictory_A";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Blast_Dam_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Blast_Dam_Failure_A";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Blast_Dam_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Blast_Dam_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Blast_Dam_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Blast_Dam_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Blast_Dam_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Blast_Dam_Musings_F";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeAbductionWaterfrontMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeAbductionWaterfront');

	Template.MissionType = "ChallengeAbductionWaterfront";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Sea_Abduction_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Sea_Abduction_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Sea_Abduction_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Sea_Abduction_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Sea_Abduction_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Sea_Abduction_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Sea_Abduction_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Sea_Abduction_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Sea_Abduction_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Sea_Abduction_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Sea_Abduction_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Sea_Abduction_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Sea_Abduction_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Sea_Abduction_NeonateChryssalidSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Sea_Abduction_Musings_G";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Sea_Abduction_Musings_H";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Sea_Abduction_Musings_I";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Sea_Abduction_Musings_J";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeTerrorCoastalRadioMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeTerrorCoastalRadio');

	Template.MissionType = "ChallengeTerrorCoastalRadio";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Sea_Terror_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Sea_Terror_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Sea_Terror_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Sea_Terror_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Sea_Terror_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Sea_Terror_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Sea_Terror_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Sea_Terror_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Sea_Terror_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Sea_Terror_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Sea_Terror_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Sea_Terror_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Sea_Terror_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Sea_Terror_CiviliansSaved";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Sea_Terror_CiviliansWipe";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Sea_Terror_Musings_G";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Sea_Terror_Musings_H";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Sea_Terror_Musings_I";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Sea_Terror_Musings_J";
	
	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeDestroyWaterfrontRadioMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeDestroyWaterfrontRadio');

	Template.MissionType = "ChallengeDestroyWaterfrontRadio";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Sea_DestroyRadio_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Sea_DestroyRadio_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Sea_DestroyRadio_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Sea_DestroyRadio_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Sea_DestroyRadio_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Sea_DestroyRadio_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Sea_DestroyRadio_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Sea_DestroyRadio_RadioSpotted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Sea_DestroyRadio_RadioDestroyed";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Sea_DestroyRadio_TimerNag";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Sea_DestroyRadio_TimerNagFinal";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Sea_DestroyRadio_TimerExpired";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_G";
	Template.NarrativeMoments[19] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_H";
	Template.NarrativeMoments[20] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_I";
	Template.NarrativeMoments[21] = "TLE_NarrativeMoments.Sea_DestroyRadio_Musings_J";

		return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeGatherWaterfrontRadioMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeGatherWaterfrontRadio');

	Template.MissionType = "ChallengeGatherWaterfrontRadio";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Sea_GatherDJ_Intro_A";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Sea_GatherDJ_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Sea_GatherDJ_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Sea_GatherDJ_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Sea_GatherDJ_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Sea_GatherDJ_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Sea_GatherDJ_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Sea_GatherDJ_DJSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Sea_GatherDJ_DJRescued";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Sea_GatherDJ_Guard1Rescued";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Sea_GatherDJ_Guard2Rescued";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Sea_GatherDJ_DJandGuardsEvac";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Sea_GatherDJ_DJDeath";
	Template.NarrativeMoments[19] = "TLE_NarrativeMoments.Sea_GatherDJ_DJEvac";
	Template.NarrativeMoments[20] = "TLE_NarrativeMoments.Sea_GatherDJ_FacelessTunaSighted";
	Template.NarrativeMoments[21] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_G";
	Template.NarrativeMoments[22] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_H";
	Template.NarrativeMoments[23] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_I";
	Template.NarrativeMoments[24] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_J";
	Template.NarrativeMoments[25] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_K";
	Template.NarrativeMoments[26] = "TLE_NarrativeMoments.Sea_GatherDJ_Musings_L";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeExtractCoastalRadioMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeExtractCoastalRadio');

	Template.MissionType = "ChallengeExtractCoastalRadio";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Sea_ExtractDJ_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Sea_ExtractDJ_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Sea_ExtractDJ_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Sea_ExtractDJ_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Sea_ExtractDJ_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Sea_ExtractDJ_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Sea_ExtractDJ_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Sea_ExtractDJ_DJEvac";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Sea_ExtractDJ_DJDeath";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Sea_ExtractDJ_Timer6TurnsLeft";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Sea_ExtractDJ_Timer3TurnsLeft";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Sea_ExtractDJ_TimerNagFinal";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Sea_ExtractDJ_TimerFailed";
	Template.NarrativeMoments[19] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_G";
	Template.NarrativeMoments[20] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_H";
	Template.NarrativeMoments[21] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_I";
	Template.NarrativeMoments[22] = "TLE_NarrativeMoments.Sea_ExtractDJ_Musings_J";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeHackWaterfrontRadioMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeHackWaterfrontRadio');

	Template.MissionType = "ChallengeHackWaterfrontRadio";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Sea_HackRadio_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Sea_HackRadio_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Sea_HackRadio_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Sea_HackRadio_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Sea_HackRadio_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Sea_HackRadio_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Sea_HackRadio_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Sea_HackRadio_TerminalSpotted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Sea_HackRadio_Timer3TurnsLeft";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Sea_HackRadio_TimerNagFinal";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Sea_HackRadio_TimerFailed";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Sea_HackRadio_TerminalDestroyed";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Sea_HackRadio_AreaSecured";
	Template.NarrativeMoments[19] = "TLE_NarrativeMoments.Sea_HackRadio_TerminalHacked";
	Template.NarrativeMoments[20] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_G";
	Template.NarrativeMoments[21] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_H";
	Template.NarrativeMoments[22] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_I";
	Template.NarrativeMoments[23] = "TLE_NarrativeMoments.Sea_HackRadio_Musings_J";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeSabotageWaterfrontTransmitterMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeSabotageWaterfrontTransmitter');

	Template.MissionType = "ChallengeSabotageWaterfrontTransmitter";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_BombSpotted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_BombPlanted";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_BombDetonated";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_AreaSecured";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Nag3Turns";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Nag1Turn";
	Template.NarrativeMoments[19] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_NagNoTurns";
	Template.NarrativeMoments[20] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_G";
	Template.NarrativeMoments[21] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_H";
	Template.NarrativeMoments[22] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_I";
	Template.NarrativeMoments[23] = "TLE_NarrativeMoments.Sea_SabotageTransmitter_Musings_J";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRecoverChairMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRecoverChair');

	Template.MissionType = "ChallengeRecoverChair";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildnerss_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildernss_ObjSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildernss_ObjDestroyed";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildernss_AreaClear";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Avenger_Interceptor_Wildernss_ObjAcquired";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRecoverRotorMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRecoverRotor');

	Template.MissionType = "ChallengeRecoverRotor";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_Musings_F'";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_ObjSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_ObjDestgroyed";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_AreaClear";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Avenger_Skyranger_Wildnerss_ObjAcquired";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRecoverMissilesMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRecoverMissiles');

	Template.MissionType = "ChallengeRecoverMissiles";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_ObjSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_ObjDestroyed";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_AreaClear";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Avenger_Interceptor_SmallTown_ObjAcquired";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeHackPowerGridMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeHackPowerGrid');

	Template.MissionType = "ChallengeHackPowerGrid";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_TerminalSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Nag3Turns";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_Nag1Turn";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_NagNoTurns";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_TerminalDestroyed";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_AreaClear";
	Template.NarrativeMoments[19] = "TLE_NarrativeMoments.Avenger_SmallScout_Shanty_ObjComplete";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeGatherSkyrangerMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeGatherSkyranger');

	Template.MissionType = "ChallengeGatherSkyranger";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_VIPspotted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_VIPlinked";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_FirstVIPLink";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_NextVIPLink";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_AllVip_EVAC";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_VIPdead";
	Template.NarrativeMoments[19] = "TLE_NarrativeMoments.Avenger_Skyranger_AbandonedCity_PrimarySecur";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeProtectUFODeviceMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeProtectUFODevice');

	Template.MissionType = "ChallengeProtectUFODevice";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_DeviceSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Avenger_SmallScout_Slums_ObjDestroyed";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRecoverManualMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRecoverManual');

	Template.MissionType = "ChallengeRecoverManual";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_ObjSpotted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_ObjDestroyed";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_AreaClear";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Avenger_Firestorm_Wilderness_ObjAcquired";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRescueShenMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRescueShen');

	Template.MissionType = "ChallengeRescueShen";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Lazarus_RescueShen_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Lazarus_RescueShen_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Lazarus_RescueShen_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Lazarus_RescueShen_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Lazarus_RescueShen_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Lazarus_RescueShen_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Lazarus_RescueShen_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Lazarus_RescueShen_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Lazarus_RescueShen_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Lazarus_RescueShen_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Lazarus_RescueShen_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Lazarus_RescueShen_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Lazarus_RescueShen_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Lazarus_RescueShen_ShenSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Lazarus_RescueShen_ShenSecured";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Lazarus_RescueShen_ShenLost";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRescueJaneKellyMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRescueJaneKelly');

	Template.MissionType = "ChallengeRescueJaneKelly";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Lazarus_RescueKelly_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Lazarus_RescueKelly_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Lazarus_RescueKelly_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Lazarus_RescueKelly_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Lazarus_RescueKelly_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Lazarus_RescueKelly_VIPacquired";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Lazarus_RescueKelly_ObjSecured";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Lazarus_RescueKelly_TargetLost";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeSabotageSiegeCannonMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeSabotageSiegeCannon');

	Template.MissionType = "ChallengeSabotageSiegeCannon";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_CannonSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Bomb_NoRNF";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_Bomb_Detonated";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Lazarus_RescueVehicle_AreaClear";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRescuePeterOseiMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRescuePeterOsei');

	Template.MissionType = "ChallengeRescuePeterOsei";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Lazarus_RescueOsei_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Lazarus_RescueOsei_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Lazarus_RescueOsei_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Lazarus_RescueOsei_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Lazarus_RescueOsei_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Lazarus_RescueOsei_VIPacquired";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Lazarus_RescueOsei_ObjSecure";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Lazarus_RescueOsei_TargetLost";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRescueAnaRamirezMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRescueAnaRamirez');

	Template.MissionType = "ChallengeRescueAnaRamirez";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_VIPacquired";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_ObjSecured";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Lazarus_RescueRamirez_TargetLost";

	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeExtractTyganMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeExtractTygan');

	Template.MissionType = "ChallengeExtractTygan";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Lazarus_RescueTygan_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Lazarus_RescueTygan_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Lazarus_RescueTygan_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Lazarus_RescueTygan_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Lazarus_RescueTygan_ObjSecured";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Lazarus_RescueTygan_ObjDestroyed";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Nag6turns";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Nag3turns";
	Template.NarrativeMoments[17] = "TLE_NarrativeMoments.Lazarus_RescueTygan_Nag1turn";
	Template.NarrativeMoments[18] = "TLE_NarrativeMoments.Lazarus_RescueTygan_TimerExpired";
	
	return Template;
}

static function X2MissionNarrativeTemplate AddDefaultChallengeRecoverSweaterMissionNarrativeTemplate()
{
	local X2MissionNarrativeTemplate Template;

	`CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultChallengeRecoverSweater');

	Template.MissionType = "ChallengeRecoverSweater";
	Template.NarrativeMoments[0] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Intro";
	Template.NarrativeMoments[1] = "TLE_NarrativeMoments.Lazarus_RescueSweater_TotalVictory_A";
	Template.NarrativeMoments[2] = "TLE_NarrativeMoments.Lazarus_RescueSweater_TotalVictory_B";
	Template.NarrativeMoments[3] = "TLE_NarrativeMoments.Lazarus_RescueSweater_PartialVictory_A";
	Template.NarrativeMoments[4] = "TLE_NarrativeMoments.Lazarus_RescueSweater_PartialVictory_B";
	Template.NarrativeMoments[5] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Failure_A";
	Template.NarrativeMoments[6] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Failure_B";
	Template.NarrativeMoments[7] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Musings_A";
	Template.NarrativeMoments[8] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Musings_B";
	Template.NarrativeMoments[9] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Musings_C";
	Template.NarrativeMoments[10] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Musings_D";
	Template.NarrativeMoments[11] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Musings_E";
	Template.NarrativeMoments[12] = "TLE_NarrativeMoments.Lazarus_RescueSweater_Musings_F";
	Template.NarrativeMoments[13] = "TLE_NarrativeMoments.Lazarus_RescueSweater_ChamberSighted";
	Template.NarrativeMoments[14] = "TLE_NarrativeMoments.Lazarus_RescueSweater_ObjDestroyed";
	Template.NarrativeMoments[15] = "TLE_NarrativeMoments.Lazarus_RescueSweater_AreaClear";
	Template.NarrativeMoments[16] = "TLE_NarrativeMoments.Lazarus_RescueSweater_SweaterReveal";

	return Template;
}