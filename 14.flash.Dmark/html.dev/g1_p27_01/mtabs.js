var TABS = {
	bDisabled: false,
	oWith: 0,
	oHeight: 0,
	g_nTabStatus: 1, // 1: normal; 0: turn off by click outside button.
	g_nTabIndex: -1, //Current tab index.
	g_nTabElement: null, // Dung de dieu khien button khi tab vao doi hover
	g_tabIdSelected: 'home',
	// var BTN_01 = "0:92:78:1:43";
	// var BTN_03 = "0:92:78:3:50";
	// var BTN_05 = "0:92:78:5:57";
	// var BTN_07 = "0:92:78:7:64";

	tabId: {//A, B, F, G, M
		'home': [BTN_SETTING_ID, BTN_START_ID, BTN_RESET_ID],
		'settingScreen': [BTN_BACK_TO_GAME, 
			"0:59:314:48:259", "0:59:314:50:263", "0:59:314:52:267", "0:59:314:54:271", "0:59:314:56:275", 
			"0:59:314:58:279", "0:59:314:60:283", "0:59:314:70:303", "0:59:314:64:291", "0:59:314:66:295", "0:59:314:62:287", "0:59:314:68:299",
			"0:59:314:18:245:14:244", "0:59:314:3:245:14:244"
		],
		'mainScreen': [
//var BTN_RESET_ID =  "0:49:225:1:196";
//var	BTN_STOP_ID = "0:49:225:3:203";		// Stop
//var	BTN_NEXT_ID = "0:49:225:5:210";		// Next
//var	BTN_START_ID = "0:49:225:7:217";		// Start
//var	BTN_SETTING_ID = "0:49:225:9:224";		// Setting
//var BTN_BACK_TO_GAME = "0:59:314:45:255";		
			BTN_SETTING_ID, BTN_START_ID, BTN_NEXT_ID, BTN_STOP_ID, BTN_RESET_ID
		]

	},

	updateTabIdSelected: function(tabSelected) {
		console.log("updateTabIdSelected", tabSelected);
		this.g_tabIdSelected = tabSelected;
		this.g_nTabIndex = -1;
	},
	updateTabIdSelectedNoChangeTabIndex: function(tabSelected) {
		this.g_tabIdSelected = tabSelected;
	},
	updateTabID: function(tabId) {
		this.tabId = tabId;
	},
	drawTab: function(g) {
		var oWith = this.oWith;
		var oHeight = this.oHeight;
		var box = g[0].getBoundingClientRect();
		var o = $("svg:first");
		var offset = o.offset();

		var x1 = (box.left - offset.left) * oWith / o.width();
		var y1 = (box.top - offset.top) * oHeight / o.height();
		var x2 = (box.left + box.width - offset.left) * oWith / o.width();
		var y2 = (box.top + box.height - offset.top) * oHeight / o.height();
		$("#TAB_RECTANGLE").attr(({x: x1, y: y1, width: x2 - x1, height: y2 - y1})).show();
	},
	makeSVG: function(tag, attrs) {
		var el = document.createElementNS('http://www.w3.org/2000/svg', tag);
		for (var k in attrs)
			el.setAttribute(k, attrs[k]);
		return el;
	},
	hideTabRectangle: function(id) {
		if (typeof (id) == "undefined") {
			// Click when tab is hidden.
			if ($("#TAB_RECTANGLE").css("display") == "none") {
				return;
			} else {
				$("#TAB_RECTANGLE").attr({x: 0, y: 0, height: 0, width: 0}).toggle(false);
				$(document.getElementById(this.g_nTabElement)).trigger("tabOff");
			}
			this.g_nTabStatus = 0;	// Turn off by click outside.
			return;
		} else if (id == -1) {
			this.g_nTabIndex = -1;
			this.g_nTabStatus = 1;
		} else {
			this.g_nTabIndex = this.findTabIndex(id);
			this.g_nTabStatus = 1;
		}

		$("#TAB_RECTANGLE").attr({x: 0, y: 0, height: 0, width: 0}).toggle(false);
	},
	findTabIndex: function(id) {
		var tabId = this.tabId[this.g_tabIdSelected]; // Tab theo tung frame
		for (var i = 0; i < tabId.length; i++) {
			if (tabId[i] == id) {
				return i;
			}
		}
		return -1;
	},
	init: function(screenWith, screenHeight) {
		this.oWith = screenWith;
		this.oHeight = screenHeight;

//		var rect = this.makeSVG('rect', {id: 'TAB_RECTANGLE', x: 0, y: 0, height: 0, width: 0, "stroke-opacity": 1, "stroke-width": 3, "stroke": "red", "fill": "none"});
		var rect = this.makeSVG('rect', {id: 'TAB_RECTANGLE', x: 0, y: 0, height: 0, width: 0, "stroke-opacity": 1, "stroke-width": 3, 
			"stroke": "yellow", "fill": "none"});
		$(rect).hide();
		$("#0").append(rect);
		$(document).keydown(function(e) {
			if(TABS.bDisabled) return;
			
			var tabId = TABS.tabId[TABS.g_tabIdSelected];
			if (e.keyCode == 9) {  // TAB
				e.preventDefault();
				var g;
				if (e.shiftKey && TABS.g_nTabIndex == -1)
					TABS.g_nTabIndex = 0;

				//// console.log(tabId);
				for (var i = 0; i <= tabId.length; i++) {
					if (e.shiftKey) {
						TABS.g_nTabIndex = (TABS.g_nTabIndex + tabId.length - TABS.g_nTabStatus) % tabId.length;
					} else {
						TABS.g_nTabIndex = (TABS.g_nTabIndex + tabId.length + TABS.g_nTabStatus) % tabId.length;
					}

					g = $(document.getElementById(tabId[TABS.g_nTabIndex]));
					if (g.css("display") != "none") {
						break;
					}
					g = null;
				}
				if (!g)
					return;
				TABS.drawTab(g);

				TABS.g_nTabStatus = 1;
				$(document.getElementById(TABS.g_nTabElement)).trigger("tabOff");
				g.trigger("mouseover");
			} else if (e.keyCode == 13) {  // ENTER
				if (TABS.g_nTabIndex == -1)
					return;
				if ($("#TAB_RECTANGLE").css('display') != 'none') {
					$(document.getElementById(tabId[TABS.g_nTabIndex])).trigger("mouseup");
				}
			}
		});
	}
};