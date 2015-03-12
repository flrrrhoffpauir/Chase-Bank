
// sharedCode.as
// created by Junie Threatt
// on 2008-07-21

import classes.tweening.TweenLite;
import classes.tweening.Expo;
import classes.tweening.Back;

// -- Tweening Functions ------------------------------- //

var SPEED:Number = .5;
var EASE:Function = Expo.easeOut;

var _count:Number = 0;

function offerTween():Void { TweenLite.from(offer, SPEED, { _y:0-offer._height-10, ease:EASE }); };

function slowAlphaTween(mc:MovieClip):Void { TweenLite.to(mc, SPEED*2.5, { _alpha:100 }); };

function xTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _x:0-mc._width-10, ease:EASE }); };

function yTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _y:Stage.height+mc._height+10, ease:EASE }); };

function yTopTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _y:-10-mc._height, ease:EASE }); };

function yBackTween(mc:MovieClip, dlay:Number):Void { TweenLite.from(mc, SPEED, { _y:Stage.height+mc._height+10, _xscale:10, _yscale:10, delay:dlay, ease:Back.easeOut, onComplete:initController }); };

function xTweenRight(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _x:Stage.width+mc._width+10, ease:EASE }); };

function initItems():Void {
	
	var mc:MovieClip;
	var dlay:Number = 0;
	
	for(var i:Number = 0; i < 3; i++) {
		mc = this["item"+i];
		yBackTween(mc, dlay);
		dlay += .2;
	};

};

function initController():Void {
	if(_count == 2) {
		if(banner == "vert") {
			var _controller:vertItemController = new vertItemController(_root.content, distNums, flag);
		} else {
			var _controller:itemController = new itemController(_root.content);
		};
	};
	
	_count++;
};

function initCTA():Void {
	
	yTween(cta);
	
	cta.onRollOver = shimmerCTA;
	cta.onRelease = defaultClick;
};

function shimmerCTA():Void { cta.bg.gotoAndPlay("shimmer"); };

// -- Timing ------------------------------------------- //

var pauseInterval:Number;
var _pauseTime:Number = .25;

function pauseTimeLine(num:Number):Void {
	stop();
	clearInterval(pauseInterval);
	pauseInterval = setInterval(this, "playTimeLine", num*1000);
};

function playTimeLine():Void {
	play();
	clearInterval(pauseInterval);
};

// -- Hotspot ------------------------------------------ //

hotspot.onRelease = defaultClick;

function defaultClick():Void {
	
	// there is another click tag in the itemController class
	
	getURL(_root.clickTag, "_blank");
};