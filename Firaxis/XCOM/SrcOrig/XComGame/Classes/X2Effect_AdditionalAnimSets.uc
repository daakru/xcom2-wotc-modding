//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2Effect_AdditionalAnimSets extends X2Effect_Persistent;

var privatewrite Array<AnimSet> AdditonalAnimSets;

function AddAnimSetWithPath(string AnimSetPath)
{
	AdditonalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype(AnimSetPath)));
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	if (EffectApplyResult != 'AA_Success')
		return;

	class'X2Action_UpdateAnimations'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded);
}

simulated function AddX2ActionsForVisualization_Removed(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	if (EffectApplyResult != 'AA_Success')
		return;

	class'X2Action_UpdateAnimations'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded);
}