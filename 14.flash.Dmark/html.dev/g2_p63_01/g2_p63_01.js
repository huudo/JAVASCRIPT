(function() {

	// Deal with IE9 console bug.
	if (typeof(window.console) == 'undefined' || typeof(window.console.log) == 'undefined')
		window.console = {
			log: function() {} // Disable console.log
		};

	function findSpriteDataById(a, spriteId) {
		for (var i = 0; i < a.length; i++) {
			if (typeof(a[i].id) === 'number' && a[i].id == spriteId) {
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
		if (1)
			for (var i = 0, a = data.tg; i < a.length; i++) {
				if (a[i].tp == 11 && a[i].tt == "html") { // find text element with html content.
					var x = a[i];
					var o = {
						"id": x.id,
						"tf": x.tf,
						"tp": 11,
						"rs": [{
							"b": false, // bold = false
							"c": x.rs[0].c, // color
							"fd": x.rs[0].fd, // font face 
							"h": x.rs[0].fs, // font size
							"tx": x.rs[0].tx, // text
							"x": x.bd.l, // bd.left
							"y": x.bd.t // bd.top
						}]
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

		$("div:first").css({
			overflow: "hidden",
			position: "absolute",
			top: 0,
			left: 0,
			width: "100%",
			height: "100%"
		});

		if(1)
			$(window).resize(function() {
				var ratio = g_nOriginalWidth / g_nOriginalHeight;
				var w = $(this).width();
				var h = $(this).height();
				var svgWidth = w;
				var svgHeight = h;
				//			paddingLeft = 0;
				paddingTop = 0;
				if (w / h < ratio) {
					svgHeight = w / ratio;
					paddingTop = (h - svgHeight) / 2;
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
			.attr("unselectable", "on")
			.css({
				"user-select": "none"
			})
			.on("selectstart", false);

		TABS.init(g_nOriginalWidth, g_nOriginalHeight);
		TABS.updateTabIdSelected("screen1");
		$(document).mousedown(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});

		$(window).blur(function() {
			TABS.hideTabRectangle(); // Khi chuyen qua lai cac man hinh tab van o chinh no.
		});
	}

	function initGame() {
		bindEvents();

		$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
			"id": "point_container", "transform": ["matrix(1.09998,0,0,1.09998,530,275)"].join("")
		}))

		$(document.getElementById(BTN_move_a)).attr({"transform": ["matrix(1,0,0,1,160,0)"].join("")});

		draw_ax(2,0);

	}	


	

	function bindEvents() {
		//	g#0:97:91:1:55, g#0:97:91:3:62, g#0:97:91:5:69, g#0:97:91:7:76

		var BTN_reset = "0:34:141:5:66";
		var BTN_show = "0:34:141:3:59";
		var BTN_draw = "0:34:141:7:73";

		var BTN_remove_0 = "0:34:141:87:140:81:139";
		var BTN_remove_1 = "0:34:141:87:140:83:139";
		var BTN_remove_2 = "0:34:141:87:140:85:139";
		var BTN_remove_3 = "0:34:141:87:140:87:139";

		MVNButton({
			id: BTN_reset
		}); // Reset Game.
		MVNButton({
			id: BTN_draw
		}); // draw game
		MVNButton({
			id: BTN_show
		}); // ẩn hiện đồ thị

		MVNButton({
			id: increase_a
		}); // tang a
		MVNButton({
			id: increase_b
		}); // tang b
		MVNButton({
			id: decrease_a
		}); // giam a 
		MVNButton({
			id: decrease_a
		}); // giam b 

		MVNButton({
			id: BTN_remove_0
		}); 
		MVNButton({
			id: BTN_remove_1
		}); 
		MVNButton({
			id: BTN_remove_2
		}); 
		MVNButton({
			id: BTN_remove_3
		}); 

		$(document.getElementById(BTN_show)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			show_all();
		});
		$(document.getElementById(BTN_draw)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			drawSlot();
		});
		$(document.getElementById(BTN_reset)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			reset_all();

		});

		$(document.getElementById(increase_a)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(g_move_a_x < 5)action_increase_a();
			
		});

		$(document.getElementById(decrease_a)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(g_move_a_x > -5)action_decrease_a();
			
		});

		$(document.getElementById(increase_b)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(g_move_b < 5) action_increase_b();
			
		});

		$(document.getElementById(decrease_b)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			if(g_move_b > -5) action_decrease_b();
			
		});

		$(document.getElementById(BTN_remove_1)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			remove_1();
		});

		$(document.getElementById(BTN_remove_2)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			remove_2();
		});

		$(document.getElementById(BTN_remove_3)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			remove_3();
		});

		$(document.getElementById(BTN_remove_0)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			remove_0();
		});


		// <<=========== start drag a

		
		$(document.getElementById(BTN_move_a)).bind("draginit", function(event) {
			this.startPosition = {
				x: event.clientX, //toa do ban dau cua chuot
				t: g_move_a_x //gia tri ban dau cua chuot  
			};

		}).drag(function(event) {
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel/0.899994; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			p = this.startPosition.t + (dX / dist);
			if (!(-5 <= g_move_a_x && g_move_a_x <= 5)) return;

			//console.log(g_move_a_x.toFixed(1) % 0.2);
			g_move_a_x = p;
			
			if(show_status == 0){
				if((Math.abs(g_move_a_x).toFixed(1) % 0.2) == 0) draw_ax(g_move_a_x, g_move_b);
				console.log(g_move_a_x.toFixed(1) % 0.2);
			}else{
				draw_ax(g_move_a_x, g_move_b);
			}
			global_AdjustTextDragA();


		}).drag("dragend", function(event) {
			
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel/0.899994; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			p = this.startPosition.t + (dX / dist);

			if (g_move_a_x < -5) p = -5;
			if (g_move_a_x > 5) p = 5;
		
			for(var i=0; i<g_aRulers.length-1; i++) {
				if(g_aRulers[i]<=p && p<=g_aRulers[i+1]) {
					if(p<(g_aRulers[i]+g_aRulers[i+1])/2) {
						p = g_aRulers[i];
					} else {
						p = g_aRulers[i+1];
					}
					break;
				}
			}	

			g_move_a_x = p;

			draw_ax(g_move_a_x, g_move_b);

			global_AdjustTextDragEndA();

		}).css({
			cursor: "pointer"
		});

		// ============>> end drag a


		// <<============ start drag b
		
		$(document.getElementById(BTN_move_b)).bind("draginit", function(event) {
			this.startPosition = {
				x: event.clientX, //toa do ban dau cua chuot
				t: g_move_b //gia tri ban dau cua chuot  
			};
			

		}).drag(function(event) {
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel/0.899994; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			p = this.startPosition.t + (dX / dist);
			if (!(-5 <= g_move_b && g_move_b <= 5)) return;
			

			g_move_b = p;
			console.log(show_status);
			if(show_status == 0){
				if((Math.abs(g_move_b).toFixed(1) % 0.2) == 0){
					draw_ax(g_move_a_x, g_move_b);
				}
				console.log(g_move_b.toFixed(1) % 0.2);
			}else{
				draw_ax(g_move_a_x, g_move_b);
			}
			global_AdjustTextDragB();
			
			

		}).drag("dragend", function(event) {
			
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel/0.899994; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			p = this.startPosition.t + (dX / dist);
			

			if (g_move_b < -5) p = -5;
			if (g_move_b > 5) p = 5;

			for(var i=0; i<g_aRulers_b.length-1; i++) {
				if(g_aRulers_b[i]<=p && p<=g_aRulers_b[i+1]) {
					if(p<(g_aRulers_b[i]+g_aRulers_b[i+1])/2) {
						p = g_aRulers_b[i];
					} else {
						p = g_aRulers_b[i+1];
					}

					break;
				}

			}	
			
			g_move_b = p;
			draw_ax(g_move_a_x, g_move_b);
			global_AdjustTextDragEndB();
			

		}).css({
			cursor: "pointer"
		});

		// ============>> end drag b

	}


	//==========================================================================
	//==== Start here
	//==========================================================================

	global_PatchData();
	//=======================================================================
	// Đoạn dưới đây chạy sau khi data được xử lý bởi sprite.js
	// nhưng trước khi shapes được render.
	//=======================================================================
	$(document).bind("beforeRender", function() {
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
	$(document).bind("frameRendered", function(event, data) {

		if (data.spriteId != "Mf")
			return false;

		global_AdjustTextPos();
		// Run one time only.
		global_BindEvents();
		// $(window).trigger("resize");
		initGame();
	});



})();