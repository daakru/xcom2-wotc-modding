
class X2Action_SetTimeDilation extends X2Action;

var float TimeDilation;

var private XGUnit UnitVisualizer;

function Init( )
{
	UnitVisualizer = XGUnit( Metadata.VisualizeActor );
}

simulated state Executing
{
Begin:
	if (UnitVisualizer != none)
		UnitVisualizer.SetTimeDilation( TimeDilation );

	CompleteAction();
}