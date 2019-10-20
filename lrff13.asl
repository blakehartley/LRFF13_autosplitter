state("LRFF13")
{
	//int time			: "LRFF13.exe", 0x0026A6F4, 0x34;
	bool isLoading 		: "LRFF13.exe", 0x1F9F8E4, 0x50, 0x2DC;
	
	// Cool stuff
	byte warp			: "LRFF13.exe", 0x0088DD50, 0x48;// 255 when warping to the ark
	//byte screen			: "LRFF13.exe", 0x00452B68, 0x0;// Area-change popups
	
	
	byte begin			: "LRFF13.exe", 0x003A09F8, 0xD5;
	short bover			: "LRFF13.exe", 0x003A09F8, 0xD5;
	byte menu			: "LRFF13.exe", 0x003B2A98, 0x0;
	
	// Bestiary based addreses
	//int zaltys			: "LRFF13.exe", 0x04CF6808, 0x52C;
	int noel			: "LRFF13.exe", 0x04CF6808, 0x398;
	int choco			: "LRFF13.exe", 0x04CF6808, 0x364;
	int cyclops			: "LRFF13.exe", 0x04CF6808, 0x544;
	int snow			: "LRFF13.exe", 0x04CF6808, 0x55C;
	int caius			: "LRFF13.exe", 0x04CF6808, 0x254;
	int parandus		: "LRFF13.exe", 0x04CF6808, 0x54C;
	int cactair			: "LRFF13.exe", 0x04CF6808, 0x4EC;
	int chimera			: "LRFF13.exe", 0x04CF6808, 0x374;
	int bhunivelze		: "LRFF13.exe", 0x04CF6808, 0x4F4;
	
	// Time addresses
	byte day			: "LRFF13.exe", 0x04D05430, 0x336;
	uint time			: "LRFF13.exe", 0x020C8E38, 0x18, 0x50;
	
	// Menu addresses
	string16 g1garb		: "LRFF13.exe", 0x04D0525C, 0x110;
	string16 g1wep		: "LRFF13.exe", 0x04D0525C, 0x160;
}

init
{
	vars.split = false;
	vars.daysplit = false;
	vars.shadowEquip = false;
	vars.museEquip	= false;
	vars.time0 = 4294967295;
	vars.done = false;
	
}

startup
{
	settings.Add("killSet", true, "Bestiary");
		settings.Add("noelSet", false, "Noel", "killSet");
		settings.Add("chocoSet", false, "Chocobo eater", "killSet");
		settings.Add("cyclopsSet", false, "Cyclops", "killSet");
		settings.Add("snowSet", false, "Snow", "killSet");
		settings.Add("caiusSet", false, "Caius", "killSet");
		settings.Add("parandusSet", false, "Parandus", "killSet");
		settings.Add("cactairSet", false, "Cactair", "killSet");
		settings.Add("chimeraSet", false, "Chimera", "killSet");
	
	settings.Add("eodSet", true, "End of Day");
		settings.Add("eod0Set", false, "Day 0", "eodSet");
		settings.Add("eod1Set", false, "Day 1", "eodSet");
		settings.Add("eod2Set", false, "Day 2", "eodSet");
		settings.Add("eod3Set", false, "Day 3", "eodSet");
		settings.Add("eod4Set", false, "Day 4", "eodSet");
		settings.Add("eod5Set", false, "Day 5", "eodSet");
		settings.Add("eod6Set", false, "Day 6", "eodSet");
		settings.Add("eod7Set", false, "Day 7", "eodSet");
		settings.Add("eod8Set", false, "Day 8", "eodSet");
		settings.Add("eod9Set", false, "Day 9", "eodSet");
		settings.Add("eod10Set", false, "Day 10", "eodSet");
		settings.Add("eod11Set", false, "Day 11", "eodSet");
		settings.Add("eod12Set", false, "Day 12", "eodSet");
	
	settings.Add("menuSet", true, "Menu");
		settings.Add("shadowSet", false, "Equip Shadow Hunter", "menuSet");
		settings.Add("dmpSet", false, "Equip Dark Muse+", "menuSet");
}

isLoading
{
        return current.isLoading;
}

start
{
	if( current.begin == 189 & old.begin == 192)
	{
		vars.split = false;
		vars.daysplit = false;
		return true;
	}
}

split
{
	////////////////////	Datalog		////////////////////
	if( settings["noelSet"] & old.noel == 0 & current.noel != 0 )
	{
		vars.split = true;
	}
	if( settings["chocoSet"] & old.choco == 0 & current.choco != 0 )
	{
		vars.split = true;
	}
	if( settings["cyclopsSet"] & old.cyclops == 0 & current.cyclops != 0 )
	{
		vars.split = true;
	}
	if( settings["snowSet"] & old.snow == 0 & current.snow != 0 )
	{
		vars.split = true;
	}
	if( settings["caiusSet"] & old.caius == 0 & current.caius != 0 )
	{
		vars.split = true;
	}
	if( settings["parandusSet"] & old.parandus == 0 & current.parandus != 0 )
	{
		vars.split = true;
	}
	if( settings["cactairSet"] & old.cactair == 0 & current.cactair != 0 )
	{
		vars.split = true;
	}
	if( settings["chimeraSet"] & old.chimera == 0 & current.chimera != 0 )
	{
		vars.split = true;
	}
	
	////////////////////	End of Day		////////////////////
	if( settings["eod0Set"] & current.day == 0 & old.time == 1125000000 & current.time == 1350000000 )
	{
		vars.daysplit = true;
	}
	if( settings["eod1Set"] & current.day == 1 & old.time != 2430000000 & current.time == 2430000000 )
	{
		vars.daysplit = true;
	}
	if( settings["eod2Set"] & current.day == 2 & old.time != 3510000000 & current.time == 3510000000 )
	{
		vars.daysplit = true;
	}
	if( settings["eod3Set"] & current.day == 3 & old.time != 295032704 & current.time == 295032704 )
	{
		vars.daysplit = true;
	}
	if( settings["eod4Set"] & current.day == 4 & old.time != 1375032704 & current.time == 1375032704 )
	{
		vars.daysplit = true;
	}
	if( settings["eod5Set"] & current.day == 5 & old.time != 2455032704 & current.time == 2455032704 )
	{
		vars.daysplit = true;
	}
	if( settings["eod6Set"] & current.day == 6 & old.time != 3535032704 & current.time == 3535032704 )
	{
		vars.daysplit = true;
	}
	if( settings["eod7Set"] & current.day == 7 & old.time != 320065408 & current.time == 320065408 )
	{
		vars.daysplit = true;
	}
	if( settings["eod8Set"] & current.day == 8 & old.time != 1400065408 & current.time == 1400065408 )
	{
		vars.daysplit = true;
	}
	if( settings["eod9Set"] & current.day == 9 & old.time != 2480065408 & current.time == 2480065408 )
	{
		vars.daysplit = true;
	}
	if( settings["eod10Set"] & current.day == 10 & old.time != 3560065408 & current.time == 3560065408 )
	{
		vars.daysplit = true;
	}
	if( settings["eod11Set"] & current.day == 11 & old.time != 345098112 & current.time == 345098112 )
	{
		vars.daysplit = true;
	}
	if( settings["eod12Set"] & current.day == 12 & old.time != 1425098112 & current.time == 1425098112 )
	{
		vars.daysplit = true;
	}
	////////////////////	Menu		////////////////////
	if( settings["shadowSet"] )// 
	{
		if( old.g1wep != "w_ltw_oa00" & current.g1wep == "w_ltw_oa00")
		{
			vars.shadowEquip = true;
		}
		
		if(vars.shadowEquip == true & current.menu == 255 & old.menu != 255)
		{
			vars.shadowEquip = false;
			vars.split = true;
		}
	}
	if( settings["dmpSet"] )// 
	{
		if( old.g1garb != "Dark Muse+" & current.g1garb == "Dark Muse+")
		{
			vars.museEquip = true;
		}
		
		if(vars.museEquip == true & current.menu == 255 & old.menu != 255)
		{
			vars.museEquip = false;
			vars.split = true;
		}
	}
	////////////////////	Bhunivelze		////////////////////
	if( old.bhunivelze == 0 & current.bhunivelze != 0 )
	{
		vars.done = true;
	}
	if( vars.done == true & old.bover != 24 & current.bover == 24)
	{
		vars.done = false;
		return true;
	}
	
	// Split
	if(vars.split == true)
	{
		vars.split = false;
		return true;
	}
	// End of Day Split
	if( current.warp == 255 & vars.daysplit == true )
	{
		vars.daysplit = false;
		return true;
	}
}