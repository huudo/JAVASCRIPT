function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}

function createText(textId) {
	var textData = g_allSVGText[textId];
	var g = $(createTag("g"));
	for (var i = 0, len = g_allSVGText[textId].length; i < len; i++) {
		var p = g_allSVGText[textId][i];
		g.append($(createTag("path")).css(p.css).attr({
			d: p.d,
			transform: p.transform
		}));
	}
	return g;
}

var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
		var aButtons = [
			BTN_BACK_ID,	// 戻る
			BTN_NEXT_ID,	// 次へ
			BTN_RESET_ID 	// はじめに戻る
		];
		for (var i = 0; i < aButtons.length; i++) {
			MVNButton({id: aButtons[i]});
		}
		
		$(document.getElementById(BTN_NEXT_ID)).show();
		$(document.getElementById(BTN_BACK_ID)).hide();
		$(document.getElementById(BTN_RESET_ID)).hide();
	},
	rotateCompa1: function() {
		var o = mvn.mainMovie.sprites["43:80"];
		var compSpriteId = "12:64";
		var nStartFrame = 0;
		var nEndFrame = COMPA1_FRAME;
		var bShowCompa = false;
		g_anim.reset();
		g_anim.add({
			duration: (nEndFrame-nStartFrame+1) * 1000/30,	// 65 frames, rate 30frames/s
			delay: 0,
			isRunAtEnd: true,	// ====
			data: {frame: {startValue: nStartFrame, endValue: nEndFrame, easing: "linearTween"}},
			onInit: function() {
				o.jumpToFrame(0);
				$(document.getElementById(BTN_NEXT_ID)).hide();
				$(document.getElementById(BTN_BACK_ID)).hide();
				$(document.getElementById(BTN_RESET_ID)).hide();
			},
			onComplete: function() {
				$(document.getElementById(BTN_NEXT_ID)).show();
				$(document.getElementById(BTN_BACK_ID)).show();
				$(document.getElementById(BTN_RESET_ID)).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != o.frame) {
					o.jumpToFrame(frameNo);
					
					if(!bShowCompa && o.sprites[compSpriteId]) {
						bShowCompa = true;
						for(var i=0; i<25; i++){
							o.sprites[compSpriteId].jumpToFrame(i);
						}
						$(o.sprites[compSpriteId].par).css({"opacity": 1});
					}
					
					if(bShowCompa & !o.sprites[compSpriteId]) {
						bShowCompa = false;
					}
					if(bShowCompa) {
						// Change compa's opacity.
						if(1<=frameNo && frameNo<=3) {
							$(o.sprites[compSpriteId].par).css({"opacity": {1:0, 2: 0.33, 3: 0.66}[frameNo]});
						} else if(57<=frameNo && frameNo <=60) {
							$(o.sprites[compSpriteId].par).css({"opacity": {57:0.75, 58: 0.5, 59:0.35, 60:0}[frameNo]});
						}else {
							$(o.sprites[compSpriteId].par).css({"opacity": 1});
						}
					}
				}
			}
		});
		g_anim.run();
	},
	rotateCompa2: function() {
		var o = mvn.mainMovie.sprites["43:80"];
		var compSpriteId1 = "17:64";
		var compSpriteId2 = "20:64";
		var nStartFrame = COMPA1_FRAME+1;
		var nEndFrame = COMPA2_FRAME;
//		nEndFrame = 166;
		var bShowCompa1 = false;
		var bShowCompa2 = false;
		g_anim.reset();
		g_anim.add({
			duration: (nEndFrame-nStartFrame+1) * 1000/30,	// 65 frames, rate 30frames/s
			delay: 0,
			isRunAtEnd: true,	// ====
			data: {frame: {startValue: nStartFrame, endValue: nEndFrame, easing: "linearTween"}},
			onInit: function() {
				$(document.getElementById(BTN_NEXT_ID)).hide();
				$(document.getElementById(BTN_BACK_ID)).hide();
				$(document.getElementById(BTN_RESET_ID)).hide();
			},
			onComplete: function() {
				$(document.getElementById(BTN_NEXT_ID)).show();
				$(document.getElementById(BTN_BACK_ID)).show();
				$(document.getElementById(BTN_RESET_ID)).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != o.frame) {
					o.jumpToFrame(frameNo);
					if(!bShowCompa1 && o.sprites[compSpriteId1]) {
						bShowCompa1 = true;
						for(var i=0; i<25; i++){
							o.sprites[compSpriteId1].jumpToFrame(i);
						}
						$(document.getElementById("0:43:80:17:64")).attr({
						  transform: ["matrix(",0.85714285714,",0,0,",0.85714285714,"1,20,52)"].join("")
						});					}
					if(bShowCompa1 & !o.sprites[compSpriteId1]) {
						bShowCompa1 = false;
					}
					if(bShowCompa1) {
						// Change compa's opacity.
						if(65<=frameNo && frameNo<=68) {
							$(o.sprites[compSpriteId1].par).css({"opacity": {65:0, 66: 0.25, 67: 0.50, 68:0.75}[frameNo]});
						} else if(106<=frameNo && frameNo <=109) {
							$(o.sprites[compSpriteId1].par).css({"opacity": {106:0.75, 107: 0.5, 108:0.25, 109:0}[frameNo]});
						}else {
							$(o.sprites[compSpriteId1].par).css({"opacity": 1});
						}
					}
					
					
					if(!bShowCompa2 && o.sprites[compSpriteId2]) {
						bShowCompa2 = true;
						for(var i=0; i<25; i++){
							o.sprites[compSpriteId2].jumpToFrame(i);
						}
						$(document.getElementById("0:43:80:20:64")).attr({
							transform: ["matrix(",0.85714285714,",0,0,",0.85714285714,"1,57,51)"].join("")
						});
					}
					if(bShowCompa2 & !o.sprites[compSpriteId2]) {
						bShowCompa2 = false;
					}
					if(bShowCompa2) {
						// Change compa's opacity.
						if(116<=frameNo && frameNo<=118) {
							$(o.sprites[compSpriteId2].par).css({"opacity": {115:0, 116: 0.25, 117: 0.50, 118:0.75}[frameNo]});
						} else if(166<=frameNo && frameNo <=169) {
							$(o.sprites[compSpriteId2].par).css({"opacity": {166:0.75, 167: 0.5, 168:0.25, 169:0}[frameNo]});
						}else {
							$(o.sprites[compSpriteId2].par).css({"opacity": 1});
						}
					}
				}
			}
		});
		g_anim.run();
	},
	rotateCompa3: function() {
		var o = mvn.mainMovie.sprites["43:80"];
		var nStartFrame = COMPA2_FRAME+1;
		var nEndFrame = COMPA3_FRAME;
		var bShowCompa = false;
		g_anim.reset();
		g_anim.add({
			duration: (nEndFrame-nStartFrame+1) * 1000/30,	// 65 frames, rate 30frames/s
			delay: 0,
			isRunAtEnd: true,	// ====
			data: {frame: {startValue: nStartFrame, endValue: nEndFrame, easing: "linearTween"}},
			onInit: function() {
				$(document.getElementById(BTN_NEXT_ID)).hide();
				$(document.getElementById(BTN_BACK_ID)).hide();
				$(document.getElementById(BTN_RESET_ID)).hide();
			},
			onComplete: function() {
				$(document.getElementById(BTN_BACK_ID)).show();
				$(document.getElementById(BTN_RESET_ID)).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != o.frame) {
					o.jumpToFrame(frameNo);
					
					if(!bShowCompa && o.sprites["12:64"]) {
						bShowCompa = true;
						for(var i=0; i<25; i++){
							o.sprites["12:64"].jumpToFrame(i);
						}
						$(o.sprites["12:64"].par).css({"opacity": 1});
					}
				}
			}
		});
		g_anim.run();
	},

	bindEvents: function() {
		$(document.getElementById(BTN_NEXT_ID)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			switch(g_nGameMode) {
				case GAME_INIT:
					g_nGameMode = GAME_STEP1;
					GAME.rotateCompa1();
					break;
				case GAME_STEP1:
					g_nGameMode = GAME_STEP2;
					GAME.rotateCompa2();
					break;
				case GAME_STEP2:
					g_nGameMode = GAME_STEP3;
					GAME.rotateCompa3();
					break;
			}
		});
		
		$(document.getElementById(BTN_RESET_ID)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			mvn.mainMovie.sprites["43:80"].jumpToFrame(0);
			g_nGameMode = GAME_INIT;
			$(document.getElementById(BTN_NEXT_ID)).show();
			$(document.getElementById(BTN_BACK_ID)).hide();
			$(document.getElementById(BTN_RESET_ID)).hide();
		});
		$(document.getElementById(BTN_BACK_ID)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			switch(g_nGameMode) {
				case GAME_STEP3:
					g_nGameMode = GAME_STEP2;
					mvn.mainMovie.sprites["43:80"].jumpToFrame(COMPA2_FRAME);
					$(document.getElementById(BTN_NEXT_ID)).show();
					$(document.getElementById(BTN_BACK_ID)).show();
					$(document.getElementById(BTN_RESET_ID)).show();
					break;
				case GAME_STEP2:
					g_nGameMode = GAME_STEP1;
					mvn.mainMovie.sprites["43:80"].jumpToFrame(COMPA1_FRAME);
					$(document.getElementById(BTN_NEXT_ID)).show();
					$(document.getElementById(BTN_BACK_ID)).show();
					$(document.getElementById(BTN_RESET_ID)).show();
					break;
				case GAME_STEP1:
					g_nGameMode = GAME_INIT;
					mvn.mainMovie.sprites["43:80"].jumpToFrame(0);
					$(document.getElementById(BTN_NEXT_ID)).show();
					$(document.getElementById(BTN_BACK_ID)).hide();
					$(document.getElementById(BTN_RESET_ID)).hide();
					break;
			}
		});
	},

	removeStuffs: function() {
		//==== Remove below g as requested by client.
		var a = [
			"0:1:13",
			"0:3:14",
			"0:4:16",
			"0:5:18",
			"0:6:19",
			"0:7:21",
			"0:8:22",
			"0:9:23",
			"0:10:21",
			"0:11:24",
			"0:12:25",
			"0:13:26",
			"0:14:27",
			"0:15:28",
			"0:16:29",
			"0:17:25",
			"0:18:26",
			"0:19:27",
			"0:20:30",
			"0:21:31",
			"0:22:32",
			"0:23:33",
			"0:24:34",
			"0:25:28",
			"0:26:35",
			"0:27:36",
			"0:28:37",
			"0:29:38",
			"0:30:39",
			"0:31:40",
			"0:32:41",
			"0:33:42",
			"0:34:43",
			"0:35:44",
			"0:36:45",
			"0:37:46",
			"0:38:48",
			"0:39:49",
			"0:41:50",
			"0:42:51"
//			"0:43:80",
//			"0:66:87",
//			"0:68:96",
//			"0:71:101",
//			"0:74:105"
		];
		for(var i=0; i<a.length; i++) {
			$(document.getElementById(a[i])).remove();
		}
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();
	}
};