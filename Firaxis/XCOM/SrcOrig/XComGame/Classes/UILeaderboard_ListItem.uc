class UILeaderboard_ListItem extends UIPanel;

var TLeaderboardEntry m_Entry;

simulated function UILeaderboard_ListItem InitListItem(optional name InitName, optional name InitLibID)
{
	InitPanel(InitName, InitLibID);
	return self;
}

simulated function UpdateData(const out TLeaderboardEntry entry)
{
	local string strWins;
	local string strLosses;
	local string strDisconnects;

	m_Entry = entry;

	strWins = m_Entry.iWins == -1 ? "--" : string(m_Entry.iWins);
	strLosses = m_Entry.iLosses == -1 ? "--" : string(m_Entry.iLosses);
	strDisconnects = m_Entry.iDisconnects == -1 ? "--" : string(m_Entry.iDisconnects);

	SetData(string(m_Entry.iRank), m_Entry.strPlayerName, strWins, strLosses, strDisconnects);
}

function SetData(string rank,
						 string playerName, string Wins,  
						 string Losses, string Disconnects)
{
	mc.BeginFunctionOp("setData");
	mc.QueueString(rank);
	mc.QueueString(playerName);
	mc.QueueString(Wins);
	mc.QueueString(Losses);
	mc.QueueString(Disconnects);
	mc.EndOp();
}

defaultproperties
{
	LibID = "LeaderboardListItem";

	width = 1265;
	height = 43;
}