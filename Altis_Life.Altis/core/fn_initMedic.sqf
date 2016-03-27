#include "..\script_macros.hpp"
/*
	File: fn_initMedic.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Initializes the medic..
*/
private["_end"];
player addRating 99999999;
waitUntil {!(isNull (findDisplay 46))};

if((FETCH_CONST(life_medicLevel)) < 1 && (FETCH_CONST(life_adminlevel) == 0)) exitWith {
	["Notwhitelisted",FALSE,TRUE] call BIS_fnc_endMission;
	sleep 35;
};

if(EQUAL(LIFE_SETTINGS(getNumber,"allow_medic_weapons"),0)) then
{
	[] spawn
	{
		while {true} do
		{
			waitUntil {sleep 3; currentWeapon player != ""};
			removeAllWeapons player;
		};
	};
};

//
// XOXO Medic Uniform
//
[] spawn {
	while {true} do {
		waitUntil {sleep 3; uniform player == "U_Marshal"};

		if((FETCH_CONST(life_medicLevel)) < 2) then {
			(backpackContainer player) setObjectTextureGlobal [0, "#(rgb,8,8,3)color(1,0,0,1)"];
			player setObjectTextureGlobal [0, "textures\uniforms\UN\marshal-medic.jpg"];
		} else {
			player setObjectTextureGlobal [0, "textures\uniforms\UN\marshal-un.jpg"];
		};
		
		waitUntil {sleep 3; uniform player != "U_Marshal"};
	};
};

//
// XOXO UN Soldier Uniform
//
[] spawn {
	while {true} do {
		waitUntil {sleep 3; uniform player == "U_B_CTRG_3"};

		player setObjectTextureGlobal [0, "textures\uniforms\UN\U_B_CTRG_3_un_soldier.jpg"];

		waitUntil {sleep 3; uniform player != "U_B_CTRG_3"};
	};
};

[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
