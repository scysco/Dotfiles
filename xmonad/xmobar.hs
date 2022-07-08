Config	{ font = "xft:Ubuntu:weight=bold:pixelsize=15:antialias=true:hinting=true"
	, additionalFonts = [ "xft:mononoki Nerd Font Mono:pixelsize=20:antialias=true:hinting=true" 
		, "xft:Font Awesome 6 Free Regular:pixelsize=14"
		, "xft:Font Awesome 6 Free Solid:pixelsize=14"
		, "xft:Font Awesome 6 Brands Regular:pixelsize=15"]
		, bgColor  = "#5f5f5f"
		, fgColor  = "#eceff4"
		, alpha = 0
		, position = TopW L 100
		, commands = [Run Cpu
		[ "-t",     "<fc=#81a1c1><fn=3>\xf2db</fn><total>%</fc>"
		, "-p", "3"
			, "-H", "50", "-h", "#ff6961"
			, "-L", "3"
			, "-n", "#81a1c1"
		] 10
		, Run Volume "default" "Master" 
		["--template"     ,"<status> <fc=#88c0d0><volume>%</fc>"
		, "--"
			, "-C"            ,"green"
			, "-c"            ,"red"
			, "-O"            ,""
			, "-o"            ,"<fc=#C1C1C1><fn=3>\xf026</fn></fc>"
			, "-H"            ,"75"
			, "-L"            ,"25"
			, "-h"            ,"<fc=#88c0d0><fn=3>\xf028</fn></fc>"
			, "-m"            ,"<fc=#88c0d0><fn=3>\xf027</fn></fc>"
			, "-l"            ,"<fc=#88c0d0><fn=3>\xf026</fn></fc>"
		] 1

		, Run Memory ["--template", "<fc=#81a1c1><fn=2>\xf0a0</fn> <usedratio>%</fc>"] 10
		, Run Battery 
		["--template"     ,"<acstatus> <left>%"
		,"-L"             ,"10"
			,"-H"             ,"75"
			,"--"
			,"-h"             ,"green"
			,"-m"             ,"yell"
			,"-l"             ,"red"
			,"-i"             ,"<fn=3>\xf0e7</fn>"
			,"--highs"        ,"<fn=3>\xf240</fn>"
			,"--mediums"      ,"<fn=3>\xf242</fn>"
			,"--lows"         ,"<fn=3>\xf243</fn>"
			,"--on-icon-pattern"   ,""
			,"-A"             ,"15"
			,"-a"             ,"notify-send -u critical 'Battery running out!!'"
		] 10
		, Run Date "<fn=2>\xf133</fn> %a %Y-%m-%d <fc=#d8dee9>%H:%M</fc>" "date" 10
		, Run Brightness 
		["--template"     , "<fc=#ebcb8b><fn=2>\xf185</fn> <percent>%</fc>"
		, "--"
			, "-D"            , "intel_backlight"
		] 1
		, Run Com "/home/scysco/.config/xmonad/scripts/padding-icon.sh" [] "trayerpad" 10
		, Run XMonadLog
		]
		, sepChar  = "%"
		, alignSep = "}{"
		, template = "%XMonadLog% }{ %default:Master% | %bright% | %cpu%   %memory% | %date% | %battery% %trayerpad% "
}
