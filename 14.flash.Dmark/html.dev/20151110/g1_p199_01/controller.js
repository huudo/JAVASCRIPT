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
//==========================================HAM VE TAM GIAC=========================================

function drawLevel1(a){
	for(var i=0 ; i<=a ; i++){
		_$(Level1_right[i]).show();
		_$(Level1_left[i]).show();
		if(i>=1){
			_$("0:549:53:565:42").attr({transform: ["rotate(",(i-1)*20,",0,0)"].join("")});
		}
		
	}
}
function drawLevel2(a){
	for(var i=0 ; i<=a ; i++){
		_$(Level2_right[i]).show();
		_$(Level2_left[i]).show();
		if(i>=3){
			_$("0:549:53:565:42").attr({transform: ["rotate(",(i-3)*10,",0,0)"].join("")});
		}
		//_$(Level2_right[a-i]).hide();
	}
}


function drawLevel3(a){
	for(var i=0 ; i<=a ; i++){
		_$(Level3_right[i]).show();
		_$(Level3_left[i]).show();
	}
	if(i>=8){
			_$("0:549:53:565:42").attr({transform: ["rotate(",(i-8)*5,",0,0)"].join("")});
		}
}

function drawLevel4(a){
	for(var i=0 ; i<=a ; i++){
		_$(Level4_right[i]).show();
		_$(Level4_left[i]).show();
	}
	if(i>=16){
			_$("0:549:53:565:42").attr({transform: ["rotate(",(i-16)*2.5,",0,0)"].join("")});
		}
}

//==========================================HAM AN TAM GIAC=========================================

function clearLevel1(b){
	for(var i = 8;i>=b;i--){
		_$(Level1_right[i]).hide();
		_$(Level1_left[i]).hide();
	}
}

function clearLevel2(b){
	for(var i = 17;i>=b;i--){
		if(i>=4){
		_$(Level2_right[i]).hide();
		_$(Level2_left[i]).hide();
		}
		
	}
}
function clearLevel3(b){
	for(var i = 35;i>=b;i--){
		if(i>=8){
		_$(Level3_right[i]).hide();
		_$(Level3_left[i]).hide();
		}
		
	}
}
function clearLevel4(b){
	for(var i = 72;i>=b;i--){
		if(i>=16){
		_$(Level4_right[i]).hide();
		_$(Level4_left[i]).hide();
		}
		
	}
}

//======================================HAM ANIMATIN================================================

function anim_Open(i){
	switch(i){
		case 1: 
			var o1 = mvn.mainMovie.sprites["549:53"].sprites["21:13"];
			var o2 = mvn.mainMovie.sprites["549:53"].sprites["3:9"];
			break;
		case 2: 
			var o1 = mvn.mainMovie.sprites["549:53"].sprites["75:21"];
			var o2 = mvn.mainMovie.sprites["549:53"].sprites["39:17"];
			break;
		case 3: 
			var o1 = mvn.mainMovie.sprites["549:53"].sprites["183:29"];
			var o2 = mvn.mainMovie.sprites["549:53"].sprites["111:25"];
			break;
		case 4: 
			var o1 = mvn.mainMovie.sprites["549:53"].sprites["399:35"];
			var o2 = mvn.mainMovie.sprites["549:53"].sprites["255:32"];
			break;
		default:
			break;		
	}
	
	g_anim_open.stop();
		g_anim_open.add({
		duration: TIME_open,
		delay: 0,
		isRunAtEnd: true,
		data: {
			
			int_Frame:{startValue:g_Frame, endValue: 29, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {
			g_finish = true;
			anim_rotate(i);
		},

		onStep: function(data, t) {	
			g_time_open = t;
			g_Frame = Math.floor(data.int_Frame.now);
			
				o1.jumpToFrame(g_Frame);
				o2.jumpToFrame(g_Frame);	
					
				}
														 											
		
	});
	g_anim_open.run();
}

function anim_rotate(i){
	switch(i){
		case 1: 
			var rotate1 = _$(ID_LEVEL1_RIGHT);
			var rotate2 = _$(ID_LEVEL1_LEFT);
			break;
		case 2: 
			var rotate1 = _$(ID_LEVEL2_RIGHT);
			var rotate2 = _$(ID_LEVEL2_LEFT);
			break;
		case 3: 
			var rotate1 = _$(ID_LEVEL3_RIGHT);
			var rotate2 = _$(ID_LEVEL3_LEFT);
			break;
		case 4: 
			var rotate1 = _$(ID_LEVEL4_RIGHT);
			var rotate2 = _$(ID_LEVEL4_LEFT);
			break;
		default:
			break;		

	}
	
	g_anim_rotate.stop();
		g_anim_rotate.add({
		duration: TIME_rotate ,
		delay: 1*1000,
		isRunAtEnd: true,
		data: {
			
			rotate:{startValue:g_rotate, endValue: 180, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {
			anim_join(i);
		},

		onStep: function(data, t) {	
			g_time_rotate = t;
			g_rotate = Math.floor(data.rotate.now);
			
					rotate1.attr({transform: ["rotate(",-g_rotate,",0,-15)"].join("")});

					
				}
														 											
		
	});
	g_anim_rotate.run();
}

function anim_join(i){
	switch(i){
		case 1: 
			var rotate1 = _$(ID_LEVEL1_RIGHT);
			var rotate2 = _$(ID_LEVEL1_LEFT);
			g_end_joinX = 41;
			break;
		case 2: 
			var rotate1 = _$(ID_LEVEL2_RIGHT);
			var rotate2 = _$(ID_LEVEL2_LEFT);
			g_end_joinX = 20;
			break;
		case 3: 
			var rotate1 = _$(ID_LEVEL3_RIGHT);
			var rotate2 = _$(ID_LEVEL3_LEFT);
			g_end_joinX = 10;
			break;
		case 4: 
			var rotate1 = _$(ID_LEVEL4_RIGHT);
			var rotate2 = _$(ID_LEVEL4_LEFT);
			g_end_joinX = 5;
			break;
		default:
			break;			

	}
	
	g_anim_join.stop();
		g_anim_join.add({
		duration: TIME_join ,
		delay: 1*1000,
		isRunAtEnd: true,
		data: {
			
			join:{startValue:g_join, endValue: 132, easing: "linearTween"},
			joinX:{startValue:g_joinX, endValue: g_end_joinX, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {
		},

		onStep: function(data, t) {	
			g_time_join = t;
			g_join = data.join.now;
			g_joinX = data.joinX.now;
					rotate1.find("g").first().attr({transform: ["matrix(1,0,0,1,",-g_joinX,",",-g_join,")"].join("")});
					rotate2.find("g").first().attr({transform: ["matrix(1,0,0,1,0,",-g_join,")"].join("")})
					
				}
														 											
		
	});
	g_anim_join.run();	
}


var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
	},
		
	bindEvents: function() {

		MVNButton({
			id: BTN_DETAILS //BTN_01 = "0:6:9:12:33"
		}); // START
		MVNButton({
		id: BTN_OPEN
		}); // OPEN
		MVNButton({
		id: BTN_STOP
		}); // OPEN
		
		MVNButton({
			id: BTN_RESET
		}); // RESET
		
	
		$(document.getElementById(BTN_DETAILS)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			
			if(g_details !=4){
				g_details++;
			}			
			if(g_details == 2){
				_$("0:549:53:543:44").hide();
				for(var i=0;i<=18;i++){
						if(y1<=check2[i]){
							a=i;	
							console.log(y1);					
						}
					}			
				for(var i =0;i<=a;i++){
					_$(Level1_right[i]).hide();
					_$(Level1_left[i]).hide();
				}
														
					drawLevel2(a);				
			}if(g_details==3){
				for(var i=0;i<36;i++){
						if(y1<=check3[i]){
							a=i;		
							console.log(i);	
							if(y1 == -175){
								a =35;
							}				
						}
					}
				_$("0:549:53:543:44").hide();
				for(var i =0;i<=a;i++){
					_$(Level2_right[i]).hide();
					_$(Level2_left[i]).hide();
				}

				
																					
				drawLevel3(a);	
			}if(g_details == 4 && p4==false){
				_$("0:549:53:543:44").hide();
				for(var i=0;i<72;i++){
						if(y1<=check4[i]){
							a=i;	
							if(y1==-175){
								a = 72;
							}					
						}
					}
				for(var i =0;i<=a;i++){
					_$(Level3_right[i]).hide();
					_$(Level3_left[i]).hide();
				}
				
				
																	
				drawLevel4(a);		
			}
																
		});


		$(document.getElementById(BTN_OPEN)).bind("mouseup touchend", function(event) {
			event.preventDefault();

			_$(BTN_OPEN).hide();
			_$(BTN_STOP).show();

			_$("0:549:53:565:42").hide();
			_$("0:549:53:1:5").hide();
			_$("0:1115:91:5:62").hide();
			if(g_finish == false){
				anim_Open(g_details);	
			}else{
				g_anim_open.stop();
				anim_rotate(g_details);
			}
				
	
		});

		$(document.getElementById(BTN_STOP)).bind("mouseup touchend", function(event) {
		event.preventDefault();
			_$(BTN_OPEN).show();
			_$(BTN_STOP).hide();			
			g_anim_open.stop();
			g_anim_rotate.stop();
			TIME_open = TIME_open - g_time_open;
			TIME_rotate = TIME_rotate - g_time_rotate;
			g_anim_open.reset();
			g_anim_rotate.reset();
			

	
		});


		$(document.getElementById(BTN_RESET)).bind("mouseup touchend", function(event) {
			event.preventDefault();		
			$(document.getElementById("0"));
			$(createTag("g"));
			// $(createTag("text").attr({"id":"text"})).appendTo("NameID");


		});



		$(document.getElementById(BTN_MOVE)).bind("draginit", function(event) {
			this.startPosition = {
				x: event.clientX, //toa do ban dau cua chuot
				y: event.clientY,
				
			};

		}).drag(function(event) {

			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			dY = (event.clientY - this.startPosition.y)/g_zoomLevel;
			y1 = y_end+dY; //vi tri hien tai cua bong'
			var test = y1;
					if(y1 < -175){y1 = -175};
					if(y1>175){y1=175};		
					x1 = Math.sqrt(175*175 - y1*y1);
					//console.log("YFIST", dY);
					//var  test = L-count;			

					_$("0:549:53:543:44").hide();
					if(g_details == 1){
						for(var i=0;i<9;i++){
							if(y1<=check[i]){
								a=i;						
							}
						}
						if(a>=1){
							clearLevel1(a);
						}						
						drawLevel1(a);		
					}else{
						if(g_details == 2){
							for(var i=0;i<=18;i++){
								if(y1<=check2[i]){
									a=i;						
								}
							}
								clearLevel2(a);														
								drawLevel2(a);		
						}else{
								if(g_details == 3){
									for(var i=0;i<36;i++){
										if(y1<=check3[i]){
											a=i;		
											console.log(i);	
											if(y1 == -175){
												a =35;
											}				
										}
									}
									clearLevel3(a);														
									drawLevel3(a);		
								}else{
										if(g_details == 4){
										for(var i=0;i<=72;i++){
											if(y1<=check4[i]){
												a=i;	
												if(y1==-175){
													a = 72;
												}					
											}
										}
										clearLevel4(a);														
										drawLevel4(a);		
										}
									}
							}

						}						
											
					_$("0:1115:91:5:62").find("g").first().attr({transform: ["matrix(0.75,0,0,0.75,",x1,",",y1,")"].join("")});
			
		}).drag("dragend", function(event) {
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			dY = (event.clientY - this.startPosition.y)/g_zoomLevel;
			dY = (event.clientY - this.startPosition.y)/g_zoomLevel;
			x1 = Math.sqrt(175*175 - y1*y1);
			y_end = y_end +dY; 
		
		}).css({
			cursor: "pointer"
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