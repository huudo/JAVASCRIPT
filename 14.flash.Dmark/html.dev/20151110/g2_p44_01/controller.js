function createTag(tag) {
	return document.createElementNS("http://www.w3.org/2000/svg", tag)
}

function _$(id) {
	return $(document.getElementById(id));
}

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




var GAME = {
	//===============================================================
	//	createFruit.
	//	parameters:
	//	- fruitType: ORANGE, BANANA, KAKI
	//	- id: fruitId
	//	Return g = container of the fruit.
	//===============================================================
	createFruit: function(fruitType, id) {
//		console.log(fruitType, g_hFruitImages[fruitType]);
		var g = $(createTag("g")).attr({id: id, transform: "matrix(1,0,0,1,0,0)"});
		var image = document.createElementNS('http://www.w3.org/2000/svg','image');
		var fruit = g_hFruitImages[fruitType];
		image.setAttributeNS("http://www.w3.org/1999/xlink", "href", fruit.path);
		$(image).attr({
			width: fruit.width,
			height: fruit.height,
			transform: fruit.transform
		});
		//==== Save fruitType here.
		g.append(image).attr({"fruitType": fruitType});
		return g;
	},
	
	
	//=== create fruit in each plate in advance.
	prepareFruitInPlate: function(fruitType, plateNo, id) {
		var fruit = g_hFruitImages[fruitType];
//		console.log("fruitType", fruitType, plateNo, fruit);
//		console.log(PLATES[plateNo]);
		var num  = (MODEL[plateNo][fruit.name]++);

		//==== Position, startX position for each plate.
		//==== stepX, stepY, startX, startY, max fruit, max column for each fruit.

		var max = g_hFruitPos[fruitType].max;
		var column = g_hFruitPos[fruitType].column;
		var startX = g_hFruitPos[fruitType].startX[plateNo];
		var startY = g_hFruitPos[fruitType].startY;
		var stepX = g_hFruitPos[fruitType].stepX;
		var stepY = g_hFruitPos[fruitType].stepY;
		var x = column-1-num%column;
		var y = Math.floor(num/column);
		
		x = startX + x*stepX;
		y = startY + y*stepY;
		//==== Add more fruit in to plage.
		$(document.getElementById(PLATES[plateNo]).firstChild.nextSibling).append(GAME.createFruit(fruitType, id).attr({
			transform: ["matrix(1,0,0,1,",x,",",y,")"].join("")
		}));
	},
	
	patchText: function() {
		console.log("GAME.patchText");

		var a = [	
//			OUTSIDE_AREA,
//			FRUIT_AREA,
			PLATE1_DRAGAREA,
			PLATE2_DRAGAREA,
			PLATE3_DRAGAREA,
			PLATE4_DRAGAREA
		];
		for(var i=0; i<a.length; i++) {
			_$(a[i]).css({opacity:0.2, stroke: "red", "stroke-width": 1, "stroke-dasharray": "5px 2px", fill: "none"});
		};		
//		_$(BTN_CONDITION_ID)



	},
		
	prepare: function() {
		// Add fruits to plates in advance.
		for(var i=0; i<20; i++) {		// fruitNo in plate.
			for(var j=1; j<=4; j++) {	// Plate
				var id = [j, 0, i].join("_");
				GAME.prepareFruitInPlate(0, j, id);	// ORANGE, platename, no.
				_$(id).hide();
			}
		}
		for(var i=0; i<5; i++) {
			for(var j=1; j<=4; j++) {
				var id = [j, 1, i].join("_");
				GAME.prepareFruitInPlate(1, j, id);	// BANANA
				_$(id).hide();
			}
		}

		for(var i=0; i<20; i++) {
			for(var j=1; j<=4; j++) {
				var id = [j, 2, i].join("_");
				GAME.prepareFruitInPlate(2, j, id);	// KAKI
				_$(id).hide();
			}
		}

		//==== create 3 free fruits		
		_$(CONTAINER)
			.append(GAME.createFruit(ORANGE, "gOrange"))
			.append(GAME.createFruit(BANANA, "gBanana"))
			.append(GAME.createFruit(KAKI, "gKaki"));

		$("#gOrange image:first").attr({transform: "matrix(0.599991, 0, 0, 0.599991, 0, 0)"});
		$("#gBanana image:first").attr({transform: "matrix(0.599991, 0, 0, 0.599991, 0, 0)"});
		$("#gKaki image:first").attr({transform: "matrix(0.599991, 0, 0, 0.599991, 0, 0)"});
	},
	bindEvents: function() {
		for(var i=0; i<20; i++) {
			for(var j=1; j<=4; j++) {	// Plate
				for(var k=0; k<=2; k++) {
					GAME.bindFruit(_$([j, k, i].join("_")).show().css("cursor", "pointer"), k);
				}
			}
		}
	},

	bindFruit: function(fruitElement, fruitType) {
		var fruitDragElement = {0: "gOrange", 1: "gBanana", 2: "gKaki"}[fruitType];
		$(fruitElement).drag("init", function(event){
			var pos = calcMousePos(event, this.parentElement);
//			var p0 = 
			var a = $(this).attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean);
			this.startPos = {
				x0: pos.x,	// element's position
				y0: pos.y,
					
				a: Number(a[0]),	// element's inside matrix.
				b: Number(a[1]),
				c: Number(a[2]),
				d: Number(a[3]),
				e: Number(a[4]),
				f: Number(a[5])
			}
		}).drag(function(event){
			var pos = calcMousePos(event, this.parentElement);
			var e = pos.x - this.startPos.x0 + this.startPos.e;
			var f = pos.y - this.startPos.y0 + this.startPos.f;
			$(this).attr({transform: ["matrix(",this.startPos.a,",",this.startPos.b,",",this.startPos.c,",",this.startPos.d,",",e, ",",f, ")"].join("")});
		}).drag("end", function(event){
			
		}).css({cursor: "pointer"}).show();
	},
	removeStuffs: function() {
	},
	initGame: function() {
		console.log("GAME.initGame");
		GAME.patchText();
		GAME.prepare();
		GAME.removeStuffs();
		GAME.bindEvents();

	}
};