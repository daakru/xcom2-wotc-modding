//-----------------------------------------------------------
//
//-----------------------------------------------------------
class XComAnimNotify_SpawnMesh extends AnimNotify
	native(Animation);

var() Name				AttachSocket;
var() StaticMesh		StaticMesh;

/* SkeletalMesh will only be spawned if StaticMesh is None */
var() SkeletalMesh		SkeletalMesh;

/** Information for one particle system to spawn on the SkeletalMesh. */
struct native SpawnMeshNotityEffect
{
	/* Particle system to spawn on the SkeletalMesh */
	var() ParticleSystem	PSTemplate;
	/* Socket of the SkeletalMesh to spawn the particle system */
	var() Name				PSSocket;
};

/* FX to spawn on the SkeletalMesh */
var() array<SpawnMeshNotityEffect> SkeletalMeshFX;

var() vector			Translation;
var() rotator			Rotation;
var() vector			Scale;

/* if false, this notify acts as a "destroy" notify, removing the previously spawned mesh in AttachSocket. In this case, only AttachSocket needs to be specified. */
var() bool				bSpawn;

cpptext
{
	// AnimNotify interface.
	virtual void Notify( class UAnimNodeSequence* NodeSeq );
	virtual FString GetEditorComment() { return "Spawn Mesh"; }
	virtual FColor GetEditorColor() { return FColor(0,128,255); }
}

defaultproperties
{
	Translation=(X=0,Y=0,Z=0)
	Rotation=(Roll=0,Pitch=0,Yaw=0)
	Scale=(X=1,Y=1,Z=1)
}