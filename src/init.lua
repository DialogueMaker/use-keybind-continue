--!strict

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");

local React = require(script.Parent.react);

local IDialogueClient = require(script.Parent["dialogue-client-types"]);

type DialogueClient = IDialogueClient.DialogueClient;

function useKeybindContinue(dialogueClient: DialogueClient, continueDialogueFunction: () -> ())

  React.useEffect(function(): ()
  
    local dialogueClientSettings = dialogueClient:getSettings();
    local continueKey = dialogueClientSettings.keybinds.interactKey;
    local continueKeyGamepad = dialogueClientSettings.keybinds.interactKeyGamepad;

    if continueKey or continueKeyGamepad then

      local function checkKeybinds(keybind: Enum.KeyCode)

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