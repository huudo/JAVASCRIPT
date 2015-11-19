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
					var a = $(document.getElementById("0:170:95:67:86:7:83"));
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
					var a = $(document.getElementById("0:170:95:67:86:7:83"));
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

function runClock(a){
	s3=(a % 10);
			s2=Math.floor(a/10);
		if(s2>=10){
			s2= (s2%10);
		}		
		s1=Math.floor(a/100);
	$(document.getElementById("0:170:95:67:86:5:80")).find("text").empty().text(s3);
	$(document.getElementById("0:170:95:67:86:4:79")).find("text").empty().text(s2);
	$(document.getElementById("0:170:95:67:86:3:78")).find("text").empty().text(s1);
}

function taxiRun1(){
	var taxi =$(document.getElementById("0:170:95:19:71")).find("g").first();
	g_anim_taxi.add({
		duration: g_TIME_TAXI1,
		delay: 0,
		isRunAtEnd: true,
		
		data: {
			distance:{startValue: g_PAUSE_TAXI, endValue: 200, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {									
		},

		onStep: function(data, t) {					
			g_timerun_taxi1 =t;
			g_PAUSE_TAXI = data.distance.now;												
			taxi.attr({transform: ["matrix(1,0,0,1,",data.distance.now,",50.85)"].join("")});	
			if(g_PAUSE_TAXI == 200){
				g_taxi = 1;		
					if(g_check1 == true){
					$(document.getElementById(BTN_01)).show();		
					$(document.getElementById(BTN_02)).hide();
					g_anim_taxi.stop();		
								
									
				}else{
					g_anim_taxi.stop();
					taxiRun2();					
					busRun();
				}
			}
		}
	});
	g_anim_taxi.run();
}

function taxiRun2(){
	var taxi =$(document.getElementById("0:170:95:19:71")).find("g").first();
	g_anim_taxi2.add({
		duration: g_TIME_TAXI2,
		delay: 0,
		isRunAtEnd: true,
		data: {
			clock:{startValue: g_CLOCK, endValue: 40, easing: "linearTween"},
			distance:{startValue: g_PAUSE_TAXI, endValue: 600, easing: "linearTween"}
		},

		onInit: function() {},
		onComplete: function() {
			if(g_check2 == true){	
					$(document.getElementById(BTN_01)).show();		
					$(document.getElementById(BTN_02)).hide();				
					g_anim_taxi2.stop();
					g_anim_bus.stop();
					g_taxi = 2;
					g_TIME_BUS1 = g_TIME_BUS1 - g_timerun_bus1;

				}else{
					g_anim_taxi2.stop();
					taxiRun3();
					}						
		},

		onStep: function(data, t) {					

			g_CLOCK = Math.floor(data.clock.now);
			g_timerun_taxi2 =t;
			g_PAUSE_TAXI = data.distance.now;	

			runClock(g_CLOCK);
			taxi.attr({transform: ["matrix(1,0,0,1,",g_PAUSE_TAXI,",50.85)"].join("")});
									
		}
	});
	g_anim_taxi2.run();
}

function taxiRun3(){
	var taxi =$(document.getElementById("0:170:95:19:71")).find("g").first();
	g_anim_taxi3.add({
		duration: g_TIME_TAXI3,
		delay: 0,
		isRunAtEnd: true,
		
		data: {
			clock:{startValue: g_CLOCK, endValue: 60, easing: "linearTween"},
			distance:{startValue: g_PAUSE_TAXI, endValue: 800, easing: "linearTween" }
		},

		onInit: function() {},
		onComplete: function() {
			g_anim_bus.stop();
			g_anim_taxi3.stop();
		},

		onStep: function(data, t) {		
			g_CLOCK = Math.floor(data.clock.now);						
			g_timerun_taxi3 =t;
			g_PAUSE_TAXI = data.distance.now;				
			runClock(g_CLOCK);											
			taxi.attr({transform: ["matrix(1,0,0,1,",g_PAUSE_TAXI,",50.85)"].join("")});
								
		}
	});
	g_anim_taxi3.run();
}


function busRun(){
	var bus =$(document.getElementById("0:170:95:36:73")).find("g").first();

	g_anim_bus.add({
		duration: g_TIME_BUS1,
		delay: 0,
		isRunAtEnd: true,
		
		data: {
			timebus:{startValue:g_TIME_BUS, endValue: 30, easing: "linearTween"}
			
		},

		onInit: function() {},
		onComplete: function() {
		},

		onStep: function(data, t){		
			g_timerun_bus1 = t;				
			g_TIME_BUS = data.timebus.now;		
			var s = g_TIME_BUS * g_TIME_BUS;			
			bus.attr({transform: ["matrix(1,0,0,1,",s+200,",12.55)"].join("")});
			//console.log(s+200);
			//busRun();
			
		}
	});
	g_anim_bus.run();
}


var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
	},
		
	bindEvents: function() {

		MVNButton({
			id: BTN_01 //BTN_01 = "0:6:9:12:33"
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
			aniAlert();
			$(document.getElementById("0:8:68")).hide();
			$(document.getElementById(BTN_RESET)).show();
			$(document.getElementById(BTN_02)).show();		
			$(document.getElementById(BTN_01)).hide();
			if(g_taxi ==0){
				taxiRun1();
			}else{
				if(g_taxi == 1){
					g_anim_taxi.stop();
					taxiRun2();
					busRun();
				}else{
					if(g_taxi == 2){
						g_anim_taxi2.stop();
						taxiRun3();
						busRun();
					}
				}
			}
														
		});

		$(document.getElementById(BTN_02)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);

			aniAlert2();
			$(document.getElementById(BTN_01)).show();		
			$(document.getElementById(BTN_02)).hide();

			g_anim_taxi.stop();
			g_anim_taxi.reset();
			g_anim_taxi2.stop();
			g_anim_taxi2.reset();
			g_anim_taxi3.stop();
			g_anim_taxi3.reset();

			g_TIME_BUS1 = g_TIME_BUS1 - g_timerun_bus1;	
			g_TIME_TAXI1 = g_TIME_TAXI1 - g_timerun_taxi1;
			g_TIME_TAXI2 = g_TIME_TAXI2 - g_timerun_taxi2;
			g_TIME_TAXI3 = g_TIME_TAXI3 - g_timerun_taxi3;

			g_anim_bus.stop();
			g_anim_bus.reset();

				
		});
		$(document.getElementById(CBOX1)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(g_checked1 == false){
				$(document.getElementById("0:170:95:75:89:1:88")).show();
				g_check1 = true;
				g_checked1 = true;
			}else{
				$(document.getElementById("0:170:95:75:89:1:88")).hide();
				g_check1 =false;
				
				g_checked1 =false;
			}
			
		});
		$(document.getElementById(CBOX2)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(g_checked2 == false){
				$(document.getElementById("0:170:95:80:89:1:88")).show();
				g_check2 = true;
				
				g_checked2 = true;
			}else{
				$(document.getElementById("0:170:95:80:89:1:88")).hide();
				g_check2 =false;
				
				g_checked2 =false;
			}	
		
		});

		$(document.getElementById(BTN_RESET)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);	
			$(document.getElementById(BTN_RESET)).hide();
			$(document.getElementById(BTN_01)).show();
			$(document.getElementById(BTN_02)).hide();
			$(document.getElementById("0:170:95:67:86:5:80")).find("text").empty().text(0);
			$(document.getElementById("0:170:95:67:86:4:79")).find("text").empty().text(0);
			$(document.getElementById("0:170:95:67:86:3:78")).find("text").empty().text(0);

			var taxi =$(document.getElementById("0:170:95:19:71")).find("g").first();
			taxi.attr({transform: ["matrix(1,0,0,1,0,50.85)"].join("")});

			var bus =$(document.getElementById("0:170:95:36:73")).find("g").first();
			bus.attr({transform: ["matrix(1,0,0,1,200,12.55)"].join("")});

			g_taxi = 0;
			g_TIME_TAXI1 = 10*1000;
			g_TIME_TAXI2 = 20*1000;
			g_TIME_TAXI3 = 10*1000;
		
			g_TIME_BUS1 = 30*1000;
			g_TIME_BUS = 0;
			g_timerun_bus1 = 0;
		
			g_timerun_taxi1 = 0;
			g_timerun_taxi2 = 0;
			g_timerun_taxi3 = 0;
			
			
			g_PAUSE_TAXI = 0;
			
			g_CLOCK = 0;

			g_anim_taxi.reset();
			g_anim_taxi2.reset();
			g_anim_taxi3.reset();

			g_anim_bus.reset();
			

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