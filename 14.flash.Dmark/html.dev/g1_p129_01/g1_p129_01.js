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

	function global_AdjustTextPos() {
		// Adjust text GRAPH.
		// 
		var txt = $(document.getElementById("0:92:78:13:73:2:72")).find("text").attr({x:1.5,  y:34}).css({"font-family": "MS UI Gothic"});
		var txt2 = $(document.getElementById("0:92:78:16:77:2:76")).find("text").attr({x:-4,  y:34}).css({"font-family": "MS UI Gothic"});
		var txt_count = $(document.getElementById("0:92:78:11:68")).find("text").attr({x:47,  y:65}).css({"font-family": "MS UI Gothic"});
		var txt_x = $(document.getElementById("0:92:78:12:69")).find("text").attr({x:12,  y:33}).css({"font-family": "MS UI Gothic"});
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
				//			var paddingLeft = 0;
				var paddingTop = 0;
				if (w / h < ratio) {
					svgHeight = w / ratio;
					paddingTop = (h - svgHeight) / 2;
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

	function createTag(tag) {
		return document.createElementNS("http://www.w3.org/2000/svg", tag)
	}

	function move_counter(){
		if(current_point.toString().length == 2) var txt_count = $(document.getElementById("0:92:78:11:68")).find("text").attr({x:27});
		if(current_point.toString().length == 3) var txt_count = $(document.getElementById("0:92:78:11:68")).find("text").attr({x:8});
		if(current_point.toString().length == 4) var txt_count = $(document.getElementById("0:92:78:11:68")).find("text").attr({x:-12});
	};

	function initGame() {

		bindEvents();
		var arr = [ "0:3:36:1:33:83:32", "0:3:36:1:33:73:22", "0:3:36:1:33:72:21"];
		
		$.each(arr, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({x:0.25 ,y:17}).css({"font-family": "MS PMincho"});
		});

		var arr_x = ["0:3:36:1:33:74:23", "0:3:36:1:33:75:24", "0:3:36:1:33:76:25" ];

		$.each(arr_x, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({x:5.25 ,y:17}).css({"font-family": "MS PMincho"});
		});
		var arr_y = [ "0:3:36:1:33:82:31", "0:3:36:1:33:81:30", "0:3:36:1:33:80:29"];
		
		$.each(arr_y, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({x:5 ,y:17}).css({"font-family": "MS PMincho"});
		});

		var arr_y2 = ["0:3:36:1:33:79:28", "0:3:36:1:33:78:27", "0:3:36:1:33:77:26" ];
		$.each(arr_y2, function( index, value ) {
			$(document.getElementById(value)).find("text").attr({x:-0.5 ,y:17}).css({"font-family": "MS PMincho"});
		});

		
	}

	//===== Draw point from [a, b] 16 point
	function drawGame_oneAB(a, b) {
		//alert('a');
		if (b == 8) b += 1;
		for (var i = a; i < b; i++) {
			if(current_point < 16) txt_point.empty().text(1+parseInt(current_point)); 
			if (i == 0) continue;

			var point = $(createTag("circle"))
				.css({
					stroke: "black",
					fill: "black"
				})
				.attr({
					id: "test" + i,
					cx: i * 35,
					cy: -6 / i * 35,
					r: 3
				});

			$(document.getElementById(point_container)).append(point);
			
		}
		move_counter();
		console.log(current_point);
	}
	

	//===== action draw 16 poitn
	function drawGame_one() {
		
		if (BTN_07_status != 1 && current_point < 16) {
			g_anim.stop();
			g_anim.reset();
			g_anim_five.stop();
			g_anim_five.reset();
			$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
					id: "point_container"
				}))
			txt_point = $(document.getElementById("0:92:78:11:68")).find("text");
			current_point = parseInt(txt_point.text());
			//alert(current_point);
			var currentX = -8;

			g_anim.add({
				duration: 1.6 * 1000,
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
					BTN_07_status = 1;
				},
				onComplete: function() {
					//g_anim.reset();
				},
				onStep: function(data, t) {

					var currentValue = Math.floor(data.x.now);

					if ((currentValue == (Math.floor(currentX) + 1))) {

						
						current_point = parseInt(txt_point.text());
						drawGame_oneAB(currentX, currentValue);
						currentX = currentValue;
					}

				}
			});

			g_anim.run();
			//g_anim.stop();

		}
		BTN_07_status = 1;

	}

	//===== Draw point from [a, b] 30 point
	function drawGame_fiveAB(a, b) {
		txt_point = $(document.getElementById("0:92:78:11:68")).find("text");
		//current_point = parseInt(txt_point.text());
		if (b == 8) b += 0.5;
		for (var i = a; i < b; i+=0.5) {
			if (i == 0) continue;

			var point = $(createTag("circle"))
				.css({
					stroke: "black",
					fill: "black"
				})
				.attr({
					id: "test" + i,
					cx: i * 35,
					cy: -6 / i * 35,
					r: 3
				});
			if(current_point < 30) {
				current_point++;
				txt_point.empty().text(parseInt(current_point));
			} 
			$(document.getElementById(point_container)).append(point);
			current_point = parseInt(txt_point.text());
		}
		//console.log(point);
		move_counter();
	}
	//===== Draw point from [a, b] 16 point change to  30 point
	function drawGame_fiveAB_plus(a, b) {
		txt_point = $(document.getElementById("0:92:78:11:68")).find("text");
		//current_point = parseInt(txt_point.text());
		if (b == 8) b = b + 0.5;
		for (var i = a; i < b; i = i + 0.5) {
			if (i == 0 || i == 0.5 || i == (-0.5)) continue;

			var point = $(createTag("circle"))
				.css({
					stroke: "black",
					fill: "black"
				})
				.attr({
					id: "test" + i,
					cx: i * 35,
					cy: -6 / i * 35,
					r: 3
				});
			if(current_point < 30) txt_point.empty().text(1+parseInt(current_point)); 
			$(document.getElementById(point_container)).append(point);
			current_point = parseInt(txt_point.text());
		}
		//console.log(point);
		move_counter();
	}

	//===== action draw 30 poitn
	function drawGame_five() {

		if (BTN_05_status != 1 && current_point < 30) {
			g_anim.stop();
			g_anim.reset();
			g_anim_five.stop();
			g_anim_five.reset();

			$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
				id: "point_container"
			}))
			current_point = parseInt($(document.getElementById("0:92:78:11:68")).find("text").text());
			var currentX = -8;

			//g_anim.reset();
			g_anim_five.add({
				duration: 3 * 1000,
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
					BTN_05_status = 1;
					//console.log(+new Date());
				},
				onComplete: function() {
					//console.log(+new Date());
					g_anim.reset();
				},
				onStep: function(data, t) {

					var currentValue = Math.floor(data.x.now);

					if ((currentValue == (Math.floor(currentX) + 1))) {
						drawGame_fiveAB(currentX, currentValue);

					}
					//console.log(currentX, currentValue);
					console.log(currentValue);
					currentX = currentValue;

				}
			});
			if (current_point < 30) g_anim_five.run();
		}

		if (BTN_05_status == 0 && BTN_07_status == 1){
			//alert(BTN_05_status);
			//$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({id: "point_container"}))
			g_anim.reset();
			current_point = parseInt($(document.getElementById("0:92:78:11:68")).find("text").text());
			var currentX = -8;

			//g_anim.stop();
			g_anim_five.add({
				duration: 3 * 1000,
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
					//console.log(+new Date());
				},
				onComplete: function() {
					//console.log(+new Date());
					g_anim.reset();
				},
				onStep: function(data, t) {

					var currentValue = Math.floor(data.x.now);

					if ((currentValue == (Math.floor(currentX) + 1))) {
						drawGame_fiveAB_plus(currentX, currentValue);

					}

					currentX = currentValue;

				}
			});
			if (current_point < 30) g_anim_five.run();
		}
		BTN_05_status = 1;

		//console.log(point);
	}

	//===== action draw random point
	var check = 0;
	function drawGame_allAB(nPhat) {
		//console.log(nPhat);

		txt_point = $(document.getElementById("0:92:78:11:68")).find("text");
		
		//check++;

		for (var i = 0; i < nPhat; i++) {

			var ran = Math.random() * (8 + 8) - 8;
			while (-0.75 < ran && ran < 0.75) {
				ran = Math.random() * (8 + 8) - 8;

			}

			var point = $(createTag("circle"))
				.css({
					stroke: "black",
					fill: "black"
				})
				.attr({
					id: "test" + ran,
					cx: ran * 35,
					cy: -6 / ran * 35,
					r: 3
				});
			

			if($(document.getElementById(point_container)).append(point)){
				

				//check++;
			}
			current_point++;
			txt_point.empty().text(parseInt(current_point));


		}
		//console.log(check);
		//console.log(nPhat);
		move_counter();

	}



	//var g_currentX = 1;
	//===== action draw random point
	function drawGame_all() {
		txt_point = $(document.getElementById("0:92:78:11:68")).find("text");
		current_point = parseInt(txt_point.text());
		g_anim.stop();
		g_anim.reset();
		if (BTN_03_status < 10000) {
			$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({
				id: "point_container"
			}))
			var nPhat = 0;
			var xPhat = 50;
		
			if(BTN_03_status % 5 == 0 ) xPhat = 50; 
			if(BTN_03_status % 5 == 1 ) xPhat = 100; 
			if(BTN_03_status % 5 == 2 ) xPhat = 150; 
			if(BTN_03_status % 5 == 3 ) xPhat = 1200; 
			if(BTN_03_status % 5 == 4 ) xPhat = 500; 
			if(current_point >= 50 && current_point < 100) xPhat = 100; 
			if(current_point >= 0 && current_point < 50) xPhat = 50; 
			
			var time = xPhat/50;
			g_anim.add({
				duration: time * 1000,
				delay: 0,
				isRunAtEnd: true,
				data: {
					phat: {
						startValue: nPhat,
						endValue: xPhat,
						easing: "linearTween"
					}
				},
				onInit: function() {
					//console.log(+new Date());
				},
				onComplete: function() {
					BTN_03_status++;
					//console.log(+new Date());

				},
				onStep: function(data, t) {
					var currentValue = Math.floor(data.phat.now);
					drawGame_allAB(currentValue - nPhat);

					nPhat = currentValue;
					
				}
			});

			g_anim.run();
			
		}
	}


	function reset_all() {
		$(document.getElementById("point_container")).remove();
		$(document.getElementById("0:92:78:11:68")).find("text").empty().text(0);
		var txt_count = $(document.getElementById("0:92:78:11:68")).find("text").attr({x:47});
		BTN_01_status = 0;
		BTN_03_status = 0;
		BTN_05_status = 0;
		BTN_07_status = 0;
		current_point = 0;
		check = 0;
		g_anim.stop();
		g_anim.reset();
		g_anim_five.stop();
		g_anim_five.reset();


	}

	function bindEvents() {
		//	g#0:97:91:1:55, g#0:97:91:3:62, g#0:97:91:5:69, g#0:97:91:7:76

		MVNButton({
			id: BTN_01
		}); // Reset Game.
		MVNButton({
			id: BTN_03
		}); // More Detail
		MVNButton({
			id: BTN_05
		}); // Độ mịn 0.5
		MVNButton({
			id: BTN_07
		}); // Độ mịn 1

		$(document.getElementById(BTN_07)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			drawGame_one();
		});

		$(document.getElementById(BTN_05)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			drawGame_five();
		});
		$(document.getElementById(BTN_03)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			drawGame_all();
		});
		$(document.getElementById(BTN_01)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			TABS.hideTabRectangle(this.id);
			reset_all();
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
		//		console.log("g_nOriginalWidth, g_nOriginalHeight", g_nOriginalWidth, g_nOriginalHeight);
	});

	//=======================================================================
	// Đoạn dưới đây chạy sau khi data được render bởi sprite.js
	//=======================================================================
	$(document).bind("frameRendered", function(event, data) {
		//		// // console.log("frameRendered", data.spriteId);
		if (data.spriteId != "Mf")
			return false;

		global_AdjustTextPos();
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
	var COOR_ID = "0:3:36:1:33";

	var BTN_01 = "0:92:78:1:43";
	var BTN_03 = "0:92:78:3:50";
	var BTN_05 = "0:92:78:5:57";
	var BTN_07 = "0:92:78:7:64";
	var BTN_01_status = 0;
	var BTN_03_status = 0;
	var BTN_05_status = 0;
	var BTN_05_click_time = 0;
	var BTN_07_status = 0;
	var txt_counter = "0:92:78:11:68";
	var point_container = "point_container";
	var current_point = 0;
	//var $(document.getElementById("0:92:78:11:68")).find("text") = $(document.getElementById("0:92:78:11:68")).find("text");
	//var counter_txt = $(document.getElementById("0:92:78:11:68")).find("text");
	//alert(counter_txt.text());
	//==== CONSTANTS End =============================================================================

	var g_anim = new Animation();
	var g_anim_five = new Animation();

})();