//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================
var g_nOriginalWidth = parseInt(data.Fw);
var g_nOriginalHeight = parseInt(data.Fh);
var g_zoomLevel = 1;

(function() {

	// Deal with IE9 console bug.
	if(typeof (window.console) == 'undefined' || typeof (window.console.log) == 'undefined' )
	window.console = {
		log: function() {}	// Disable console.log
	};

	function findSpriteDataById(a, spriteId) {
		for (var i = 0; i < a.length; i++) {
			if (typeof (a[i].id) === 'number' && a[i].id == spriteId) {
				return a[i];
			}
		}
	}


	function global_PatchData() {
//		//===================================================
//		// Sửa phần đầu của textbutton  bị lỗi
//		// Xóa Sf[0] có chứ Sf[0].Cd
//		//===================================================
//		var aTg = data.tg;
//		for (var i = 0; i < aTg.length; i++) {
//			if (typeof (aTg[i].Sf) != "undefined") {
//				var aSf = aTg[i].Sf;
//				var cD = aSf[0].cD;
//				if (typeof (cD) != "undefined") {
//					aSf.splice(0, 1);
////					console.log("Delete Sf[0].id = ",aTg[i].id);
//				}
//			}
//		}

// Change foreignObject to Normal Text.
//		if(0)
		for (var i = 0, a = data.tg; i < a.length; i++) {
			if (a[i].tp == 11 && a[i].tt == "html") {	// find text element with html content.
				var x = a[i];
				var o = {
					"id": x.id,
					"tf": x.tf,
					"tp": 11,
					"rs": [
						{
							"b": false, // bold = false
							"c": x.rs[0].c, // color
//							"fd": x.rs[0].fd, // font face 
							"fd": "MS UI Gothic", // font face 
							"h": x.rs[0].fs, // font size
							"tx": x.rs[0].tx, // text
							"x": x.bd.l, // bd.left
							"y": x.bd.t			// bd.top
						}
					]
				};
//				// // console.log(x, o, o.rs[0].tx);
				a[i] = o;
			}
		}
	}
	
	

//==========================================================================
//====	Global settings.
//==========================================================================
	function global_BindEvents() {
		//==== Auto resize ====
		
		$("div:first").css({overflow: "hidden", position: "absolute", top: 0, left: 0, width: "100%", height: "100%"});

if(1)	
		$(window).resize(function() {
			var ratio = g_nOriginalWidth/g_nOriginalHeight;
			var w = $(this).width();
			var h = $(this).height();
			var svgWidth = w;
			var svgHeight = h;
//			var paddingLeft = 0;
			var paddingTop = 0;
			if(w/h<ratio) {
				svgHeight = w/ratio;
				paddingTop = (h - svgHeight)/2;
//				paddingLeft = 0;
			} else {
				svgWidth = h * ratio;
//				paddingLeft = (w - svgWidth)/2;
				paddingTop = 0;
			}
			g_zoomLevel = svgWidth/g_nOriginalWidth;
			$("svg:first").css({
				"margin-top": paddingTop,
//				"margin-left": paddingLeft,
				width: svgWidth, 
				height: svgHeight
			});
//			console.log(w, h, svgWidth, svgHeight, "==", (w-svgWidth)/2, (h-svgHeight)/2, "==", paddingLeft, paddingTop);
		}).trigger("resize");
		
		
		document.body.style.msTouchAction = "none";

		//-- Disable text selection.
		$("text")
			.attr("unselectable","on")
			.css({"user-select":"none"})
			.on("selectstart", false);

		$(document).mousedown(function() {
//			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

		$(window).blur(function() {
//			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

	}


function initGame() {
	var a = [
//		"0:3:189:45:188",
		SCREEN_SETTING
	];
	
	//==== Hide unused screen.
	for(var i=0; i<a.length; i++) {
		$(document.getElementById(a[i])).hide();
	}

	//==== Create some animate buttons
	MVNButton({id: "0:49:225:1:196"});		// Reset
	MVNButton({id: "0:49:225:3:203"});		// Stop
	MVNButton({id: "0:49:225:5:210"});		// Next
	MVNButton({id: "0:49:225:7:217"});		// Start
	MVNButton({id: "0:49:225:9:224"});		// Setting


	//==== Adjust Text in Setting screen.
	if(0) {
		$("text").each(function(i, o) {
		var a = $(o).attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean);
			console.log(i, a);
			a[5] = Number(a[5])+43;
			a[4] = Number(a[4])+2;
			$(o).attr({"transform":["matrix(",a.join(","),")"].join("")});
		});
	}


	bindEvents();
}

function bindEvents() {
	$(document.getElementById(BTN_START_ID)).bind("mouseup touchend", function(event) {
		console.log("BTN_START_ID", g_nGameMode);
		switch(g_nGameMode) {
			case GAME_MODE_INIT:
				g_nGameMode = GAME_MODE_NEW_GAME;
				$(document.getElementById(SCREEN_HELP)).hide();
				createNewGame();
				break;
			case GAME_MODE_NEW_GAME:
				break;
			case GAME_MODE_PLAYING:
				break;
			case GAME_MODE_SETTING:
				break;
			case GAME_MODE_END_GAME:
				break;
		}
	});

	$(document.getElementById(BTN_RESET_ID)).bind("mouseup touchend", function(event) {
		//==== Do nothing if current mode is init.
		if(g_nGameMode == GAME_MODE_INIT) return;
	});


	$(document.getElementById(BTN_SETTING_ID)).bind("mouseup touchend", function(event) {
		g_nSaveGameMode = g_nGameMode;
		g_nGameMode = GAME_MODE_SETTING;
		$(document.getElementById(SCREEN_SETTING)).show();
	});


	$(document.getElementById(BTN_BACK_TO_GAME)).bind("mouseup touchend", function(event) {
		// If saved mode = init then when return from setting, mode keeps as init.
		// Else mode = new game.
		g_nGameMode = g_nSaveGameMode == GAME_MODE_INIT
			? GAME_MODE_INIT
			: GAME_MODE_NEW_GAME;
		$(document.getElementById(SCREEN_SETTING)).hide();
		createNewGame();
	});
}


function showCardSlot(slotNum) {
	var o = mvn.mainMovie.sprites["3:189"].sprites["1:132"];
	var nFrame = 0;
	switch(slotNum) {
		case 2:	nFrame = 0; break;
		case 3:	nFrame = 5; break;
		case 4:	nFrame = 10; break;
		default: nFrame=0;
	}
	o.jumpToFrame(nFrame);
}

function createNewGame() {
	g_aQuestions = generateQuestions(SETTINGS.nCardType, SETTINGS.nCardNum, SETTINGS.bRandomCardNum)
	console.log(g_aQuestions);
	
	showCardSlot(g_aQuestions[g_nCurrentQuestion].length);
//	drawCards();
	
}

function drawCard() {

}

function generateQuestions(nCardType, nCardNum, bRandomCardNum) {
	console.log("generateQuestions(nCardType, nCardNum, bRandomCardNum)", nCardType, nCardNum, bRandomCardNum);
	var a = [];
	var nIndexMin = nCardType == CARD_TYPE_TRAP? 1 : 41;	// in sprite 121, TRAPs are from frame 1 to 40.
															// Numbers are from frame 41 to 80.
	for(var i=0; i<10; i++) {
		a[i] = [];
		var nSlot = bRandomCardNum
			? Math.floor(Math.random() * (4-2+1) + 2)
			: nCardNum;
		
		for(var j=0; j<nSlot; j++) {
			a[i].push(Math.floor(Math.random() * 40 + nIndexMin));
		}
	} 
	return a;
}

//==========================================================================
//==== Start here
//==========================================================================

	global_PatchData();
//=======================================================================
// Đoạn dưới đây chạy sau khi data được xử lý bởi sprite.js
// nhưng trước khi shapes được render.
//=======================================================================
	$(document).bind("beforeRender", function () {
		$(document.body).css("text-align", "center");
		$(document.body).css("background-color", "#CECFCE");
		
		document.body.style.msTouchAction = "none";
		
//		$.fn.disableSelection = function() {
//	        return this
//                 .attr('unselectable', 'on')
//                 .css('user-select', 'none')
//                 .on('selectstart', false);
//		};

		g_nOriginalWidth = parseInt(data.Fw);
		g_nOriginalHeight = parseInt(data.Fh);
//		console.log("g_nOriginalWidth, g_nOriginalHeight", g_nOriginalWidth, g_nOriginalHeight);
	});

//=======================================================================
// Đoạn dưới đây chạy sau khi data được render bởi sprite.js
//=======================================================================
	$(document).bind("frameRendered", function (event, data) {
//		// // console.log("frameRendered", data.spriteId);
		if (data.spriteId != "Mf")
			return false;
		
		// Run one time only.
		global_BindEvents();
//		$(window).trigger("resize");

		GAME.initGame();
	});


})();
