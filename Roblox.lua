copas = require "copas"
socket = require "socket"
http = require "copas.http"
requests = require "requests"

SpecNotification = false

function main()
	repeat wait(0) until isSampAvailable()
	lua_thread.create(Anti_Public)
end

GITHUB_RAW_URL = "https://raw.githubusercontent.com/Hn207nH/HWID/refs/heads/main/Licence.txt"
AntiPublic = false
allowedNames = {}
hasWarned = false

function FetchAllowedNames()
    print(" HWID [+] Darhale Baresi Licence Shoma..")
    
     response = requests.get({url = GITHUB_RAW_URL})
    
    if response and response.status_code == 200 and #response.text > 0 then
        for line in response.text:gmatch("[^\r\n]+") do
             cleanName = line:gsub("%s+", "")
            if #cleanName > 0 then
                table.insert(allowedNames, string.lower(cleanName))
            end
        end
        print("[+] Licence Shoma Tayid Shod ! , Channel: @ArtOfCheat")
    else
        print("[-] Khata Dar Server ( Licence Ha Natavanestan Load Beshan.. )")
    end
end

FetchAllowedNames()

function Anti_Public()
    while true do
        wait(1000)
        
        if SpecNotification then 
            
             result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            if result then
                 myName = sampGetPlayerNickname(id)
                if myName then
                     myLowerName = string.lower(myName)
                     found = false
                    
                        for i = 1, #allowedNames do
	                        allowedName = allowedNames[i]
                        if myLowerName:find(allowedName, 1, true) then
                            found = true
                            break
                        end
                    end
                    
                    if found then
                        if not AntiPublic then
                            AntiPublic = true
                            hasWarned = false
                            sampAddChatMessage("{111111}[ {FFFFFF}@{FF00FF}Art{00FFFF}Of{FFFF00}Cheat {111111}] {00FF00}[Anti-Public] {FFFFFF}Licence shoma tayid shod!", -1)
                        end
                        
                        
                    else
					
                        AntiPublic = false
                        
                        if not hasWarned then
                            sampAddChatMessage("{111111}[ {FFFFFF}@{FF00FF}Art{00FFFF}Of{FFFF00}Cheat {111111}] {FF0000}[Anti-Public] {FFFFFF}Shoma bayad {00FF66}Licence {FFFFFF}cheat ro dashte bashid !", -1)
							sampAddChatMessage("{FFFFFF}Baraye Kharid Cheat, Dar Telegram Payam Bedid : {AA00AA}@NishaLom {FFFFFF}& {00AAAA}@HiradForodad", 0xFF000)
                            hasWarned = true
                        end
                        
                        SpecNotification = false
                    end
                end
            end
            
        else
		
            if AntiPublic then
                AntiPublic = false
            end
            hasWarned = false
		end
    end
end
