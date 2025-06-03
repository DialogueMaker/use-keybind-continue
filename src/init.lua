--!strict

local ContextActionService = game:GetService("ContextActionService");

local packages = script.Parent.roblox_packages;
local React = require(packages.react);
local DialogueMakerTypes = require(packages.dialogue_maker_types);

type Client = DialogueMakerTypes.Client;

function useKeybindContinue(client: Client, continueDialogue: () -> ())

  React.useEffect(function(): ()
  
    local clientSettings = client:getSettings();
    local continueKey = clientSettings.keybinds.interactKey;
    local continueKeyGamepad = clientSettings.keybinds.interactKeyGamepad;

    if continueKey or continueKeyGamepad then

      local function checkKeybinds(_, inputState: Enum.UserInputState)

        if inputState == Enum.UserInputState.Begin then

          continueDialogue();

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