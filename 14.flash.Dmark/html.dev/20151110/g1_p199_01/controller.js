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
//=================================================================================================================//
function drawShape(){


	var a = $(document.getElementById("0:549:53:543:44"));
	var i=1;
	var image = document.createElementNS('http://www.w3.org/2000/svg','image');
	image.setAttributeNS("http://www.w3.org/1999/xlink", "href","g1_p199_01/image/image_11_0.png");
	$(image).attr({width:134,height:391,
					transform: ["matrix(0.599991, 0, 0, 0.599991, 0, 0)"]
		});
	var t1 = 1-0.939697;
	var t2 = 0.342026;
	var g1 = $(createTag("g")).attr({"id":"shap"+i,
					transform: ["matrix(1,0,0,1,0,0)"]
		});
	g1.append(image);
	a.append(g1);
}


function drawLevel1(a){
	for(var i=0 ; i<a ; i++){
		_$(Level1_right[i]).show();
	}
}








var GAME = {
	patchText: function() {
		console.log("GAME.patchText");
	},
		
	bindEvents: function() {

		// MVNButton({
		// 	id: BTN_START //BTN_01 = "0:6:9:12:33"
		// }); // START
		// MVNButton({
		// id: BTN_BACK
		// }); // PAUSE
		// MVNButton({
		// 	id: BTN_RESET
		// }); // RESET
	
		$(document.getElementById(BTN_START)).bind("mouseup touchend", function(event) {
			event.preventDefault();
			//$(document.getElementById("0:42:91:76:90")).css({"opacity": 1});

														
		});
		// $(document.getElementById(BTN_BACK)).bind("mouseup touchend", function(event) {
		// 	event.preventDefault();
		// 	var o = mvn.mainMovie.sprites["42:91"];
	
		// });

		// $(document.getElementById(BTN_RESET)).bind("mouseup touchend", function(event) {
		// 	event.preventDefault();		

		// });



		$(document.getElementById(BTN_MOVE)).bind("draginit", function(event) {
			this.startPosition = {
				x: event.clientX, //toa do ban dau cua chuot
				y: event.clientY,
				
			};

		}).drag(function(event) {

			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			dY = (event.clientY - this.startPosition.y)/g_zoomLevel;
			y1 = y_end+dY;
			dx = Math.sqrt(175*175 - y1*y1) - x1;
			x1 = Math.sqrt(175*175 - y1*y1);
			//console.log("YFIST", dY);
			//var  test = L-count;
			count = Math.sqrt(dx*dx +dY*dY);
			a = parseInt(count/L + 0.5);	
			console.log(a);		
			_$("0:549:53:543:44").hide();
			var m = t+a;			
			drawLevel1(m);
			_$("0:1115:91:5:62").find("g").first().attr({transform: ["matrix(0.75,0,0,0.75,",x1,",",y1,")"].join("")});

		}).drag("dragend", function(event) {
			var dX = (event.clientX - this.startPosition.x)/g_zoomLevel; //clientX: toa do chuot khi drag - dX: toa do di chuyen chuot
			dY = (event.clientY - this.startPosition.y)/g_zoomLevel;
			dY = (event.clientY - this.startPosition.y)/g_zoomLevel;
			x1 = Math.sqrt(175*175 - y1*y1);
			count = Math.sqrt(dX*dX +dY*dY);
			t= t+a;
			y_end = y_end +dY; 

			

		}).css({
			cursor: "pointer"
		});

		//=====================CHECK BOX==============================
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