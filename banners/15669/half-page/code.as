_quality = "best";

var typeInterval:Number;
var i:Number = 0;

var swipeInterval:Number;
var z:Number = 1;

var swipeBottomInterval:Number;
var b:Number = 1;

function typeWrite(txt:String, t:TextField):Void {
	stop();
	i = 0;
	txt = txt.toUpperCase();
	clearInterval(typeInterval);
	typeInterval = setInterval(this, "typeChar", 20, txt, t);
}

function typeChar(txt:String, t:TextField):Void {
	if(i == txt.length) {
		t.text = txt;
		clearInterval(typeInterval);
		play();
	} else {
		t.text = txt.substr(0, i);
		i++;
	}
}

/*
cta_mc.hotspot.onRollOver = function() {
	var shimmerz = _tweens.xTween(this._parent.shimmer, this._parent.shimmer._x, 115, 2);
	shimmerz.onMotionFinished = function() {
		_level0.cta_mc.shimmer._x = -65;
		trace(": " + shimmer)
	}
}
*/

function mcHover(mc:MovieClip, startX:Number, startY:Number, step:Number, range:Number):Void {
	var count:Number = 0;
	mc.onEnterFrame = function():Void {
		count += step;
		this._y = startY + Math.sin(count) * range;
		this._x = startX + Math.cos(count) * 1.5;
	}
}

function swipePortals():Void {
	clearInterval(swipeInterval);
	swipeInterval = setInterval(this, "swipe", 5);
}

function swipeBottomPortals():Void {
	clearInterval(swipeBottomInterval);
	swipeBottomInterval = setInterval(this, "swipeBottom", 5);
}

function swipe():Void {
	var mc:MovieClip = eval("s" + z);
	_tweens.scaleTween(mc, mc._xscale, Math.random() / 2 * 100, .3);
	if((z % 2) == 0) {
		_tweens.xTween(mc, mc._x, mc._x + Math.random() * Stage.width + Stage.width, .5);
		_tweens.yTween(mc, mc._y, mc._y + Math.random() * Stage.height + Stage.height, .5);
	} else {
		_tweens.xTween(mc, mc._x, mc._x + Math.random() * Stage.width + (Stage.width / 2), .5);
		_tweens.yTween(mc, mc._y, mc._y + Math.random() * Stage.height + (Stage.height / 2), .5);
	}
	
	_tweens.fadeTween(mc, mc._alpha, 0, .3);
	
		
	z++;
		
	if(z >= 12) {
		clearInterval(swipeInterval);
	}
}

function swipeBottom():Void {
	var mc:MovieClip = eval("p" + b);
	var speed:Number = 1;
	_tweens.scaleTween(mc, mc._xscale, Math.random() / 2 * 100, .3);
	if((b % 2) == 0) {
		_tweens.xTween(mc, mc._x, mc._x + -(Math.random() * Stage.width + Stage.width), speed);
		_tweens.yTween(mc, mc._y, mc._y + -(Math.random() * Stage.height + Stage.height), speed);
	} else {
		_tweens.xTween(mc, mc._x, mc._x + -(Math.random() * Stage.width + (Stage.width / 2)), speed);
		_tweens.yTween(mc, mc._y, mc._y + -(Math.random() * Stage.height + (Stage.height / 2)), speed);
	}
	
	_tweens.fadeTween(mc, mc._alpha, 0, speed);
	
		
	b++;
		
	if(b >= 12) {
		clearInterval(swipeBottomInterval);
	}
}

function setHotSpot():Void {
	hotspot.onRollOver = function():Void {
		smallPhone_mc.gotoAndPlay("shake");
		cta_mc.bg.gotoAndPlay("shimmer");
		if(Stage.width == 728) {
			_tweens.xTween(cta_mc.arrow_mc, cta_mc.arrow_mc._x, 52, .5);
		} else if(Stage.width == 468) {
			// do nothing
		} else {
			_tweens.xTween(cta_mc.arrow_mc, cta_mc.arrow_mc._x, 59, .5);
		}
	}
	hotspot.onRollOut = function():Void {
		if(Stage.width == 728) {
			_tweens.xTween(cta_mc.arrow_mc, cta_mc.arrow_mc._x, 49, .5);
		} else if(Stage.width == 468) {
			// do nothing
		} else {
			_tweens.xTween(cta_mc.arrow_mc, cta_mc.arrow_mc._x, 57, .5);
		}
	}
}

function defaultClick():Void {
	getURL(_root.clickTAG, "_blank");
}

hotspot.onRelease = defaultClick;