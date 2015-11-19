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
	setTrianglePos: function(posX) {
		$(document.getElementById(TRIANGLE_HANDLER)).attr({transform: ["matrix(1,0,0,1,",posX,",0)"].join("")});
		
		//==== if TriangleHalder is selected and not hidden then move tab with it.
		if(TABS.g_nTabIndex == 3 && ($("#TAB_RECTANGLE").css("display") != "none")) {
			TABS.drawTab($(document.getElementById(TRIANGLE_HANDLER)));
		}
	},
		
	drawAPQ: function() {
		$(document.getElementById(POINT_P)).attr({transform: ["matrix(1,0,0,1,0,",MODEL.AP*AP_STEP,")"].join("")});
		$(document.getElementById(POINT_Q)).attr({transform: ["matrix(1,0,0,1,",-MODEL.AP*AQ_STEP,",0)"].join("")});
		$(document.getElementById(ARROW_P)).attr({transform: ["matrix(1,0,0,1,0,",MODEL.AP*AP_STEP,")"].join("")}).toggle(MODEL.bShowArrows);
		$(document.getElementById(ARROW_Q)).attr({transform: ["matrix(1,0,0,1,",-MODEL.AP*AQ_STEP,",0)"].join("")}).toggle(MODEL.bShowArrows);
		
			
		
		$("#triangleAPQ").remove();
		$(document.getElementById(APQ_CONTAINER).firstChild.nextSibling)
		.append($(createTag("path"))
			.css({fill: "#FFEFEF", stroke: "black", "stroke-width": "1.5px"})
			.attr({
				id: "triangleAPQ",
				d: [
					"M", -SQUARE_SIZE_X/2, 0,									// A
					"L", SQUARE_SIZE_X/2 - MODEL.AP*AQ_STEP,0,	// Q
					"L", -SQUARE_SIZE_X/2,MODEL.AP*AQ_STEP,					// P
					"z"
				].join(" ")
			})
		);
	},
		
	autorun: function() {
		var startValue = MODEL.AP;
		var endValue = 6;
		var nDuration = (endValue - startValue) * 1000;
		
		g_anim.stop();
		g_anim.reset();
		g_anim.add({
			duration: nDuration,
			delay: 0,
			isRunAtEnd: true,
			data: {ap: {startValue: startValue, endValue: endValue, easing: "linearTween"}},
			onInit: function() {},
			onComplete: function() {
				$(document.getElementById(BTN_STOP)).hide();
				$(document.getElementById(BTN_START)).show();
			},
				
			onStep: function(data, t) {
				MODEL.AP = data.ap.now;
				GAME.setTrianglePos(MIN_POS + MODEL.AP*RULER_STEP);
				GAME.drawAPQ();
			}
		});
		g_anim.run();
	},

//========================================================================================================
	patchText: function() {
		console.log("GAME.patchText");
		var aButtons = [BTN_MOVE_P_TO_A, BTN_STOP, BTN_START];
		for(var i=0; i<aButtons.length; i++) {
			MVNButton({id: aButtons[i]});
		}

		//499.2, 257.0
		$(document.getElementById("0:12:75:33:74").firstChild.nextSibling).attr("transform", ["matrix(1,0,0,1,8,33)"].join(""));
		$(document.getElementById("0:12:75:7:73")).find("g[type=text]").each(function(i, e){
			$(e).attr("transform", ["matrix(1,0,0,1,4,23)"].join(""));
		});
		GAME.setTrianglePos(MIN_POS + MODEL.AP*RULER_STEP);
		GAME.drawAPQ();
		MODEL.bShowArrows = false;
		$(document.getElementById(BTN_STOP)).hide();
	},
	
	bindEvents: function() {
		$(document.getElementById(TRIANGLE_HANDLER)).drag("draginit", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			this.startPosition = {
				clientX: event.clientX,	// draginit's Mouse pos
	  			lastPos: MIN_POS + MODEL.AP*RULER_STEP
			};
			GAME.drawAPQ();
		}).drag(function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			var dX = (event.clientX - this.startPosition.clientX)/g_zoomLevel;
			var newPos = this.startPosition.lastPos + dX;
			if(newPos<MIN_POS || newPos>MAX_POS) return;	// Do not drag outside ruler.
			MODEL.AP = (newPos-MIN_POS)/RULER_STEP;

			GAME.setTrianglePos(newPos);
			GAME.drawAPQ();
			
			if(g_anim.isRunning()) {
				GAME.autorun();
			}
		}).drag("dragend", function(event){
			var dX = (event.clientX - this.startPosition.clientX)/g_zoomLevel;
			var newPos = this.startPosition.lastPos + dX;
			if(newPos<MIN_POS) newPos = MIN_POS;
			if(newPos>MAX_POS) newPos = MAX_POS;
			newPos = MIN_POS + Math.round((newPos-MIN_POS)/RULER_STEP) * RULER_STEP;
			MODEL.AP = Math.round((newPos-MIN_POS)/RULER_STEP);
			GAME.setTrianglePos(newPos);
			GAME.drawAPQ();
		});
		
		
		$(document.getElementById(BTN_MOVE_P_TO_A)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			MODEL.AP = 0;
			MODEL.bShowArrows = true;
			GAME.setTrianglePos(MIN_POS + MODEL.AP*RULER_STEP);
			GAME.drawAPQ();
			MODEL.bShowArrows = false;
		});

		$(document.getElementById(BTN_START)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			$(this).hide();
			$(document.getElementById(BTN_STOP)).show();
			GAME.autorun();
		});

		$(document.getElementById(BTN_STOP)).bind("mouseup touchend", function(event){
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			$(this).hide();
			$(document.getElementById(BTN_START)).show();
			g_anim.stop();
			g_anim.reset();
		});
	},

	removeStuffs: function() {
		var a = [
			"0:12:75:7:73:25:72:68_1:2:67",	// Black rect over triangle.
			"0:12:75:7:73:25:72:71_2:2:67"	// Black rect over triangle.
//			"0:12:75:7:73:25:72:66_0"
		];
		for(var i=0; i<a.length; i++) {
			$(document.getElementById(a[i])).remove();
		}
//		$(document.getElementById("0:12:75:7:73:25:72:68_1")).remove();
//		$(document.getElementById("0:12:75:7:73:25:72:71_2")).remove();
//		$(document.getElementById("0:3:29:8:28:13:19")).remove();
//		$(document.getElementById("0:3:29:8:28:16:22")).remove();
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();		
	}
};