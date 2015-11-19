//==============
// MVNButton Button class
// id: Sothink Button Id.
// zoomMa: kích thước lớn nhất khi nở ra.
// step: bước tăng kích thước.
function MVNButton(options) {
	var g_bRunning = false;
	var _id = options.id;
	var _zoomMin = 1;
	var _zoomMax = options.zoomMax || 1.05;
	var _zoomStep = options.zoomStep || 0.0125;
	var _zoomStepX = _zoomStep;
	var _eOver = null; // over
	var _eUp = null; // up
	var _e = $(document.getElementById(_id).firstChild.nextSibling);

	// Calculate original position X, Y and Zoom level.		
	var s = _e.attr("transform");
	if (s == "")
		s = "matrix(1,0,0,1,0,0)";
	var _a = s.split(/matrix\(|[, ]+|\)/).filter(Boolean);
	
	var zoom = Number(_a[3]); // use zoomY as zoom unit.
	var zoomX = Number(_a[0]); // "matrix(x" ==> x
	_zoomMin *= zoom;
	_zoomMax *= zoom;
	_zoomStep *= zoom;
	_zoomStepX = _zoomStep * zoomX / zoom;

	var ZOOM_IN = 1;
	var ZOOM_OUT = -1;
	var NORMAL = 0;
	var _mode = NORMAL; // 0: normal; 1:zoomIn. -1: zoomOut.

	$.each(_e.children(), function(k, v) {
		if (v.getAttribute("state") == "over") {
			_eOver = $(v);
		} else if (v.getAttribute("state") == "up") {
			_eUp = $(v);
		}
	});

	function zoomIn(x) {
		setTimeout(function() {
			if (_mode != ZOOM_IN)
				return;
			var a = x.attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean);
			var dY = Number(a[3]);
			if (dY >= _zoomMax) {
				_mode = NORMAL;
				return;
			}
			dY += _zoomStep;
			var dX = Number(a[0]);
			dX += _zoomStepX;
			x.attr("transform", ["matrix(", dX, 0, 0, dY, a[4], a[5], ")"].join(" "));
			setTimeout(arguments.callee, 33); // 33 is seconds per frame.
		}, 33);
	}

	function zoomOut(x) {
		setTimeout(function() {
			if (_mode != ZOOM_OUT)
				return;
			var a = x.attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean);
			var dY = Number(a[3]);
			if (dY <= _zoomMin) {
				_mode = NORMAL; // normal
				return;
			}
			dY -= _zoomStep;
			var dX = Number(a[0]);
			dX -= _zoomStepX;
			x.attr("transform", ["matrix(" + dX, 0, 0, dY, a[4], a[5], ")"].join(" "));
			setTimeout(arguments.callee, 33);
		}, 33);
	}

	$(document.getElementById(_id)).mousedown(function(event) {
		if (event.which != 1)
			return;
		if (g_bRunning)
			return;


		g_bRunning = true; // Turn Animate ON.

		//			console.log("mousedown");
		if (Number(_e.attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean)[3]) >= _zoomMax)
			return;

		$(document).css("cursor", "pointer");
		_mode = ZOOM_IN;
		zoomIn(_e);
	}).mouseleave(function(event) {
		if (!g_bRunning)
			return;

		// if Animation Mode = ON then do ZoomOut (size--)
		_eOver.toggle(true);
		_eUp.toggle(false);
		//			console.log("mouseleave");

		if (Number(_e.attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean)[3]) <= _zoomMin)
			return;
		_mode = ZOOM_OUT;
		zoomOut(_e);
	}).mouseenter(function(event) {
		if (!g_bRunning)
			return;

		// if Animation Mode = ON then do ZoomIn (size++)
		//			console.log("mouseenter");
		if (Number(_e.attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean)[3]) >= _zoomMax)
			return;
		_mode = ZOOM_IN;
		zoomIn(_e);
	});
	$(document).mouseup(function(event) {
		if (!g_bRunning)
			return;
		// Turn Animation Mode = OFF.
		g_bRunning = false;
		_mode = NORMAL;
		//			console.log("mouseup");

		_eOver.toggle(false);
		_eUp.toggle(true);
		if (Number(_e.attr("transform").split(/matrix\(|[, ]+|\)/).filter(Boolean)[3]) <= _zoomMin)
			return;
		_mode = ZOOM_OUT;
		zoomOut(_e);
	});
}