QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = false -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 500
            },
        },
	},
	['police'] = {
		label = 'Law Enforcement',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Cadet',
                payment = 1500
            },
			['1'] = {
                name = 'Officer',
                payment = 3000
            },
			['2'] = {
                name = 'Sergeant',
                payment = 5000
            },
			['3'] = {
                name = 'Lieutenant',
                payment = 7500,
                bankAuth = true
            },
			['4'] = {
                name = 'Captain',
				isboss = true,
                payment = 10000,
                bankAuth = true
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 1500
            },
			['1'] = {
                name = 'Paramedic',
                payment = 3000
            },
			['2'] = {
                name = 'Doctor',
                payment = 5000
            },
			['3'] = {
                name = 'Surgeon',
                payment = 7500,
                bankAuth = true
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 10000,
                bankAuth = true
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 1500
            },
			['1'] = {
                name = 'Driver',
                payment = 2000
            },
			['2'] = {
                name = 'Event Driver',
                payment = 2500
            },
			['3'] = {
                name = 'Sales',
                payment = 3000
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 5000,
                bankAuth = true
            },
        },
	},
     ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 1000
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 15000
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 1000
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 1000
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 1000
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 1000
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 1000
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 1000
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 1000
            },
        },
	},
    ["burgershot"] = {
        label = "Burgershot",
        defaultDuty = true,
        grades = {
            ['0'] = {
                name = "Trainee",
                payment = 50
            },
            ['1'] = {
                name = "Employee",
                payment = 75
            },
            ['2'] = {
                name = "Burger Flipper",
                payment = 100
            },
            ['3'] = {
                name = "Manager",
                payment = 125
            },
            ['4'] = {
                name = "Owner",
                isboss = true,
                payment = 150,
                bankAuth = true
            },
        },
    },
}
