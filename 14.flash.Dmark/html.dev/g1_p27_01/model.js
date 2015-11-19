//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================

//==== CONSTANTS Begin ===========================================================================
var MIN_SLIDER = -250;
var MAX_SLIDER = 250;
var STEP_SLIDER = 50;


var MAX_QUESTION_NUM = 10;	// Each game has 10 questions.


//==== CardTypes
var CARD_TYPE_TRAP = 0;
var CARD_TYPE_NUMBER = 1;

//==== Game Mode constants ====
var g_nModeCounter=-1;
var GAME_MODE_INIT = (g_nModeCounter++);		// init => new game => playing => new game
var GAME_MODE_NEW_GAME = (g_nModeCounter++);	// ... setting => new game.
var GAME_MODE_SETTING = (g_nModeCounter++);
var GAME_MODE_FACE_OFF = (g_nModeCounter++);
var GAME_MODE_SHOW_RESULT = (g_nModeCounter++);
var GAME_MODE_NEXT = (g_nModeCounter++);
var GAME_MODE_END_GAME = (g_nModeCounter++);

//==== Buttons, Screens' id ====
var BTN_RESET_ID =  "0:49:225:1:196";
var	BTN_STOP_ID = "0:49:225:3:203";		// Stop
var	BTN_NEXT_ID = "0:49:225:5:210";		// Next
var	BTN_START_ID = "0:49:225:7:217";		// Start
var	BTN_SETTING_ID = "0:49:225:9:224";		// Setting
var BTN_BACK_TO_GAME = "0:59:314:45:255";

var SCREEN_SETTING = "0:59:314";
var SCREEN_HELP = "0:3:189:45:188";


var CARD_BACKS = ["0:3:189:6:133", "0:3:189:8:133", "0:3:189:10:133", "0:3:189:12:133"];
var CARD_FRONTS = ["0:3:189:14:125", "0:3:189:18:125", "0:3:189:22:125", "0:3:189:26:125"];
var CARD_FLIPS = ["0:3:189:14:125:3:124", "0:3:189:18:125:3:124", "0:3:189:22:125:3:124", "0:3:189:26:125:3:124"];
var CARD_FACE= ["0:3:189:14:125:1:121", "0:3:189:18:125:1:121", "0:3:189:22:125:1:121", "0:3:189:26:125:1:121"];
var NUMBER_FACE = ["0:3:189:30:174", "0:3:189:32:174", "0:3:189:34:174", "0:3:189:36:174"];
		
var CARDS_POS_X = {
	2: [-207.3, -3.65],
	3: [-308.9, -105.25, 98.4],
	4: [-410.95, -207.3, -3.65, 200]
};

//==== CONSTANTS End =============================================================================


var MODEL = {
	nCardType: CARD_TYPE_TRAP,	// 0: Card; 1: Number.
	bShowResultPoint: true,
	nCardNum: 2,				// Could be 2, 3, 4 or -1 for random [2,3,4].
	bRandomCardNum: false,
		
	bShowAnswer: true,			// true: show answer; false: not show.
	bGameAutoProcess: false,		// true: auto; false: user has to click to move next.
	
	//==== Below properties are enable only if bGameAutoProcess if true.
	dTimeToShowIssue: 5,		// [0.5, 1, 2, 3,... 10]
	dTimeToShowAnswer: 5		// [0.5, 1, 2, 3,... 10]
};

var g_nSaveGameMode = GAME_MODE_INIT;	// Save current game mode then enter setting screen.
var g_nGameMode = GAME_MODE_INIT;
var g_nCurrentQuestion = 0;		// Default: 0; Reset if new setting or passed 10 questions.
var g_aQuestions = [				// Array of Questions; 10 questions. Each has maximum 4 cards to show.
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
//	[1, 2, 3, 4],
// 	[1, 2, 3, 4]
];

var g_anim = new Animation();	// Cards animation.
//var g_auto = new Animation();	// Autoplay animation.
var g_auto;
var g_bAutoRunning = false;