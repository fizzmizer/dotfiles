/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>
#include "movestack.c"
/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=12", "Material Design Icons:Regular:pixelsize=20:antialias:true" };
static const char dmenufont[]       = "monospace:size=12";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class          instance    title       tags mask     isfloating   monitor */
	{ "Gimp",         NULL,       NULL,       0,                1,        -1 },
	{ "firefox",      NULL,       NULL,       1 << 2   ,        0,        -1 },
	{ "Thunderbird",  NULL,       NULL,       1 << 1   ,        0,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "/home/antoine/dotfiles/dmenu/run-recent.sh", NULL };

static Key keys[] = {
	/* modifier             key    function        argument */
	{ MODKEY,               32,    spawn,          SHCMD("/home/antoine/dotfiles/scripts/logout") }, // o
	{ MODKEY,               40,    spawn,          SHCMD("/home/antoine/dotfiles/dmenu/run-recent.sh") }, // d
	{ MODKEY|ShiftMask,     25,    spawn,          SHCMD("st -e ranger") }, // Z
	{ MODKEY,               36,    spawn,          SHCMD("st") }, // Return
	{ MODKEY,               53,    spawn,          SHCMD("firefox") }, // x
	{ MODKEY,               56,    togglebar,      {0} },             // b
	{ MODKEY,               44,    focusstack,     {.i = +1 } },      // j                   
	{ MODKEY,               45,    focusstack,     {.i = -1 } },      // k          
	{ MODKEY|ShiftMask,     44,    movestack,      {.i = +1 } },      //J
	{ MODKEY|ShiftMask,     45,    movestack,      {.i = -1 } },      //K
	{ MODKEY,               31,    incnmaster,     {.i = +1 } },      // i          
	{ MODKEY,               33,    incnmaster,     {.i = -1 } },      // p          
	{ MODKEY,               43,    setmfact,       {.f = -0.05} },    // h          
	{ MODKEY,               46,    setmfact,       {.f = +0.05} },    // l          
	{ MODKEY|ShiftMask,     36,    zoom,           {0} },             // Return     
	{ MODKEY,               23,    view,           {0} },             // Tab        
	{ MODKEY|ShiftMask,     24,    killclient,     {0} },             // a          
	{ MODKEY,               28,    setlayout,      {.v = &layouts[0]} }, // t       
	{ MODKEY|ShiftMask,     41,    setlayout,      {.v = &layouts[1]} }, // F       
	{ MODKEY,               47,    setlayout,      {.v = &layouts[2]} }, // m      
	{ MODKEY,               30,    setlayout,      {.v = &layouts[3]} }, // u
	{ MODKEY|ShiftMask,     32,    setlayout,      {.v = &layouts[4]} }, // O
	{ MODKEY,               65,    setlayout,      {0} },             // space      
        { MODKEY,               41,    togglefullscr,  {0} },
	{ MODKEY|ShiftMask,     65,    togglefloating, {0} },             // space      
	{ MODKEY,               19,    view,           {.ui = ~0 } },     // 0          
	{ MODKEY|ShiftMask,     19,    tag,            {.ui = ~0 } },     // 0          
	{ MODKEY,               59,    focusmon,       {.i = -1 } },      // comma      
	{ MODKEY,               60,    focusmon,       {.i = +1 } },      // period     
	{ MODKEY|ShiftMask,     59,    tagmon,         {.i = -1 } },      // comma      
	{ MODKEY|ShiftMask,     60,    tagmon,         {.i = +1 } },      // period     
        { 0,                   122,    spawn,          SHCMD("/usr/bin/pactl set-sink-volume 0 -5% ; kill -44 $(pidof dwmblocks)") },
        { 0,                   121,    spawn,          SHCMD("/usr/bin/pactl set-sink-mute 0 toggle ; kill -44 $(pidof dwmblocks)") },
        { 0,                   123,    spawn,          SHCMD("/usr/bin/pactl set-sink-volume 0 +5% ; kill -44 $(pidof dwmblocks)") },
        { 0,                   233,    spawn,          SHCMD("xbacklight -inc 10 ; kill -45 $(pidof dwmblocks)") },
        { 0,                   232,    spawn,          SHCMD("xbacklight -dec 10 ; kill -45 $(pidof dwmblocks)") },
	TAGKEYS(                10,                    0)                 // 1 
	TAGKEYS(                11,                    1)                 // 2                 
	TAGKEYS(                12,                    2)                 // 3                  
	TAGKEYS(                13,                    3)                 // 4                  
	TAGKEYS(                14,                    4)                 // 5                  
	TAGKEYS(                15,                    5)                 // 6                  
	TAGKEYS(                16,                    6)                 // 7                  
	TAGKEYS(                17,                    7)                 // 8                  
	TAGKEYS(                18,                    8)                 // 9                   
	{ MODKEY|ShiftMask,     38,    quit,           {0} },             // q
};


/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};



/*

24  a                        83  KP_4
56  b                        84  KP_5
54  c                        85  KP_6
40  d                        79  KP_7
26  e                        80  KP_8
41  f                        81  KP_9
42  g                        50  Shift_L
43  h                        10  1
31  i                        11  2
44  j                        12  3
45  k                        13  4
46  l                        14  5
47  m                        15  6
57  n                        16  7
32  o                        17  8
33  p                        18  9
38  q                        19  0
27  r                        10  ampersand
39  s                        11  eacute
28  t                        12  quotedbl
30  u                        13  apostrophe
55  v                        14  parenleft
52  w                        15  section
53  x                        16  egrave
29  y                        17  exclam
25  z                        18  ccedilla
50  Shift_L                  19  agrave
62  Shift_R                  20  parenright
66  Control_L                21  minus
64  Alt_L                    198 XF86AudioMicMute
133 Super_L                  235 XF86Display
108 ISO_Level3_Shift         246 XF86WLAN
105 Control_R                179 XF86Tools
111 Up                       245 XF86Bluetooth
116 Down                     164 XF86Favorites
113 Left                     110 Home
114 Right                    115 End
77  Num_Lock                 118 Insert
87  KP_1                     119 Delete
88  KP_2                     50  Shift_L
89  KP_3                     133 Super_L
*/
