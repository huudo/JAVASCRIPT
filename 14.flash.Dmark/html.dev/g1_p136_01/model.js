//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================

//==== CONSTANTS Begin ===========================================================================
//==== Buttons, Screens' id ====


//==== CONSTANTS End =============================================================================

var BTN_01 = "0:82:145:17:129";
var BTN_02 = "0:82:145:15:122";
var BTN_RESET = "0:82:145:13:115";

var CBOX_1 = "0:82:145:7:94";
var CBOX_2 = "0:82:145:9:101";
var CBOX_3 = "0:82:145:11:108";

var CBOX4_2 = "0:82:145:1:82";
var CBOX4_1 = "0:82:145:3:83";

var MAN_ID = "0:72:77:7:63";
var GIRL_ID = "0:72:77:5:46";
var SECONDE_ID = "0:82:145:19:144:5:135";
var MINUTE_ID = "0:82:145:19:144:4:134";
var HOUR_ID = "0:82:145:19:144:3:133";
var BLURE_ID = "0:82:145:19:144:8:141:1:140";
var XGIRL = -360;
var YGIRL = 210;
var XMAN =  -360;
var YMAN = 210;
var g_BTN_RESET =false;

var g_time_start = 0;
var g_time_end = 120;
var g_anim_man = new Animation();
var g_anim_girl = new Animation();
var g_anim_alert = new Animation();
var g_anim_alert2 = new Animation();
var g_disable= false;

var g_TIME_MAN = 10*1000;// Thoi gian chay cua Nam
var g_TIME_GIRL = 20*1000;
var g_TIME_START_MAN = 0;// Thoi gian bat dau chay
var g_TIME_START_GIRL = 0;// Thoi gian bat dau chay
var g_PAUSE_MAN = -202.8;// Vi tri tai thoi diem bat dau chay	
var g_PAUSE_GIRL = -146.11;
var g_stop = false;// false trang thai dang chay, true la dung
var g_line_girl = 0;
var x_girl = -360;
var y_girl = 210;
var g_end_girl = 360;
var g_line_man = 0;
var x_man = -360;
var y_man = 210;
var g_end_man = 360;
var g_check = false;
var s3=0; s2 =0; s1=0;
var g_run = 0;
