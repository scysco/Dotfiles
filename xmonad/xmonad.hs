import XMonad

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

import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing

import XMonad.Hooks.EwmhDesktops

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "urxvt"    -- Sets default terminal

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask = myModMask      -- Rebind Mod to the Super key
    , terminal = myTerminal
    , layoutHook = spacingWithEdge 10 $ myLayout      -- Use custom layouts
    , manageHook = myManageHook  -- Match on certain windows
    , startupHook = myStartupHook
    , workspaces = myWorkspaces
    }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-S-=", unGrab *> spawn "scrot -s"        )
    , ("M-]"  , spawn "firefox"                   )
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
          spawnOnce "gpick"
          setWMName "LG3D"



myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]

myLayout = lessBorders Never $ tiled ||| Mirror tiled ||| Full ||| threeCol 
  where
    threeCol 
			= renamed [Replace "ThreeCol"]
        	$ magnifiercz' 1.3
        	$ ThreeColMid nmaster delta ratio 
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    --, ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
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
		, "<fc=#f6f0ef><fn=3>\xf120</fn></fc>"	-- 
		, "<fc=#1DB954><fn=4>\xf1bc</fn></fc>"	-- 
		, "<fc=#179CDE><fn=3>\xf1d8</fn></fc>"	-- 
		, "<fc=#f6f0ef><fn=3>\xf126</fn></fc>"	-- 
		, "<fc=#808b96><fn=4>\xf1b6</fn></fc>"	-- 
		, "<fc=#198dc2><fn=3>\xf7c0</fn></fc>"]	-- 





