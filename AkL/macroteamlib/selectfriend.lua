package.path = package.path .. ';' .. scriptPath() .. '?.lua'

--development resolution
--eventually we'll want this to become a global variable, overwritten by the
--final script
local devRez = Location(720, 1280)
local rezString = devRez:getX() .. 'x' .. devRez:getY()

--local maxscroll = 4

advancedchecks = require("advancedchecks")
--basicchecks = require("basicchecks")
clicks = require("clicks")
drags = require("drags")
resconv = require("resconv")

local bonuspng = Pattern('assets/' .. rezString .. '/bonus-onus.png'):similar(0.8)

local friendRegLoc = resconv.convertCoordinates(Location(0, 330), devRez)
local friendRegHW = resconv.convertCoordinates(Location(160, 950), devRez)
local friendRegion = Region(friendRegLoc:getX(), friendRegLoc:getY(), friendRegHW:getX(), friendRegHW:getY())

local selectfriend = {}

function selectfriend.selectFriend(searchimage, maxscroll)
    if (maxscroll == nil)
    then
        maxscroll = 6
    end

    if (searchimage ~= nil)
        then
            target = false

            for i=1, maxscroll, 1
            do
                target = friendRegion:exists(searchimage, 2)

                if (target)
                then
                    clicks.click(target)
                    break
                else
                    drags.friendsdrag(1)
                end
            end

            if (target ~= true)
            then
                clicks.clickTopFriend()
            end

            wait(1)
            return false
    else
        clicks.clickTopFriend()
        wait(1)

        return true
    end

    return false
end

function selectfriend.selectBonusFriend()
    print(selectfriend.selectFriend(bonuspng))
end

return selectfriend