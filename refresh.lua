--[[ Rev 02 Script cleans all local files and syncs with github repository]]--

local turtleName = "timmy"
local gUser = "ejayjock"

local gitRunCmd="/github.rom/program/github"
local gitArgs=" clone ejayjock/turtle-"..turtleName.." -a "..gUser

shell.run(gitRunCmd..gitArgs)

--shell.run("rm /startup.lua")
--shell.run("mv turtle-timmy/startup.lua /startup.lua")
