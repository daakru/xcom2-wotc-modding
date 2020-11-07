//-----------------------------------------------------------
//	Class:	WOTC_DisplayHitChance_MCMScreen
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class WOTC_DisplayHitChance_MCMScreenListener extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local WOTC_DisplayHitChance_MCMScreen DisplayHitChanceMCMScreen;
	
	// Everything out here runs on every UIScreen. Not great but necessary.
	if (MCM_API(Screen) != none)
	{
		DisplayHitChanceMCMScreen = new class'WOTC_DisplayHitChance_MCMScreen';
		DisplayHitChanceMCMScreen.OnInit(Screen);
	}
}

defaultproperties
{
    ScreenClass = class'MCM_API';
}