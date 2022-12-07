Config = {}

Config.PawnLocation = {
    [1] = {
            coords = vector3(-1368.03, -647.06, 28.69),
            length = 1.5,
            width = 1.8,
            heading = 304.23,
            debugPoly = false,
            minZ = 20.97,
            maxZ = 30.42,
            distance = 5.0
        },
    }

Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = false -- Set to false if you want the pawnshop open 24/7
Config.TimeOpen = 7 -- Opening Time
Config.TimeClosed = 17 -- Closing Time
Config.SendMeltingEmail = true

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.PawnItems = {
    [1] = {
        item = 'goldchain',
        price = math.random(2500,5000)
    },
    [2] = {
        item = 'diamond_ring',
        price = math.random(500,1000)
    },
    [3] = {
        item = 'rolex',
        price = math.random(500,1000)
    },
    [4] = {
        item = '10kgoldchain',
        price = math.random(500,1000)
    },
    [5] = {
        item = 'tablet',
        price = math.random(500,1000)
    },
    [6] = {
        item = 'iphone',
        price = math.random(500,1000)
    },
    [7] = {
        item = 'samsungphone',
        price = math.random(500,1000)
    },
    [8] = {
        item = 'laptop',
        price = math.random(500,1000)
    },
    [9] = {
        item = 'diamond',
        price = math.random(2000,5000)
    }
}

Config.MeltingItems = { -- meltTime is amount of time in minutes per item
    [1] = {
        item = 'goldchain',
        rewards = {
            [1] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 1.00
    },
    [2] = {
        item = 'diamond_ring',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [3] = {
        item = 'rolex',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            },
            [3] = {
                item = 'electronickit',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [4] = {
        item = '10kgoldchain',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 5
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
}
