//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================

//==== CONSTANTS Begin ===========================================================================
var MIN_POS = -300;				// Triangle's min position.
var MAX_POS = 300;				// Triangle's max position.
var RULER_COUNT = 6;			// Ruler: from 0 to 6 (RULER_COUNT)
var RULER_STEP = (MAX_POS  - MIN_POS)/RULER_COUNT;
var SQUARE_SIZE_X = 195 * 2;	// AB's length.
var SQUARE_SIZE_Y = 195 * 2;	// AC's length.
var AP_STEP = SQUARE_SIZE_Y/ RULER_COUNT;
var AQ_STEP = SQUARE_SIZE_X/ RULER_COUNT;
//==== Game Mode constants ====

//==== Buttons, Screens' id ====
var TRIANGLE_HANDLER = "0:12:75:7:73:25:72";
var POINT_P = "0:3:29:8:28:13:19:2:18";
var POINT_Q = "0:3:29:8:28:16:22:2:21";

var APQ_CONTAINER = "0:3:29:8:28:1:12:1:11";	// Draw APQ inside this g.

var BTN_MOVE_P_TO_A = "0:12:75:1:36";
var BTN_STOP = "0:12:75:3:43";
var BTN_START = "0:12:75:5:50";


var ARROW_Q = "0:3:29:8:28:19:25";
var ARROW_P = "0:3:29:8:28:21:27";
//==== CONSTANTS End =============================================================================


var MODEL = {
	bShowArrows: true,	// Show/Hide arrows.
	AP: 2				// Ruler position.
};

var g_anim = new Animation();