//-----------------------------------------------------------
//	Class:	UIAbilityList_HitChance
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class UIAbilityList_HitChance extends UIAbilityList;

var int MaxHeight;
var int LastActive;
delegate OnSizeRealized();

simulated function RefreshData(array<UISummary_Ability> Data)
{
	local UIAbilityListItem Item; 
	local int i; 

	//Test
	for( i = 0; i < Data.Length; i++ )
	{
		
		// Build new items if we need to. 
		if( i > Items.Length-1 )
		{
			Item = Spawn(class'UIAbilityListItem_HitChance', self).InitAbilityListItem(self);
			Item.ID = i; 
			Items.AddItem(Item);
		}
		
		// Grab our target Item
		Item = Items[i]; 

		//Update Data 
		Item.Data = Data[i]; 

		Item.Show();
	}
	LastActive=i-1;
	//List items no longer notify on height change, so we call OnItemChanged once directly

	// Hide any excess list items if we didn't use them. 
	for( i = Data.Length; i < Items.Length; i++ )
	{
		Items[i].Hide();
	}
}

static function	UISummary_Ability GetUISummary_Ability(XComGameState_Ability kGameStateAbility, optional XComGameState_Unit UnitState)
{
	local UISummary_Ability Data;
	local X2AbilityTemplate	AbilityTemplate;
	local X2AbilityCost		Cost;

	Data=kGameStateAbility.GetUISummary_Ability(UnitState);

	AbilityTemplate=kGameStateAbility.GetMyTemplate();

	foreach AbilityTemplate.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_ActionPoints') && !X2AbilityCost_ActionPoints(Cost).bFreeCost)
		Data.ActionCost += X2AbilityCost_ActionPoints(Cost).GetPointCost(kGameStateAbility, UnitState);
	}

	
	if (UnitState==none)
		UnitState=XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kGameStateAbility.OwnerStateObject.ObjectID));

	if (UnitState==none) return Data;

	Data.CooldownTime = AbilityTemplate.AbilityCooldown.GetNumTurns(kGameStateAbility, UnitState, none, none);
	Data.bEndsTurn = AbilityTemplate.WillEndTurn(kGameStateAbility, UnitState); // Will End Turn
	Data.Icon=kGameStateAbility.GetMyIconImage();
	//if (Data.Name == "") Data.Name=string(AbilityTemplate.DataName);
	//Data.Description=string(AbilityTemplate.DataName) @ Data.Description;

	return Data;
}

simulated function OnItemChanged(UIAbilityListItem ItemModified )
{
	local int i;//, iStartIndex; 
	local float currentYPosition; 
	local UIAbilityListItem Item;

	//iStartIndex = Items.Find(Item); 
	currentYPosition = 0;// Items[iStartIndex].Y; 

	ClearScroll();
	for( i = 0; i < Items.Length; i++ )
	{
		Item = Items[i]; 
		if( !Item.bIsVisible )
			break;
		Item.SetY(currentYPosition);
		currentYPosition += Item.height; 
	}

	if( height != currentYPosition )
	{
		height = currentYPosition;
		StretchToFit();

		if( OnSizeRealized != none )
			OnSizeRealized();

		AnimateScroll(height, MaskHeight);
	}
}

//If a max size is defined, this list will attempt to stretch or shrink. 
simulated function StretchToFit()
{
	if( MaxHeight == 0 ) return; 

	if( height < MaxHeight )
	{
		MaskHeight = height; 
	}
	else
	{
		MaskHeight = MaxHeight;
	}
}

defaultproperties
{
	MaxHeight=850;
}