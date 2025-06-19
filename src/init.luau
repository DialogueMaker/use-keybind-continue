--!strict

local ContextActionService = game:GetService("ContextActionService");

local packages = script.Parent.roblox_packages;
local React = require(packages.react);
local DialogueMakerTypes = require(packages.DialogueMakerTypes);

type Client = DialogueMakerTypes.Client;

function useKeybindContinue(client: Client, continueDialogue: () -> ())

  React.useEffect(function(): ()
  
    local continueKey = client.settings.keybinds.interactKey;
    local continueKeyGamepad = client.settings.keybinds.interactKeyGamepad;

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

  end, {client :: unknown, continueDialogue});

end;

return useKeybindContinue;