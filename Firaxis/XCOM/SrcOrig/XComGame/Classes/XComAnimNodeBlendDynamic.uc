class XComAnimNodeBlendDynamic extends AnimNodeBlendBase
	native(Animation);

struct native FixupInfo
{
	var float       BeginTime;
	var float       EndTime;
	var BoneAtom    InitialStartingAtom;
	var BoneAtom    DesiredStartingAtom;
};

struct native PlayingChild
{
	var int						Index;
	var float					DesiredWeight;
	var float					TargetWeight;
	var float					CurrentBlendTime;
	var float					TotalBlendTime;
	var float					StartingWeight;
	var int						UseFixupIndex;
	var init Array<FixupInfo>	Fixups;
};

struct native CustomAnimParams
{
	var Name					AnimName;
	var bool					Looping;
	var float					TargetWeight;
	var float					BlendTime;
	var float					PlayRate;
	var float					StartOffsetTime;
	var bool					Additive;
	var bool					ModifyAdditive;
	var init Array<BoneAtom>	DesiredEndingAtoms;
	var bool					HasPoseOverride;
	var float					PoseOverrideDuration; //Allow the caller to specify a duration for pose override anims
	var init Array<BoneAtom>	Pose;

	structdefaultproperties
	{
		AnimName = "None";
		Looping = false;
		TargetWeight = 1.0f;
		BlendTime = 0.1f;
		PlayRate = 1.0f;
		StartOffsetTime = 0.0f;
		Additive = false;
		HasPoseOverride = false;
		PoseOverrideDuration = 0.0f;
	}

	structcpptext
	{
		FCustomAnimParams()
		{
			AnimName = FName(TEXT("None"));
			Looping = false;
			TargetWeight = 1.0f;
			BlendTime = 0.1f;
			PlayRate = 1.0f;
			StartOffsetTime = 0.0f;
			Additive = false;
			HasPoseOverride = false;
			PoseOverrideDuration = 0.0f;
		}
		FCustomAnimParams(EEventParm)
		{
			appMemzero(this, sizeof(FCustomAnimParams));
		}
	}
};

var private init Array<PlayingChild> ChildrenPlaying;
var private bool ComputedFixupRootMotion;
var private BoneAtom FixedUpRootMotionDelta;
var private BoneAtom EstimatedCurrentAtom;
var private bool Additive;
var private BoneAtom CurrentStartingAtom;

native function AnimNodeSequence PlayDynamicAnim(out CustomAnimParams Params);
native function bool BlendOutDynamicAnim(AnimNodeSequence PlayingSequence, float BlendTime);
native function AnimNodeSequence GetTerminalSequence();
native function SetAdditive(bool TreatAsAdditive); // This is so we know to use identity for the weight filler instead of reference pose

cpptext
{
public:
	static FName FindRandomAnimMatchingName(FName AnimName, USkeletalMeshComponent* SkelComp);
	static TArray<FName> GetAllPossibleAnimNames(FName AnimName, USkeletalMeshComponent* SkelComp);
	static UBOOL CanPlayAnimation(FName AnimName, UBOOL SearchAnimName, USkeletalMeshComponent* SkelComp);
	static INT GetRootBoneTrackIndex(const USkeletalMeshComponent* MeshComp, const UAnimSequence* AnimSeq, const UAnimNodeSequence* AnimNodeSeq = NULL);
	virtual void RootMotionProcessed();
	virtual UAnimNodeSequence* GetAnimNodeSequence();
private:
	virtual void InitAnim(USkeletalMeshComponent* MeshComp, UAnimNodeBlendBase* Parent);
	virtual	void TickAnim(FLOAT DeltaSeconds);
	virtual void GetBoneAtoms(FBoneAtomArray& Atoms, const TArray<BYTE>& DesiredBones, FBoneAtom& RootMotionDelta, INT& bHasRootMotion, FCurveKeyArray& CurveKeys);
	void CalculateWeights();
	FBoneAtom CalculateDesiredAtom(const UAnimNodeSequence* AnimNodeSeq, const FBoneAtom& StartLocation);
	FBoneAtom CalculateDesiredStartingAtom(const UAnimNodeSequence* AnimNodeSeq, const FBoneAtom& DesiredEndingAtom);
	INT CreateBlankBlendChild(FCustomAnimParams& AnimParams);
	
	// Editor Functions
	virtual void OnAddChild(INT ChildNum);
}

defaultproperties
{
	bFixNumChildren = TRUE
	CategoryDesc = "Firaxis"
	Additive = FALSE
}