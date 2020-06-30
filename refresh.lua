--[[ ]]--

local tName = "timmy"
local gitRunCmd="github"
local gitArgs=" clone ejayjock/turtle-"..tName

shell.run('cd /')
--shell.run('rm turtle-'..tName)
shell.run(gitRunCmd..gitArgs)
