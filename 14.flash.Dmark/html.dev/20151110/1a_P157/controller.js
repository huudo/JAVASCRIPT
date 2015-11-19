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
		
		
		$(document.getElementById("0:24:89:33:72")).empty().append(
			$(createTag("path")).attr({
				id: "test",
				d: "M-5,-5L95 -5L95 385L-5 385L-5 -5",

				transform: "matrix(1 0 0 1 0 0 )"
			}).css({
				fill: "red"
			})
		 );
		 
		$(document.getElementById("0:24:89:27:67")).empty().append(
			$(createTag("path")).attr({
				id: "test2",
				d: "M-5,-5L92 -5L92 381L-5 381L-5 -5",

				transform: "matrix(1 0 0 1 0 0 )"
			}).css({
				fill: "red"
			})
		 );
		 
		$(document.getElementById("0:24:89:21:62")).empty().append(
			$(createTag("path")).attr({
				id: "test3",
				d: "M-5,-5L5 -5L5 391L-5 391L-5 -5",

				transform: "matrix(1 0 0 1 0 0 )"
			}).css({
				fill: "red"
			})
		 );
		
	},
	rotateCompa1: function() {
		var o = mvn.mainMovie.sprites["24:89"];
		var compSpriteId = "39:81";
		var nStartFrame = 0;
		var nEndFrame = COMPA1_FRAME;
		
//		nEndFrame = 180;
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

					// Change compa's opacity.
					if(0<=frameNo && frameNo <=20) {
						$(o.sprites[compSpriteId].par).css({"opacity": {0:0, 1:0.05, 2:0.1, 3:0.14, 4:0.19, 5:0.25, 6:0.3, 7:0.35, 8:0.39, 9:0.44, 10:0.5, 11:0.55, 12:0.6, 13:0.64, 14:0.69, 15:0.75, 16:0.8, 17:0.85, 18:0.89, 19:0.94, 20:1}[frameNo]});
					} else if(201<=frameNo && frameNo<=220) {
						$(o.sprites[compSpriteId].par).css({"opacity": {201:0.94, 202:0.89, 203:0.83, 204:0.78, 205:0.73, 206:0.69, 207:0.64, 208:0.58, 209:0.53, 210:0.48, 211:0.44, 212:0.39, 213:0.33, 214:0.28, 215:0.23, 216:0.19, 217:0.14, 218:0.8, 219:0.3, 220:0.0}[frameNo]});
					} else if(81<=frameNo && frameNo<=99) {
						$(o.sprites[compSpriteId].par).css({"opacity": {81:0.94, 82:0.89, 83:0.85, 84:0.8, 85:0.75, 86:0.69, 87:0.64, 88:0.6, 89:0.55, 90:0.5, 91:0.44, 92:0.39, 93:0.35, 94:0.3, 95:0.25, 96:0.19, 97:0.14, 98:0.1, 99:0.05}[frameNo]});
					} else if(100<=frameNo && frameNo<=120) {
						$(o.sprites[compSpriteId].par).css({"opacity":0});
					} else if(121<=frameNo && frameNo<=140) {
						$(o.sprites[compSpriteId].par).css({"opacity": {121:0.03, 122:0.08, 123:0.14, 124:0.19, 125:0.23, 126:0.28, 127:0.33, 128:0.39, 129:0.44, 130:0.48, 131:0.53, 132:0.58, 133:0.64, 134:0.69, 135:0.73, 136:0.78, 137:0.83, 138:0.89, 139:0.94, 140:1}[frameNo]});
					} else {
						$(o.sprites[compSpriteId].par).css({"opacity":1});
					}
					
					if(0<=frameNo && frameNo<=39) {
						$(o.sprites["35:74"].par).css({opacity: 0});
						$(o.sprites["29:69"].par).css({opacity: 0});
					} else {
						$(o.sprites["35:74"].par).css({opacity: 1});
						$(o.sprites["29:69"].par).css({opacity: 1});
					}
				}
				
			}
		});
		g_anim.run();
	},
	rotateCompa2: function() {
		var o = mvn.mainMovie.sprites["24:89"];
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
				$(document.getElementById(BTN_NEXT_ID)).hide();
				$(document.getElementById(BTN_BACK_ID)).show();
				$(document.getElementById(BTN_RESET_ID)).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != o.frame) {
					o.jumpToFrame(frameNo);
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
			}
		});
		
		$(document.getElementById(BTN_RESET_ID)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			mvn.mainMovie.sprites["24:89"].jumpToFrame(0);
			$(document.getElementById("0:24:89:35:74")).css({opacity: 0});
			$(document.getElementById("0:24:89:29:69")).css({opacity: 0});
			g_nGameMode = GAME_INIT;
			$(document.getElementById(BTN_NEXT_ID)).show();
			$(document.getElementById(BTN_BACK_ID)).hide();
			$(document.getElementById(BTN_RESET_ID)).hide();
		});
		$(document.getElementById(BTN_BACK_ID)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			switch(g_nGameMode) {
				case GAME_STEP2:
					g_nGameMode = GAME_STEP1;
					mvn.mainMovie.sprites["24:89"].jumpToFrame(COMPA1_FRAME);
					$(document.getElementById(BTN_NEXT_ID)).show();
					$(document.getElementById(BTN_BACK_ID)).show();
					$(document.getElementById(BTN_RESET_ID)).show();
					break;
				case GAME_STEP1:
					g_nGameMode = GAME_INIT;
					mvn.mainMovie.sprites["24:89"].jumpToFrame(0);
					$(document.getElementById("0:24:89:35:74")).css({opacity: 0});
					$(document.getElementById("0:24:89:29:69")).css({opacity: 0});
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
			"0:1:29",
			"0:3:31",
			"0:4:33",
			"0:5:34",
			"0:6:35",
			"0:7:36",
			"0:8:37",
			"0:9:38",
			"0:10:39",
			"0:11:40",
			"0:12:42",
			"0:13:43",
			"0:14:44",
			"0:15:45",
			"0:16:46",
			"0:17:49",
			"0:21:50",
			"0:22:52",
			"0:23:53",
			"0:86:27"
//			"0:24:89",
//			"0:64:104",
//			"0:78:111",
//			"0:80:120",
//			"0:83:125",
		];

		for(var i=0; i<a.length; i++) {
//			$(document.getElementById(a[i])).remove();
		}
		
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();
	}
};