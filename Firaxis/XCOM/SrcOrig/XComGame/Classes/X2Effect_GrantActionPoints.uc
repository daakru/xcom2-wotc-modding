class X2Effect_GrantActionPoints extends X2Effect;

var int NumActionPoints;
var name PointType;

var bool bApplyOnlyWhenOut;
var array<Name> SkipWithEffect;

var bool bSelectUnit;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit UnitState;
	local int i;
	local Name SkipEffect;

	UnitState = XComGameState_Unit(kNewTargetState);
	if( UnitState != none )
	{
		foreach SkipWithEffect(SkipEffect)
		{
			if( UnitState.IsUnitAffectedByEffectName(SkipEffect) )
			{
				return;
			}
		}

		if( !bApplyOnlyWhenOut || (UnitState.NumActionPoints(class'X2CharacterTemplateManager'.default.StandardActionPoint) == 0) )
		{
			for( i = 0; i < NumActionPoints; ++i )
			{
				UnitState.ActionPoints.AddItem(PointType);
			}
		}
	}
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local X2Action_SelectNextActiveUnit SelectUnitAction;

	super.AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, EffectApplyResult);

	if (bSelectUnit)
	{
		SelectUnitAction = X2Action_SelectNextActiveUnit(class'X2Action_SelectNextActiveUnit'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext()));
		SelectUnitAction.TargetID = ActionMetadata.StateObject_NewState.ObjectID;
	}
}