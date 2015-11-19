function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}

function createText(textId) {
	var textData = g_allSVGText[textId];
	var g = $(createTag("g"));
	for(var i=0, len=g_allSVGText[textId].length; i<len; i++) {
		var p = g_allSVGText[textId][i];
		g.append($(createTag("path")).css(p.css).attr({d: p.d, transform: p.transform}));
	}
	return g;
}

var GAME = {
	patchText: function() {
		
		//==== Patch text [1m]
		var g = createText(31);
		$(document.getElementById("0:3:43:1:33:11:32:2:31")).append(g).find("foreignObject").remove();
//		var a = g[0].getBoundingClientRect();
//		g.append($(createTag("rect")).attr({x: 0, y: 0, width: a.width, height: a.height}).css({"stroke": "red", "fill": "none"}));
		g.attr({"transform": ["matrix(1,0,0,1,-45.125,-18.058)"].join("")});
	},
		
	bindEvents: function() {
		//==== Create zoomable buttons.
		var aButtons = [
			"0:17:79:1:50",
			"0:17:79:3:57",
			"0:17:79:5:64",
			"0:17:79:7:71",
			"0:17:79:9:78"];
		for(var i=0; i<aButtons.length; i++) {
			MVNButton({id: aButtons[i]});
		}
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.bindEvents();
	}
};