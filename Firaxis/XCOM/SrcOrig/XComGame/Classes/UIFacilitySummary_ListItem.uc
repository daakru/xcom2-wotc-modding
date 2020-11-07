
class UIFacilitySummary_ListItem extends UIPanel;

var StateObjectReference FacilityRef;
var Name m_FacilityName; //bsg-crobinson (4.26.17): Grab and store the name of the Facility

var localized string m_strUnstaffed;
var localized string m_strTimeRemainingLabel;
var localized string m_strAvailableStaffLabel;
var localized string m_strCoreFacilityLabel;
var localized string m_strUnderConstructionLabel;

simulated function UIFacilitySummary_ListItem InitListItem(optional name InitName, optional name InitLibID)
{
	InitPanel(InitName, InitLibID);
	return self;
}

simulated function UpdateData(StateObjectReference _FacilityRef)
{
	local XComGameState_FacilityXCom Facility;
	local XComGameState_StaffSlot StaffSlot;
	local string FacilityName;
	local string StaffSlot1;
	local string StaffSlot2;
	local string FacilityPower;
	local string ConstructionDate;
	local string QueueMessage;
	local string StatusMessage;
	local string UpkeepCost;


	FacilityRef = _FacilityRef;
	Facility = XComGameState_FacilityXCom(`XCOMHISTORY.GetGameStateForObjectID(FacilityRef.ObjectID));

	if (Facility.UpkeepCost > 0 && !Facility.IsUnderConstruction())
	{
		UpkeepCost = "(" $class'UIUtilities_Strategy'.default.m_strCreditsPrefix $ Facility.UpkeepCost $ ")";
		UpkeepCost = class'UIUtilities_Text'.static.GetColoredText(UpkeepCost, eUIState_Warning);
	}

	FacilityName = class'UIUtilities_Text'.static.GetSizedText(Facility.GetMyTemplate().DisplayName @ UpkeepCost, 26);
	m_FacilityName = Facility.GetMyTemplateName(); //bsg-crobinson (4.26.17): Set the Facility Name
	
	if(!Facility.IsUnderConstruction())
	{
		if(Facility.StaffSlots.Length > 0)
		{
			StaffSlot = Facility.GetStaffSlot(0);
			StaffSlot1 = class'UIUtilities_Text'.static.GetSizedText(StaffSlot.GetNameDisplayString(), 22);
		}

		if(Facility.StaffSlots.Length > 1)
		{
			StaffSlot = Facility.GetStaffSlot(1);
			StaffSlot2 = class'UIUtilities_Text'.static.GetSizedText(StaffSlot.GetNameDisplayString(), 22);
		}
	}
	
	FacilityPower = class'UIUtilities_Text'.static.GetColoredText(string(Facility.GetPowerOutput()), Facility.GetPowerOutput() > 0 ? eUIState_Good : eUIState_Bad); 

	if(class'X2StrategyGameRulesetDataStructures'.static.IsFirstDay(Facility.ConstructionDateTime) && Facility.GetMyTemplate().bIsCoreFacility)
	{
		ConstructionDate = m_strCoreFacilityLabel;
	}
	else if(!Facility.IsUnderConstruction())
	{
		ConstructionDate = class'X2StrategyGameRulesetDataStructures'.static.GetDateString(Facility.ConstructionDateTime);
	}
	
	statusMessage = Facility.GetStatusMessage();
	queueMessage = Facility.GetQueueMessage();

	SetData(FacilityName,
		StaffSlot1, StaffSlot2, FacilityPower,
		ConstructionDate, StatusMessage, QueueMessage);
}

simulated function bool OnUnrealCommand(int cmd, int arg)
{
	if (!CheckInputIsReleaseOrDirectionRepeat(cmd, arg))
	{
		return false;
	}

	switch (cmd)
	{
		case class'UIUtilities_Input'.const.FXS_BUTTON_A:
		case class'UIUtilities_Input'.const.FXS_KEY_ENTER:
			OnButtonClicked(none);
			break;
	}

	return super.OnUnrealCommand(cmd, arg);
}

simulated function OnButtonClicked(UIButton kButton)
{
	if(m_FacilityName != 'CommandersQuarters') //bsg-crobinson (4.26.17): Be sure we dont select the commanders quarters if we're already in it
		class'UIUtilities_Strategy'.static.SelectFacility(FacilityRef);
}

function SetData(string facilityName,
						 string staffSlot1, string staffSlot2,  
						 string facilityPower, string constructionDate, 
						 string statusMessage, string queueMessage)
{
	mc.BeginFunctionOp("setData");
	mc.QueueString(facilityName);
	mc.QueueString(staffSlot1);
	mc.QueueString(staffSlot2);
	mc.QueueString(facilityPower);
	mc.QueueString(constructionDate);
	mc.QueueString(statusMessage);
	mc.QueueString(queueMessage);
	mc.EndOp();
}

defaultproperties
{
	LibID = "FacilityListItem";

	width = 1265;
	height = 76;
}