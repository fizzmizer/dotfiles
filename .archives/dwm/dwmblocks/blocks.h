//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*//*Command*/ /*Update Interval*/	/*Update Signal*/

	{"", "volumedwm",	        0,		10},

	{"", "pacmandwm",	        1200,		15},

	{"", "lightdwm",        	0,		11},

	{"", "batterydwm",    		30,		12},

	{"", "wifidwm",      		300,		13},

	{"", "timedwm",             	1,		14},
	
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = ' ';
