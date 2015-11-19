function _$(id) {
	return $(document.getElementById(id));
}

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
	},
		
	bindEvents: function() {
	},

	removeStuffs: function() {
	},
	initGame: function() {
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();
	}
};

function adjustText(){
	_$(BTN_back).hide();
	_$(BTN_reset).hide();
	//_$("0:637:360:3:2").find("g").first().attr({"transform": ["matrix(1,0,0,1,9,9)"].join("")});
	
	_$("0:3:4:1:3").find("path").attr({"stroke-width": 0});

}


function runStep1() {
		var obj = mvn.mainMovie.sprites["45:75"];
		//var sprite_id = "53";
		var nStartFrame = 0;
		var nEndFrame = step1_FRAME;
		g_anim.reset();
		g_anim.add({
			duration: (nEndFrame-nStartFrame+1) * 1000/30,	// 65 frames, rate 30frames/s
			delay: 0,
			isRunAtEnd: false,	// ====
			data: {frame: {startValue: nStartFrame, endValue: nEndFrame, easing: "linearTween"}},
			onInit: function() {
				obj.jumpToFrame(0);
				_$(BTN_next).hide();
				_$(BTN_back).hide();
				_$(BTN_reset).hide();
				
			},
			onComplete: function() {
				_$(BTN_next).show();
				_$(BTN_back).show();
				_$(BTN_reset).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != obj.frame) {
					obj.jumpToFrame(frameNo);
					
				}
			}
		});
		g_anim.run();
	}
function runStep2() {
		var obj = mvn.mainMovie.sprites["45:75"];
		var nStartFrame = step1_FRAME+1;
		var nEndFrame = step2_FRAME;
//		nEndFrame = 166;

		g_anim.reset();
		g_anim.add({
			duration: (nEndFrame-nStartFrame) * 1000/30,	// 65 frames, rate 30frames/s
			delay: 0,
			isRunAtEnd: false,	// ====
			data: {frame: {startValue: nStartFrame, endValue: nEndFrame, easing: "linearTween"}},
			onInit: function() {
				_$(BTN_next).hide();
				_$(BTN_back).hide();
				_$(BTN_reset).hide();
			},
			onComplete: function() {
				_$(BTN_next).show();
				_$(BTN_back).show();
				_$(BTN_reset).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != obj.frame) {
					obj.jumpToFrame(frameNo);
				}
			}
		});
		g_anim.run();
	}

	function runStep3() {
		var obj = mvn.mainMovie.sprites["45:75"];
		var nStartFrame = step2_FRAME+1;
		var nEndFrame = step3_FRAME;

		g_anim.reset();
		g_anim.add({
			duration: (nEndFrame-nStartFrame) * 1000/30,	// 65 frames, rate 30frames/s
			delay: 0,
			isRunAtEnd: false,	// ====
			data: {frame: {startValue: nStartFrame, endValue: nEndFrame, easing: "linearTween"}},
			onInit: function() {
				_$(BTN_next).hide();
				_$(BTN_back).hide();
				_$(BTN_reset).hide();
			},
			onComplete: function() {
				_$(BTN_next).show();
				_$(BTN_back).show();
				_$(BTN_reset).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != obj.frame) {
					obj.jumpToFrame(frameNo);
				}
			}
		});
		g_anim.run();
	}

	function runStep4() {
		var obj = mvn.mainMovie.sprites["45:75"];
		var nStartFrame = step3_FRAME+1;
		var nEndFrame = step4_FRAME;

		g_anim.reset();
		g_anim.add({
			duration: (nEndFrame-nStartFrame) * 1000/30,	// 65 frames, rate 30frames/s
			delay: 0,
			isRunAtEnd: false,	// ====
			data: {frame: {startValue: nStartFrame, endValue: nEndFrame, easing: "linearTween"}},
			onInit: function() {
				_$(BTN_next).hide();
				_$(BTN_back).hide();
				_$(BTN_reset).hide();
			},
			onComplete: function() {
				//_$(BTN_next).show();
				_$(BTN_back).show();
				_$(BTN_reset).show();
			},
				
			onStep: function(data, t) {
				var frameNo = Math.floor(data.frame.now);
				if(frameNo != obj.frame) {
					obj.jumpToFrame(frameNo);
				}
			}
		});
		g_anim.run();
	}


function reset_all(){
	g_nGameMode = 1;
	mvn.mainMovie.sprites["45:75"].jumpToFrame(0);
	_$(BTN_next).show();
	_$(BTN_back).hide();
	_$(BTN_reset).hide();

}