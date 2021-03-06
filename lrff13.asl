state("LRFF13")
{
	long gtime			: "LRFF13.exe", 0x0026A6F4, 0x34;
	bool isLoading0 	: "LRFF13.exe", 0x1F9F8E4, 0x50, 0x2DC;
	
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
	
	// ATB addresses
	//uint atb1			: "LRFF13.exe", 0x01E879F0, 0x8, 0x4, 0x31C;
	//uint atb1			: "LRFF13.exe", 0x012033DC, 0x220, 0x8, 0x4, 0x31C;
	uint battle			: "LRFF13.exe", 0x0015408C, 0x0;
	
	// EP address
	//uint ep				: "LRFF13.exe", 0x012CA950, 0x328;
	
	// Load Remover Addresses
	uint loading 		: "LRFF13.exe", 0x0088DD50, 0x24;
	uint interval		: "LRFF13.exe", 0x020C8E38, 0x18, 0x98;
	byte paused			: "LRFF13.exe", 0x003B91D8, 0x0;
	byte saving			: "LRFF13.exe", 0x0086C4F0, 0x3;
	byte ingame			: "LRFF13.exe", 0x000877D0, 0x0;
}

init
{
	vars.split = false;
	vars.daysplit = false;
	vars.shadowEquip = false;
	vars.museEquip	= false;
	vars.time0 = 4294967295;
	vars.done = false;
	
	vars.fightTime = 0;
	vars.fightStart = 0;
	vars.fightEnd = 0;
	
	vars.menuTime = 0;
	vars.menuStart = 0;
	vars.menuEnd = 0;
	
	vars.encounterCount = 0;
	
	vars.comp_array = new LiveSplit.UI.Components.IComponent [3];
	
	vars.arrNum = 0;
	vars.fightTextNum = -1;
	vars.menuTextNum = -1;
	vars.encounterTextNum = -1;
foreach (LiveSplit.UI.Components.IComponent component in timer.Layout.Components) {
  if (component.GetType().Name == "TextComponent") {
	if (settings["fightTextSet"] == true & vars.fightTextNum == -1) {
		vars.comp_array[vars.arrNum] = component;
		vars.comp_array[vars.arrNum].Settings.Text1 = "Last Battle Time";
		vars.fightTextNum = vars.arrNum;
		vars.arrNum++;
		continue;
	}
		if (settings["menuTextSet"] == true & vars.menuTextNum == -1) {
			vars.comp_array[vars.arrNum] = component;
			vars.comp_array[vars.arrNum].Settings.Text1 = "Last Menu Time";
			vars.menuTextNum = vars.arrNum;
			vars.arrNum++;
			continue;
		}
		if (settings["encounterTextSet"] == true & vars.encounterTextNum == -1) {
			vars.comp_array[vars.arrNum] = component;
			vars.comp_array[vars.arrNum].Settings.Text1 = "Encounters";
			vars.encounterTextNum = vars.arrNum;
			vars.arrNum++;
			continue;
		}
	  }
	}
	
	/*foreach (LiveSplit.UI.Components.IComponent component in timer.Layout.Components) {
	  if (component.GetType().Name == "CounterComponent") {
		component.Settings.Count += 1;
		continue;
	  }
	}*/
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
		settings.Add("dmpSet", false, "Equip Dark Muse+", "menuSet");
	
	settings.Add("fightTextSet", false, "Override text component with a Fight Timer");
	settings.Add("menuTextSet", false, "Override text component with a Menu Timer");
	settings.Add("encounterTextSet", false, "Override text component with an Encounter Counter");
}

isLoading
{
	vars.loadingVal = false;
	
	if(current.isLoading0)
	{
		vars.loadingVal = true;
	}
	else if(	current.loading == 0 &
				current.interval == 0 &
				current.battle == 0 &
				current.menu == 255 &
				current.paused == 0 &
				current.saving != 192 &
				current.ingame != 255 &
				current.bhunivelze == 0)
	{
		vars.loadingVal = true;
	}
	else
	{
		vars.loadingVal = false;
	}
	
	return vars.loadingVal;
}

update
{
	if(settings["fightTextSet"])
	{
		if(current.battle != 0 & old.battle == 0 )
		{
			vars.fightStart = current.gtime;
		}
		if( current.battle == 0 & old.battle != 0 )
		{
			vars.fightEnd = current.gtime;
		}
		if(vars.fightEnd >= vars.fightStart)
		{
			vars.fightTime = vars.fightEnd - vars.fightStart;
		}
		
		vars.tcs = vars.comp_array[vars.fightTextNum].Settings;
		vars.s = (((vars.fightTime)/10)%6000)/100.0;
		vars.m = vars.fightTime/60000;
		if(vars.m == 0)
		{
			if(vars.fightTime == 0)
			{
				vars.tcs.Text2 = "0";
			}
			else
			{
				vars.tcs.Text2 = vars.s.ToString().PadRight(3,'0');
			}
		}
		else
		{
			if(vars.s < 10)
			{
				vars.tcs.Text2 = vars.m.ToString() + ":0"+vars.s.ToString().PadRight(3,'0');
			}
			else {
				vars.tcs.Text2 = vars.m.ToString() + ":"+vars.s.ToString().PadRight(3,'0');
			}
		}
	}
	
	if(settings["menuTextSet"])
	{
		if( current.menu != 255 & old.menu == 255 )
		{
			vars.menuStart = current.gtime;
		}
		if( current.menu == 255 & old.menu != 255 )
		{
			vars.menuEnd = current.gtime;
		}
		if( vars.menuEnd >= vars.menuStart)
		{
			vars.menuTime = vars.menuEnd - vars.menuStart;
		}
		
		vars.tcs = vars.comp_array[vars.menuTextNum].Settings;
		vars.s = (((vars.menuTime)/10)%6000)/100.0;
		vars.m = vars.menuTime/60000;
		if(vars.m == 0)
		{
			if(vars.menuTime == 0)
			{
				vars.tcs.Text2 = "0";
			}
			else
			{
				vars.tcs.Text2 = vars.s.ToString().PadRight(4,'0');
			}
		}
		else
		{
			if(vars.s < 10)
			{
				vars.tcs.Text2 = vars.m.ToString() + ":0"+vars.s.ToString().PadRight(3,'0');
			}
			else {
				vars.tcs.Text2 = vars.m.ToString() + ":"+vars.s.ToString().PadRight(3,'0');
			}
		}
	}
	
	if(settings["encounterTextSet"])
	{
		if(current.battle != 0 & old.battle == 0 )
		{
			vars.encounterCount++;
		}
		
		vars.tcs = vars.comp_array[vars.encounterTextNum].Settings;
		vars.tcs.Text2 = vars.encounterCount.ToString();
	}
	
	return true;
}

start
{
	if( current.begin == 189 & old.begin == 192)
	{
		vars.split = false;
		vars.daysplit = false;
		vars.fightEnd = 0;
		vars.fightStart = 0;
		vars.menuStart = 0;
		vars.menuEnd = 0;
		vars.encounterCount = 0;
		return true;
	}
	if( current.begin == 181 & old.begin == 184)
	{
		vars.split = false;
		vars.daysplit = false;
		vars.fightEnd = 0;
		vars.fightStart = 0;
		vars.menuStart = 0;
		vars.menuEnd = 0;
		vars.encounterCount = 0;
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
	if( old.bhunivelze == 0 & current.bhunivelze != 0 & old.battle != 0 )
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
		if(current.ingame != 255)
		{
			return true;
		}
	}
	// End of Day Split
	if( current.warp == 255 & vars.daysplit == true )
	{
		vars.daysplit = false;
		return true;
	}
}
