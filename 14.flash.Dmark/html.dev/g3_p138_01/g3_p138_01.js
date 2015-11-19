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

	}
	
var g_bShowGrayLines = true;
//model point
var g_model = {
	m_A: { color: "black", x: -150, y: 0},
	m_B: {color: "black", x: -200, y: 200},
	m_C: {color: "black", x: 200, y: 200},
	m_D: {color: "black", x: 150, y: -150},
	m_M: {  x: -175, y: 100},
	m_N: { x: -250.214, y: 199.478},
	m_P: { x: 203.2, y: -151},
	m_Q: { x: 203, y: -152}	
};

g_model.m_M.x = (g_model.m_A.x + g_model.m_B.x) / 2;
g_model.m_M.y = (g_model.m_A.y + g_model.m_B.y) /2;

g_model.m_N.x = (g_model.m_B.x + g_model.m_C.x) / 2;
g_model.m_N.y = (g_model.m_B.y + g_model.m_C.y) /2;
g_model.m_P.x = (g_model.m_C.x + g_model.m_D.x) / 2;
g_model.m_P.y = (g_model.m_C.y + g_model.m_D.y) /2;
g_model.m_Q.x = (g_model.m_D.x + g_model.m_A.x) / 2;
g_model.m_Q.y = (g_model.m_D.y + g_model.m_A.y) /2;

function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}

function initGame() {
	hide();
	drawAll();
	bindEvents();
	binding();
	
	changeCheckbox($(document.getElementById(BTN_CHECKBOX_Y))[0], false);
}

function bindEvents(){
	$("#pointm_A_event").bind("draginit", function(event){
		this.startPosition = {
			x: event.clientX, 
			y: event.clientY,
  			cx0: g_model["m_A"].x,	  			
  			cy0: g_model["m_A"].y
		};
	})
	.drag(function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(!(MIN_X<=x && x<=MAX_X && MIN_Y<=y && y<=MAX_Y)) return;
		
		g_model["m_A"].x = x;
		g_model["m_A"].y = y;
		redraw();
	})
	.drag("dragend", function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(x<MIN_X) x = MIN_X;
		if(x>MAX_X) x = MAX_X;
		if(y<MIN_Y) y = MIN_Y;
		if(y>MAX_Y) y = MAX_Y;
		
		g_model["m_A"].x = Math.round(x/GRID_SIZE) * GRID_SIZE;
		g_model["m_A"].y = Math.round(y/GRID_SIZE) * GRID_SIZE;
		redraw();
	}).css({"cursor": "pointer"});

	$("#pointm_B_event").bind("draginit", function(event){
		this.startPosition = {
			x: event.clientX, 
			y: event.clientY,
  			cx0: g_model["m_B"].x,	  			
  			cy0: g_model["m_B"].y
		};
	})
	.drag(function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(!(MIN_X<=x && x<=MAX_X && MIN_Y<=y && y<=MAX_Y)) return;
		
		g_model["m_B"].x = x;
		g_model["m_B"].y = y;
		redraw();
	})
	.drag("dragend", function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(x<MIN_X) x = MIN_X;
		if(x>MAX_X) x = MAX_X;
		if(y<MIN_Y) y = MIN_Y;
		if(y>MAX_Y) y = MAX_Y;
		
		g_model["m_B"].x = Math.round(x/GRID_SIZE) * GRID_SIZE;
		g_model["m_B"].y = Math.round(y/GRID_SIZE) * GRID_SIZE;
		redraw();
	}).css({"cursor": "pointer"});

	$("#pointm_C_event").bind("draginit", function(event){
		this.startPosition = {
			x: event.clientX, 
			y: event.clientY,
  			cx0: g_model["m_C"].x,	  			
  			cy0: g_model["m_C"].y
		};
	})
	.drag(function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(!(MIN_X<=x && x<=MAX_X && MIN_Y<=y && y<=MAX_Y)) return;
		
		g_model["m_C"].x = x;
		g_model["m_C"].y = y;
		redraw();
	})
	.drag("dragend", function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(x<MIN_X) x = MIN_X;
		if(x>MAX_X) x = MAX_X;
		if(y<MIN_Y) y = MIN_Y;
		if(y>MAX_Y) y = MAX_Y;
		
		g_model["m_C"].x = Math.round(x/GRID_SIZE) * GRID_SIZE;
		g_model["m_C"].y = Math.round(y/GRID_SIZE) * GRID_SIZE;
		redraw();
	}).css({"cursor": "pointer"});

	$("#pointm_D_event").bind("draginit", function(event){
		this.startPosition = {
			x: event.clientX, 
			y: event.clientY,
  			cx0: g_model["m_D"].x,	  			
  			cy0: g_model["m_D"].y
		};
	})
	.drag(function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(!(MIN_X<=x && x<=MAX_X && MIN_Y<=y && y<=MAX_Y)) return;
		
		g_model["m_D"].x = x;
		g_model["m_D"].y = y;
		redraw();
	})
	.drag("dragend", function(event){
		var dX = event.clientX - this.startPosition.x;
		var dY = event.clientY - this.startPosition.y;
		var x = this.startPosition.cx0 + dX/g_zoomLevel;
		var y = this.startPosition.cy0 + dY/g_zoomLevel;
		if(x<MIN_X) x = MIN_X;
		if(x>MAX_X) x = MAX_X;
		if(y<MIN_Y) y = MIN_Y;
		if(y>MAX_Y) y = MAX_Y;
		
		g_model["m_D"].x = Math.round(x/GRID_SIZE) * GRID_SIZE;
		g_model["m_D"].y = Math.round(y/GRID_SIZE) * GRID_SIZE;
		redraw();
	}).css({"cursor": "pointer"});
}

function binding(){
//	var check = //$(document.getElementById("0:27:57:3:45")).toggle(true);
//	var uncheck = $(document.getElementById("0:27:57:1:44")).toggle(false);	
	//bind checkbox
	$(document.getElementById(BTN_CHECKBOX_Y)).bind("mouseup touchend", function(event)	{
		event.preventDefault();
		TABS.hideTabRectangle(this.id);			
		g_checked = !g_checked;
		
		$("#pathMNPQ").toggle(g_checked);
		$("#textM").toggle(g_checked);
		$("#textN").toggle(g_checked);
		$("#textP").toggle(g_checked);
		$("#textQ").toggle(g_checked);

		changeCheckbox(this, g_checked);
	});
	//======= Switch checkbox ===========

}
function changeCheckbox(e, bCheck) {
	// Change checkbox
	var sImg = bCheck? "g3_p138_01/image/image_43_0.png" : "g3_p138_01/image/image_41_0.png";
	for(var i=0, a=$("image", e); i<a.length; i++) {
		a[i].setAttributeNS("http://www.w3.org/1999/xlink", "href", sImg);
	}
}

function hide(){
	//==== Remove unused Text A, B, C, D, E, F, G, H and unused Circles.
	$(document.getElementById("0:27:57:6:56:1:52:3:51:1:50")).remove(); 
	$(document.getElementById("0:27:57:6:56:13:55:3:51:1:50")).remove();
	$(document.getElementById("0:27:57:6:56:5:53:3:51:1:50")).remove();
	$(document.getElementById("0:27:57:6:56:9:54:3:51:1:50")).remove();
	$(document.getElementById("0:27:57:6:56:1:52:1:49:1:48")).remove();
	$(document.getElementById("0:27:57:6:56:5:53:1:49:1:48")).remove();
	$(document.getElementById("0:27:57:6:56:9:54:1:49:1:48")).remove();
	$(document.getElementById("0:27:57:6:56:13:55:1:49:1:48")).remove();
	$(document.getElementById("0:5:39:5:17")).remove();
	$(document.getElementById("0:5:39:7:17")).remove();
	$(document.getElementById("0:5:39:9:19")).remove();
	$(document.getElementById("0:5:39:11:19")).remove();
	$(document.getElementById("0:5:39:21:38:1:31")).remove();
	$(document.getElementById("0:5:39:21:38:3:33")).remove();
	$(document.getElementById("0:5:39:21:38:5:35")).remove();
	$(document.getElementById("0:5:39:21:38:3:33")).remove();
	$(document.getElementById("0:5:39:21:38:7:37")).remove();	
	$(document.getElementById("0:5:39:13:29:1:22:1:21")).remove();
	$(document.getElementById("0:5:39:13:29:3:24:1:23")).remove();
	$(document.getElementById("0:5:39:13:29:5:26:1:25")).remove();
	$(document.getElementById("0:5:39:13:29:7:28:1:27")).remove();
	
	
	//==== Move checkbox label to correct position.
	$(document.getElementById("0:27:57:5:47")).find("text:first")
		.css({"font-family": "MS UI Gothic"})
		.attr({"transform": "matrix(1,0,0,1,326,315)"});


}

function redraw(){
	g_model.m_M.x = (g_model.m_A.x + g_model.m_B.x) / 2;
	g_model.m_M.y = (g_model.m_A.y + g_model.m_B.y) / 2;
	g_model.m_N.x = (g_model.m_B.x + g_model.m_C.x) / 2;
	g_model.m_N.y = (g_model.m_B.y + g_model.m_C.y) / 2;
	g_model.m_P.x = (g_model.m_C.x + g_model.m_D.x) / 2;
	g_model.m_P.y = (g_model.m_C.y + g_model.m_D.y) / 2;
	g_model.m_Q.x = (g_model.m_D.x + g_model.m_A.x) / 2;
	g_model.m_Q.y = (g_model.m_D.y + g_model.m_A.y) / 2;
	var a = ["m_A", "m_B", "m_C", "m_D", "m_M", "m_N", "m_P", "m_Q"];
	for(var i=0; i<a.length; i++) {
		var p = g_model[a[i]];
		$("#point"+a[i]).attr({
			cx: p.x,
			cy:	p.y
		});
		$("#point"+a[i]+"_event").attr({
			cx: p.x,
			cy:	p.y
		});
	}
	
	$("#lineAB").attr({x1: g_model["m_A"].x, y1: g_model["m_A"].y, x2: g_model["m_B"].x, y2: g_model["m_B"].y});
	$("#lineBC").attr({x1: g_model["m_B"].x, y1: g_model["m_B"].y, x2: g_model["m_C"].x, y2: g_model["m_C"].y});
	$("#lineCD").attr({x1: g_model["m_C"].x, y1: g_model["m_C"].y, x2: g_model["m_D"].x, y2: g_model["m_D"].y});
	$("#lineDA").attr({x1: g_model["m_D"].x, y1: g_model["m_D"].y, x2: g_model["m_A"].x, y2: g_model["m_A"].y});
	var d = [
		"M", g_model["m_M"].x, g_model["m_M"].y,
		"L", g_model["m_N"].x, g_model["m_N"].y,
		"L", g_model["m_P"].x, g_model["m_P"].y,
		"L", g_model["m_Q"].x, g_model["m_Q"].y,
		"z"
	];
	$("#pathMNPQ")
	.attr({
		d: d.join(" ")
	});
	//A text
	$("#textA")
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_A"].x - 45-1, ",", g_model["m_A"].y-45+2, ")"].join("")
		});
	//B text
	$("#textB")
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_B"].x - 57-2, ",", g_model["m_B"].y-20+1, ")"].join("")		
		});	
	//C text
	$("#textC")
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_C"].x - 5, ",", g_model["m_C"].y-5, ")"].join("")		
	});
	//D text
	$("#textD")
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_D"].x-3, ",", g_model["m_D"].y-60-1, ")"].join("")		
		});
	//M text
	$("#textM")	
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_M"].x-102+2, ",", g_model["m_M"].y-30, ")"].join("")		
		});
	//N text
	$("#textN")
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_N"].x-39, ",", g_model["m_N"].y-20+4, ")"].join("")		
	});
	//P text
	$("#textP")
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_P"].x-18+5, ",", g_model["m_P"].y-38-2, ")"].join("")		
		})
	//Q text
	$("#textQ")
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_Q"].x-65, ",", g_model["m_Q"].y-90, ")"].join("")		
		})
	
}

function drawAll(){
//	console.log("drawAll", COOR_ID);
	$(document.getElementById(COOR_ID)).append($(createTag("g")).attr({id:"gContainer"}));
	
	//==== Draw MNPQ via path
	var d = [
		"M", g_model["m_M"].x, g_model["m_M"].y,
		"L", g_model["m_N"].x, g_model["m_N"].y,
		"L", g_model["m_P"].x, g_model["m_P"].y,
		"L", g_model["m_Q"].x, g_model["m_Q"].y,
		"z"
	];
	var path = $(createTag("path"))
		.attr({
			id: "pathMNPQ",
			d: d.join(" "),
			"stroke-width": 2
		})
		.css({stroke: "black", fill: "#FFEEE8"}).hide();
	$("#gContainer").append(path);
		
	//======= Draw ABCD text ==========
	// A text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_A"].x - 45-1, ",", g_model["m_A"].y-45+2, ")"].join(""),
			id: "textA",
			d: "M35.792,34.272h-8.086v-1.078h0.719c0.719,0,1.137-0.239,1.258-0.719c0.239-0.478,0.239-1.078,0-1.797l-3.055-7.906H13.331 l-3.055,7.727c-0.359,0.839-0.359,1.499,0,1.977c0.478,0.48,1.137,0.719,1.977,0.719h0.539v1.078H5.964v-1.078h0.359 c0.478,0,0.898-0.18,1.258-0.539c0.478-0.239,0.837-0.719,1.078-1.438L19.62,3.725l2.695-0.898l10.781,28.391 c0.239,0.719,0.539,1.199,0.898,1.438c0.359,0.359,0.778,0.539,1.258,0.539h0.539V34.272z M26.269,21.694L20.159,5.881h-0.18 L13.69,21.694H26.269z",
		})
		.css({stroke: "none", fill: "black"}));
	//B text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_B"].x - 57-2, ",", g_model["m_B"].y-20+1, ")"].join(""),
			id: "textB",
			d: "M44.305,51.365c0,2.397-0.96,4.313-2.875,5.75c-1.797,1.438-4.492,2.156-8.086,2.156H20.586v-1.078h1.078c0.598,0,1.017-0.118,1.258-0.359c0.239-0.239,0.359-0.598,0.359-1.078V31.06c0-0.478-0.121-0.837-0.359-1.078c-0.241-0.239-0.66-0.359-1.258-0.359h-1.078v-1.078h12.219c3.234,0,5.688,0.539,7.367,1.617c1.797,1.199,2.695,2.996,2.695,5.391c0,1.679-0.601,3.116-1.797,4.313c-1.199,1.199-2.996,2.097-5.391,2.695c2.993,0.48,5.149,1.499,6.469,3.055C43.586,47.293,44.305,49.208,44.305,51.365z M39.813,35.552c0-2.156-0.719-3.712-2.156-4.672c-1.319-0.837-3.296-1.258-5.93-1.258h-3.953c-0.48,0-0.898,0.121-1.258,0.359c-0.241,0.241-0.359,0.601-0.359,1.078v11.141h6.469c1.797,0,3.414-0.539,4.852-1.617C39.033,39.505,39.813,37.829,39.813,35.552z M40.891,51.005c0-2.754-0.78-4.731-2.336-5.93c-1.558-1.196-3.714-1.797-6.469-1.797h-5.93v13.477c0,0.48,0.118,0.839,0.359,1.078c0.359,0.241,0.778,0.359,1.258,0.359h5.031c2.516,0,4.492-0.598,5.93-1.797C40.172,55.2,40.891,53.403,40.891,51.005z",
		})
		.css({stroke: "none", fill: "black"}));
	//C text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_C"].x - 5, ",", g_model["m_C"].y-5, ")"].join(""),
			id: "textC",
			d: "M43.742,38.347c-0.839,2.397-2.218,4.433-4.133,6.109c-1.917,1.679-4.613,2.516-8.086,2.516c-3.594,0-6.89-1.317-9.883-3.953c-2.875-2.516-4.313-6.407-4.313-11.68c0-4.672,1.317-8.445,3.953-11.32c2.754-2.993,6.407-4.492,10.961-4.492c1.797,0,3.293,0.121,4.492,0.359c1.676,0.359,2.813,0.539,3.414,0.539c0.478,0,0.837-0.059,1.078-0.18c0.359-0.118,0.657-0.359,0.898-0.719l1.617,7.906l-1.078,0.359c-0.719-2.274-1.977-4.012-3.773-5.211c-1.797-1.196-4.133-1.797-7.008-1.797c-3.594,0-6.351,1.378-8.266,4.133c-1.797,2.757-2.695,6.171-2.695,10.242c0,4.433,1.017,7.906,3.055,10.422c2.156,2.636,4.731,3.953,7.727,3.953c3.114,0,5.509-0.719,7.188-2.156c1.797-1.438,3.055-3.293,3.773-5.57L43.742,38.347z",
		})
		.css({stroke: "none", fill: "black"}));
	//D text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_D"].x-3, ",", g_model["m_D"].y-60-1, ")"].join(""),
			id: "textD",
			d: "M40.851,36.95c0,5.391-1.617,9.405-4.852,12.039c-3.116,2.636-7.847,3.953-14.195,3.953h-7.547v-1.078h1.078c0.598,0,1.017-0.118,1.258-0.359c0.239-0.239,0.359-0.598,0.359-1.078V24.731c0-0.478-0.121-0.837-0.359-1.078c-0.241-0.239-0.66-0.359-1.258-0.359h-1.078v-1.078h8.086c5.868,0,10.422,1.319,13.656,3.953C39.234,28.805,40.851,32.398,40.851,36.95z M37.437,37.309c0-4.192-1.378-7.606-4.133-10.242c-2.636-2.516-6.289-3.773-10.961-3.773c-0.839,0-1.499,0.121-1.977,0.359c-0.359,0.241-0.539,0.601-0.539,1.078v25.695c0,0.48,0.18,0.839,0.539,1.078c0.359,0.241,0.837,0.359,1.438,0.359c5.031,0,8.864-1.137,11.5-3.414C36.059,46.175,37.437,42.461,37.437,37.309z",
		})
		.css({stroke: "none", fill: "black"}));
	//M text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_M"].x-102+2, ",", g_model["m_M"].y-30, ")"].join(""),
			id: "textM",
			d: "M81.194,40.871l-1.977,7.008H57.295V46.8h1.078c0.598,0,1.017-0.118,1.258-0.359c0.239-0.239,0.359-0.598,0.359-1.078V19.667c0-0.478-0.121-0.837-0.359-1.078c-0.241-0.239-0.66-0.359-1.258-0.359h-1.078v-1.078h21.383l1.977,6.109l-0.898,0.359c-0.96-1.915-1.977-3.293-3.055-4.133c-0.96-0.837-2.156-1.258-3.594-1.258h-8.625c-0.48,0-0.898,0.121-1.258,0.359c-0.241,0.241-0.359,0.601-0.359,1.078v11.141h8.805c1.196,0,2.036-0.298,2.516-0.898c0.598-0.719,0.898-1.617,0.898-2.695v-1.078h1.078v10.602h-1.078v-0.719c0-1.196-0.3-2.215-0.898-3.055c-0.48-0.719-1.319-1.078-2.516-1.078h-8.805v13.477c0,0.48,0.118,0.839,0.359,1.078c0.359,0.241,0.778,0.359,1.258,0.359h8.266c1.676,0,3.173-0.539,4.492-1.617c1.317-1.078,2.336-2.634,3.055-4.672L81.194,40.871z",
		})
		.css({stroke: "none", fill: "black"})
		.hide()
	);
	//N text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_N"].x-39, ",", g_model["m_N"].y-20+4, ")"].join(""),
			id: "textN",
			d: "M51.353,37.545l-0.898,0.359c-0.96-1.915-2.097-3.353-3.414-4.313c-1.319-0.958-2.757-1.438-4.313-1.438h-8.625c-0.48,0-0.898,0.121-1.258,0.359c-0.241,0.241-0.359,0.601-0.359,1.078v11.5h9.523c1.196,0,2.036-0.298,2.516-0.898c0.598-0.478,0.898-1.317,0.898-2.516v-0.898h1.078v10.422h-1.078v-0.719c0-1.317-0.3-2.395-0.898-3.234c-0.48-0.719-1.319-1.078-2.516-1.078h-9.523v13.117c0,0.48,0.118,0.839,0.359,1.078c0.359,0.241,0.778,0.359,1.258,0.359h1.258v1.078h-8.445v-1.078h1.078c0.598,0,1.017-0.118,1.258-0.359c0.239-0.239,0.359-0.598,0.359-1.078V33.592c0-0.478-0.121-0.837-0.359-1.078c-0.241-0.239-0.66-0.359-1.258-0.359h-1.078v-1.078h22.281L51.353,37.545z",
		})
		.css({stroke: "none", fill: "black"})
		.hide()
	);
	//P text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_P"].x-18+5, ",", g_model["m_P"].y-38-2, ")"].join(""),
			id: "textP",
			d: "M56.752,44.341h-0.898c-0.601,0-1.078,0.18-1.438,0.539s-0.539,0.839-0.539,1.438v8.984c-0.241-0.118-0.48-0.239-0.719-0.359c-0.121,0-0.3,0-0.539,0c-0.241,0-0.539,0-0.898,0c-0.359,0.121-0.719,0.3-1.078,0.539c-0.601,0.359-1.797,0.719-3.594,1.078s-3.234,0.539-4.313,0.539c-3.594,0-6.828-1.317-9.703-3.953c-2.875-2.634-4.313-6.407-4.313-11.32c0-5.149,1.438-9.164,4.313-12.039c2.875-2.754,6.109-4.133,9.703-4.133c1.797,0,3.532,0.18,5.211,0.539c1.676,0.359,2.634,0.539,2.875,0.539c0.359,0,0.719-0.118,1.078-0.359c0.359-0.118,0.657-0.359,0.898-0.719l1.438,8.086l-1.078,0.359c-0.719-2.634-1.977-4.492-3.773-5.57c-1.679-1.078-3.894-1.617-6.648-1.617c-2.757,0-5.272,1.258-7.547,3.773c-2.156,2.397-3.234,6.109-3.234,11.141c0,4.672,1.196,8.147,3.594,10.422c2.516,2.397,5.149,3.594,7.906,3.594c1.317,0,2.934-0.298,4.852-0.898c1.797-0.598,2.695-1.376,2.695-2.336v-6.109c0-0.719-0.18-1.258-0.539-1.617s-0.898-0.539-1.617-0.539h-1.078v-1.078h8.984V44.341z",
		})
		.css({stroke: "none", fill: "black"}).hide());
	//Q text
	$("#gContainer").append($(createTag("path"))
		.attr({
			transform: ["matrix(1,0,0,1,", g_model["m_Q"].x-65, ",", g_model["m_Q"].y-90, ")"].join(""),
			id: "textQ",
			d: "M78.451,76.993h-8.266v-1.078h1.078c0.598,0,1.017-0.118,1.258-0.359c0.239-0.239,0.359-0.598,0.359-1.078V61.36H55.091v13.117c0,0.48,0.118,0.839,0.359,1.078c0.359,0.241,0.778,0.359,1.258,0.359h1.078v1.078h-8.266v-1.078h1.078c0.598,0,1.017-0.118,1.258-0.359c0.239-0.239,0.359-0.598,0.359-1.078V48.782c0-0.478-0.121-0.837-0.359-1.078c-0.241-0.239-0.66-0.359-1.258-0.359h-1.078v-1.078h8.266v1.078h-1.078c-0.48,0-0.898,0.121-1.258,0.359c-0.241,0.241-0.359,0.601-0.359,1.078v11.5H72.88v-11.5c0-0.478-0.121-0.837-0.359-1.078c-0.241-0.239-0.66-0.359-1.258-0.359h-1.078v-1.078h8.266v1.078h-1.078c-0.48,0-0.898,0.121-1.258,0.359c-0.241,0.241-0.359,0.601-0.359,1.078v25.695c0,0.48,0.118,0.839,0.359,1.078c0.359,0.241,0.778,0.359,1.258,0.359h1.078V76.993z",
		})
		.css({stroke: "none", fill: "black"}).hide());
	drawLinePoint("lineAB", g_model["m_A"], g_model["m_B"], {stroke: "black", fill: "green"});
	drawLinePoint("lineBC", g_model["m_B"], g_model["m_C"], {stroke: "black", fill: "green"});
	drawLinePoint("lineCD", g_model["m_C"], g_model["m_D"], {stroke: "black", fill: "green"});
	drawLinePoint("lineDA", g_model["m_D"], g_model["m_A"], {stroke: "black", fill: "green"});



	//==== drag point at last so points have z-index higher than lines.
	var a = ["m_A", "m_B", "m_C", "m_D"];
//	console.log(a.length);
	for(var i=0; i<a.length; i++) {
		var p = g_model[a[i]];
		var circle = $(createTag("circle"))
			.css({stroke: p.color, fill: p.color})
			.attr({
				id: "point"+a[i], 
				cx: p.x,
				cy:	p.y,
				r: 5								
			});			
		var circleHandler = $(createTag("circle"))
			.css({stroke: p.color, fill: p.color, opacity: 0})
			.attr({
				id: "point"+a[i]+"_event", 
				cx: p.x,
				cy:	p.y,
				r: 40								
			});			
		$("#gContainer").append(circle).append(circleHandler);
		//add text
		//drawText("0:5:39:21:38:1:31:1:30", 131, -15, {stroke: "black", fill: "none", "font-size": 30});
	}
}

function drawLinePoint(id, p1, p2, css){
	var line = $(createTag("line")).attr({
		id: id,
		x1: p1.x,
		y1: p1.y,
		x2: p2.x, 
		y2: p2.y, 
		"stroke-width": 4
	}).css(css);
	$("#gContainer").append(line);
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
var MIN_X = -450;
var MIN_Y = -250;
var MAX_X = 450;
var MAX_Y = 250;
var GRID_SIZE = 50;
var COOR_ID = "0:3:13:1:12:1:11";
var BTN_CHECKBOX_Y = "0:27:57:3:45"; //check
//var BTN_CHECKBOX_N = "0:27:57:1:44"; //uncheck
var g_checked = false;
//==== CONSTANTS End =============================================================================


})();

var g_zoomLevel = 1;
