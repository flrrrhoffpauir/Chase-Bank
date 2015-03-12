
import flash.filters.BlurFilter;

// -- Variables  -------------------------------------------------------------------------------------

_quality = "best";

var typeInterval:Number;
var i:Number = 0;

// -- Functions  -------------------------------------------------------------------------------------

function typeWrite(txt:String, t:TextField):Void {
	stop();
	i = 0;
	txt = txt.toUpperCase();
	clearInterval(typeInterval);
	typeInterval = setInterval(this, "typeChar", 20, txt, t);
};

function typeChar(txt:String, t:TextField):Void {
	if(i == txt.length) {
		t.text = txt;
		clearInterval(typeInterval);
		play();
	} else {
		t.text = txt.substr(0, i);
		i++;
	};
};

function blurTween(mc:MovieClip, bx:Number, by:Number):Void {
	var blur:BlurFilter = new BlurFilter(bx, by, 3);
	mc.filters = new Array(blur);
	var blur_x = TweenLite.to(blur, .2, { blurX:0, blurY:0, onComplete:stopBlur, onCompleteParams:[mc] });
};

function stopBlur(mc:MovieClip):Void {
	mc.filters = [];
};

function setHotSpot():Void {
	hotspot.onRollOver = function():Void {
		smallPhone_mc.gotoAndPlay("shake");
		cta_mc.bg.gotoAndPlay("shimmer");
		TweenLite.to(cta_mc.arrow_mc, .5, { _x:62 });
	};
	hotspot.onRollOut = function():Void {
			TweenLite.to(cta_mc.arrow_mc, .5, { _x:57 });
	};
};

function defaultClick():Void {
	getURL(_root.clickTag, "_blank");
	// getURL("http://www.chasewhatmatters.com", "_blank");
};

hotspot.onRelease = defaultClick;