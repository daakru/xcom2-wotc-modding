//---------------------------------------------------------------------------------------
//  FILE:    X2ChallengeAlertForce.uc
//  AUTHOR:  Russell Aasland
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2ChallengeAlertForce extends X2ChallengeTemplate;

var delegate<ChallengeAlertForceSelector> SelectAlertForceFn;

delegate  ChallengeAlertForceSelector( X2ChallengeAlertForce Selector, XComGameState StartState, XComGameState_HeadquartersXCom HeadquartersStateObject, out int AlertLevel, out int ForceLevel );

static function SelectAlertAndForceLevels( X2ChallengeAlertForce Selector, XComGameState StartState, XComGameState_HeadquartersXCom HeadquartersStateObject, out int AlertLevel, out int ForceLevel )
{
	Selector.SelectAlertForceFn( Selector, StartState, HeadquartersStateObject, AlertLevel, ForceLevel );

	`assert( AlertLevel >= 1 );
	`assert( AlertLevel <= 6 );
	`assert( ForceLevel >= 1 );
	`assert( ForceLevel <= 20 );
}