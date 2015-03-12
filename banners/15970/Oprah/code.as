//
//  code.as
//
//  Created by Junie Threatt on 2008-02-21.
//

import TweenLite; // default tween is Cubic

// variables  -------------------------------------------------------------------------------------
_quality = "BEST";

var mSpeed:Number = .5;
var fSpeed:Number = .3;

var pauseInterval:Number;

var easeType:String = "easeOutQuad";

// functions  -------------------------------------------------------------------------------------

// pause the timeline for t seconds
function pauseTL(t:Number):Void {
	stop();
	clearInterval(pauseInterval);
	pauseInterval = setInterval(this, "unPauseTL", t * 1000);
}

// unpause and clear interval
function unPauseTL():Void {
	play();
	clearInterval(pauseInterval);
}

function initHeadline():Void {
	TweenLite.from(headline_mc, mSpeed, { _y:headline_mc._y - headlineBG_mc._height });
	TweenLite.from(headlineBG_mc, mSpeed, { _y:0 });
	TweenLite.from(headlineBGShadow_mc, mSpeed, { _y:1 });
	TweenLite.from(logo_mc, mSpeed, { _y:logo_mc._y - headlineBG_mc._height });
}

function transitionHeadline(y:Number, h:Number):Void {
	TweenLite.to(headline_mc, fSpeed, { _alpha:0, _y:headline_mc._y+50 });
	TweenLite.to(headlineBG_mc, fSpeed, { _height:h, _y:y });
	TweenLite.to(headlineBGShadow_mc, fSpeed, { _height: h, _y:y+1 });
}

function initHotSpot():Void {
	hotspot.onRollOver = function():Void {
		this._parent.cta_mc.gotoAndPlay("shimmer");
	}	
}

function defaultClick():Void {
	getURL(_root.clickTag, "_blank");
}
// run at once  -----------------------------------------------------------------------------------

hotspot.onRelease = defaultClick;