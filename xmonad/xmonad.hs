import XMonad
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


myPP :: PP
myPP = defaultPP { ppCurrent = xmobarColor "#073642" "#eee8d5"
                 , ppHidden = xmobarColor "#fdf6e3" ""
                 , ppTitle   = xmobarColor "#fdf6e3" ""
                 , ppVisible = xmobarColor "#073642" "#eee8d5" . wrap " (" ") " . trim
                 , ppUrgent  = xmobarColor "#dc322f" ""
                 , ppSep = " | "
                 , ppWsSep = ""
                 }
myWorkspaces = map (wrap " " " ") ["1:www", "2:shell", "3:emacs", "4:org", "5:mail", "6:music", "7:video", "8:pass", "9:nil"]

myManageHook :: ManageHook
myManageHook = composeAll
             [ (className =? "chromium") --> doShift "1:www"
             , (title =? "shell") --> doShift "2:shell"
             , (title =? "Agenda") --> doShift "4:org"
             , (className =? "Emacs") --> doShift "3:emacs"
             , (className =? "Icedove") --> doShift "5:mail"
             , (title =? "ncmpcpp") --> doShift "6:music"
             , (title =? "keepass") --> doShift "8:pass"
             , (className =? "mplayer") --> doShift "9:nil"]
     
main :: IO ()
main = do
     myXmobar <-  spawnPipe "$HOME/.cabal/bin/xmobar $HOME/.xmobarrc"
     xmonad $ defaultConfig 
        { modMask               = mod4Mask
        , terminal              = "urxvt"
        , normalBorderColor     = "#073642" -- base 02
        , focusedBorderColor    = "#eee8d5" -- base 2
        , manageHook            = myManageHook <+> manageDocks <+> (manageHook defaultConfig) 
        , layoutHook            = avoidStruts $ layoutHook defaultConfig
        , logHook               = dynamicLogWithPP myPP { ppOutput  = hPutStrLn myXmobar}
        , workspaces            = myWorkspaces
	}
        `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_l), spawn "slock")
        , ((mod4Mask .|. shiftMask, xK_e), spawn "emacsclient.emacs-snapshot -c") 
        , ((mod4Mask .|. shiftMask, xK_o), raiseMaybe (spawn "$HOME/code/bin/orgclient -c")                                                      (title =? "Agenda"))
        , ((mod4Mask .|. shiftMask, xK_m), raiseMaybe (runInTerm "-title ncmpc" "ncmpcpp")
                                                      (title =? "ncmpc")) ]
