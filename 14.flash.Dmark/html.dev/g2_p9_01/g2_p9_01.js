//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================
var g_nOriginalWidth = parseInt(data.Fw);
var g_nOriginalHeight = parseInt(data.Fh);
var g_zoomLevel = 1;

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
		if(0)
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
//							"fd": x.rs[0].fd, // font face 
							"fd": "MS UI Gothic", // font face 
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

			g_zoomLevel = svgWidth/g_nOriginalWidth;
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
		// Chinh Text
		var a = $(document.getElementById("0:3:43:1:33:11:32:2:31")).find("foreignObject");
		a.attr({x:20,y:-4}).css({"font-family": "MS UI Gothic"});

	}

//==========================================================================
//==== Start here
//==========================================================================


// ANIMATION FOR BUTTON 1
function AniShow_01(){
	$(document.getElementById("0:3:43:1:33:7:26:1:21")).find('image').attr('href','g2_p9_01/image/image_21_0.png');	
	$(document.getElementById("0:3:43:1:33:5:26:1:21")).find('image').attr('href','g2_p9_01/image/image_21_0.png');	
	$(document.getElementById("0:3:43:1:33:1:19")).find('image').attr('href','g2_p9_01/image/image_4_0.png');		
	
}
function AniShow_011(){
	var c = $(document.getElementById("0:3:43:1:33:7:26:1:21")).find('image').attr('href','g2_p9_01/image/image_23_0.png');	
	$(document.getElementById("0:3:43:1:33:5:26:1:21")).find('image').attr('href','g2_p9_01/image/image_23_0.png');		
	$(document.getElementById("0:3:43:1:33:1:19")).find('image').attr('href','g2_p9_01/image/image_16_0.png');
		
}

// ANIMATION FOR BUTTON 2
function AniShow_02(){
	$(document.getElementById("0:3:43:1:33:7:26:1:21")).find('image').attr('href','g2_p9_01/image/image_21_0.png');	
	$(document.getElementById("0:3:43:1:33:5:26:1:21")).find('image').attr('href','g2_p9_01/image/image_21_0.png');
	
	$(document.getElementById("0:3:43:1:33:1:19")).find('image').attr('href','g2_p9_01/image/image_4_0.png');
	
}
function AniShow_021(){
	$(document.getElementById("0:3:43:1:33:7:26:1:21")).find('image').attr('href','g2_p9_01/image/image_25_0.png');	
	$(document.getElementById("0:3:43:1:33:5:26:1:21")).find('image').attr('href','g2_p9_01/image/image_25_0.png');	
	
	$(document.getElementById("0:3:43:1:33:1:19")).find('image').attr('href','g2_p9_01/image/image_18_0.png');
		
		
}
// ANIMATION FOR BUTTON 3
function AniShow_03_1(){

	var x1 =213;
	var y1 = 142;	
	y2 = 201;
	y3 = 292+142;
	y4 = 292+201;

	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                       .css({stroke:"#00a1e9","stroke-width":"1px"}).attr({x1:x1,y1:y1,x2:705,y2:y1}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                       .css({stroke:"#e4007f","stroke-width":"1px"}).attr({x1:x1,y1:y2,x2:705,y2:y2}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                        .css({stroke:"#e4007f","stroke-width":"1px"}).attr({x1:x1,y1:y3,x2:705,y2:y3}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                        .css({stroke:"#00a1e9","stroke-width":"1px"}).attr({x1:x1,y1:y4,x2:705,y2:y4}));
 }
function AniShow_03_2(){

	
	var x1 =213;
	var y1 = 142;	
	y2 = 201;
	y3 = 292+142;
	y4 = 292+201;
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#63b7dc","stroke-width":"1px"}).attr({x1:x1,y1:y1,x2:705,y2:y1}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#e075b1","stroke-width":"1px"}).attr({x1:x1,y1:y2,x2:705,y2:y2}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#e4007f","stroke-width":"1px"}).attr({x1:x1,y1:y3,x2:705,y2:y3}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                    .css({stroke:"#00a1e9","stroke-width":"1px"}).attr({x1:x1,y1:y4,x2:705,y2:y4}));

}

function AniShow_03_3(){
 
	$(document.getElementById(CENTER_ID)).empty();
	var x1 =213;
	var y1 = 142;	
	y2 = 201;
	y3 = 292+142;
	y4 = 292+201;
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y1,x2:705,y2:y1}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y2,x2:705,y2:y2}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#e4007f","stroke-width":"1px"}).attr({x1:x1,y1:y3,x2:705,y2:y3}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#00a1e9","stroke-width":"1px"}).attr({x1:x1,y1:y4,x2:705,y2:y4}));
}
function AniShow_03_4(){
	
	var x1 =213;
	var y1 = 142;	
	y2 = 201;
	y3 = 292+142;
	y4 = 292+201;
	// $(document.getElementById(CENTER_ID)).append($(createTag("line"))
	//                                    .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y1,x2:705,y2:y1}));
	// $(document.getElementById(CENTER_ID)).append($(createTag("line"))
	//                                    .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y2,x2:705,y2:y2}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#e4007f","stroke-width":"1px"}).attr({x1:x1,y1:y3,x2:705,y2:y3}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#00a1e9","stroke-width":"1px"}).attr({x1:x1,y1:y4,x2:705,y2:y4}));
}

function AniShow_03_5(){
	
	var x1 =213;
	var y1 = 142;	
	y2 = 201;
	y3 = 292+142;
	y4 = 292+201;
	// $(document.getElementById(CENTER_ID)).append($(createTag("line"))
	//                                    .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y1,x2:705,y2:y1}));
	// $(document.getElementById(CENTER_ID)).append($(createTag("line"))
	//                                    .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y2,x2:705,y2:y2}));
	
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                    .css({stroke:"#e075b1","stroke-width":"1px"}).attr({x1:x1,y1:y3,x2:705,y2:y3}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"#63b7dc","stroke-width":"1px"}).attr({x1:x1,y1:y4,x2:705,y2:y4}));


}

function AniShow_03_6(){
 
	$(document.getElementById(CENTER_ID)).empty();
	var x1 =213;
	var y1 = 142;	
	y2 = 201;
	y3 = 292+142;
	y4 = 292+201;
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y1,x2:705,y2:y1}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y2,x2:705,y2:y2}));

	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y3,x2:705,y2:y3}));
	$(document.getElementById(CENTER_ID)).append($(createTag("line"))
	                                   .css({stroke:"black","stroke-dasharray":"5px, 5px","stroke-width":"1px"}).attr({x1:x1,y1:y4,x2:705,y2:y4}));

}
// ANIMATION FOR CUT BUTTON
function AniCut(a,b){
	for(var i=a;i<b;i++){
		var x = -5 * i;
		var y = 5.0425*i;
  		$(document.getElementById(RIGHT_ID)).attr("transform", ["matrix(1,0,0,1,",x,",0)"].join(""));
  		$(document.getElementById(LEFT_ID)).attr("transform", ["matrix(1,0,0,1,",y,",0)"].join(""));
  		$(document.getElementById("0:3:43:1:33:11:32")).attr("transform", ["matrix(1,0,0,1,",y,",0)"].join(""));
  		$(document.getElementById("0:3:43:1:33:9:28")).attr("transform", ["matrix(1,0,0,1,",y,",0)"].join(""));
	}
}

//=============================HAM XU LY SU KIEN CHO CAC BUTTON=============================
// FUNCTION 01
function Show_01() {
	var currentX = 0;
	g_anim.stop();
	g_anim.add({
		duration: 1 * 1000,
		delay: 0,
		isRunAtEnd: true,
		data: {
			x: {
				startValue: currentX,
				endValue: 5,
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

			var currentValue = Math.floor(data.x.now);
			if (currentX % 2 == 1) {
				AniShow_011();
			} else {
				AniShow_01();
			}
			currentX = currentValue;
		}
	});
	g_anim.run();
}
// FUNCTION 02
function Show_02(){

	var currentX = 0;
	g_anim.stop();
	g_anim.add({
		duration: 1 * 1000,
		delay: 0,
		isRunAtEnd: true,
		data: {
			x: {
				startValue: currentX,
				endValue: 5,
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
			var currentValue = Math.floor(data.x.now);
			if (currentX % 2 == 1) {
				AniShow_021();
			} else {
				AniShow_02();
			}
			currentX = currentValue;
		}
	});
	g_anim.run();
}

//FUNCTION 03
function Show_03(){
	$(document.getElementById("0:3:43:13:42")).hide();
	$(document.getElementById("0")).append($(createTag("g")).attr({id:CENTER_ID}));
	$(document.getElementById("0")).append($(createTag("g")).attr({id:CENTER_ID2}));

	$(document.getElementById(CENTER)).hide();
	
	var currentX = 0;
	g_anim03.stop();
	g_anim03.add({
		duration: 3 * 1000,
		delay: 0,
		isRunAtEnd: true,
		data: {
			x: {
				startValue: currentX,
				endValue: 20,
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
			var currentValue = Math.floor(data.x.now);
			if(currentX <10){
				if(currentX <5){
					if(currentX %2 == 0){
						AniShow_03_1();
						}else{
							AniShow_03_2();
						}
				}else{
					AniShow_03_3(); }
					currentX = currentValue;
			}else{
				if(currentX <15 && currentX >=10){
					if(currentX %2 == 0){
						AniShow_03_4();
					}else AniShow_03_5();
				}else{
					AniShow_03_6();
				}
			}
					
			currentX = currentValue;
		}
	});
	g_anim03.run();

}

// FUNCTION CUT
function Show_cut(){
	if(g_BTN_CUT_STT == 0){
		g_BTN_CUT_STT =1;
		$(document.getElementById(CENTER_ID)).hide();
		$(document.getElementById(CENTER)).hide();
		$(document.getElementById("0:3:43:13:42")).hide();
		g_anim_cut.stop();
		 var currentX =0;
			g_anim_cut.add({
				duration: 1* 1000,
				delay: 0,
				isRunAtEnd: true,
				data: {
					x: {
						startValue: currentX,
						endValue: 36,
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
					var currentValue = Math.floor(data.x.now);	
					AniCut(currentX,currentValue);
					currentX = currentValue;																																
				}
			});
			g_anim_cut.run();
	}

}

function bindEvents(){
	// 0:17:79:3:57 : First
	// 0:17:79:5:64 : Second
	// 0:17:79:7:71 : Third
	// 0:17:79:9:78 : Cut
	// 0:17:79:1:50 : DEFAULT

	MVNButton({
		id: BTN_01
	}); // First
	MVNButton({
		id: BTN_02
	}); // Second
	MVNButton({
		id: BTN_03
	}); // Third
	MVNButton({
		id: BTN_CUT
	}); // CUT
	MVNButton({
		id: BTN_DEFAULT
	}); // DEFAULT

	$(document.getElementById(BTN_01)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		g_anim.stop();
		Show_01();
		
	}); // FIRST
	$(document.getElementById(BTN_02)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		Show_02();
		
	}); // FIRST
	$(document.getElementById(BTN_03)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		if(g_BTN_CUT_STT == 0 ){
			G_BTN03_STT =1;
			Show_03();
		}
		
	}); // FIRST
	$(document.getElementById(BTN_CUT)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
		Show_cut();

		
	}); // FIRST
	$(document.getElementById(BTN_DEFAULT)).bind("mouseup touchend", function(event) {
		event.preventDefault();
		TABS.hideTabRectangle(this.id);
			if(g_BTN_CUT_STT == 1){
			
				g_anim_cut.reset();
			}
			$(document.getElementById(CENTER_ID)).show();
			$(document.getElementById("0:3:43:13:42")).show();
			$(document.getElementById(RIGHT_ID)).attr("transform", ["matrix(1,0,0,1,",0,",0)"].join(""));
	  		$(document.getElementById(LEFT_ID)).attr("transform", ["matrix(1,0,0,1,",0,",0)"].join(""));
	  		$(document.getElementById("0:3:43:1:33:11:32")).attr("transform", ["matrix(1,0,0,1,",0,",0)"].join(""));
	  		$(document.getElementById("0:3:43:1:33:9:28")).attr("transform", ["matrix(1,0,0,1,",0,",0)"].join(""));
	  		g_BTN_CUT_STT = 0;
	  		$(document.getElementById(CENTER_ID)).remove();
	  		$(document.getElementById(CENTER)).show();
  			  				
	}); // FIRST

}

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

function initGame(){
	bindEvents();

}	
//=========KHAI BAO BIEN GLOBAL==================================================================
	var g_nOriginalWidth = parseInt(data.Fw);
	var g_nOriginalHeight = parseInt(data.Fh);

	// 0:17:79:3:57 : Fist
	// 0:17:79:5:64 : Second
	// 0:17:79:7:71 : Third
	// 0:17:79:9:78 : Cut
	// 0:17:79:1:50 : DEFAULT
	// 0:3:43:1:33:7:26 :LEFT  
	// 0:3:43:1:33:7:26:1:21 : SHAPE LEFT
	// 0:3:43:1:33:5:26 : RIGHT
	// 0:3:43:1:33:5:26:1:21 : SHAPE RIGHT
	// 0:3:43:1:33:1:19 : CENTER
	// 0:3:43:1:33:1:19:1:4 : SHAPE CENTER
var LEFT_ID = "0:3:43:1:33:7:26";
var LEFT_SHAPE_ID = "0:3:43:1:33:7:26:1:21";
var RIGHT_ID = "0:3:43:1:33:5:26";
var RIGHT_SHAPE_ID = "0:3:43:1:33:5:26:1:21";
var CENTER = "0:3:43:1:33:1:19";
var CENTER_SHAPE_ID = "0:3:43:1:33:1:19:1:4 ";  
var CENTER_ID ="CENTER_ID"; 
var CENTER_ID2 = "CENTER_ID2";

var BTN_01 = "0:17:79:3:57";
var BTN_02 = "0:17:79:5:64";
var BTN_03 = "0:17:79:7:71";
var BTN_CUT = "0:17:79:9:78";
var BTN_DEFAULT = "0:17:79:1:50";
var g_check = 0;
var g_BTN_CUT_STT = 0;
var g_anim = new Animation();
var g_anim03 =new Animation();
var g_anim_cut = new Animation();
var G_BTN03_STT =0;
//==== CONSTANTS Begin ===========================================================================


//==== CONSTANTS End =============================================================================



})();

