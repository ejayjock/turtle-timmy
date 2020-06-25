--[[ Rev02
Script cleans all local files and syncs with github repository]]--

local gUser = "ejayjock"
local gRepo = "turtle-timmy"
local gBranch = "master"
local gPath=""

local usage = [[
 github <user> <repo> [path] [remote path] [branch]
 Remote path defaults to the root of the repo.
 Path defaults to the download folder.
 Branch defaults to master.
 If you want to leave an option empty use a dot.
 Example: github johnsmith hello-world . foo
 Everything inside the directory foo will be
 downloaded to downloads/hello-world/.
  ]]
local blackList = [[
@blacklistedfile
]]

local title = "Github Repo Downloader "
local fileList = {dirs={},files={}}
local x , y = term.getSize()

-- GUI
function printTitle()
        local line = 2
        term.setCursorPos(1,line)
        for i = 2, x, 1 do write("-") end
        term.setCursorPos((x-title:len())/2,line+1)
        print(title)
        for i = 2, x, 1 do write("-") end
end

function writeCenter( str )
        term.clear()
        printTitle()
        term.setCursorPos((x-str:len())/2-1,y/2-1)
        for i = -1, str:len(), 1 do write("-") end
        term.setCursorPos((x-str:len())/2-1,y/2)
        print("|"..str.."|")
        term.setCursorPos((x-str:len())/2-1,y/2+1)
        for i = -1, str:len(), 1 do write("-") end
end

function printUsage()
        local str = "Press space key to continue"
        term.clear()
        printTitle()
        term.setCursorPos(1,y/2-4)
        print(usage)
        term.setCursorPos((x-str:len())/2,y/2+7)
        print(str)
        while true do
                local event, param1 = os.pullEvent("key")
                if param1 == 57 then
                        sleep(0)
                        break
                end
        end
        term.clear()
        term.setCursorPos(1,1)
end

-- Download File
function downloadFile( path, url, name )
        writeCenter("Downloading File: "..name)
        dirPath = path:gmatch('([%w%_%.% %-%+%,%;%:%*%#%=%/]+)/'..name..'$')()
        if dirPath ~= nil and not fs.isDir(dirPath) then fs.makeDir(dirPath) end
        local content = http.get(url)
        local file = fs.open(path,"w")
        file.write(content.readAll())
        file.close()
end

-- Get Directory Contents
function getGithubContents( path )
        local pType, pPath, pName, checkPath = {}, {}, {}, {}
        local response = http.get("https://api.github.com/repos/"..gUser.."/"..gRepo.."/contents/"..path.."/?ref="..gBranch)
        if response then
                response = response.readAll()
                if response ~= nil then
                        for str in response:gmatch('"type":"(%w+)"') do table.insert(pType, str) end
                        for str in response:gmatch('"path":"([^\"]+)"') do table.insert(pPath, str) end
                        for str in response:gmatch('"name":"([^\"]+)"') do table.insert(pName, str) end
                end
        else
                writeCenter( "Error: Can't resolve URL" )
                sleep(2)
                term.clear()
                term.setCursorPos(1,1)
                error()
        end
        return pType, pPath, pName
end

-- Blacklist Function
function isBlackListed( path )
        if blackList:gmatch("@"..path)() ~= nil then
                return true
        end
end

-- Download Manager
function downloadManager( path )
        local fType, fPath, fName = getGithubContents( path )
        for i,data in pairs(fType) do
                if data == "file" then
                        checkPath = http.get("https://raw.github.com/"..gUser.."/"..gRepo.."/"..gBranch.."/"..fPath[i])
                        if checkPath == nil then

                                fPath[i] = fPath[i].."/"..fName[i]
                        end
                        local path = "downloads/"..gRepo.."/"..fPath[i]
                        if gPath ~= "" then path = gPath.."/"..gRepo.."/"..fPath[i] end
                        if not fileList.files[path] and not isBlackListed(fPath[i]) then
                                fileList.files[path] = {"https://raw.github.com/"..gUser.."/"..gRepo.."/"..gBranch.."/"..fPath[i],fName[i]}
                        end
                end
        end
        for i, data in pairs(fType) do
                if data == "dir" then
                        local path = "downloads/"..gRepo.."/"..fPath[i]
                        if gPath ~= "" then path = gPath.."/"..gRepo.."/"..fPath[i] end
                        if not fileList.dirs[path] then
                                writeCenter("Listing directory: "..fName[i])
                                fileList.dirs[path] = {"https://raw.github.com/"..gUser.."/"..gRepo.."/"..gBranch.."/"..fPath[i],fName[i]}
                                downloadManager( fPath[i] )
                        end
                end
        end
end

-- Main Function
function main( path )
        writeCenter("Connecting to Github")
        downloadManager(path)
        for i, data in pairs(fileList.files) do
                downloadFile( i, data[1], data[2] )
        end
        writeCenter("Download completed")
        sleep(2,5)
        term.clear()
        term.setCursorPos(1,1)
end

-- Parse User Input
function parseInput( user, repo , dldir, path, branch )
        if path == nil then path = "" end
        if branch ~= nil then gBranch = branch end
        if repo == nil then printUsage()
        else
                gUser = user
                gRepo = repo
                if dldir ~= nil then gPath = dldir end
                main( path )
        end
end

-- Clean the file space for everything except refresh.Language
function rmExcept(exception)
  files=fs.list(".")
  for i = 1, #files do
    if files[i] ~= exception and files[i] ~= "rom" then
      shell.run("rm "..files[i])
    end
  end
end

-- Clean up download space
if fs.exists("/downloads") then
  print("Removing previously existing downloads directory.")
  shell.run("rm downloads")
end

-- Import Code From Github
parseInput( gUser, gRepo, nil, nil, branch)

-- Remove the refresh.lua script, copy contents of dl directory, and rm downloads
if fs.exists("downloads/"..gRepo.."/refresh.lua") then
  print("Sync Complete...Cleaning the file space")
  rmExcept("downloads")
  print("Moving files from downloaded gitHub folder to root")
  shell.run("cp downloads/"..gRepo.."/* .")
  print("Removing the downloads folder")
  shell.run("rm downloads")
else
  print("Error in syncing gitHub Repo.")
end
