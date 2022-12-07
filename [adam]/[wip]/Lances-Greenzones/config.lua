Config = {
    Greenzones = {
        ["sspd"] = {
            location = {x = 1837.02, y = 3681.55, z = -10.68},
            diameter = (20 * 3.14159), -- the maximum width of the sphere. this is also the width on ground level. Multiply this by 3.14159 to have a better looking sphere, It's not required to do that however.
            visabilitydistance = 100.0, -- the maximum distance from the circle's shell that the player is able to see. (reccomended distance is 25.0).
            color = {r = 255, g = 0, b = 0, a = 20}, -- The color of the zone's sphere (set a to equal 0 to be transparent).
            restrictions = {
                blockattack = true, -- disables any type of attack and weapon usage.
                speedlimit  = 10.0, -- NOTE: Measurement is in MP/H. Change to a speed if enabled. Else change to nil to disable.
            },
            customrestrictions = {
                -- Enable/Disable run function to loop while inside the zone.
                -- NOTE: All functions will be executed on the side the function is called on.
                -- Meaning if you call this function through the client-side, you must use client-sided methods and natives.

                enabled = true,
                
                -- (customrestriction.loop = true => run function while player is inside.) 
                -- (customrestriction.loop = false => run function when player goes inside.)
                
                loop = false,

                -- Runs while/when player is inside the zone.

                run = function(zone)
                end, 
                
                -- Same as above, but runs once when the player leaves the zone. This also stops the loop of the run function if looping is enabled.
                
                stop = function(zone)
                end, 
            },
        },
    },
}