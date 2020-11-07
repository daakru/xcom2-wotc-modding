//-----------------------------------------------------------
//	Class:	UIAbilityListItem_HitChance
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------

class UIAbilityListItem_HitChance extends UIAbilityListItem;

var UIIcon Icon;

var int TitleYPadding, BottomPadding;

simulated function UIAbilityListItem InitAbilityListItem(UIAbilityList initList,
															   optional int InitX = 0, 
															   optional int InitY = 0, 
															   optional int InitWidth = 0)
{
	Super.InitAbilityListItem(initList, InitX, InitY, InitWidth);
	Icon = Spawn(class'UIIcon', self).InitIcon('IconMC',,false,true, 36);
	Title.SetPosition(Icon.width + TitlePadding, TitleYPadding);
	Title.SetWidth(width - Title.X); 
	Line.SetY(Line.Y + TitleYPadding);
	Actions.SetPosition(0, Line.Y + ActionsPadding); 
	EndTurn.SetPosition(0, Line.Y + ActionsPadding);
	//Desc.SetPosition(0, Actions.Y + Actions.height);
	return self;
}

simulated function RefreshDisplay()
{
	// Sebkulu - DynamicLoadObject is used to test also the incapacity of game to load an icon even if the path to it is correctly set in template
	if (Data.Icon == "" || DynamicLoadObject(Repl(Data.Icon, "img:///", "", false), class'Texture2D') == none)
	{
		Icon.Hide();
		Title.SetPosition(0, TitleYPadding);
		Title.SetWidth(width); 

	}
	else
	{
		Icon.LoadIcon(Data.Icon);
		Icon.Show();
		Title.SetPosition(Icon.width + TitlePadding, TitleYPadding);
		Title.SetWidth(width - Title.X); 
	}

	if (Data.ActionCost==0 && !Data.bEndsTurn)
		Desc.SetY(Actions.Y);
	else Desc.SetY(Actions.Y + Actions.height);
	Super.RefreshDisplay();
	onTextSizeRealized();
}

simulated function onTextSizeRealized()
{
	local int iCalcNewHeight;
	if (Data.CooldownTime != 0)
		iCalcNewHeight = Desc.Y + Desc.height + Cooldown.Height; 
	else 
		iCalcNewHeight = Desc.Y + Desc.height + BottomPadding;

	if (iCalcNewHeight != Height )
	{
		Height = iCalcNewHeight;  
		Cooldown.SetY(Desc.Y + Desc.height);
		List.OnItemChanged(self);
	}
}



defaultproperties
{
	TitleYPadding = 4;
	ActionsPadding = 8;
	BottomPadding=6;
}