//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================

//==== CONSTANTS Begin ===========================================================================

//==== Game Mode constants ====
var ID_LEVEL1_RIGHT = "0:549:53:21:13";
var ID_LEVEL2_RIGHT = "0:549:53:75:21";
var ID_LEVEL3_RIGHT = "0:549:53:183:29";
var ID_LEVEL4_RIGHT = "0:549:53:399:35";

var ID_LEVEL1_LEFT = "0:549:53:3:9";
var ID_LEVEL2_LEFT = "0:549:53:39:17";
var ID_LEVEL3_LEFT = "0:549:53:111:25";
var ID_LEVEL4_LEFT = "0:549:53:255:32";
var a = 0;
var t= 0;
var Level1_right = new Array("0:549:53:21:13:1:12","0:549:53:21:13:3:12","0:549:53:21:13:5:12",
							"0:549:53:21:13:7:12","0:549:53:21:13:9:12","0:549:53:21:13:11:12",
							"0:549:53:21:13:13:12","0:549:53:21:13:15:12","0:549:53:21:13:17:12");//9 hinh

var Level2_right= new Array("0:549:53:75:21:1:20","0:549:53:75:21:3:20","0:549:53:75:21:5:20","0:549:53:75:21:7:20",
							"0:549:53:75:21:9:20","0:549:53:75:21:11:20","0:549:53:75:21:13:20","0:549:53:75:21:15:20",
							"0:549:53:75:21:17:20","0:549:53:75:21:19:20","0:549:53:75:21:21:20","0:549:53:75:21:23:20",
							"0:549:53:75:21:25:20","0:549:53:75:21:27:20","0:549:53:75:21:29:20","0:549:53:75:21:31:20",
							"0:549:53:75:21:33:20","0:549:53:75:21:35:20");//35 Hinh

var Level3_right = new Array("0:549:53:183:29:1:28","0:549:53:183:29:3:28","0:549:53:183:29:5:28","0:549:53:183:29:7:28",
							"0:549:53:183:29:9:28","0:549:53:183:29:11:28","0:549:53:183:29:13:28","0:549:53:183:29:15:28",
							"0:549:53:183:29:17:28","0:549:53:183:29:19:28","0:549:53:183:29:21:28","0:549:53:183:29:23:28",
							"0:549:53:183:29:25:28","0:549:53:183:29:27:28","0:549:53:183:29:29:28","0:549:53:183:29:31:28",
							"0:549:53:183:29:33:28","0:549:53:183:29:35:28",
							"0:549:53:183:29:37:28","0:549:53:183:29:39:28","0:549:53:183:29:41:28","0:549:53:183:29:43:28",
							"0:549:53:183:29:45:28","0:549:53:183:29:47:28","0:549:53:183:29:49:28","0:549:53:183:29:51:28",
							"0:549:53:183:29:53:28","0:549:53:183:29:55:28","0:549:53:183:29:57:28","0:549:53:183:29:59:28",
							"0:549:53:183:29:61:28","0:549:53:183:29:63:28","0:549:53:183:29:65:28","0:549:53:183:29:67:28",
							"0:549:53:183:29:69:28","0:549:53:183:29:71:28"); //71 hinh


var Level4_right = new Array("0:549:53:399:35:1:34","0:549:53:399:35:3:34","0:549:53:399:35:5:34","0:549:53:399:35:7:34",
							"0:549:53:399:35:9:34","0:549:53:399:35:11:34","0:549:53:399:35:13:34","0:549:53:399:35:15:34",
							"0:549:53:399:35:17:34","0:549:53:399:35:19:34","0:549:53:399:35:21:34","0:549:53:399:35:23:34",
							"0:549:53:399:35:25:34","0:549:53:399:35:27:34","0:549:53:399:35:29:34","0:549:53:399:35:31:34",
							"0:549:53:399:35:33:34","0:549:53:399:35:35:34",
							"0:549:53:399:35:37:34","0:549:53:399:35:39:34","0:549:53:399:35:41:34","0:549:53:399:35:43:34",
							"0:549:53:399:35:45:34","0:549:53:399:35:47:34","0:549:53:399:35:49:34","0:549:53:399:35:51:34",
							"0:549:53:399:35:53:34","0:549:53:399:35:55:34","0:549:53:399:35:57:34","0:549:53:399:35:59:34",
							"0:549:53:399:35:61:34","0:549:53:399:35:63:34","0:549:53:399:35:65:34","0:549:53:399:35:67:34",
							"0:549:53:399:35:69:34","0:549:53:399:35:71:34",
							"0:549:53:399:35:73:34","0:549:53:399:35:75:34","0:549:53:399:35:77:34","0:549:53:399:35:79:34",
							"0:549:53:399:35:81:34","0:549:53:399:35:83:34","0:549:53:399:35:85:34","0:549:53:399:35:87:34",
							"0:549:53:399:35:89:34","0:549:53:399:35:91:34","0:549:53:399:35:93:34","0:549:53:399:35:95:34",
							"0:549:53:399:35:97:34","0:549:53:399:35:99:34","0:549:53:399:35:101:34","0:549:53:399:35:103:34",
							"0:549:53:399:35:105:34","0:549:53:399:35:107:34",
							"0:549:53:399:35:109:34","0:549:53:399:35:111:34","0:549:53:399:35:113:34","0:549:53:399:35:115:34",
							"0:549:53:399:35:117:34","0:549:53:399:35:119:34","0:549:53:399:35:121:34","0:549:53:399:35:123:34",
							"0:549:53:399:35:125:34","0:549:53:399:35:127:34","0:549:53:399:35:129:34","0:549:53:399:35:130:34",
							"0:549:53:399:35:131:34","0:549:53:399:35:133:34","0:549:53:399:35:135:34","0:549:53:399:35:137:34",
							"0:549:53:399:35:139:34","0:549:53:399:35:141:34","0:549:53:399:35:143:34"
							); //143 hinh`

var Level1_left = new Array("0:549:53:3:9:1:8","0:549:53:3:9:3:8","0:549:53:3:9:5:8",
							"0:549:53:3:9:7:8","0:549:53:3:9:9:8","0:549:53:3:9:11:8",
							"0:549:53:3:9:13:8","0:549:53:3:9:15:8","0:549:53:3:9:17:8");

var Level2_left = new Array("0:549:53:39:17:1:16","0:549:53:39:17:3:16","0:549:53:39:17:5:16","0:549:53:39:17:7:16",
							"0:549:53:39:17:9:16","0:549:53:39:17:11:16","0:549:53:39:17:13:16","0:549:53:39:17:15:16",
							"0:549:53:39:17:17:16","0:549:53:39:17:19:16","0:549:53:39:17:21:16","0:549:53:39:17:23:16",
							"0:549:53:39:17:25:16","0:549:53:39:17:27:16","0:549:53:39:17:29:16","0:549:53:39:17:31:16",
							"0:549:53:39:17:33:16","0:549:53:39:17:35:16");

var Level3_left = new Array("0:549:53:111:25:1:24","0:549:53:111:25:3:24","0:549:53:111:25:5:24","0:549:53:111:25:7:24",
							"0:549:53:111:25:9:24","0:549:53:111:25:11:24","0:549:53:111:25:13:24","0:549:53:111:25:15:24",
							"0:549:53:111:25:17:24","0:549:53:111:25:19:24","0:549:53:111:25:21:24","0:549:53:111:25:23:24",
							"0:549:53:111:25:25:24","0:549:53:111:25:27:24","0:549:53:111:25:29:24","0:549:53:111:25:31:24",
							"0:549:53:111:25:33:24","0:549:53:111:25:35:24",
							"0:549:53:111:25:37:24","0:549:53:111:25:39:24","0:549:53:111:25:41:24","0:549:53:111:25:43:24",
							"0:549:53:111:25:45:24","0:549:53:111:25:47:24","0:549:53:111:25:49:24","0:549:53:111:25:51:24",
							"0:549:53:111:25:53:24","0:549:53:111:25:55:24","0:549:53:111:25:57:24","0:549:53:111:25:59:24",
							"0:549:53:111:25:61:24","0:549:53:111:25:63:24","0:549:53:111:25:65:24","0:549:53:111:25:67:24",
							"0:549:53:111:25:69:24","0:549:53:111:25:71:24");

var Level4_left = new Array("0:549:53:255:32:1:31","0:549:53:255:32:3:31","0:549:53:255:32:5:31","0:549:53:255:32:7:31",
							"0:549:53:255:32:9:31","0:549:53:255:32:11:31","0:549:53:255:32:13:31","0:549:53:255:32:15:31",
							"0:549:53:255:32:17:31","0:549:53:255:32:19:31","0:549:53:255:32:21:31","0:549:53:255:32:23:31",
							"0:549:53:255:32:25:31","0:549:53:255:32:27:31","0:549:53:255:32:29:31","0:549:53:255:32:31:31",
							"0:549:53:255:32:33:31","0:549:53:255:32:35:31",
							"0:549:53:255:32:37:31","0:549:53:255:32:39:31","0:549:53:255:32:41:31","0:549:53:255:32:43:31",
							"0:549:53:255:32:45:31","0:549:53:255:32:47:31","0:549:53:255:32:49:31","0:549:53:255:32:51:31",
							"0:549:53:255:32:53:31","0:549:53:255:32:55:31","0:549:53:255:32:57:31","0:549:53:255:32:59:31",
							"0:549:53:255:32:61:31","0:549:53:255:32:63:31","0:549:53:255:32:65:31","0:549:53:255:32:67:31",
							"0:549:53:255:32:69:31","0:549:53:255:32:71:31",
							"0:549:53:255:32:73:31","0:549:53:255:32:75:31","0:549:53:255:32:77:31","0:549:53:255:32:79:31",
							"0:549:53:255:32:81:31","0:549:53:255:32:83:31","0:549:53:255:32:85:31","0:549:53:255:32:87:31",
							"0:549:53:255:32:89:31","0:549:53:255:32:91:31","0:549:53:255:32:93:31","0:549:53:255:32:95:31",
							"0:549:53:255:32:97:31","0:549:53:255:32:99:31","0:549:53:255:32:101:31","0:549:53:255:32:103:31",
							"0:549:53:255:32:105:31","0:549:53:255:32:107:31",
							"0:549:53:255:32:109:31","0:549:53:255:32:111:31","0:549:53:255:32:113:31","0:549:53:255:32:115:31",
							"0:549:53:255:32:117:31","0:549:53:255:32:119:31","0:549:53:255:32:121:31","0:549:53:255:32:123:31",
							"0:549:53:255:32:125:31","0:549:53:255:32:127:31","0:549:53:255:32:129:31","0:549:53:255:32:130:31",
							"0:549:53:255:32:131:31","0:549:53:255:32:133:31","0:549:53:255:32:135:31","0:549:53:255:32:137:31",
							"0:549:53:255:32:139:31","0:549:53:255:32:141:31","0:549:53:255:32:143:31"
							);

var Level1_right2 = new Array("0:3:43:21:13:1:12","0:3:43:21:13:3:12","0:3:43:21:13:5:12",
							"0:3:43:21:13:7:12","0:3:43:21:13:9:12","0:3:43:21:13:11:12",
							"0:3:43:21:13:13:12","0:3:43:21:13:15:12","0:3:43:21:13:17:12");//9 hinh

var Level2_right2= new Array("0:3:43:75:21:1:20","0:3:43:75:21:3:20","0:3:43:75:21:5:20","0:3:43:75:21:7:20",
							"0:3:43:75:21:9:20","0:3:43:75:21:11:20","0:3:43:75:21:13:20","0:3:43:75:21:15:20",
							"0:3:43:75:21:17:20","0:3:43:75:21:19:20","0:3:43:75:21:21:20","0:3:43:75:21:23:20",
							"0:3:43:75:21:25:20","0:3:43:75:21:27:20","0:3:43:75:21:29:20","0:3:43:75:21:31:20",
							"0:3:43:75:21:33:20","0:3:43:75:21:35:20");//35 Hinh

var Level3_right2 = new Array("0:3:43:183:29:1:28","0:3:43:183:29:3:28","0:3:43:183:29:5:28","0:3:43:183:29:7:28",
							"0:3:43:183:29:9:28","0:3:43:183:29:11:28","0:3:43:183:29:13:28","0:3:43:183:29:15:28",
							"0:3:43:183:29:17:28","0:3:43:183:29:19:28","0:3:43:183:29:21:28","0:3:43:183:29:23:28",
							"0:3:43:183:29:25:28","0:3:43:183:29:27:28","0:3:43:183:29:29:28","0:3:43:183:29:31:28",
							"0:3:43:183:29:33:28","0:3:43:183:29:35:28",
							"0:3:43:183:29:37:28","0:3:43:183:29:39:28","0:3:43:183:29:41:28","0:3:43:183:29:43:28",
							"0:3:43:183:29:45:28","0:3:43:183:29:47:28","0:3:43:183:29:49:28","0:3:43:183:29:51:28",
							"0:3:43:183:29:53:28","0:3:43:183:29:55:28","0:3:43:183:29:57:28","0:3:43:183:29:59:28",
							"0:3:43:183:29:61:28","0:3:43:183:29:63:28","0:3:43:183:29:65:28","0:3:43:183:29:67:28",
							"0:3:43:183:29:69:28","0:3:43:183:29:71:28"); //71 hinh


var Level4_right2 = new Array("0:3:43:399:35:1:34","0:3:43:399:35:3:34","0:3:43:399:35:5:34","0:3:43:399:35:7:34",
							"0:3:43:399:35:9:34","0:3:43:399:35:11:34","0:3:43:399:35:13:34","0:3:43:399:35:15:34",
							"0:3:43:399:35:17:34","0:3:43:399:35:19:34","0:3:43:399:35:21:34","0:3:43:399:35:23:34",
							"0:3:43:399:35:25:34","0:3:43:399:35:27:34","0:3:43:399:35:29:34","0:3:43:399:35:31:34",
							"0:3:43:399:35:33:34","0:3:43:399:35:35:34",
							"0:3:43:399:35:37:34","0:3:43:399:35:39:34","0:3:43:399:35:41:34","0:3:43:399:35:43:34",
							"0:3:43:399:35:45:34","0:3:43:399:35:47:34","0:3:43:399:35:49:34","0:3:43:399:35:51:34",
							"0:3:43:399:35:53:34","0:3:43:399:35:55:34","0:3:43:399:35:57:34","0:3:43:399:35:59:34",
							"0:3:43:399:35:61:34","0:3:43:399:35:63:34","0:3:43:399:35:65:34","0:3:43:399:35:67:34",
							"0:3:43:399:35:69:34","0:3:43:399:35:71:34",
							"0:3:43:399:35:73:34","0:3:43:399:35:75:34","0:3:43:399:35:77:34","0:3:43:399:35:79:34",
							"0:3:43:399:35:81:34","0:3:43:399:35:83:34","0:3:43:399:35:85:34","0:3:43:399:35:87:34",
							"0:3:43:399:35:89:34","0:3:43:399:35:91:34","0:3:43:399:35:93:34","0:3:43:399:35:95:34",
							"0:3:43:399:35:97:34","0:3:43:399:35:99:34","0:3:43:399:35:101:34","0:3:43:399:35:103:34",
							"0:3:43:399:35:105:34","0:3:43:399:35:107:34",
							"0:3:43:399:35:109:34","0:3:43:399:35:111:34","0:3:43:399:35:113:34","0:3:43:399:35:115:34",
							"0:3:43:399:35:117:34","0:3:43:399:35:119:34","0:3:43:399:35:121:34","0:3:43:399:35:123:34",
							"0:3:43:399:35:125:34","0:3:43:399:35:127:34","0:3:43:399:35:129:34","0:3:43:399:35:130:34",
							"0:3:43:399:35:131:34","0:3:43:399:35:133:34","0:3:43:399:35:135:34","0:3:43:399:35:137:34",
							"0:3:43:399:35:139:34","0:3:43:399:35:141:34","0:3:43:399:35:143:34"
							); //143 hinh`

var Level1_left2 = new Array("0:3:43:3:9:1:8","0:3:43:3:9:3:8","0:3:43:3:9:5:8",
							"0:3:43:3:9:7:8","0:3:43:3:9:9:8","0:3:43:3:9:11:8",
							"0:3:43:3:9:13:8","0:3:43:3:9:15:8","0:3:43:3:9:17:8");

var Level2_left2 = new Array("0:3:43:39:17:1:16","0:3:43:39:17:3:16","0:3:43:39:17:5:16","0:3:43:39:17:7:16",
							"0:3:43:39:17:9:16","0:3:43:39:17:11:16","0:3:43:39:17:13:16","0:3:43:39:17:15:16",
							"0:3:43:39:17:17:16","0:3:43:39:17:19:16","0:3:43:39:17:21:16","0:3:43:39:17:23:16",
							"0:3:43:39:17:25:16","0:3:43:39:17:27:16","0:3:43:39:17:29:16","0:3:43:39:17:31:16",
							"0:3:43:39:17:33:16","0:3:43:39:17:35:16");

var Level3_left2 = new Array("0:3:43:111:25:1:24","0:3:43:111:25:3:24","0:3:43:111:25:5:24","0:3:43:111:25:7:24",
							"0:3:43:111:25:9:24","0:3:43:111:25:11:24","0:3:43:111:25:13:24","0:3:43:111:25:15:24",
							"0:3:43:111:25:17:24","0:3:43:111:25:19:24","0:3:43:111:25:21:24","0:3:43:111:25:23:24",
							"0:3:43:111:25:25:24","0:3:43:111:25:27:24","0:3:43:111:25:29:24","0:3:43:111:25:31:24",
							"0:3:43:111:25:33:24","0:3:43:111:25:35:24",
							"0:3:43:111:25:37:24","0:3:43:111:25:39:24","0:3:43:111:25:41:24","0:3:43:111:25:43:24",
							"0:3:43:111:25:45:24","0:3:43:111:25:47:24","0:3:43:111:25:49:24","0:3:43:111:25:51:24",
							"0:3:43:111:25:53:24","0:3:43:111:25:55:24","0:3:43:111:25:57:24","0:3:43:111:25:59:24",
							"0:3:43:111:25:61:24","0:3:43:111:25:63:24","0:3:43:111:25:65:24","0:3:43:111:25:67:24",
							"0:3:43:111:25:69:24","0:3:43:111:25:71:24");

var Level4_left2 = new Array("0:3:43:255:32:1:31","0:3:43:255:32:3:31","0:3:43:255:32:5:31","0:3:43:255:32:7:31",
							"0:3:43:255:32:9:31","0:3:43:255:32:11:31","0:3:43:255:32:13:31","0:3:43:255:32:15:31",
							"0:3:43:255:32:17:31","0:3:43:255:32:19:31","0:3:43:255:32:21:31","0:3:43:255:32:23:31",
							"0:3:43:255:32:25:31","0:3:43:255:32:27:31","0:3:43:255:32:29:31","0:3:43:255:32:31:31",
							"0:3:43:255:32:33:31","0:3:43:255:32:35:31",
							"0:3:43:255:32:37:31","0:3:43:255:32:39:31","0:3:43:255:32:41:31","0:3:43:255:32:43:31",
							"0:3:43:255:32:45:31","0:3:43:255:32:47:31","0:3:43:255:32:49:31","0:3:43:255:32:51:31",
							"0:3:43:255:32:53:31","0:3:43:255:32:55:31","0:3:43:255:32:57:31","0:3:43:255:32:59:31",
							"0:3:43:255:32:61:31","0:3:43:255:32:63:31","0:3:43:255:32:65:31","0:3:43:255:32:67:31",
							"0:3:43:255:32:69:31","0:3:43:255:32:71:31",
							"0:3:43:255:32:73:31","0:3:43:255:32:75:31","0:3:43:255:32:77:31","0:3:43:255:32:79:31",
							"0:3:43:255:32:81:31","0:3:43:255:32:83:31","0:3:43:255:32:85:31","0:3:43:255:32:87:31",
							"0:3:43:255:32:89:31","0:3:43:255:32:91:31","0:3:43:255:32:93:31","0:3:43:255:32:95:31",
							"0:3:43:255:32:97:31","0:3:43:255:32:99:31","0:3:43:255:32:101:31","0:3:43:255:32:103:31",
							"0:3:43:255:32:105:31","0:3:43:255:32:107:31",
							"0:3:43:255:32:109:31","0:3:43:255:32:111:31","0:3:43:255:32:113:31","0:3:43:255:32:115:31",
							"0:3:43:255:32:117:31","0:3:43:255:32:119:31","0:3:43:255:32:121:31","0:3:43:255:32:123:31",
							"0:3:43:255:32:125:31","0:3:43:255:32:127:31","0:3:43:255:32:129:31","0:3:43:255:32:130:31",
							"0:3:43:255:32:131:31","0:3:43:255:32:133:31","0:3:43:255:32:135:31","0:3:43:255:32:137:31",
							"0:3:43:255:32:139:31","0:3:43:255:32:141:31","0:3:43:255:32:143:31"
							);

var BTN_DETAILS = "0:1115:91:14:90";
var BTN_OPEN = "0:1115:91:12:83";
var BTN_RESET = "0:1115:91:8:69";
var BTN_STOP = "0:1115:91:10:76";
var BTN_MOVE = "0:1115:91:5:62:1:59";

var TIME_open = 3*1000;
var TIME_rotate = 3*1000;
var TIME_join = 2*1000;

var g_end_joinX = 0;
var g_time_open =0;
var g_time_rotate = 0;
var g_time_join = 0;
var g_joinX = 0;
var g_anim_join = new Animation();
var g_anim_open = new Animation();
var g_details = 1;
var g_anim_rotate = new Animation();
var g_Frame = 0;
var g_rotate = -100;
var g_join = -144;
var g_join2 = -122;


var g_finish1 = false;
var g_finish2 = false;
var g_finish3 = false;
var g_arc = 121.46;
var g_rY = 0; 
var g_rX = 0; 

var y_end =130;
var dY=0;
var dx = 115;
var x = 0;
var y = 0;
var R = 174;
var L =61;
var x1= 115;
var y1 = 131;
var count =0;
var count_end =0;
var test = 0;
var p4 = false;
var drag = 133.3;


var check = new Array(R*Math.cos(10*Math.PI/180),R*Math.cos(30*Math.PI/180),R*Math.cos(50*Math.PI/180),R*Math.cos(70*Math.PI/180), 0, R*Math.cos(110*Math.PI/180), R*Math.cos(130*Math.PI/180),
R*Math.cos(150*Math.PI/180),R*Math.cos(170*Math.PI/180) );
var check2 = new Array();

var check2 = new Array();
check2[0] = R*Math.cos(5*Math.PI/180);
for(i=1;i<=18;i++){
	check2[i] = R*Math.cos((10*i+5)*Math.PI/180);
}
var check3 = new Array();
check3[0]=2.5;
for(i=1;i<=35;i++){
	check3[i] = R*Math.cos((5*i+2.5)*Math.PI/180);
}
var check4 = new Array();
check4[0]=1.25;
for(i=1;i<=72;i++){
	check4[i] = R*Math.cos((2.5*i+1.25)*Math.PI/180);
}