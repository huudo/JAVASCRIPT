function Animation() {
	this.aAnim = [];
	this.bPause = false;
	this._t0 = 0;
	this._t1 = 0;
	this._nInterval = 0;
}

Animation.prototype.onInit = function() {
	for(var i=0; i<this.aAnim.length; i++) {
		this.aAnim[i].bRunning = true;
		if(this.aAnim[i].onInit != null) {
			this.aAnim[i].onInit();
		}
	}
}

Animation.prototype.onStep = function(t) {
	for(var i=0; i<this.aAnim.length; i++) {
		var o = this.aAnim[i];
		if(o.delay < t && t<=o.duration + o.delay) {
			for(var j in o.data) {
				var e = o.data[j];
				e.now = Math[e.easing](t-o.delay, e.startValue, e.endValue-e.startValue, o.duration);
			}
			o.onStep(o.data, t);
		} 
		
	}
}

Animation.prototype.onComplete = function(t) {
	for(var i=0; i<this.aAnim.length; i++) {
		var o = this.aAnim[i];
		// Nếu có hàm onComplete và chưa được gọi lần nào.
		
		if((o.bRunning) && t>o.duration + o.delay) {
			if(o.isRunAtEnd) {
				for(var j in o.data) {
					o.data[j].now = o.data[j].endValue;
				}
				o.onStep(o.data, t);
			}
			
			if(o.onComplete) {
				o.onComplete();
			}
			o.bRunning = false;
			
		}
	}
}

// Kiểm tra xem một nhóm Animation đã dừng toàn bộ hiệu ứng hay chưa.
// Chỉ dừng khi mọi cờ đã được tắt (false).
Animation.prototype.isRunning = function(t) {
	for(var i=0; i< this.aAnim.length; i++) {
		if(this.aAnim[i].bRunning) return true;
	}
	
	return false;
}

Animation.prototype.isTimeout = function(t) {
	// Kiểm tra điều kiện kết thúc.
	// Một animation thread gọi là kết thúc nếu t> delay + duration.
	var b = true;
	for(var i=0; i<this.aAnim.length; i++) {
		b = b && (t>this.aAnim[i].duration + this.aAnim[i].delay);
	}
	
	return b;
}

// Thực hiện animation.
Animation.prototype.run = function() {
	this._t0 = +new Date();
	var _this = this;

	_this.onInit();	
	clearInterval(this._nInterval);
	
	this._nInterval = setInterval(function() {
		if(_this.bPause) {
			clearInterval(_this._nInterval);
			return;
		}
		
		var t = +new Date() - _this._t0;
		// Kiểm tra onComplete của từng Animation.
		_this.onComplete(t);		

		// Kiểm tra nếu toàn bộ Animation đã quá timeout thì dừng process.
		if(_this.isTimeout(t)) {
			clearInterval(_this._nInterval);
		}
		
		_this.onStep(t);
	}, 14);
}

Animation.prototype.stop = function() {
	clearInterval(this._nInterval);
	this._nInterval = 0;
}

Animation.prototype.pause = function() {
	this.bPause = true;
	this._t1 = +new Date();
}

Animation.prototype.resume = function() {
	this.bPause = false
	this._t0 += (+new Date() - this._t1);

	var _this = this;
	var _nInterval = setInterval(function() {
		if(_this.bPause) {
			clearInterval(_nInterval);
			return;
		}
			
		var t = +new Date() - _this._t0;
		// Kiểm tra onComplete của từng Animation.
		_this.onComplete(t);		

		// Kiểm tra nếu toàn bộ Animation đã quá timeout thì dừng process.
		if(_this.isTimeout(t)) {
			clearInterval(_nInterval);
		}
		
		_this.onStep(t);
	}, 14);
}


/*===================
 Thêm 1 animation vào list.
// anim: {
	duration: 1500,				// duration theo mili giây.
	delay: 3000,					// delay bao nhiêu mili giây, sau đó mới thực hiện animation.
	isRunAtEnd: false,			// có đảm bảo endValue được thực hiện không?
	data: {
		y : {
			startValue: 0,			// giá trị ban đầu animation.
			endValue: 15,			// giá trị khi kết thúc animation.
			easing: "easeOutCirc"	// hàm easing để tính toán.
		},
		width: {
			startValue: 0,
			endValue: 15,
			easing: "easeOutCirc"
		}
	},					// dữ liệu riêng của animation.
	onInit: function() {},		// hàm thực hiện khi bắt đầu animation.
	onComplete: function() {},	// hàm thực hiện khi kết thúc animation.
	onStep: function(t) {},		// hàm thực hiện tại mỗi animation step. input: t.
}
===================*/
Animation.prototype.add = function(anim) {
	var o = {
		duration: 1,
		delay: 0,
		isRunAtEnd: false,
		data: {},
		onInit: function() {},
		onComplete: function() {},
		onStep: function() {}
	};
		
	for(var i in o) {
		if(typeof(anim[i]) != "undefined") {
			o[i] = anim[i];
		}
	}
	
	
	this.aAnim.push(o);
}

Animation.prototype.reset = function() {
	this.aAnim = new Array();
	this.bPause = false;
	this._t0 = 0;
	this._t1 = 0;
	this._nInterval = 0;
} 



