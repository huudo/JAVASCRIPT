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
		//console.log("GAME.patchText");
	},
		
	bindEvents: function() {
	},

	removeStuffs: function() {
	},
	initGame: function() {
		//console.log("GAME.initGame");
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();
	}
};

function adjustText(){
	_$(g_ball_0).hide();
	_$(g_ball_1).hide();
	_$(g_ball_2).hide();
	_$(g_ball_3).hide();
	_$(g_ball_4).hide();

	_$(g_ball_txt_0).hide();
	_$(g_ball_txt_1).hide();
	_$(g_ball_txt_2).hide();
	_$(g_ball_txt_3).hide();
	_$(g_ball_txt_4).hide();

	_$(BTN_show.id).hide();
	_$(BTN_reset).hide();
	_$("0:641:361").attr({"transform": ["matrix(1,0,0,1,1,-0.5)"].join("")});
	_$("0:620:336:9:333").attr({"transform": ["matrix(1,0,0,1,0.5,-0.5)"].join("")});

	_$("0:637:360:3:2").find("g").first().attr({"transform": ["matrix(1,0,0,1,9,9)"].join("")});
	_$("0:637:360:3:2:1:1").find("path").attr({d: "M0,0L25 0L25 25L0 25L0 0z"});

}

function showText(){

	if(BTN_show.status == 0){
		_$(BTN_show.id).show();
		showAllText();
		BTN_show.status =1;
	}else{
		_$(BTN_show.id).hide();
		hideAllText();
		BTN_show.status =0;
	}

}

function hideAllText(){
	_$(g_ball_txt_0).hide();
	_$(g_ball_txt_1).hide();
	_$(g_ball_txt_2).hide();
	_$(g_ball_txt_3).hide();
	_$(g_ball_txt_4).hide();

	_$(g_ball_0).hide();
	_$(g_ball_1).hide();
	_$(g_ball_2).hide();
	_$(g_ball_3).hide();
	_$(g_ball_4).hide();

}

function showAllText(){
	if(g_current_s >= 0){
		check_show_text(g_current_s);
	}else{
		_$(g_ball_txt_0).show();
		_$(g_ball_txt_1).show();
		_$(g_ball_txt_2).show();
		_$(g_ball_txt_3).show();
		_$(g_ball_txt_4).show();

		_$(g_ball_0).show();
		_$(g_ball_1).show();
		_$(g_ball_2).show();
		_$(g_ball_3).show();
		_$(g_ball_4).show();
	}
}

function check_show_text(s){

		if(s*100 >= 0){
			_$(g_ball_txt_0).show();
			_$(g_ball_0).show();
		}else{
			_$(g_ball_txt_0).hide();
			_$(g_ball_0).hide();
		}

		if(s*100 >= 20){
			_$(g_ball_txt_1).show();
			_$(g_ball_1).show();
		}else{
			_$(g_ball_txt_1).hide();
			_$(g_ball_1).hide();
		}

		if(s*100 >= 80){
			_$(g_ball_txt_2).show();
			_$(g_ball_2).show();
		}else{
			_$(g_ball_txt_2).hide();
			_$(g_ball_2).hide();
		}

		if(s*100 >= 180){
			_$(g_ball_txt_3).show();
			_$(g_ball_3).show();
		}else{
			_$(g_ball_txt_3).hide();
			_$(g_ball_3).hide();
		}

		if(s*100 >= 320){
			_$(g_ball_txt_4).show();
			_$(g_ball_4).show();
		}else{
			_$(g_ball_txt_4).hide();
			_$(g_ball_4).hide();
			
		}

}

function move_ball(s) {
		
		_$(g_ball).attr({"transform": ["matrix(1,0,0,1,", s*100,",0)"].join("")});
		
		if(BTN_show.status) check_show_text(s);

		
	}

function move_pointer(x) {
	_$(BTN_move).attr({"transform": ["matrix(1,0,0,1,", 30*x,",0)"].join("")});
}

function ani_ball(start){
	g_anim.add({
				duration: (6-start) * 1000,
				delay: 0,
				isRunAtEnd: true,
				data: {
					t: {
						startValue: start,
						endValue: 6,
						easing: "linearTween"
					}
				},
				onInit: function() {
					
				},
				onComplete: function() {
					g_anim.reset();
					_$(BTN_stop).hide();
					_$(BTN_start).hide();
				},
				onStep: function(data, time) {

					var t = data.t.now;
					g_current_time = t;
					var s = 1/2 * 0.4 * t * t;
					g_current_s = s;
					move_ball(s);
					move_pointer(t);

				}
			});

	g_anim.run();
}

	//===== action draw 16 poitn
function start_run() {
	g_anim.stop();
	g_anim.reset();
	ani_ball(g_current_time);
	
	_$(BTN_start).hide();
	_$(BTN_stop).show();
	_$(BTN_reset).show();
	
}

function stop_run() {
	g_anim.stop();
	g_anim.reset();
	_$(BTN_start).show();
	_$(BTN_stop).hide();
}

function reset_all(){
	_$(g_ball).attr({"transform": ["matrix(1,0,0,1,0,0)"].join("")});
	_$(BTN_move).attr({"transform": ["matrix(1,0,0,1,0,0)"].join("")});
	hideAllText();
	g_current_time = 0;
	g_current_s = 0;
	g_anim.stop();
	g_anim.reset();
	_$(BTN_start).show();
	_$(BTN_reset).hide();
}