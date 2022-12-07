Config = Config or {}

Config.Target = true
Config.DebugPoly = false

Config.ItemTiers = 1

-- Minimum Police Needed
Config.MinimumThermitePolice = 0
Config.MinimumFleecaPolice = 0
Config.MinimumPaletoPolice = 2
Config.MinimumPacificPolice = 2
Config.MinimumVaultPolice = 4 -- K4MBI MAP

-- Wait Times for Vault Opening
Config.FleecaVaultWait = 180000 -- 3 Mins
Config.PaletoVaultWait = 300000 -- 5 Mins
Config.PacificVaultWait = 300000 -- 5 Mins

-- Purchasable laptops
Config.Laptops = true
Config.LaptopPedLoc = vector4(-1360.10, -759.562, 21.304, 302.6)

-- Laptop Pricing for menu
Config.PinkLaptopPrice = 10000
Config.GreenLaptopPrice = 20000
Config.BlueLaptopPrice = 30000
Config.RedLaptopPrice = 40000
Config.GoldLaptopPrice = 50000

-- Amount of money bags recieved
Config.minFleecaBags = 2
Config.maxFleecaBags = 5
Config.minPaletoBags = 3
Config.maxPaletoBags = 6
Config.minPacificBags = 4
Config.maxPacificBags = 8
Config.minVaultBags = 5
Config.maxVaultBags = 10

-- Values of Money Bags
Config.minFleecaBagsWorth = 5000
Config.maxFleecaBagsWorth = 7500
Config.minPaletoBagsWorth = 5000
Config.maxPaletoBagsWorth = 10000
Config.minPacificBagsWorth = 7500
Config.maxPacificBagsWorth = 15000
Config.minVaultBagsWorth = 7500
Config.maxVaultBagsWorth = 20000

-- Trolley Populate Chance / 100
Config.FleecaTrolleyChance = 100
Config.PaletoTrolleyChance = 100
Config.PacificTrolleyChance = 100
Config.VaultTrolleyChance = 100

-- Trolley Gold Chances / 100
Config.FleecaGoldbarChance = 10
Config.PaletoGoldbarChance = 10
Config.PacificGoldbarChance = 50
Config.VaultGoldbarChance = 70

-- Trolley Gold Bar Amounts
Config.minFleecaGoldBars = 3
Config.maxFleecaGoldBars = 6
Config.minPaletoGoldBars = 5
Config.maxPaletoGoldBars = 8
Config.minPacificGoldBars = 6
Config.maxPacificGoldBars = 10
Config.minVaultGoldBars = 8
Config.maxVaultGoldBars = 11

-- Bank Cooldown
Config.SmallBankTimer = 20
Config.BigBankTimer = 60

-- Door Locks
Config.PaletoDoor1 = 85
Config.PaletoDoor2 = 86
Config.PacificDoor1 = 75
Config.PacificDoor2 = 76
Config.PacificDoor3 = 78
Config.PacificDoor4 = 79

-- Powerplant hits for blackout
Config.HitsNeeded = 13

-- Thermite Minigame Settings
Config.ThermiteBlocks = 18
Config.ThermiteAttempts = 3
Config.ThermiteShow = 5
Config.ThermiteTime = 45

-- Fleeca Laptop Config
Config.FleecaTime = 8
Config.FleecaBlocks = 4
Config.FleecaRepeat = 3

-- Paleto Laptop Config
Config.PaletoTime = 8
Config.PaletoBlocks = 5
Config.PaletoRepeat = 4

-- Pacific Laptop Config
Config.PacificTime = 8
Config.PacificBlocks = 6
Config.PacificRepeat = 4

-- Lower Vault Laptop Config [Computer]
Config.VaultTime = 8
Config.VaultBlocks = 6
Config.VaultRepeat = 5

-- Lower Vault Laptop Config [Back Door]
Config.VaultBackTime = 8
Config.VaultBackBlocks = 6
Config.VaultBackRepeat = 5

Config.RewardTypes = {
    [1] = {
        type = "item"
    },
    [2] = {
        type = "money",
    }
}

Config.LockerRewards = {
    ["tier1"] = {
        [1] = {item = "goldchain", minAmount = 5, maxAmount = 15},
    },
    ["tier2"] = {
        [1] = {item = "rolex", minAmount = 5, maxAmount = 15},
    },
    ["tier3"] = {
        [1] = {item = "goldbar", minAmount = 1, maxAmount = 2},
    },
}

Config.LockerRewardsPaleto = {
    ["tier1"] = {
        [1] = {item = "goldchain", minAmount = 10, maxAmount = 20},
    },
    ["tier2"] = {
        [1] = {item = "rolex", minAmount = 10, maxAmount = 20},
    },
    ["tier3"] = {
        [1] = {item = "goldbar", minAmount = 2, maxAmount = 4},
    },
}

Config.LockerRewardsPacific = {
    ["tier1"] = {
        [1] = {item = "goldbar", minAmount = 4, maxAmount = 8},
    },
    ["tier2"] = {
        [1] = {item = "goldbar", minAmount = 4, maxAmount = 8},
    },
    ["tier3"] = {
        [1] = {item = "goldbar", minAmount = 4, maxAmount = 8},
    },
}

Config.LockerRewardsVault = {
    ["tier1"] = {
        [1] = {item = "goldbar", minAmount = 4, maxAmount = 8},
    },
    ["tier2"] = {
        [1] = {item = "goldbar", minAmount = 4, maxAmount = 8},
    },
    ["tier3"] = {
        [1] = {item = "goldbar", minAmount = 4, maxAmount = 8},
    },
}

Config.PowerStations = {
    [1] = {
        coords = vector4(2835.24, 1505.68, 24.72, 160.0),
        hit = false
    },
    [2] = {
        coords = vector4(2811.76, 1500.6, 24.72, 338.8),
        hit = false
    },
    [3] = {
        coords = vector4(2137.73, 1949.62, 93.78, 176.0),
        hit = false
    },
    [4] = {
        coords = vector4(708.92, 117.49, 80.95, 152.5),
        hit = false
    },
    [5] = {
        coords = vector4(670.23, 128.14, 80.95, 340.0),
        hit = false
    },
    [6] = {
        coords = vector4(692.17, 160.28, 80.94, 162.0),
        hit = false
    },
    [7] = {
        coords = vector4(2459.16, 1460.94, 36.2, 3.5),
        hit = false
    },
    [8] = {
        coords = vector4(2280.45, 2964.83, 46.75, 267.0),
        hit = false
    },
    [9] = {
        coords = vector4(2059.68, 3683.8, 34.58, 303.0),
        hit = false
    },
    [10] = {
        coords = vector4(2589.5, 5057.38, 44.91, 17.0),
        hit = false
    },
    [11] = {
        coords = vector4(1343.61, 6388.13, 33.4, 90.0),
        hit = false
    },
    [12] = {
        coords = vector4(236.61, 6406.1, 31.83, 115.0),
        hit = false
    },
    [13] = {
        coords = vector4(-293.1, 6023.54, 31.54, 135.0),
        hit = false
    }
}

Config.SmallBanks = {
    [1] = {
        ["label"] = "Pink Cage Motel",
        ["coords"] = vector4(311.57, -284.0903, 53.974, 259.00),
        ["alarm"] = true,
        ["object"] = `v_ilev_gb_vauldr`,
        ["heading"] = {
            closed = 250.0,
            open = 160.0
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(315.230, -284.93, 53.1430),
                heading = 70.00,
                grabbed = false
            },
            {
                coords = vector3(313.480, -283.25, 53.1430),
                heading = 160.0,
                grabbed = false
            },
        },
        ["camId"] = 21,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(315.2048, -287.468, 54.143),
                ["heading"] = 246.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(314.6565, -288.885, 54.143),
                ["heading"] = 246.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(313.1488, -289.375, 54.143),
                ["heading"] = 156.90,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(311.7352, -288.875, 54.143),
                ["heading"] = 156.90,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(310.9144, -287.467, 54.143),
                ["heading"] = 66.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(311.4365, -286.277, 54.143),
                ["heading"] = 66.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    [2] = {
        ["label"] = "Legion Square",
        ["coords"] = vector4(148.1218, -1046.60, 30.000, 250.7),
        ["alarm"] = true,
        ["object"] = `v_ilev_gb_vauldr`,
        ["heading"] = {
            closed = 250.0,
            open = 160.0
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(149.5361, -1045.02, 28.346),
                heading = 160.00,
                grabbed = false
            },
            {
                coords = vector3(150.8701, -1046.30, 28.346),
                heading = 70.0,
                grabbed = false
            },
        },
        ["camId"] = 22,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(150.5759, -1049.07, 29.346),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(150.0989, -1050.43, 29.346),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(149.0469, -1051.08, 29.346),
                ["heading"] = 155.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(147.3068, -1050.42, 29.346),
                ["heading"] = 155.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(146.5203, -1049.30, 29.346),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(147.0513, -1047.85, 29.346),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    [3] = {
        ["label"] = "Hawick Ave",
        ["coords"] = vector4(-354.00, -55.30, 49.85, 257.45),
        ["alarm"] = true,
        ["object"] = `v_ilev_gb_vauldr`,
        ["heading"] = {
            closed = 250.0,
            open = 160.0
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(-350.955, -54.3646, 48.014),
                heading = 160.00,
                grabbed = false
            },
            {
                coords = vector3(-349.708, -55.5932, 48.014),
                heading = 70.0,
                grabbed = false
            },
        },
        ["camId"] = 23,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-349.795, -58.2366, 49.014),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-350.292, -59.6852, 49.014),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-351.550, -60.3088, 49.014),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-353.348, -59.6940, 49.014),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-354.147, -58.5504, 49.014),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-353.656, -57.0587, 49.014),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    [4] = {
        ["label"] = "Del Perro Blvd",
        ["coords"] = vector4(-1210.150, -336.350, 37.380, 299.500),
        ["alarm"] = true,
        ["object"] = `v_ilev_gb_vauldr`,
        ["heading"] = {
            closed = 296.863,
            open = 206.863
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(-1209.60, -333.876, 36.759),
                heading = 206.00,
                grabbed = false
            },
            {
                coords = vector3(-1207.67, -333.946, 36.759),
                heading = 115.0,
                grabbed = false
            },
        },
        ["camId"] = 24,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-1205.84, -335.683, 37.759),
                ["heading"] = 290.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-1205.17, -337.042, 37.759),
                ["heading"] = 290.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-1205.56, -338.343, 37.759),
                ["heading"] = 205.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-1207.37, -339.294, 37.759),
                ["heading"] = 205.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-1208.64, -338.993, 37.759),
                ["heading"] = 115.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-1209.32, -337.726, 37.759),
                ["heading"] = 115.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    [5] = {
        ["label"] = "Great Ocean Hwy",
        ["coords"] = vector4(-2956.500, 482.075, 15.300, 347.00),
        ["alarm"] = true,
        ["object"] = `hei_prop_heist_sec_door`,
        ["heading"] = {
            closed = 357.542,
            open = 267.542
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(-2958.34, 484.0975, 14.675),
                heading = 268.00,
                grabbed = false
            },
            {
                coords = vector3(-2957.35, 485.6234, 14.675),
                heading = 178.0,
                grabbed = false
            },
        },
        ["camId"] = 25,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-2954.89, 486.4198, 15.675),
                ["heading"] = 355.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-2953.42, 486.3435, 15.675),
                ["heading"] = 355.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-2952.43, 485.4940, 15.675),
                ["heading"] = 265.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-2952.58, 483.4612, 15.675),
                ["heading"] = 265.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-2953.44, 482.3929, 15.675),
                ["heading"] = 180.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-2954.90, 482.4014, 15.675),
                ["heading"] = 180.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    [6] = {
        ["label"] = "Sandy Shores",
        ["coords"] = vector4(1175.350, 2712.900, 39.350, 84.600),
        ["alarm"] = true,
        ["object"] = `v_ilev_gb_vauldr`,
        ["heading"] = {
            closed = -270.542,
            open = -370.542
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(1173.668, 2711.000, 37.066),
                heading = 0.00,
                grabbed = false
            },
            {
                coords = vector3(1172.139, 2711.782, 37.066),
                heading = 270.00,
                grabbed = false
            },
        },
        ["camId"] = 25,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(1171.216, 2714.311, 38.066),
                ["heading"] = 90.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(1171.214, 2715.894, 38.066),
                ["heading"] = 90.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(1172.274, 2716.826, 38.066),
                ["heading"] = 360.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(1174.206, 2716.818, 38.066),
                ["heading"] = 360.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(1175.264, 2715.944, 38.066),
                ["heading"] = 270.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(1175.247, 2714.510, 38.066),
                ["heading"] = 270.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    }	
}

Config.BigBanks = {
    ["paleto"] = {
        ["label"] = "Blaine County Savings Bank",
        ["coords"] = vector4(-106.060, 6472.420, 31.010, 43.500),
        ["alarm"] = true,
        ["object"] = -1185205679,
        ["heading"] = {
            closed = 45.45,
            open = 130.45
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(-107.038, 6473.670, 30.626),
                heading = 315.00,
                grabbed = false
            },
            {
                coords = vector3(-107.525, 6475.475, 30.626),
                heading = 225.0,
                grabbed = false
            },
        },
        ["thermite"] = {
            [1] = {
                ["coords"] = vector3(-105.782, 6474.974, 31.626),
                ["heading"] = 310.0,
                ["isOpened"] = false,
                ["doorId"] = 86
            }
        },
        ["camId"] = 26,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-106.597, 6477.979, 31.626),
                ["heading"] = 40.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-105.398, 6478.903, 31.649),
                ["heading"] = 40.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-104.137, 6479.149, 31.626),
                ["heading"] = 310.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-102.636, 6477.651, 31.678),
                ["heading"] = 310.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-102.308, 6476.092, 31.626),
                ["heading"] = 220.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-103.241, 6475.249, 31.647),
                ["heading"] = 220.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    ["pacific"] = {
        ["label"] = "Pacific Standard",
        ["coords"] = {
            [1] = vector3(261.95, 223.11, 106.28),
            [2] = vector4(253.210, 228.30, 101.700, 73.150)
        },
        ["alarm"] = true,
        ["object"] = 961976194,
        ["heading"] = {
            closed = 160.00001,
            open = 70.00001
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(266.20, 214.6539, 100.68),
                heading = 70.00,
                grabbed = false
            },
            {
                coords = vector3(265.50, 212.6842, 100.68),
                heading = 70.0,
                grabbed = false
            },
            {
                coords = vector3(263.6069, 216.2170, 100.68),
                heading = 160.0,
                grabbed = false
            },
            {
                coords = vector3(262.2430, 213.1907, 100.68),
                heading = 340.0,
                grabbed = false
            },
        },
        ["thermite"] = {
            [1] = {
                ["coords"] = vector3(252.55, 221.15, 101.68),
                ["heading"] = 160.0,
                ["isOpened"] = false,
            },
            [2] = {
                ["coords"] = vector3(261.15, 215.21, 101.68),
                ["heading"] = 250.0,
                ["isOpened"] = false,
            },
            [3] = {
                ["coords"] = vector3(257.2764, 220.2341, 106.28),
                ["heading"] = 335.0,
                ["isOpened"] = false,
            }
        },
        ["camId"] = 26,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(258.1886, 218.5870, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(259.4572, 218.0901, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(261.0686, 217.5370, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(256.6934, 214.6796, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(258.2743, 214.1041, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(259.7899, 213.6278, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [7] = {
                ["coords"] = vector3(263.1606, 212.3338, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [8] = {
                ["coords"] = vector3(264.2391, 211.9872, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [9] = {
                ["coords"] = vector3(266.0842, 213.5762, 101.68),
                ["heading"] = 337.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [10] = {
                ["coords"] = vector3(265.7250, 215.7426, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [11] = {
                ["coords"] = vector3(264.7821, 216.1715, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            }
        }
    }
}

Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true
}