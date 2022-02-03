--------------------------------------------------------------------------------
------------------------------------------------- Ezt ne töröld szeretném ha a script egyedisége meg maradna!  -------------
--------------------------------------------------------------------------------

    local szoveg = [[^7
           _   _ _______ _____   __      _______  _   _ 
     /\   | \ | |__   __|_   _|  \ \    / /  __ \| \ | |
    /  \  |  \| |  | |    | |_____\ \  / /| |__) |  \| |
   / /\ \ | . ` |  | |    | |______\ \/ / |  ___/| . ` |
  / ____ \| |\  |  | |   _| |_      \  /  | |    | |\  |
 /_/    \_\_| \_|  |_|  |_____|      \/   |_|    |_| \_| 
                    DRAZOX & s00kin
                    V2.0
                    github.com/drazoxXD
                    github.com/s00kin
            ]]
--wait(20000)
print(szoveg)
--credit a készítőnek mindig jól esik!
--------------------------------------------------------------------------------
------------------------------------------------- Event-ek NE EDITELD ---------------
--------------------------------------------------------------------------------
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)

    local player = source
    local name, setKickReason, deferrals = name, setKickReason, deferrals;
    local ipIdentifier --  ip 
    local nick = GetPlayerName(source) -- steam név
    local steam = GetPlayerIdentifier(source, 0) -- steam hex
    local identifiers = GetPlayerIdentifiers(player) -- IP 
    local discord = 'Nem találtunk discord-ot!' -- [Not found] = discord nem csatlakozott a fivem-hez!

    deferrals.defer()
    Wait(0)
    deferrals.update(string.format("Szia "..nick.." , VPN Keresése és IP átnézése!", name)) -- csatlakozás oka
    Wait(10000)
    for _, v in pairs(identifiers) do
        if string.find(v, "ip") then
            ipIdentifier = v:sub(4)
        end
        if string.find(v, "discord") then
            discord = v
        end
    end
    Wait(0)    
    if not ipIdentifier then
        deferrals.done("Nem találtam az IP-d.")
    else
        PerformHttpRequest("http://ip-api.com/json/" .. ipIdentifier .. "?fields=proxy", function(err, text, headers) -- ip átnézése
            if tonumber(err) == 200 then
                local tbl = json.decode(text)
                if tbl["proxy"] == false then
                        deferrals.done()
                else
                  
sendlogstodiscord(nick, steam,ipIdentifier,discord )
                    deferrals.done("\n TE egy VPN-t használsz vagy nem Magyar IP-n keresztul csatlakozol! \n Felhasznalonev: ".. nick.." \n IP:" ..ipIdentifier.."\n") -- oka amiért használsz VPN-t
                end
            else
                deferrals.done("HIBA! Csatlakozz újra!")
            end
        end)
    end
end)
--------------------------------------------------------------------------------
-------------------------------------------------  Funkciók  ------------------
--------------------------------------------------------------------------------
function sendlogstodiscord(source, steam, ip,discord) 
-- kivételesen editelheted!
--local draz_webhook = "https://discord.com/api/webhooks/916693/......" -- webhook log-oknak

     local draz_time = os.date("%c | github.com/drazoxXD") --igazából erre már én se emlékszem! MI A TÖK EZ?!?!?!

            local draz_embed = {
        {
            ["color"] = 23295, -- színe az üzinek
            ["title"] = "[drazox]ANTI-VPN V2", -- webhook szöveg
            ["description"] = "\n **[Felhasználó]:** `"..source.."` \n **[Steam]:**` " ..steam.."` \n **[IP]:**` " ..ip.."`\n **[Discord]:**`"..discord.."`\n",
            ["footer"] = {
                ["text"] = draz_time
            },
        }
    }
       PerformHttpRequest(config.webhook, function(err, text, headers) end, 'POST', json.encode({username = 'anti-vpn', embeds = draz_embed}), { ['Content-Type'] = 'application/json' })
end




--if config.kiveteleshasznalata == 'true' then
    --if ipIdentifier == config.kivetelesip then
    --deferrals.done()
    --end
--else
