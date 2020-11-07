/**
 * Version of SkeletalMeshActor intended to be used in cinematics, when SkeletalMeshActorMAT is too heavyweight.
 * Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
 */
class SkeletalMeshCinematicActor extends SkeletalMeshActor
	native(Anim)
	placeable;

defaultproperties
{
	Begin Object Name=SkeletalMeshComponent0
		// Keep expensive defaults that are almost always needed on cinematic skeletal mesh actors
		MinDistFactorForKinematicUpdate=0
		bUpdateSkelWhenNotRendered=false
		bIgnoreControllersWhenNotRendered=FALSE
		bTickAnimNodesWhenNotRendered=TRUE
		bAcceptsStaticDecals=TRUE
		bAcceptsDynamicDecals=TRUE
		// Nice translucent lighting for hair
		bUseOnePassLightingOnTranslucency=TRUE
		// Enable the more proper skinned mesh motion blur
		bPerBoneMotionBlur=TRUE
	End Object
}
