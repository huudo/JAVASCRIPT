//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================

//==== CONSTANTS Begin ===========================================================================
var ORANGE = 0;
var BANANA = 1;
var KAKI = 2;

//==== Game Mode constants ====

//==== Buttons, Screens' id ====
var BTN_INFO_IN = "0:8:75:36:66";
var BTN_INFO_OUT = "0:8:75:40:74";

var PLATE1_DRAGAREA = "0:8:75:4:40";
var PLATE2_DRAGAREA = "0:8:75:6:40";
var PLATE3_DRAGAREA = "0:8:75:16:40";
var PLATE4_DRAGAREA = "0:8:75:18:40";
var FRUIT_DRAGAREA = "0:8:75:8:49";
var OUTSIDE_DRAGAREA  = "0:8:75:1:38";

var BALANCE1 = "0:8:75:20:55";
var BALANCE2 = "0:8:75:27:55";

var CONTAINER = "0:8:75";

var BALANCES = {
	1: BALANCE1,
	2: BALANCE2
}
var PLATE1 = "0:8:75:20:55:4:54:1:53";
var PLATE2 = "0:8:75:20:55:6:54:1:53";
var PLATE3 = "0:8:75:27:55:4:54:1:53";
var PLATE4 = "0:8:75:27:55:6:54:1:53";

var PLATES = {
	1: PLATE1,
	2: PLATE2,
	3: PLATE3,
	4: PLATE4
}

//==== CONSTANTS End =============================================================================


var MODEL = {
	1: {
		orange: 0,	//	オレンジ
		banana: 0,	//	バナナ
		kaki: 0		//	柿
	},
	2: {
		orange: 0,	//	オレンジ
		banana: 0,	//	バナナ
		kaki: 0		//	柿
	},
	3: {
		orange: 0,	//	オレンジ
		banana: 0,	//	バナナ
		kaki: 0		//	柿
	},
	4: {
		orange: 0,	//	オレンジ
		banana: 0,	//	バナナ
		kaki: 0		//	柿
	},
	outside: {
		orange: 0,	//	オレンジ
		banana: 0,	//	バナナ
		kaki: 0		//	柿
	}
};


var g_fruitAutoNumber = 0;
var g_hFruitImages = {
	0: {name: "orange", path: "g2_p44_01/image/image_11_0.png", width: 	54, height: 47, transform: "matrix(1, 0, 0, 1, 0, 0)"}, 	// ORANGE
	1: {name: "banana", path: "g2_p44_01/image/image_2_0.png", width: 	158, height: 131, transform: "matrix(1, 0, 0, 1, 0, 0)"},	// BANANA
	2: {name: "kaki", path: "g2_p44_01/image/image_7_0.png", width: 	62, height: 55, transform: "matrix(1, 0, 0, 1, 0, 0)"}, 	// KAKI
}
var g_hFruitPos = {
	0: {startX: {1:-195, 2: -191, 3:-203, 4:-199}, stepX: 58, startY: -52, stepY: -50, max: 20, column: 2},	// ORANGE
	1: {startX: {1:-82, 2:-78, 3:-88, 4:-84},	stepX: 0, startY: -136, stepY: -100, max: 5, column: 1},	// BANANA
	2: {startX: {1:76, 2:79, 3:69, 4:73}, stepX: 66, startY: -60, stepY: -56, max: 20, column: 2}	// KAKI
};
