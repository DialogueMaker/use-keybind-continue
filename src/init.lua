--!strict

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");

local packages = script.Parent.roblox_packages;
local React = require(packages.react);
local IClient = require(packages.client_types);

type Client = IClient.Client;

function useKeybindContinue(client: Client, continueDialogueFunction: () -> ())

  React.useEffect(function(): ()
  
    local clientSettings = client:getSettings();
    local continueKey = clientSettings.keybinds.interactKey;
    local continueKeyGamepad = clientSettings.keybinds.interactKeyGamepad;

    if continueKey or continueKeyGamepad then

      local function checkKeybinds(_, _, keybind: InputObject)

        if keybind and not UserInputService:IsKeyDown(continueKey) and not UserInputService:IsKeyDown(continueKeyGamepad) then

          continueDialogueFunction();

        end;

      end;

      ContextActionService:BindAction("ContinueDialogue", checkKeybinds, false, continueKey, continueKeyGamepad);

      return function()

        ContextActionService:UnbindAction("ContinueDialogue");

      end;

    end;

  end, {client});

end;

return useKeybindContinue;