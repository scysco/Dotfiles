import XMonad

import XMonad.Actions.PhysicalScreens
import XMonad.Actions.MouseResize
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

import qualified XMonad.Layout.IndependentScreens as LIS
import XMonad.Layout.Accordion
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation

import XMonad.Hooks.EwmhDesktops

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "kitty"    -- Sets default terminal

myNormColor :: String       -- Border color of normal windows
myNormColor   = "#44475A"

myFocusColor :: String      -- Border color of focused windows
myFocusColor  = "#BD93F9"     

myBorderWidth :: Dimension
myBorderWidth = 1 


main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.dotfiles/xmonad/xmobar.hs" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask = myModMask      -- Rebind Mod to the Super key
    , terminal = myTerminal
    , layoutHook = spacingRaw False (Border 0 10 10 10) True (Border 10 10 10 10) True $ myLayout      -- Use custom layouts
    , manageHook = myManageHook  -- Match on certain windows
    , startupHook = myStartupHook
    , workspaces = myWorkspaces
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-S-=", unGrab *> spawn "scrot -s"        )
    , ("M-]"  , spawn "firefox"                   )
    , ("M-<Return>", spawn "kitty")
    , ("M-e", spawn "kitty -e ranger")
    -- Multimedia Keys
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
    ]

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "nitrogen --restore"
    spawnOnce "picom"
    spawnOnce "sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 255 --height 18"
    spawnOnce "nm-applet"
    spawnOnce "blueman-applet"
--    spawnOnce "gpick"
    spawnOnce "udiskie -A -s -f 'kitty -e ranger'"
    setWMName "LG3D"
    togglevga

togglevga = do
  screencount <- LIS.countScreens
  if screencount > 1
   then spawn "xrandr --output HDMI-1 --off"
   else spawn "xrandr --output HDMI-1 --auto --right-of eDP-1"

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
    --, className =? "Gimp"            --> doFloat
    , className =? "firefox"   --> doShift ( myWorkspaces !! 0 )
    , className =? "Brave-browser"   --> doShift ( myWorkspaces !! 0 )
    , className =? "Google-chrome"   --> doShift ( myWorkspaces !! 0 )
    , className =? "MongoDB Compass" --> doShift ( myWorkspaces !! 2 )
    , className =? "Postman" --> doShift ( myWorkspaces !! 2 )
    , className =? "notion-app"      --> doShift ( myWorkspaces !! 3 )
    , className =? "Spotify" --> doShift ( myWorkspaces !! 4 )
    , className =? "TelegramDesktop" --> doShift ( myWorkspaces !! 5 )
    -- , className =? "mpv"             --> doShift ( myWorkspaces !! 7 )
    -- , className =? "Gimp"            --> doShift ( myWorkspaces !! 8 )
    -- , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
    ]

myLayout  = lessBorders Never $ myDefaultLayout
            where
              myDefaultLayout = withBorder myBorderWidth tall 
                                ||| Main.magnify
                                ||| threeCol
                                ||| tallAccordion
                                ||| Full

tall     = renamed [Replace "tall"]
           $ smartBorders
           $ windowNavigation
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ smartBorders
           $ windowNavigation
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ ResizableTall 1 (3/100) (1/2) []
threeCol = renamed [Replace "ThreeCol"]
           $ smartBorders
           $ windowNavigation
           $ subLayout [] (smartBorders Simplest)
        	 $ magnifiercz' 1.3
           $ limitWindows 12
        	 $ ThreeColMid 1 (3/100) (1/2)
tallAccordion  = renamed [Replace "tallAccordion"]
           $ Accordion
wideAccordion  = renamed [Replace "wideAccordion"]
           $ Mirror Accordion

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    --, ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, win, _] -> [ws, l, win]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""


myWorkspaces =	[ "<fc=#f6f0ef><fn=3>\xf002</fn></fc>"	-- 
		, "<fc=#008080><fn=3>\xf5fc</fn></fc>"	-- 
		, "<fc=#f4d03f><fn=3>\xf5fd</fn></fc>"	-- 
		, "<fc=#ebcb8b><fn=3>\xf02d</fn></fc>"	-- 
		, "<fc=#1DB954><fn=4>\xf1bc</fn></fc>"	-- 
		, "<fc=#179CDE><fn=3>\xf1d8</fn></fc>"	-- 
		, "<fc=#f6f0ef><fn=3>\xf126</fn></fc>"	-- 
		, "<fc=#808b96><fn=4>\xf1b6</fn></fc>"	-- 
		, "<fc=#198dc2><fn=4>\xf838</fn></fc>"]	-- 

