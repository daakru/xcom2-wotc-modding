//-----------------------------------------------------------
//	Class:	UIEffectListItem_HitChance
//	Author: Mr.Nice / Sebkulu
//	
//-----------------------------------------------------------


class UIEffectListItem_HitChance extends UIEffectListItem;

var UIText CoolDown;

simulated function UIEffectListItem InitEffectListItem(UIEffectList initList,
															   optional int InitX = 0, 
															   optional int InitY = 0, 
															   optional int InitWidth = 0)
{
	Super.InitEffectListItem(initList, InitX, InitY, InitWidth);
	CoolDown = Spawn(class'UIText', self).InitText('EffectiNumTurns', "", true);
	CoolDown.SetWidth(width); 
	return self;
}


simulated function RefreshDisplay()
{
	// Sebkulu - DynamicLoadObject is used to test also the incapacity of game to load an icon even if the path to it is correctly set in template
	if (DynamicLoadObject(Repl(Data.Icon, "img:///", "", false), class'Texture2D') == none)
	{
		Data.Icon = "";
		Title.SetPosition(0, TitleYPadding);
		Title.SetWidth(width); 
	}
	else
	{
		Title.SetPosition( Icon.Y + Icon.width + TitleXPadding, TitleYPadding );
		Title.SetWidth(width - Title.X); 
	}

	Super.RefreshDisplay();
	Cooldown.SetHTMLText( GetCooldownString( Data.Cooldown ) );
	onTextSizeRealized();
}


simulated function string GetCooldownString( int iCooldown )
{
	if( iCooldown > 0 ) return 
		class'UIUtilities_Text'.static.StyleText( class'UIMissionSummary'.default.m_strTurnsRemainingLabel, eUITextStyle_Tooltip_StatLabel)
		@ class'UIUtilities_Text'.static.StyleText(string(iCooldown), eUITextStyle_Tooltip_AbilityValue);
	else if (iCooldown==-1) return
		class'UIUtilities_Text'.static.StyleText( class'UIMissionSummary'.default.m_strTurnsRemainingLabel, eUITextStyle_Tooltip_StatLabel)
		@ class'UIUtilities_Text'.static.StyleText(string(0), eUITextStyle_Tooltip_AbilityValue);
	else return "";
}

simulated function onTextSizeRealized()
{
	local int iCalcNewHeight;

	if (Data.Cooldown != 0)
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
