// This is an Unreal Script

class X2Condition_ShadowStrike extends X2Condition;

var X2Condition_Visibility VisCondition;

function name MeetsCondition(XComGameState_BaseObject kTarget)
{
	return VisCondition.MeetsCondition(kTarget);
}

function name MeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	if (XComGameState_Unit(kSource).IsConcealed()) return 'AA_SUCCESS';
	else return VisCondition.MeetsConditionWithSource(kTarget, kSource);
}
