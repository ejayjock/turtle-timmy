-- Code to clean out existing turtle directory and clone the git repository to this local directory. NOTE: This will delete any local files!

local tName = "timmy"
local gitRunCmd="github"
local gitArgs=" clone ejayjock/turtle-"..tName

shell.run('cd /')
shell.run('rm turtle-'..tName)
shell.run(gitRunCmd..gitArgs)
shell.run('cd turtle-'..tName)
