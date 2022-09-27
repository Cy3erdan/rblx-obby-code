local LocalDoor = game.ReplicatedStorage.DLSFridge
local clone = LocalDoor:Clone()
local Fridge = clone.DLSFridge.Fridge
local FridgeF = clone.DLSFridge.FridgeFinal
clone.Parent = game.Workspace

local TweenService = game:GetService("TweenService") -- smooth animation

local hinge1 = FridgeF.FHinge1
local hinge2 = FridgeF.FHinge2
local prompt = FridgeF.TOP.Attachment.ProximityPrompt


local doorCooldown = 3

local goalOpen1 = {}
goalOpen1.CFrame = hinge1.CFrame * CFrame.Angles(0, math.rad(-90), 0) --getting current hinge CFrame and multiplying it so that it rotates it by 90 degrees. Converted to radians
local goalClose1 = {}
goalClose1.CFrame = hinge1.CFrame * CFrame.Angles(0, 0, 0)

local goalOpen2 = {}
goalOpen2.CFrame = hinge2.CFrame * CFrame.Angles(0, math.rad(90), 0) --getting current hinge CFrame and multiplying it so that it rotates it by 90 degrees. Converted to radians
local goalClose2 = {}
goalClose2.CFrame = hinge2.CFrame * CFrame.Angles(0, 0, 0) --does the same thing but closes the door now

local tweenInfo = TweenInfo.new(.7) --takes one second for the tween to open and close
local tweenOpen1 = TweenService:Create(hinge1, tweenInfo, goalOpen1) --we want to tween/rotate the hinge
local tweenClose1 = TweenService:Create(hinge1, tweenInfo, goalClose1)
local tweenOpen2 = TweenService:Create(hinge2, tweenInfo, goalOpen2)
local tweenClose2 = TweenService:Create(hinge2, tweenInfo, goalClose2)

local opentable = {}
local opentimes = 0

prompt.Triggered:Connect(function()
	if prompt.ActionText == "Open" then
		opentimes += 1
		local opentime = opentimes --to make sure it doesn't get the current number after it is opened again
		opentable[opentime] = true
		tweenOpen1:Play()
		tweenOpen2:Play()
		prompt.ActionText = "Close"
		wait(doorCooldown)
		if opentable[opentime] then
			tweenClose1:Play()
			tweenClose2:Play()
			prompt.ActionText = "Open"
		end
	elseif prompt.ActionText == "Close" then
		opentable[opentimes] = false
		tweenClose1:Play()
		tweenClose2:Play()
		prompt.ActionText = "Open"
	end
end)
