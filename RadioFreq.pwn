/*
	Radio Frequencies
	© Luis- (2016)
*/
#define FILTERSCRIPT

#include 	<a_samp>
#include    <zcmd>
#include    <sscanf2>
#include    <foreach>

enum pInfo {
	pRadioFreq
}
new
	PlayerInfo[MAX_PLAYERS][pInfo]
;

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Radio Frequency Script. ");
	print(" Coded by Luis- ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

CMD:setfreq(playerid, params[]) {
	new freqcode, pName[MAX_PLAYER_NAME], string[128];
	if(sscanf(params, "i", freqcode)) return SendClientMessage(playerid, -1, "USAGE: /setfreq [frequency]");
	else {
	    GetPlayerName(playerid, pName, sizeof pName);
	    format(string, sizeof string, "[Radio] You've changed your radio frequency from {008ACF}%d {FFFFFF}to {008ACF}%d.", PlayerInfo[playerid][pRadioFreq], freqcode);
	    SendClientMessage(playerid, 0xFFFFFFFF, string);
        PlayerInfo[playerid][pRadioFreq] = freqcode;
        foreach(new i : Player) {
            if(PlayerInfo[i][pRadioFreq] == PlayerInfo[playerid][pRadioFreq] && i != playerid) {
                format(string, sizeof string, "[Radio] %s has just joined your radio frequency.", pName);
                SendClientMessage(i, 0xFFFFFFFF, string);
            }
        }
	}
	return 1;
}

CMD:radio(playerid, params[]) {
	new text[128], pName[MAX_PLAYER_NAME], string[128];
	if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, -1, "USAGE: /radio [text]");
	else {
	    if(PlayerInfo[playerid][pRadioFreq] != 0) {
			GetPlayerName(playerid, pName, sizeof pName);
        	foreach(new i : Player) {
            	if(PlayerInfo[playerid][pRadioFreq] == PlayerInfo[i][pRadioFreq]) {
					format(string, sizeof string, "[Radio Freq: {008ACF}%d{FFFFFF}] %s: %s", PlayerInfo[i][pRadioFreq], pName, text);
					SendClientMessage(i, 0xFFFFFFFF, string);
				}
			}
		}
		else {
			SendClientMessage(playerid, 0xFFFFFFFF, "ERROR: Your radio frequency is set to {008ACF}0{FFFFFF}, you should change it.");
		}
	}
	return 1;
}
