function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}

function _$(id) {
	return $(document.getElementById(id));
}

/**
 * returns the transformation matrix (ctm) for the given dom::Node up to a different dom::Node
 * the basic use case is to provide a wrapper function for the missing SVGLocatable.getTransformToElement method (missing in ASV3)
 * @param {svg::SVGTransformable} node			the node reference for the element the where the ctm should be calculated from
 * @param {svg::SVGTransformable} targetNode	the target node reference for the element the ctm should be calculated to
 * @return CTM									the current transformation matrix from the given node to the target element
 * @type svg::SVGMatrix
 * @version 1.0 (2007-05-01)
 * @credits <a href="http://www.kevlindev.com/tutorials/basics/transformations/toUserSpace/index.htm">Kevin Lindsey (toUserSpace)</a>
 * @see #getTransformToRootElement
 */
function getTransformToElement1(node,targetNode) {
    try {
        //this part is for fully conformant players
        var CTM = node.getTransformToElement1(targetNode);
    }
    catch (ex) {
  		//this part is for ASV3 or other non-conformant players
		// Initialize our CTM the node's Current Transformation Matrix
		var CTM = node.getCTM();
		// Work our way through the ancestor nodes stopping at the SVG Document
		while ( ( node = node.parentNode ) != targetNode ) {
			// Multiply the new CTM to the one with what we have accumulated so far
			CTM = node.getCTM().multiply(CTM);
		}
    }
    return CTM;
}

function calcMousePos(evt, ctmNode) {
	var svg = $("svg:first")[0];
	var svgPoint = svg.createSVGPoint();
	svgPoint.x = evt.clientX;
	svgPoint.y = evt.clientY;
	if (!svg.getScreenCTM) {
		//undo the effect of transformations
		if (ctmNode) {
			var matrix = getTransformToRootElement1(ctmNode);
		}
		else {
			var matrix = getTransformToRootElement1(evt.target);			
		}
  		svgPoint = svgPoint.matrixTransform(matrix.inverse().multiply(this.m));
	}
	else {
		//case getScreenCTM is available
		if (ctmNode) {
			var matrix = ctmNode.getScreenCTM();
		}
		else {
			var matrix = evt.target.getScreenCTM();		
		}
  		svgPoint = svgPoint.matrixTransform(matrix.inverse());
	}
  //undo the effect of viewBox and zoomin/scroll
	return svgPoint;
}

//==============================================================================

function createText(textId) {
	var textData = g_allSVGText[textId];
	var g = $(createTag("g"));
	for (var i = 0, len = g_allSVGText[textId].length; i < len; i++) {
		var p = g_allSVGText[textId][i];
		g.append($(createTag("path")).css(p.css).attr({
			d: p.d,
			transform: p.transform
		}));
	}
	return g;
}

var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
	},
		
	bindEvents: function() {
	},

	removeStuffs: function() {
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.removeStuffs();
		GAME.bindEvents();
	}
};