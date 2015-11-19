//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================

//==== CONSTANTS Begin ===========================================================================
//==== Buttons, Screens' id ====


//==== CONSTANTS End =============================================================================

var BTN_02 = "0:259:109";
var BTN_01 = "0:261:116";
var BTN_RESET = "0:257:102";
var CBOX1 = "0:170:95:75:89:3:2";
var CBOX2 = "0:170:95:80:89:3:2:1:1";

var g_CLOCK = 0;
var g_PAUSE_TAXI = 0;

var g_TIME_TAXI1 = 10*1000;
var g_TIME_TAXI2 = 20*1000;
var g_TIME_TAXI3 = 10*1000;

var g_TIME_BUS = 0;
var g_TIME_BUS1 = 30*1000;
var g_taxi = 0;
var g_timerun_taxi1 = 0;
var g_timerun_taxi2 = 0;
var g_timerun_taxi3 = 0;
var g_timerun_bus1 = 0;


var g_anim_alert = new Animation();
var g_anim_alert2 = new Animation();
var g_anim_taxi = new Animation();
var g_anim_taxi2 = new Animation();
var g_anim_taxi3 = new Animation();

var g_anim_bus = new Animation();


var g_check1 = false; // true la click check box1
var g_checked1 = false; //Luu trang thai checked
var g_check2 = false;
var g_checked2 = false;