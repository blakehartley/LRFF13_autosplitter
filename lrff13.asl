// Steam build of 2021-06-23 (July 2021 patch).
state("LRFF13", "2021")
{
	long gtime			: "LRFF13.exe", 0x00269C34, 0x34;
	bool isLoading0 	: "LRFF13.exe", 0x1FA08E4, 0x50, 0x2DC;
	
	// Cool stuff
	//byte screen			: "LRFF13.exe", 0x00452B68, 0x0;// Area-change popups
	
	
	byte begin			: "LRFF13.exe", 0x0039FF78, 0xD5;
	short bover			: "LRFF13.exe", 0x0039FF78, 0xD5;
	byte menu			: "LRFF13.exe", 0x003B2008, 0x0;
	byte sfxVoices		: "LRFF13.exe", 0x04D1BA40;// UI sound voices playing; +3 in one frame on "start game"
	
	// Bestiary based addreses
	//int zaltys			: "LRFF13.exe", 0x04CF7818, 0x52C;
	int noel			: "LRFF13.exe", 0x04CF7818, 0x398;
	int choco			: "LRFF13.exe", 0x04CF7818, 0x364;
	int cyclops			: "LRFF13.exe", 0x04CF7818, 0x544;
	int snow			: "LRFF13.exe", 0x04CF7818, 0x55C;
	int caius			: "LRFF13.exe", 0x04CF7818, 0x254;
	int parandus		: "LRFF13.exe", 0x04CF7818, 0x54C;
	int cactair			: "LRFF13.exe", 0x04CF7818, 0x4EC;
	int chimera			: "LRFF13.exe", 0x04CF7818, 0x374;
	int bhunivelze		: "LRFF13.exe", 0x04CF7818, 0x4F4;
	
	// Time addresses
	byte day			: "LRFF13.exe", 0x04D06440, 0x336;
	uint time			: "LRFF13.exe", 0x020C9E38, 0x18, 0x50;
	
	// Menu addresses
	string16 g1garb		: "LRFF13.exe", 0x04D0626C, 0x110;
	string16 g1wep		: "LRFF13.exe", 0x04D0626C, 0x160;
	uint garbBase		: "LRFF13.exe", 0x04D0626C;// the JP build stores the names at +0x110 as Shift-JIS (cp932), not UTF-16
	
	// ATB addresses
	//uint atb1			: "LRFF13.exe", 0x01E879F0, 0x8, 0x4, 0x31C;
	//uint atb1			: "LRFF13.exe", 0x012033DC, 0x220, 0x8, 0x4, 0x31C;
	uint battle			: "LRFF13.exe", 0x0015365C, 0x0;
	
	// EP address
	//uint ep				: "LRFF13.exe", 0x012CA950, 0x328;
	
	// Load Remover Addresses
	uint loading 		: "LRFF13.exe", 0x008A42A0, 0x24;
	uint interval		: "LRFF13.exe", 0x020C9E38, 0x18, 0x98;
	byte paused			: "LRFF13.exe", 0x003B8738, 0x0;
	byte saving			: "LRFF13.exe", 0x00882AE0, 0x3;
	byte ingame			: "LRFF13.exe", 0x00086F90, 0x0;
}

init
{
	int size = modules.First().ModuleMemorySize;
	if (size == 0x4E48000) version = "2021";
	else version = "unknown 0x" + size.ToString("X");
	print("[LRFF13] ModuleMemorySize=0x" + size.ToString("X") + " version=" + version);
	
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
	
	if ((settings["fightTextSet"] & vars.fightTextNum == -1) | (settings["menuTextSet"] & vars.menuTextNum == -1) | (settings["encounterTextSet"] & vars.encounterTextNum == -1))
		print("[LRFF13] WARNING: a text-override setting is on but the layout does not have enough Text components; that display is skipped");
	
	/*foreach (LiveSplit.UI.Components.IComponent component in timer.Layout.Components) {
	  if (component.GetType().Name == "CounterComponent") {
		component.Settings.Count += 1;
		continue;
	  }
	}*/
}

startup
{
	vars.finalDrop = false;
	vars.onTitle = false;
	vars.garbName = "";
	vars.oldGarbName = "";
	
	settings.Add("killSet", true, "Bestiary / エネミー");
		settings.Add("noelSet", false, "Noel / ノエル", "killSet");
		settings.Add("chocoSet", false, "Chocobo Eater / チョコボイーター", "killSet");
		settings.Add("cyclopsSet", false, "Cyclops / サイクロプス", "killSet");
		settings.Add("snowSet", false, "Snow / スノウ", "killSet");
		settings.Add("caiusSet", false, "Caius / カイアス", "killSet");
		settings.Add("parandusSet", false, "Parandus / パランドゥス", "killSet");
		settings.Add("cactairSet", false, "Cactair / ボサテンダー", "killSet");
		settings.Add("chimeraSet", false, "Chimera / キマイラ", "killSet");
	
	settings.Add("eodSet", true, "End of Day / 日付終了");
		settings.Add("eod0Set", false, "Day 0 / 0日目", "eodSet");
		settings.Add("eod1Set", false, "Day 1 / 1日目", "eodSet");
		settings.Add("eod2Set", false, "Day 2 / 2日目", "eodSet");
		settings.Add("eod3Set", false, "Day 3 / 3日目", "eodSet");
		settings.Add("eod4Set", false, "Day 4 / 4日目", "eodSet");
		settings.Add("eod5Set", false, "Day 5 / 5日目", "eodSet");
		settings.Add("eod6Set", false, "Day 6 / 6日目", "eodSet");
		settings.Add("eod7Set", false, "Day 7 / 7日目", "eodSet");
		settings.Add("eod8Set", false, "Day 8 / 8日目", "eodSet");
		settings.Add("eod9Set", false, "Day 9 / 9日目", "eodSet");
		settings.Add("eod10Set", false, "Day 10 / 10日目", "eodSet");
		settings.Add("eod11Set", false, "Day 11 / 11日目", "eodSet");
		settings.Add("eod12Set", false, "Day 12 / 12日目", "eodSet");
	
	settings.Add("menuSet", true, "Menu / メニュー");
		settings.Add("dmpSet", false, "Equip Dark Muse+ / ダークミューズ改", "menuSet");
	
	settings.Add("fightTextSet", false, "Override text component with a Fight Timer / Textに戦闘時間を表示");
	settings.Add("menuTextSet", false, "Override text component with a Menu Timer / Textにメニュー操作時間を表示");
	settings.Add("encounterTextSet", false, "Override text component with an Encounter Counter / Textにエンカウント数を表示");
	refreshRate = 60;
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
	if (version != "2021") return false;	// unsupported build: no start, split or load removal
	
	// ingame is 255 on the title but stays 0 after the title's config screen; 100 or 110 in game.
	vars.onTitle = current.ingame != 100 & current.ingame != 110;
	refreshRate = vars.onTitle ? 240 : 60;
	
	vars.oldGarbName = vars.garbName;	// split runs after update, so take the previous name here
	string nm = "";
	if (current.garbBase != 0)
	{
		byte[] gb = memory.ReadBytes(new IntPtr((long)current.garbBase + 0x110), 32);
		if (gb != null)
		{
			int n = Array.IndexOf(gb, (byte)0); if (n < 0) n = gb.Length;
			nm = System.Text.Encoding.GetEncoding(932).GetString(gb, 0, n);
		}
	}
	// UTF-16 fallback (the 2016 build stored the names this way); keep it until the EN release is checked.
	if (current.g1garb == "Dark Muse+") nm = current.g1garb;
	vars.garbName = nm;
	
	// Final split helper: the result screen's last page sits at bover ~232 (238 in another run; the
	// layout shifts with its contents, also when mashing skips the animation) and the closing confirm
	// drops it by ~90 to ~142. The kill itself drops ~316 -> ~30, which the floor of 100 excludes.
	vars.finalDrop = vars.done & old.bover >= 200 & old.bover <= 280 & current.bover >= 100 & current.bover <= 200 & old.bover - current.bover >= 60;
	
	if(settings["fightTextSet"] & vars.fightTextNum != -1)
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
				vars.tcs.Text2 = vars.s.ToString("0.00");
			}
		}
		else
		{
			vars.tcs.Text2 = vars.m.ToString() + ":" + vars.s.ToString("00.00");
		}
	}
	
	if(settings["menuTextSet"] & vars.menuTextNum != -1)
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
				vars.tcs.Text2 = vars.s.ToString("0.00");
			}
		}
		else
		{
			vars.tcs.Text2 = vars.m.ToString() + ":" + vars.s.ToString("00.00");
		}
	}
	
	if(settings["encounterTextSet"] & vars.encounterTextNum != -1)
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
	// Starting the game on its confirm dialog (begin == 134 for NORMAL, 138 for EASY) starts two
	// UI sounds in the same frame, so the voice count jumps by 3 (every other menu input adds 1,
	// and Cancel on the same dialog also fades begin 134 -> 131 or 138 -> 135). Measured 7-16 ms
	// after the key press, one frame before the fade.
	if (vars.onTitle & (old.begin == 134 | old.begin == 138) & current.sfxVoices - old.sfxVoices >= 2)
	{
		vars.split = false;
		vars.daysplit = false;
		vars.fightEnd = 0;
		vars.fightStart = 0;
		vars.menuStart = 0;
		vars.menuEnd = 0;
		vars.encounterCount = 0;
		vars.done = false;
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
	if( settings["dmpSet"] )
	{
		// The JP name of Dark Muse+ is "ダークミューズ改" (measured).
		bool dmpNow = vars.garbName == "Dark Muse+" | vars.garbName == "ダークミューズ改";
		bool dmpOld = vars.oldGarbName == "Dark Muse+" | vars.oldGarbName == "ダークミューズ改";
		if( !dmpOld & dmpNow )
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
	// The last confirm on the result screen drops bover ~232 -> ~142 1-2 frames after the press
	// (4 measured runs, slow and mashed). On this build bover can jump past 24 (31 -> 19).
	if( vars.done == true & vars.finalDrop )
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
	// Split the moment the clock reaches the end-of-day value. On this build the old warp byte
	// (0x8A42A0, 0x48) only sticks at 255 7.4 s later, so it is not waited for.
	if( vars.daysplit == true )
	{
		vars.daysplit = false;
		return true;
	}
}
