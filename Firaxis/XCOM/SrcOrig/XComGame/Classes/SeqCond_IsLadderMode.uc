
class SeqCond_IsLadderMode extends SequenceCondition;

event Activated()
{
	local XComGameStateHistory History;
	local XComGameState_LadderProgress LadderData;

	History = `XCOMHISTORY;
	LadderData = XComGameState_LadderProgress( History.GetSingleGameStateObjectForClass( class'XComGameState_LadderProgress', true ) );

	if( LadderData != none )
	{
		OutputLinks[0].bHasImpulse = TRUE;
		OutputLinks[1].bHasImpulse = FALSE;
	}
	else
	{
		OutputLinks[0].bHasImpulse = FALSE;
		OutputLinks[1].bHasImpulse = TRUE;
	}
}

defaultproperties
{
	ObjName = "Ladder Mode Active"

	bAutoActivateOutputLinks = false
	bCanBeUsedForGameplaySequence = true
	bConvertedForReplaySystem = true

	OutputLinks(0)=(LinkDesc="True")
	OutputLinks(1)=(LinkDesc="False")
	//VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Players")
}