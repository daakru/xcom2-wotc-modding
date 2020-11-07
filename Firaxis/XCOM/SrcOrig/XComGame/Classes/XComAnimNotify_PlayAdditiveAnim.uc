//-----------------------------------------------------------
// FIRAXIS GAMES: Play Additive Anim Notify
//
// Play additive animations via a notify
// (c) 2008 Firaxis Games
//-----------------------------------------------------------
class XComAnimNotify_PlayAdditiveAnim extends AnimNotify
	native(Animation);

// Jwats: If we are allowed to change content I need to update this to work correctly with additives
var() float Weight;
var() Name AnimName;
var() float BlendTime;
var() bool Looping;

cpptext
{
	// AnimNotify interface.
	virtual void Notify( class UAnimNodeSequence* NodeSeq );
	virtual FString GetEditorComment();
	virtual FColor GetEditorColor() { return FColor(0,128,255); }
}

defaultproperties
{
	BlendTime = 0.1f;
	Looping = true;
	Weight = 1.0f;
}
