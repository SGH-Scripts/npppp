Config = {
	Debug = false, -- Enable to add debug boxes and message.
	img = "lj-inventory/html/images/", -- Set this to your inventory
	MaxSlots = 41, -- Set this to your player inventory slot count, this is default "41"
	Measurement = "kg", -- Custom Weight measurement
	RandomLocation = false, -- Set to true if you want random location. False = create for each location a blackmarket
	RandomItem = false, -- Set to true if you want a random item. False = show all items
	OpenWithItem = true, -- Is there an item needed to open the blackmarket ?
	ItemName = "blackpass", -- If you set the above function to yes, place here your itemname
	RemoveItem = true, -- Do you want to remove the item after purchasing something from black market
	UseDirtyMoney = false, -- Do you want to use dirty money like blackmoney / crypto. Set to false if you want pay with normal money
	Payment = "blackmoney", -- Choose between blackmoney / crypto (default q-bit crypto)
	BlackMoneyName = "trojan_usb", -- If the option above is blackmoney then set the name of the black money item
	BlackMoneyMultiplier = 1, -- Where 1 is 100% and 2 is 200% etc, 1.2 if 120%
	UseTimer = false, -- Use a timer to change the blackmarket location
	ChangeLocationTime = 30, -- Time in minutes to change the location of the black market.
}

Config.Products = {
	["blackmarket"] = {
        [1] = { name = "laptop_green", price = 25000, crypto = 3, amount = 1 },
		[2] = { name = "laptop_blue", price = 50000, crypto = 2, amount = 1 },
		[3] = { name = "laptop_red", price = 100000, crypto = 1, amount = 0 },
		-- [4] = { name = "weapon_pistol50", price = 40000, crypto = 2, amount = 1 },
		-- [5] = { name = "weapon_pistol_mk2", price = 32500, crypto = 1, amount = 2 },
		-- [6] = { name = "pistol_extendedclip", price = 20000, crypto = 3, amount = 1 },
		-- [7] = { name = "pistol_suppressor", price = 50000, crypto = 2, amount = 1 },
		-- [8] = { name = "pistol_flashlight", price = 5000, crypto = 1, amount = 5 },
		-- [9] = { name = "pistol50_extendedclip", price = 40000, crypto = 3, amount = 1 },
		-- [10] = { name = "smg_scope", price = 20000, crypto = 2, amount = 1 },
	},
}

Config.Locations = {
	["blackmarket"] = {
		["label"] = "Black Market",
		["openwith"] = "blackpass", -- Type here the name of the item you want to open the shop with
		--["gang"] = "", -- The gang name that can open the shop
		["model"] = {
			[1] = `mp_f_weed_01`,
			[2] = `MP_M_Weed_01`,
			[3] = `A_M_Y_MethHead_01`,
			[4] = `A_F_Y_RurMeth_01`,
			[5] = `A_M_M_RurMeth_01`,
			[6] = `MP_F_Meth_01`,
			[7] = `MP_M_Meth_01`,
		},
		["coords"] = {
			[1] = vector4(-1320.39, -253.14, 42.1, 310.33),
			},
		["products"] = Config.Products["blackmarket"],
		["hideblip"] = true,
	},
}
