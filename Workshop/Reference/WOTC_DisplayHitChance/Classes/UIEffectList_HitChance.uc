//-----------------------------------------------------------
//	Class:	UIEffectList_HitChance
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------


class UIEffectList_HitChance extends UIEffectList;

simulated function RefreshDisplay(array<UISummary_UnitEffect> Data)
{
	local UIEffectListItem Item; 
	local int i; 

	//Test

	for( i = 0; i < Data.Length; i++ )
	{
		
		// Build new items if we need to. 
		if( i > Items.Length-1 )
		{
			Item = Spawn(class'UIEffectListItem_HitChance', self).InitEffectListItem(self);
			Item.ID = i; 
			Items.AddItem(Item);
		}
		
		// Grab our target Item
		Item = Items[i]; 

		//Update Data 
		Item.Data = Data[i]; 

		Item.Show();
	}

	// Hide any excess list items if we didn't use them. 
	for( i = Data.Length; i < Items.Length; i++ )
	{
		Items[i].Hide();
	}
}

