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
	//if(1)
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
		$(document.getElementById('0:72:77:9:76:1:64')).find("text").attr({x:24,y:35}).css({"font-family": "MS PMincho"});
		$(document.getElementById('0:72:77:9:76:2:65')).find("text").attr({x:26,y:36}).css({"font-family": "MS PMincho"});
		
		//b.attr({"transform": "matrix(0.5,0,0,0.5,0,210)"})
		var a = $(document.getElementById("0:3:36")).find("text");
			a.attr({x:3,y:24}).css({"font-family": "MS PMincho"});
		//0:3:36:66:33
		var text1 = new Array("0:3:36:53:20","0:3:36:54:21","0:3:36:55:22","0:3:36:56:23","0:3:36:57:24","0:3:36:58:25","0:3:36:59:26","0:3:36:60:27","0:3:36:61:28");
		for(var i=0;i<9;i++){
			$(document.getElementById(text1[i])).find("text").attr({x:8,y:24});
		}
		var b = $(document.getElementById("0:3:36:67:34")).find("text");
			b.attr({x:48,y:22});
		var c = $(document.getElementById("0:3:36:66:33")).find("text");
			c.attr({x:65,y:28});
			c.css({"font-family": "MS PMincho"});
			//0:3:36:68:35
		var d = $(document.getElementById("0:3:36:68:35")).find("text");
			d.attr({x:50,y:26});	
		
		var e = $(document.getElementById("0:3:36:65:32")).find("text");
			e.attr({x:61,y:28});		
		$(document.getElementById("0:82:145:19:144")).attr({transform: "matrix(0.79,0,0,0.78,0,65)"});

		$(document.getElementById(BLURE_ID)).hide();
		$(document.getElementById(SECONDE_ID)).find("text").attr({x:52,y:68});
		$(document.getElementById(MINUTE_ID)).find("text").attr({x:52,y:68});
		$(document.getElementById(HOUR_ID)).find("text").attr({x:52,y:68});
	
		$(document.getElementById("0:82:145:19:144:2:132")).find("text").attr({x:38,y:40});
		
		$(document.getElementById("0:82:145:5:85")).find("text").attr({x:50,y:19});

		$(document.getElementById(MAN_ID)).hide();

		$(document.getElementById("0:82:145:7:94:1:89")).find("image").attr('href','g1_p136_01/image/image_93_0.png');//box3 image
		$(document.getElementById("0:82:145:11:108:1:103")).find("image").attr('href','g1_p136_01/image/image_103_0.png');//box3 image
		$(document.getElementById("0:82:145:9:101:1:96")).find("image").attr('href','g1_p136_01/image/image_96_0.png');//box2 image
		// /0:72:77
		$(document.getElementById("0:72:77")).find("g").first().attr({transform: "matrix(1,0,0,1,549.95,208)"});//THang may	
		$(document.getElementById("0:3:36")).find("g").first().attr({transform: "matrix(0,0,0,0,0,0)"});//Luoi'
		$(document.getElementById("0:82:145:19:144")).attr({transform: "matrix(1,0,0,1,0,0)"});	//DONG HO

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
		TABS.updateTabIdSelected("home");
		console.log("updateTabIdSelected");
		$(document).mousedown(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

		$(window).blur(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

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


		GAME.initGame();
	});


})();
