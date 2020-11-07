/**
 * Retrieves information about the number of members on a team
 */
class SeqAct_GetLadderIndices extends SequenceAction;

var int Ladder;
var int Rung;

event Activated()
{
	local XComGameState_LadderProgress LadderData;

	Ladder = -1;
	Rung = -1;

	LadderData = XComGameState_LadderProgress( `XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_LadderProgress', true ) );
	if (LadderData != none)
	{
		Ladder = LadderData.LadderIndex;
		Rung = LadderData.LadderRung;
	}
}

defaultproperties
{
	ObjName="Get Ladder Indicies"
	ObjCategory="Gameplay"
	bCallHandler=false;

	bConvertedForReplaySystem=true
	bCanBeUsedForGameplaySequence=true

	VariableLinks.Empty;
	VariableLinks(0)=(ExpectedType=class'SeqVar_Int', LinkDesc="Ladder", PropertyName=Ladder, bWriteable=TRUE)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int', LinkDesc="Rung", PropertyName=Rung, bWriteable=TRUE)
}
