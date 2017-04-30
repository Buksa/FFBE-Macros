package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

basicchecks = require("basicchecks")
clicks = require("clicks")
resconv = require("resconv")

local dailyClickLoc = resconv.convertCoordinates(Location(185, 800), devRez)
local friendDontRequestLoc = resconv.convertCoordinates(Location(160, 935), devRez)

local exitmission = {}

function exitmission.getDailyClick()
    return dailyClickLoc
end

function exitmission.setDailyClick(loc)
    if (loc ~= nil)
    then
        dailyClickLoc = loc
    end
end

function exitmission.getFriendDontRequest()
    return friendDontRequestLoc
end

function exitmission.setFriendDontRequest(loc)
    if (loc ~= nil)
    then
        friendDontRequestLoc = loc
    end
end

--there are a lot of checks for the results below
--because it is a pulsing logo for now this is the best
--solution. if at any point it returns 'true' during a
--single loop of the program it will continue to be true

--some of the below should be moved into advancedchecks
--if we ever need to use it in more than one script
function exitmission.exitMission()
    results = basicchecks.resultsCheck(1)

    while (results == false)
    do
        results = basicchecks.resultsCheck()
    end

    while (results == true)
    do
        clicks.clickNext()
        wait(0.25)

        dailycheck = basicchecks.dailyCheck()

        if (dailycheck == true)
        then
            repeat
                clicks.click(dailyClickLoc)
                wait(1)
                dailycheck = basicchecks.dailyCheck()
            until (dailycheck ~= true)
    
            wait(0.25)
        end

        friendcheck = basicchecks.friendRequestCheck()

        if (friendcheck == true)
        then
            repeat
                clicks.click(friendDontRequestLoc)
                wait(0.25)
                friendcheck = basicchecks.friendRequestCheck()
            until (friendcheck ~= true)
        end

        results = basicchecks.resultsCheck()
    end

    --insert check here to see if we're back at a mission select screen
    return true
end

return exitmission