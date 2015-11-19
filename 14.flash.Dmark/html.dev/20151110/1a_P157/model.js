//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================

//==== CONSTANTS Begin ===========================================================================

//==== Game Mode constants ====
var g_nStep=-1
var GAME_INIT = (g_nStep++);
var GAME_STEP1 = (g_nStep++);
var GAME_STEP2 = (g_nStep++);

var COMPA1_FRAME = 220;
var COMPA2_FRAME = 260;

//==== Buttons, Screens' id ====
var BTN_BACK_ID = "0:83:125";	// 戻る
var BTN_NEXT_ID = "0:80:120";	// 次へ
var BTN_RESET_ID = "0:78:111";	// はじめに戻る
//==== CONSTANTS End =============================================================================


var MODEL = {
};

var g_nGameMode = GAME_INIT;
var g_anim = new Animation();