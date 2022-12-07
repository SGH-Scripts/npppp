local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['testwebhook'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['playermoney'] = 'https://discord.com/api/webhooks/1049290629882052628/w0T6_WfDr8f3KPWALYjwoz7ANgwGZy-cmIezQY9CByKMJBRhPH8dNkM5UsCYH_DZGl9c',
    ['playerinventory'] = 'https://discord.com/api/webhooks/1049290629882052628/w0T6_WfDr8f3KPWALYjwoz7ANgwGZy-cmIezQY9CByKMJBRhPH8dNkM5UsCYH_DZGl9c',
    ['robbing'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['cuffing'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['drop'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['trunk'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['stash'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['glovebox'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['banking'] = 'https://discord.com/api/webhooks/1049290629882052628/w0T6_WfDr8f3KPWALYjwoz7ANgwGZy-cmIezQY9CByKMJBRhPH8dNkM5UsCYH_DZGl9c',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/1049290629882052628/w0T6_WfDr8f3KPWALYjwoz7ANgwGZy-cmIezQY9CByKMJBRhPH8dNkM5UsCYH_DZGl9c',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/1049290629882052628/w0T6_WfDr8f3KPWALYjwoz7ANgwGZy-cmIezQY9CByKMJBRhPH8dNkM5UsCYH_DZGl9c',
    ['shops'] = 'https://discord.com/api/webhooks/1049290629882052628/w0T6_WfDr8f3KPWALYjwoz7ANgwGZy-cmIezQY9CByKMJBRhPH8dNkM5UsCYH_DZGl9c',
    ['dealers'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['storerobbery'] = 'https://discord.com/api/webhooks/1049290745472892978/LXNwiowv7eSW-1ak38iKDvY8NET2kKQ-UII9gVLKDnREiBRO1yaM89TjgyIn2A_DDbrV',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/1049290745472892978/LXNwiowv7eSW-1ak38iKDvY8NET2kKQ-UII9gVLKDnREiBRO1yaM89TjgyIn2A_DDbrV',
    ['powerplants'] = 'https://discord.com/api/webhooks/1049290745472892978/LXNwiowv7eSW-1ak38iKDvY8NET2kKQ-UII9gVLKDnREiBRO1yaM89TjgyIn2A_DDbrV',
    ['death'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['joinleave'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['ooc'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['report'] = 'https://discord.com/api/webhooks/1049290851605561475/dxH7GulOYkTTpynLhUjWE_HQcyrd8PIg7pd8NnENrEB471ptRudjy8W3V7mMenvyftg4',
    ['me'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['pmelding'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['112'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['bans'] = 'https://discord.com/api/webhooks/1049290919842684938/7DsXpBzKdX213rS_jLKqCsHrKYrddwUEWxJQO27QrazjgVl_2veU2Edazni4wbAMq5-C',
    ['anticheat'] = 'https://discord.com/api/webhooks/1049290919842684938/7DsXpBzKdX213rS_jLKqCsHrKYrddwUEWxJQO27QrazjgVl_2veU2Edazni4wbAMq5-C',
    ['weather'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['moneysafes'] = 'https://discord.com/api/webhooks/1049290745472892978/LXNwiowv7eSW-1ak38iKDvY8NET2kKQ-UII9gVLKDnREiBRO1yaM89TjgyIn2A_DDbrV',
    ['bennys'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['bossmenu'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['robbery'] = 'https://discord.com/api/webhooks/1049290745472892978/LXNwiowv7eSW-1ak38iKDvY8NET2kKQ-UII9gVLKDnREiBRO1yaM89TjgyIn2A_DDbrV',
    ['casino'] = 'https://discord.com/api/webhooks/1049290745472892978/LXNwiowv7eSW-1ak38iKDvY8NET2kKQ-UII9gVLKDnREiBRO1yaM89TjgyIn2A_DDbrV',
    ['traphouse'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['911'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['palert'] = 'https://discord.com/api/webhooks/1049290352047181824/WBt0BZNo3ooj7vgwsyX9TgD0B5sysLSnOS97isOzvjW7afsrpNBYp_YdfRuDxE99vjLx',
    ['house'] = 'https://discord.com/api/webhooks/1049290745472892978/LXNwiowv7eSW-1ak38iKDvY8NET2kKQ-UII9gVLKDnREiBRO1yaM89TjgyIn2A_DDbrV',
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'QBCore Logs',
                ['icon_url'] = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670',
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
