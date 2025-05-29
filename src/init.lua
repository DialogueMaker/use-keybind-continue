--!strict

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");

local packages = script.Parent.roblox_packages;
local React = require(packages.react);
local IDialogueClient = require(packages.dialogue_client_types);

type DialogueClient = IDialogueClient.DialogueClient;

function useKeybindContinue(dialogueClient: DialogueClient, continueDialogueFunction: () -> ())

  React.useEffect(function(): ()
  
    local dialogueClientSettings = dialogueClient:getSettings();
    local continueKey = dialogueClientSettings.keybinds.interactKey;
    local continueKeyGamepad = dialogueClientSettings.keybinds.interactKeyGamepad;

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

  end, {dialogueClient});

end;

return useKeybindContinue;