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

function TIME_COUNT(a){		
			s3=(a % 10);
			s2=Math.floor(a/10);
		if(s2>=10){
			s2= (s2%10);
		}		
		s1=Math.floor(a/100);
	$(document.getElementById(SECONDE_ID)).find("text").empty().text(s3);
	$(document.getElementById(MINUTE_ID)).find("text").empty().text(s2);
	$(document.getElementById(HOUR_ID)).find("text").empty().text(s1);
		
}



function MAN_RUN(){			
			var o = mvn.mainMovie.sprites["72:77"].sprites["7:63"];
			var man = $(document.getElementById(MAN_ID));
			if(g_BTN_RESET==true){
				g_anim_man.reset();
			}
			g_anim_man.add({
				duration: g_TIME_MAN,
				delay: 0,
				isRunAtEnd: true,
				data: {
					time: {startValue: g_time_start, endValue: 60, easing: "linearTween"},
					line: {startValue: 0, endValue: g_end_man, easing: "linearTween"},
					x: {startValue: g_TIME_START_MAN, endValue: 300, easing: "linearTween"},
					distance:{startValue: g_PAUSE_MAN, endValue: 581.8, easing: "linearTween"}
				},

				onInit: function() {},
				onComplete: function() {
				},

				onStep: function(data, t) {					
					g_TIME_START_MAN = Math.floor(data.x.now);
					var buoc = (g_TIME_START_MAN % 24);					
					o.jumpToFrame(buoc);
					g_time_start = Math.floor(data.time.now+0.5);
					TIME_COUNT(g_time_start);
					g_PAUSE_MAN = data.distance.now;												
					man.attr({transform: ["matrix(1,0,0,1,",g_PAUSE_MAN,",0)"].join("")});
					g_line_man = data.line.now;
					drawLine_Man(g_line_man);
					if(g_PAUSE_MAN == 581.8){
						g_stop = true;
						g_check =true;
						g_anim_girl.stop();	
						$(document.getElementById(BTN_02)).hide();
						$(document.getElementById(BTN_01)).show();	
					

					}						 									
					
				}
			});
			g_anim_man.run();
			
		}

//==========END MAN RUN

//-===========================GIRL RUN==============

function GIRL_RUN(){
			var i=0;					
			var o = mvn.mainMovie.sprites["72:77"].sprites["5:46"];
			var girl = $(document.getElementById(GIRL_ID));
			if(g_run==1 || g_BTN_RESET==true){
				g_anim_girl.reset();				
			}
			g_anim_girl.add({
				duration: g_TIME_GIRL,
				delay: 0,
				isRunAtEnd: true,
				data: {
					time: {startValue: g_time_start, endValue: g_time_end, easing: "linearTween"},
					line: {startValue: 0, endValue: g_end_girl, easing: "linearTween"},
					x: {startValue: g_TIME_START_GIRL, endValue: 600, easing: "linearTween"},
					distance:{startValue: g_PAUSE_GIRL, endValue: 637, easing: "linearTween"}
				},
				onInit: function() {},
				onComplete: function() {

				},

				onStep: function(data, t) {
					g_TIME_START_GIRL = Math.floor(data.x.now);
					g_PAUSE_GIRL = data.distance.now;																										
					girl.attr({transform: ["matrix(1,0,0,1,",g_PAUSE_GIRL,",0)"].join("")});
					g_line_girl = data.line.now;
					drawLine_Girl(g_line_girl);
					
					if(g_time_start % 3==0){
						$(document.getElementById("0:72:77:1:43:1:40")).attr({transform: ["matrix(1,0,0,1,40,0)"].join("")});		
					}else{
						$(document.getElementById("0:72:77:1:43:1:40")).attr({transform: ["matrix(1,0,0,1,",i,",0)"].join("")});		
					}
					if(g_time_start == 40){
						$(document.getElementById(BLURE_ID)).show();
					}
					if(g_time_start >= 60){
						g_time_start = Math.floor(data.time.now+0.5);
						TIME_COUNT(g_time_start);	
					}
					
									
				}
			});
			g_anim_girl.run();
		}

//=================================END RUN======================================================

//========================================DRAW LINE==============================================

function drawLine_Girl(a){
	
	$(document.getElementById("drawLine")).append($(createTag("line"))
		                                       .css({stroke:"#e02727","stroke-width":"2px"}).attr({"id":"lineG",x1: XGIRL ,y1:YGIRL ,x2:x_girl+2*a,y2:y_girl-a}));
}

function drawLine_Man(a){
	
	$(document.getElementById("drawLine")).append($(createTag("line"))
		                                       .css({stroke:"#000000","stroke-width":"2px"}).attr({"id":"lineM",x1: XMAN ,y1:YMAN ,x2:x_man+a,y2:y_man-a}));
}

function aniAlert(){
	g_anim_alert.add({
				duration: 0.1*1000,
				delay: 0,
				isRunAtEnd: true,
				data: {
					x: {startValue:1 , endValue:10 , easing: "linearTween"},
				},
				onInit: function() {},
				onComplete: function() {

				},

				onStep: function(data, t) {	
					var a = $(document.getElementById("0:82:145:19:144:7:138"));
					var ALERT2 = a.find("image").first().next();
					var ALERT1 = a.find("image").first();				
					var test = data.x.now;						
						if(test == 10){
							ALERT1.attr({transform: "matrix(1, 0, 0, 1, 83.5, -155.7)"});
							}else{
									ALERT1.attr({transform: "matrix(1, 0, 0, 1, 83.5, -145.7)"});
								}														
				}
			});
			g_anim_alert.run();
}

function aniAlert2(){
	g_anim_alert2.add({
				duration: 0.1*1000,
				delay: 0,
				isRunAtEnd: true,
				data: {
					x: {startValue:1 , endValue:10 , easing: "linearTween"},
				},
				onInit: function() {},
				onComplete: function() {

				},

				onStep: function(data, t) {	
					var a = $(document.getElementById("0:82:145:19:144:7:138"));
					var ALERT2 = a.find("image").first().next();
							
					var test = data.x.now;						
						if(test == 10){
							ALERT2.attr({transform: "matrix(1, 0, 0, 1, -146.9, -155.7)"});
							}else{
									ALERT2.attr({transform: "matrix(1, 0, 0, 1, -136.9, -155.7)"});
								}														
				}
			});
			g_anim_alert2.run();
}

var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
	},
		
	bindEvents: function() {

		MVNButton({
			id: BTN_01
		}); // START
		MVNButton({
			id: BTN_02
		}); // PAUSE
		MVNButton({
			id: BTN_RESET
		}); // RESET
	
		$(document.getElementById(BTN_01)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			$(document.getElementById(GIRL_ID)).show();
			$(document.getElementById(MAN_ID)).show();
			aniAlert();				
			if(g_disable==false){
			$(document.getElementById("0:3:36:1:11")).append($(createTag("g")).attr({id: "drawLine"}));
			$(document.getElementById("0:72:77:9:76:12:75")).hide();	
			$(document.getElementById('0:72:77:9:76:1:64')).hide();
			$(document.getElementById('0:72:77:9:76:2:65')).hide();										
			$(document.getElementById(BTN_01)).hide();
			$(document.getElementById(BTN_02)).show();
				if(g_check == true){
					if(g_run==0){
					g_run++;	
					g_anim_girl.stop();							
					g_TIME_GIRL =20000 - g_TIME_START_GIRL*100/3;
					x_girl = x_girl + 2*(g_line_girl);
					y_girl = y_girl - g_line_girl;
					g_end_girl= g_end_girl - g_line_girl;
					}
					GIRL_RUN();
				}else{
					GIRL_RUN();
					MAN_RUN();
				}
			}
											
		});

		$(document.getElementById(BTN_02)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			aniAlert2();
			
			//g_anim.pause();
			if(g_disable==false){
				$(document.getElementById(BTN_02)).hide();
				$(document.getElementById(BTN_01)).show();	
				if(g_check == true){
					g_anim_girl.stop();
					g_TIME_GIRL =20000 - g_TIME_START_GIRL*100/3;
					x_girl = x_girl + 2*(g_line_girl);
					y_girl = y_girl - g_line_girl;
					g_end_girl= g_end_girl - g_line_girl;
					g_anim_girl.reset();				
					
				}else{
					g_anim_man.stop();
					g_anim_man.reset();
					g_anim_girl.stop();
					g_anim_girl.reset();
					
					g_TIME_MAN = 10000 - g_TIME_START_MAN*100/3;
					g_TIME_GIRL =20000 - g_TIME_START_GIRL*100/3;
					x_man = x_man + g_line_man;
					y_man = y_man -g_line_man;
					g_end_man = g_end_man - g_line_man ;
					x_girl = x_girl + 2*(g_line_girl);
					y_girl = y_girl -g_line_girl;
					g_end_girl= g_end_girl - g_line_girl;
				
					}
			}	
		});

		$(document.getElementById(BTN_RESET)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);	
			g_BTN_RESET = true;
			$(document.getElementById("0:72:77:9:76:12:75")).show();	
			$(document.getElementById('0:72:77:9:76:1:64')).show();
			$(document.getElementById('0:72:77:9:76:2:65')).show();	
			$(document.getElementById(BTN_01)).show();
			$(document.getElementById(BTN_02)).hide();
			$(document.getElementById(GIRL_ID)).hide();
			$(document.getElementById(MAN_ID)).hide();
			$(document.getElementById(SECONDE_ID)).find("text").empty().text(0);
			$(document.getElementById(MINUTE_ID)).find("text").empty().text(0);
			$(document.getElementById(HOUR_ID)).find("text").empty().text(0);
			$(document.getElementById("drawLine")).remove();
			$(document.getElementById(BLURE_ID)).hide();
			g_anim_man.stop();
			g_anim_girl.stop();
			g_anim_alert.stop();
			g_anim_alert2.stop();
			

			g_stop =false;
			g_check = false;
			g_run =0;
			g_time_start = 1;

			x_man = -360;
			y_man = 210;
			g_end_man = 360;
			g_TIME_MAN = 10000;
			g_TIME_START_MAN = 0;
			g_PAUSE_MAN = -202.8;
			g_line_man = 0;

			x_girl = -360;
			y_girl = 210;
			g_end_girl= 360;
			g_TIME_GIRL =20000;
			g_TIME_START_GIRL = 0;
			g_PAUSE_GIRL = -146.11;
			g_line_girl = 0;
			//g_disable = false;


		});

		//=====================CHECK BOX==============================
		$(document.getElementById(CBOX_1)).bind("mouseup touchend", function(event) {
			event.preventDefault();

			$(document.getElementById("0:82:145:7:94:1:89")).find("image").attr('href','g1_p136_01/image/image_93_0.png');//box3 image
			$(document.getElementById("0:82:145:11:108:1:103")).find("image").attr('href','g1_p136_01/image/image_103_0.png');//box3 image
			$(document.getElementById("0:82:145:9:101:1:96")).find("image").attr('href','g1_p136_01/image/image_96_0.png');//box2 image
			// /0:72:77
			$(document.getElementById("0:72:77")).find("g").first().attr({transform: "matrix(1,0,0,1,549.95,208)"});//THang may	
			$(document.getElementById("0:3:36")).find("g").first().attr({transform: "matrix(0,0,0,0,0,0)"});//Luoi'
			$(document.getElementById("0:82:145:19:144")).attr({transform: "matrix(1,0,0,1,0,0)"});	//DONG HO
			//$(document.getElementById("0:72:77")).find("g").first().attr({transform: "matrix(1,0,0,1,549.95,100)"});	

		});
		$(document.getElementById(CBOX_2)).bind("mouseup touchend", function(event) {
			event.preventDefault();

			$(document.getElementById("0:82:145:7:94:1:89")).find("image").attr('href','g1_p136_01/image/image_89_0.png');//box3 image
			$(document.getElementById("0:82:145:11:108:1:103")).find("image").attr('href','g1_p136_01/image/image_103_0.png');//box3 image
			$(document.getElementById("0:82:145:9:101:1:96")).find("image").attr('href','g1_p136_01/image/image_100_0.png');//box2 image
			// /0:72:77matrix(0.649994,0,0,0.649994,0.1,-0.35)
			$(document.getElementById("0:72:77")).find("g").first().attr({transform: "matrix(0.9,0,0,0.9,549.95,100)"});//THang may	
			$(document.getElementById("0:3:36")).find("g").first().attr({transform: "matrix(0.5,0,0,0.5,520.1,317.05)"});//Luoi'
			$(document.getElementById("0:82:145:19:144")).attr({transform: "matrix(0.78,0,0,0.78,0,65)"});	//DONG HO
			
		});
		$(document.getElementById(CBOX_3)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			$(document.getElementById("0:82:145:7:94:1:89")).find("image").attr('href','g1_p136_01/image/image_89_0.png');//box3 image
			$(document.getElementById("0:82:145:11:108:1:103")).find("image").attr('href','g1_p136_01/image/image_107_0.png');//box3 image
			$(document.getElementById("0:82:145:9:101:1:96")).find("image").attr('href','g1_p136_01/image/image_96_0.png');//box2 image
			// /0:72:77matrix(0.649994,0,0,0.649994,0.1,-0.35)
			$(document.getElementById("0:72:77")).find("g").first().attr({transform: "matrix(0,0,0,0,0,0)"});//THang may	
			$(document.getElementById("0:3:36")).find("g").first().attr({transform: "matrix(0.85,0,0,0.85,489,230)"});//Luoi'
			$(document.getElementById("0:82:145:19:144")).attr({transform: "matrix(0.78,0,0,0.78,0,65)"});	//DONG HO
					
		});

		$(document.getElementById(CBOX4_1)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			$(document.getElementById(CBOX4_1)).hide();
			$(document.getElementById(CBOX4_2)).show();
			$(document.getElementById(BLURE_ID)).hide();

		});
		$(document.getElementById(CBOX4_2)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			$(document.getElementById(CBOX4_2)).hide();
			$(document.getElementById(CBOX4_1)).show();
			$(document.getElementById(BLURE_ID)).show();
		});

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