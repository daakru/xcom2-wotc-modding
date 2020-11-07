//-----------------------------------------------------------
// Used by the visualizer system to control a Visualization Actor.
//-----------------------------------------------------------
class X2Action_SetRagdoll extends X2Action;

var EXComUnitPawn_RagdollFlag RagdollFlag;

function Init()
{
	super.Init();

	UnitPawn.RagdollFlag = RagdollFlag;
}

simulated state Executing
{	

Begin:

	CompleteAction();
}

DefaultProperties
{
	RagdollFlag=ERagdoll_IfDamageTypeSaysTo
}