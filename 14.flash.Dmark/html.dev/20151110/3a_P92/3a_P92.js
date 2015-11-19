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


		TABS.init(g_nOriginalWidth, g_nOriginalHeight);
		TABS.updateTabIdSelected("home");
		//console.log("updateTabIdSelected");
		$(document).mousedown(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

		$(window).blur(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

	}

	function bindEvents() {
		
		var BTN_reset = "0:631:343";
		var BTN_showText = "0:637:360";

		MVNButton({
			id: BTN_start
		}); // Start game.
		MVNButton({
			id: BTN_reset
		}); // Reset game

		MVNButton({
			id: BTN_reset
		}); // Reset text and ball

		$(document.getElementById(BTN_start)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			start_run();

		});

		$(document.getElementById(BTN_stop)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			stop_run();

		});

		$(document.getElementById(BTN_reset)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			reset_all();
		});

		$(document.getElementById(BTN_showText)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			showText();
		});

		

		// <<=========== start drag a

		
		$(document.getElementById(BTN_move)).bind("draginit", function(event) {
			this.startPosition = {
				x: event.clientX, //toa do ban dau cua chuot
				t: g_current_time //gia tri ban dau cua chuot  
			};

		}).drag(function(event) {
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel/2; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			p = this.startPosition.t + (dX / dist);
			g_current_time = p;

			s = 1/2 * 0.4 * g_current_time * g_current_time;
			if(g_current_time < 0){
				g_current_s = 0;
			}else{
				g_current_s = s;
			}
			

			if(BTN_show.status && g_current_time >= 0) check_show_text(s);

			if(p >= 6){
				_$(BTN_start).hide();
				_$(BTN_reset).show();
			}else{
				_$(BTN_start).show();
			}
			_$(BTN_stop).hide();
			if ((0 <= g_current_time && g_current_time <= 6)){
				$(document.getElementById(BTN_move)).attr({
					"transform": ["matrix(1,0,0,1,", g_current_time*dist, ",0)"].join("")
				});
				$(document.getElementById(g_ball)).attr({
					"transform": ["matrix(1,0,0,1,", s*100, ",0)"].join("")
				});
			}


			//global_AdjustTextDragA();

		}).drag("dragend", function(event) {
			
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel/2; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			p = this.startPosition.t + (dX / dist);

			if (g_current_time < 0) p = 0;
			if (g_current_time > 6) p = 6;
			if (g_current_time >= 6) p = 6;
			g_current_time = p;
			s = 1/2 * 0.4 * g_current_time * g_current_time;
			g_current_s = s;
			$(document.getElementById(BTN_move)).attr({
				"transform": ["matrix(1,0,0,1,", p*dist, ",0)"].join("")
			});

			$(document.getElementById(g_ball)).attr({
				"transform": ["matrix(1,0,0,1,", s*100, ",0)"].join("")
			})
			
			if(BTN_show.status) check_show_text(s);

		}).css({
			cursor: "pointer"
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
		adjustText();
		bindEvents();
//		$(window).trigger("resize");


		GAME.initGame();
	});


})();
