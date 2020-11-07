//-----------------------------------------------------------
//	Class:	UIAbilityList_HitChance
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------


class UITooltipGroup_Share extends UITooltipGroup_Stacking;

var int TopY, BottomY, Range;

struct GroupStruct
{
	var UITooltip ToolTip;
	var bool Top; //Does this stack at the top or bottom of the screen
	var int Weight; //Weight to allocate if has to be shrunk to fit;
	var float Height; //Height, used in loop
	var int DeadHeight; //Total Height of non-scrollable list area, ie header, padding etc.
};

var array <GroupStruct> GroupSt;

function int AddDetail(UITooltip Tooltip, bool Top, int Weight, int DeadHeight)
{
	local GroupStruct GpSt;
	GpSt.Tooltip=Tooltip;
	GpSt.Top=Top;
	GpSt.Weight=Weight;
	GpSt.Height=0;//Tooltip.Height; Really used for loop, shouldn't suggest can trust it to contain real height.
	GpSt.DeadHeight=DeadHeight;
	GroupSt.additem(GpSt);
	return Super.Add(Tooltip);
}

//Intended to be overwritten in child classes. 

simulated function Stack(bool Top, optional float Gap=0)
{
	local int i, Direction;
	local float CurrentOffset;

	if (Top)
	{
		CurrentOffset = TopY;
		Direction=1;
	}
	else
	{
		CurrentOffset=BottomY;
		Direction=-1;
	}

	for (i = 0; i < GroupSt.Length; i++)
	{
		if ( !(GroupSt[i].Top==Top && Group[i].bIsVisible) ) continue;
		Group[i].SetY(CurrentOffset-int(!Top)*Group[i].Height);
		Group[i].MC.FunctionVoid("Show");
		//Group[i].ClearTimer(Group[i].nameof(Hide));
		CurrentOffset+=Direction*Group[i].Height;
		if (GroupSt[i].Weight==0)
		{
			CurrentOffset+=Gap;
		}
	}

}

simulated function Notify()
{
	local int i, WeightTotal;
	local array<GroupStruct> Remaining;
	local float PpW, AvailableRange, HeightTotal;
	local int Gap;
	local bool NoRemove;

	//Stack(true);
	//Stack(false);
	//return;

	AvailableRange=Range;
	Remaining=GroupSt;

	for (i=Remaining.length-1; i>=0; i--)
	{
		if (Remaining[i].Weight==0)
		{
			//Weight 0 means always shows full height (ie, the Stat list)
			//So It's Height is not available
			AvailableRange-=Remaining[i].ToolTip.Height;
			Remaining.Remove(i, 1);
			continue;
		}
		else if (!Remaining[i].ToolTip.bIsVisible)
		{
			//Remove Invisible, ie empty, lists
			Remaining.Remove(i, 1);
			continue;
		}
		//Remove non-scrollable height of visible lists
		AvailableRange-=Remaining[i].DeadHeight;
		//Get Height of scrollable area of visible lists
		Remaining[i].Height=Remaining[i].ToolTip.Height-Remaining[i].DeadHeight;
		//TotalHeight used for "Short Cirtcuit" checking
		HeightTotal+=Remaining[i].Height;
		//WeightTotal is total weight of visible lists
		WeightTotal+=Remaining[i].Weight;
	}
	//`RedScreen("***************LOOP ENTRY*****************");
	//All parameters are Out parameters
	///Loop(Remaining, AvailableRange, WeightTotal, HeightTotal);
	//Since all parameters ultimately became outs, might as well make it a loop!
	//While (HeightTotal > AvailableRange && RemovedSomething)
		//HeightTotal check is a Short Circuit, without it will still end loop properly,
		//with Remaining array stripped to Empty so NoRemove must be true;
	if (HeightTotal > AvailableRange)
	{
		do
		{
			//`RedScreen("***************LOOP...");
			//`RedScreen(`ShowVar(Remaining.Length));
			//`RedScreen(`ShowVar(AvailableRange));
			//`RedScreen(`ShowVar(WeightTotal));
			//`RedScreen(`ShowVar(HeightTotal));

			NoRemove=true; //Used to indicate if have to recurse the Loop function or are down to Lists which must be shrunk;
			PpW=AvailableRange/WeightTotal; //PpW: Vertical Pixels per Weight, if resized all remaining lists by weight
			for (i=Remaining.length-1; i>=0; i--)
			{
				if (Remaining[i].Height<=PpW*Remaining[i].Weight)
				{
					//If List is shorter than if resized than PpW, then it doesn't need shrinking to fit
					//So remove from array, weight total, height total and AvailableRange (since it's height isn't available for resizing now)
					AvailableRange-=Remaining[i].Height;
					WeightTotal-=Remaining[i].Weight;
					Remaining.Remove(i, 1);
					NoRemove=false;
				}
			}
		} Until (NoRemove); //This until means will loop once, to allow NoRemove to be set;

		//`RedScreen("***************LOOP EXIT*****************");

		//`RedScreen(`ShowVar(Remaining.Length));
		//`RedScreen(`ShowVar(AvailableRange));
		//`RedScreen(`ShowVar(WeightTotal));
		//`RedScreen(`ShowVar(HeightTotal));
		//`RedScreen(`ShowVar(PpW));
		for (i=0; i<Remaining.Length; i++)
		{
			//Remaining lists must be resized according to Weight/ PpW
			Remaining[i].Height=PpW*Remaining[i].Weight+Remaining[i].DeadHeight;
			Remaining[i].ToolTip.SetHeight(Remaining[i].Height);
		}
	}
	else
	{
		AvailableRange-=HeightTotal;
		if (AvailableRange>4) Gap=fmin(10, AvailableRange/2);
		else if (AvailableRange>2) Gap=AvailableRange-2;
		else if (AvailableRange>=0) Gap=0;
		//if (AvailableRange<HeightTotal)
		//Without below, rest of Available Range will implictly be the gap between the Top and Bottom stacks.
		//Below attempts to reserve 10p to be used for a gap between StatList and abilities.
		//If less than 20p available, split 50/50 between statlist and stack gaps down to 4p,
		//then keep stack gap at 2p as long as possible
	}

	Stack(true, Gap);
	Stack(false);
}

defaultproperties
{
	TopY=54; //Top Stack start (ie Stat List)
	BottomY=900; //Bottom Stack start (ie bonus/penalty effects)
	Range=846; //Range of space to "share", difference between above two
}