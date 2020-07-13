/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
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
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,                1,        -1 },
	{ "firefox",  NULL,       NULL,       000000100,        0,        -1 },
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
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	/* modifier             key    function        argument */
	{ MODKEY,               40,    spawn,          {.v = dmenucmd } }, // d
	{ MODKEY,               36,    spawn,          {.v = termcmd } }, // Return
	{ MODKEY,               56,    togglebar,      {0} },             // b
	{ MODKEY,               44,    focusstack,     {.i = +1 } },      // j                   /*
	{ MODKEY,               45,    focusstack,     {.i = -1 } },      // k                   24  a 10  ampersand
	{ MODKEY,               31,    incnmaster,     {.i = +1 } },      // i                   56  b 11  eacute
	{ MODKEY,               33,    incnmaster,     {.i = -1 } },      // p                   54  c 12  quotedbl
	{ MODKEY,               43,    setmfact,       {.f = -0.05} },    // h                   40  d 13  apostrophe
	{ MODKEY,               46,    setmfact,       {.f = +0.05} },    // l                   26  e 14  parenleft
	{ MODKEY|ShiftMask,     36,    zoom,           {0} },             // Return              41  f 15  section
	{ MODKEY,               23,    view,           {0} },             // Tab                 42  g 16  egrave
	{ MODKEY|ShiftMask,     24,    killclient,     {0} },             // a                   43  h 17  exclam
	{ MODKEY,               28,    setlayout,      {.v = &layouts[0]} }, // t                31  i 18  ccedilla
	{ MODKEY,               58,    setlayout,      {.v = &layouts[1]} }, // m                44  j 19  agrave
	{ MODKEY,               41,    setlayout,      {.v = &layouts[2]} }, // f                45  k 20  parenright
	{ MODKEY,               30,    setlayout,      {.v = &layouts[3]} },
	{ MODKEY,               32,    setlayout,      {.v = &layouts[4]} },
	{ MODKEY,               65,    setlayout,      {0} },             // space               46  l 21  minus
	{ MODKEY|ShiftMask,     65,    togglefloating, {0} },             // space               47  m 94  less
	{ MODKEY,               19,    view,           {.ui = ~0 } },     // 0                   57  n 50  Shift_L
	{ MODKEY|ShiftMask,     19,    tag,            {.ui = ~0 } },     // 0                   32  o 24  A
	{ MODKEY,               59,    focusmon,       {.i = -1 } },      // comma               33  p 50  Shift_L
	{ MODKEY,               60,    focusmon,       {.i = +1 } },      // period              38  q 50  Shift_L
	{ MODKEY|ShiftMask,     59,    tagmon,         {.i = -1 } },      // comma               27  r
	{ MODKEY|ShiftMask,     60,    tagmon,         {.i = +1 } },      // period              39  s
	TAGKEYS(                10,                    0)                 // 1                   28  t
	TAGKEYS(                11,                    1)                 // 2                   30  u
	TAGKEYS(                12,                    2)                 // 3                   55  v
	TAGKEYS(                13,                    3)                 // 4                   52  w
	TAGKEYS(                14,                    4)                 // 5                   53  x
	TAGKEYS(                15,                    5)                 // 6                   29  y
	TAGKEYS(                16,                    6)                 // 7                   25  z
	TAGKEYS(                17,                    7)                 // 8                   
	TAGKEYS(                18,                    8)                 // 9                   */
	{ MODKEY|ShiftMask,     38,    quit,           {0} },             // q
};


/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
