//=======================================================================
// Khai báo global variables ở đây.
//=======================================================================
var g_nOriginalWidth = parseInt(data.Fw);
var g_nOriginalHeight = parseInt(data.Fh);
var NEW_HEIGHT = 900;
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
//		if(0)
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

		console.log(g_nOriginalWidth, g_nOriginalHeight);
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

		//==== Remove text.
		g_nOriginalWidth = 1086;
		g_nOriginalHeight = NEW_HEIGHT;
//		console.log("g_nOriginalWidth, g_nOriginalHeight", g_nOriginalWidth, g_nOriginalHeight);
	});

//=======================================================================
// Đoạn dưới đây chạy sau khi data được render bởi sprite.js
//=======================================================================
	$(document).bind("frameRendered", function (event, data) {
//		// // console.log("frameRendered", data.spriteId);
		if (data.spriteId != "Mf")
			return false;
		


		$("svg:first").attr({
			viewbox: ["0 0 1086 ",NEW_HEIGHT].join(""),
			width: 1086,
			height: NEW_HEIGHT
		}).css({
			width: 1086,
			height: NEW_HEIGHT
		});
		$("svg:first")[0].setAttribute("viewBox", ["0 0 1086 ",NEW_HEIGHT].join(""));
		$("svg:first")[0].setAttribute("width", "1086px");
		$("svg:first")[0].setAttribute("height", [NEW_HEIGHT,"px"].join(""));
		$(document.getElementById("0").firstChild.nextSibling).attr({
			transform: "matrix(1,0,0,1,0,-420)"
		});
		$("rect:first")[0].setAttribute("height", NEW_HEIGHT);
		$("body").css("overflow", "");
		console.log(g_nOriginalWidth, g_nOriginalHeight);

		// Run one time only.
		global_BindEvents();
//		$(window).trigger("resize");
		GAME.initGame();
	});


})();
