function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}
function _$(id) {
	return $(document.getElementById(id));
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
//=================================================================================================================//

function runCompa1(){
	var o = mvn.mainMovie.sprites["42:91"];
	g_anim_compa1.stop();
	g_anim_compa1.add({
		duration: 2*1000,
		delay: 0,
		isRunAtEnd: true,
		data: {
			
			int_Frame:{startValue: g_Frame, endValue: 60, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {
		},

		onStep: function(data, t) {	

			
			g_Frame = Math.floor(data.int_Frame.now);
			
				o.jumpToFrame(g_Frame);	
					if(data.int_Frame.now <=10){
						_$("0:42:91:76:90").css({"opacity":{2:0.1,3:0.2,4:0.3,5:0.45,6:0.5,7:0.6,8:0.7,9:0.8,10:0.9}});
					}else{
						if(10 < data.int_Frame.now && data.int_Frame.now <50){
							_$("0:42:91:76:90").css({"opacity":1});
						}
					}
					if( 50< data.int_Frame.now && data.int_Frame.now <= 55){
								_$("0:42:91:76:90").css({"opacity": 0.3});
							}
					if(55< data.int_Frame.now && data.int_Frame.now<=60){
						_$("0:42:91:76:90").css({"opacity": 0});
					}

					if(g_Frame ==60){
					_$("0:42:91:76:90").css({"opacity":0});
					_$("0:42:91:47:88").css({"opacity":0});
					_$("0:42:91:6:55").show(); // 1
					_$("0:42:91:17:61").show();// C
					_$("0:42:91:19:63").show(); // D

					_$(BTN_START).show();
					_$(BTN_BACK).show();
					_$(BTN_RESET).show();
				}
														 											
		}
	});
	g_anim_compa1.run();
}

function runCompa2(){
	var o = mvn.mainMovie.sprites["42:91"];
	g_anim_compa2.add({
		duration: 3*1000,
		delay: 0,
		isRunAtEnd: true,
		data: {
			
			int_Frame:{startValue: g_Frame, endValue: 170, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {
		},

		onStep: function(data, t) {	

			
			g_Frame = Math.floor(data.int_Frame.now);
			o.jumpToFrame(g_Frame);
				if(data.int_Frame.now <=70){
						_$("0:42:91:47:88").css({"opacity":{61:0,62:0.1,63:0.2,64:0.3,65:0.45,66:0.5,67:0.6,68:0.7,69:0.8,70:0.9}});
					}else{
						if(70 < data.int_Frame.now && data.int_Frame.now <=100){
							_$("0:42:91:47:88").css({"opacity":1});
						}
					}
				if( 100< data.int_Frame.now && data.int_Frame.now < 108){
								_$("0:42:91:47:88").css({"opacity": 0.3});
							}
				if(108<= data.int_Frame.now && data.int_Frame.now<=110){
					_$("0:42:91:47:88").css({"opacity": 0});
				}
				if(110< data.int_Frame.now && data.int_Frame.now <=120){
					_$("0:42:91:47:88").css({"opacity": 0});
				}
				if(120< data.int_Frame.now && data.int_Frame.now <=130){
					_$("0:42:91:47:88").css({"opacity":{121:0,122:0.1,123:0.2,124:0.3,125:0.45,126:0.5,127:0.6,128:0.7,129:0.8,130:0.9}});
				}
				if(130< data.int_Frame.now && data.int_Frame.now <=160){
					_$("0:42:91:47:88").css({"opacity":1});
				}
				if(160< data.int_Frame.now && data.int_Frame.now <=167){
					_$("0:42:91:47:88").css({"opacity": 0.3});
				}
				if(167< data.int_Frame.now && data.int_Frame.now <=170){
					_$("0:42:91:47:88").css({"opacity": 0});
				}
				if(g_Frame ==170){
					_$("0:42:91:47:88").css({"opacity":0});
					_$("0:42:91:9:57").show(); //2
					_$("0:42:91:21:65").show(); //E

					_$(BTN_START).show();
					_$(BTN_BACK).show();
					_$(BTN_RESET).show();

				}

		}
	});
	g_anim_compa2.run();
}

function line(){
	var o = mvn.mainMovie.sprites["42:91"];
	g_anim_line.add({
		duration: 1*1000,
		delay: 0,
		isRunAtEnd: true,
		data: {
			
			int_Frame:{startValue: g_Frame, endValue: 199, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {
		},

		onStep: function(data, t) {	

			
			g_Frame = Math.floor(data.int_Frame.now);
			o.jumpToFrame(g_Frame);
			if(g_Frame == 199){
				_$("0:42:91:14:59").show();
				_$(BTN_START).show();
				_$(BTN_BACK).show();
				_$(BTN_RESET).show();

			}	

		}
	});
	g_anim_line.run();
}


var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
	},
		
	bindEvents: function() {

		MVNButton({
			id: BTN_START //BTN_01 = "0:6:9:12:33"
		}); // START
		MVNButton({
		id: BTN_BACK
		}); // PAUSE
		MVNButton({
			id: BTN_RESET
		}); // RESET
	
		$(document.getElementById(BTN_START)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			//$(document.getElementById("0:42:91:76:90")).css({"opacity": 1});
			
			if(g_START_STT <=2){
				_$(BTN_START).hide();
				_$(BTN_BACK).hide();
				_$(BTN_RESET).hide();
					if(g_START_STT == 0){
					runCompa1();
					g_START_STT++;
					console.log(g_START_STT);
					}else{
						if(g_START_STT == 1){
							g_anim_compa1.stop();
							runCompa2();
							g_START_STT++;				
						}else{
							g_anim_compa2.stop();
							line();
							g_START_STT++;						
						}
					}			
			}
														
		});
		$(document.getElementById(BTN_BACK)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			var o = mvn.mainMovie.sprites["42:91"];
			if(g_START_STT == 1){
				o.jumpToFrame(0);
				g_Frame = 1;
				g_START_STT = 0;
				_$("0:42:91:6:55").hide(); // 1
				_$("0:42:91:17:61").hide();// C
				_$("0:42:91:19:63").hide(); // D
				g_anim_compa1.reset();
			}else{
				if(g_START_STT == 2){
					o.jumpToFrame(60);
					g_Frame = 60;
					g_START_STT =1;	
					_$("0:42:91:9:57").hide(); //2
					_$("0:42:91:21:65").hide(); //E
					g_anim_compa2.reset();

				}else{
					if(g_START_STT == 3){
						o.jumpToFrame(170);
						_$("0:42:91:14:59").hide();
						g_Frame = 170;
						g_START_STT =2;						
						g_anim_line.reset();
					}
				}	
			}

		});

		$(document.getElementById(BTN_RESET)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			_$("0:42:91:6:55").hide(); // 1
			_$("0:42:91:17:61").hide();// C
			_$("0:42:91:19:63").hide(); // D
			_$("0:42:91:9:57").hide(); //2
			_$("0:42:91:21:65").hide(); //E
			_$("0:42:91:14:59").hide();

			var o = mvn.mainMovie.sprites["42:91"];
			g_Frame =1;
			g_START_STT =0;
			o.jumpToFrame(0);
			g_anim_compa1.reset();


		});

		//=====================CHECK BOX==============================
	},

	removeStuffs: function() {
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();
	}
};