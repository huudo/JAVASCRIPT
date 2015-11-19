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
		if(1)
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
							"fd": x.rs[0].fd, // font face 
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
		TABS.init(g_nOriginalWidth, g_nOriginalHeight);
		TABS.updateTabIdSelected("screen1");
		$(document).mousedown(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

		$(window).blur(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});	
		$(document).mousedown(function() {
//			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

		$(window).blur(function() {
//			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

	}


function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}
function AjustText(){
	// 0:97:91:18:90
	var ajustX1 = new Array("0:3:48:1:45:69:25","0:3:48:1:45:68:24","0:3:48:1:45:67:23","0:3:48:1:45:66:22","0:3:48:1:45:65:21");
	var ajustX2 = new Array("0:3:48:1:45:70:26","0:3:48:1:45:71:27","0:3:48:1:45:72:28","0:3:48:1:45:73:29","0:3:48:1:45:74:30");
	var ajustY1 = new Array("0:3:48:1:45:82:38","0:3:48:1:45:83:39","0:3:48:1:45:84:40","0:3:48:1:45:85:41","0:3:48:1:45:86:42","0:3:48:1:45:87:43","0:3:48:1:45:88:44");
	var ajustY2 = new Array("0:3:48:1:45:75:31","0:3:48:1:45:76:32","0:3:48:1:45:77:33","0:3:48:1:45:78:34","0:3:48:1:45:79:35","0:3:48:1:45:80:36","0:3:48:1:45:81:37"); 
	for(j=0; j< 5 ; j++){
		 $(document.getElementById(ajustX1[j])).find("text").attr({x:-1,  y:17}).css({"font-family": "MS Mincho"});
	}

	for(j=0; j< 5 ; j++){
		 $(document.getElementById(ajustX2[j])).find("text").attr({x:5,  y:17}).css({"font-family": "MS Mincho"});
	}
 
 	for(j=0; j <7; j++){
 		 $(document.getElementById(ajustY1[j])).find("text").attr({x:4,  y:17}).css({"font-family": "MS Mincho"});
 	}

 	for(j=0; j <7; j++){
 		 $(document.getElementById(ajustY2[j])).find("text").attr({x:1,  y:17}).css({"font-family": "MS Mincho"});
 	}
// 	0:97:91:16:87
	 $(document.getElementById("0:97:91:16:87")).find("text").attr({x:115,  y:32}).css({"font-family": "MS UI Gothic","text-anchor": "middle"});
	var a = $(document.getElementById("0:97:91:18:90")).find("text").attr({x:64,  y:63}).css({"font-family": "MS UI Gothic","text-anchor": "middle"});
	var b = $(document.getElementById("0:97:91:10:82:2:81")).find("text").attr({x:0,  y:33}).css({"font-family": "MS UI Gothic"});
	var c = $(document.getElementById("0:97:91:13:86:2:85")).find("text").attr({x:-5,  y:33}).css({"font-family": "MS UI Gothic"});
}
function initGame() {
bindEvents();
AjustText();
// document.getElementById(COUNTER).innerHTML = '<defs/><g><g transform="matrix(0.753235,0,0,0.753296,-377.1,206.25)"><foreignObject x="-21.05" y="-2" width="171.20000000000002" height="84"><body><div style="text-align: center;"><p><text id="count" style="font-size: 76px; color: rgb(0, 0, 0);"></text></p></div></body></foreignObject></g></g>';
// document.getElementById('count').innerHTML =g_diem;
//	drawGame();

}

function drawGame_oneAB(a, b) {
$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
		id: "point_container",
		type: "sprite"
	}))
 for(var i=a; i<b; i++) {
  var point = $(createTag("circle"))
   .css({stroke: "black", fill: "black"})
   .attr({id: "test"+i, cx: i*35, cy: -2* i*35, r: 3});
   g_check++;
  $(document.getElementById("0:97:91:18:90")).find("text").empty().text(g_check);
   // document.getElementById('count').innerHTML = check;
  $(document.getElementById("point_container")).append(point);
 }
}

function drawGame_05AB(a, b) {
	$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
		id: "point_container",
		type: "sprite"
	}))
		
			for (var i = a; i < b; i++) {
				var point = $(createTag("circle"))
					.css({
						stroke: "black",
						fill: "black"
					})
					.attr({
						id: "test" + i,
						cx: i * 35/2,
						cy: -2 * i * 35/2,
						r: 3
					});
				g_check += 1;
				if(g_check <=17){
						$(document.getElementById("0:97:91:18:90")).find("text").empty().text(g_check);
				}
				$(document.getElementById("point_container")).append(point);
			}
		
}
//=== draw nPhat

function drawGameRandom(nPhat) {
	//	console.log(nPhat);
	// document.getElementById(COOR_ID).innerHTML += '<g id="point_container" type="sprite"></g>';
	$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
		id: "point_container",
		type: "sprite"
	}))

	for (var i = 0; i < nPhat; i++) {
		var ran_number = Math.random() * 8 - 4;
		var point = $(createTag("circle"))
			.css({
				stroke: "black",
				fill: "black"
			})
			.attr({
				id: "test" + i,
				cx: ran_number * 35,
				cy: -2 * ran_number * 35,
				r: 3
			});
		$(document.getElementById("point_container")).append(point);
	}

}

function drawGame_one() {
	if(BTN1_status==0 && BTN05_status==0){
		BTN1_status =1;
		var currentX = -4; 
		
		g_anim.add({
			duration: 0.5 * 1000,
			delay: 0,
			isRunAtEnd: true,
			data: {
				x: {
					startValue: currentX,
					endValue: 4,
					easing: "linearTween"
				}
			},
			onInit: function() {
				// console.log(+new Date());
			},
			onComplete: function() {
				// console.log(+new Date());
			},
			onStep: function(data, t) {
				//   console.log(data.x.now);
				var currentValue = Math.floor(data.x.now);
				if(currentValue == Math.floor(currentX)+1 && g_check < 9){
					if(currentValue==4) currentValue=currentValue+1;
					drawGame_oneAB(currentX, currentValue);
					currentX = currentValue;				
				}
			}
		});
	
		g_anim.run();
	}

}

function drawGame_05() {	
	if(BTN05_status == 0){
		BTN05_status = 1; 
		var currentX = -8;
		g_anim.stop();
		g_anim.add({
			duration: 1 * 1000,
			delay: 0,
			isRunAtEnd: true,
			data: {
				x: {
					startValue: currentX,
					endValue: 8,
					easing: "linearTween"
				}
			},
			onInit: function() {
				// console.log(+new Date());
			},
			onComplete: function() {
				// console.log(+new Date());
			},
			onStep: function(data, t) {
				//   console.log(data.x.now);

				var currentValue = Math.floor(data.x.now);			
						if(currentValue - Math.floor(currentX) == 1 ){
							if(currentValue==8){currentValue++;}
									drawGame_05AB(currentX, currentValue);
									currentX = currentValue;
						}					
			}
		});
		g_anim.run();
	}	
	
}


function drawGameRD() {
	var nPhat = 0;
	g_anim.reset();
	g_anim.add({
		duration: g_speed * 1000,
		delay: 0,
		isRunAtEnd: true,
		data: {
			phat: {
				startValue: nPhat,
				endValue: g_end,
				easing: "linearTween"
			}
		},
		onInit: function() {
			// console.log(+new Date());
		},
		onComplete: function() {
			// console.log(+new Date());

		},
		onStep: function(data, t) {
			var currentValue = Math.floor(data.phat.now);
			drawGameRandom(currentValue - nPhat);
			nPhat = currentValue;			
			 $(document.getElementById("0:97:91:18:90")).find("text").empty().text(g_check+currentValue);			
		}
	});
	g_anim.run();
}


function bindEvents() {
	//g#0:97:91:1:55, g#0:97:91:3:62, g#0:97:91:5:69, g#0:97:91:7:76
	MVNButton({
		id: BTN_RESET
	}); // Reset Game.
	MVNButton({
		id: BTN_DETAILS
	}); // More Detail
	MVNButton({
		id: BTN_05
	}); // Độ mịn 0.5
	MVNButton({
		id: BTN_1
	}); // Độ mịn 1

	$(document.getElementById(BTN_1)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		if(BTN_DETAILS_status>0){	
			var test = parseInt($(document.getElementById("0:97:91:18:90")).find("text").text());			
			if(test < 9){	
				g_anim.stop();
				g_anim.reset();	
				drawGame_one();			
			}
		}else{
			g_anim.stop();
			drawGame_one();	
		}
		
	}); // Độ mịn 1
	$(document.getElementById(BTN_05)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		var test = parseInt($(document.getElementById("0:97:91:18:90")).find("text").text());			
		if(BTN_DETAILS_status>0){	
			var test = parseInt($(document.getElementById("0:97:91:18:90")).find("text").text());			
			if(test < 17){	
				g_anim.stop();
				g_anim.reset();
				g_check = test;	
				drawGame_05();			
			}
		}else{			
			g_check = test;
			drawGame_05();		
		}
				
	}); // Độ mịn 0.5

	$(document.getElementById(BTN_DETAILS)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		if(g_check <=17){
			g_giatri = g_check;
		}
		switch( BTN_DETAILS_status+1){
			case 1: 
				g_speed =2;
				g_end = 50-g_giatri;
				break;														
			case 2:
				g_speed = 2;
				g_end = 50;
				break;
			
			case 3:
				g_speed = 3;
				g_end = 100;
				break;
			
			case 4:
				g_speed = 20;
				g_end = 800;
				break;
			
			case 5: 
				g_speed = 6;
				g_end = 200;
				break;
			default:
			
		}
		console.log("huu", BTN_DETAILS_status+1);
		BTN_DETAILS_status = (BTN_DETAILS_status+1) % 5;		
		if (g_anim.isRunning()) {
			var test = $(document.getElementById("0:97:91:18:90")).find("text").text();			
			g_check = parseInt(test);			
			console.log("g_check", g_check);
			drawGameRD();
			g_anim.run();
			// return;
		} else{				
			console.log("=========================");
			var test = $(document.getElementById("0:97:91:18:90")).find("text").text();
			g_check = parseInt(test);	
			console.log("g",g_check);	
			drawGameRD();			
		}

	}); // Độ mịn chi tiết
	$(document.getElementById(BTN_RESET)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		$(document.getElementById("point_container")).remove();
		g_currentX = 1;
		g_check = 0;
		g_giatri = 0;
		BTN05_status =0;
		BTN1_status =0;
		BTN_DETAILS_status=0;
		BTN_RESET_status =0;
		$(document.getElementById("0:97:91:18:90")).find("text").empty().text(0);
		g_anim.reset();
	}); // Độ mịn chi tiết
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

		initGame();
	});

//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================
var g_nOriginalWidth = parseInt(data.Fw);
var g_nOriginalHeight = parseInt(data.Fh);

//==== CONSTANTS Begin ===========================================================================
var COOR_ID = "0:3:48:1:45";

var BTN_05 = "0:97:91:5:69";
var BTN_1 = "0:97:91:7:76";
var BTN_DETAILS =  "0:97:91:3:62";
var BTN_RESET = "0:97:91:1:55";
var COUNTER = "0:97:91:18:90";

var BTN05_status =0;
var BTN1_status =0;
var BTN_DETAILS_status=0;
var BTN_RESET_status =0;
var count =  $(document.getElementById("0:97:91:18:90")).find("text");
var g_anim = new Animation();
var g_giatri = 0;
var g_check = 0;
var g_end = 0;
var g_speed = 2;
//==== CONSTANTS End =============================================================================



})();