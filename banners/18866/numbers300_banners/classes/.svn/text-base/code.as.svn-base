

// -- Imports ---------------------------------------------------- //

import gs.TweenLite;
import gs.easing.*;


// -- Properties ------------------------------------------------- //

var EASE:Function = Expo.easeOut;
var SPEED:Number = .5;

var pauseInterval:Number;
var TIME:Number = 1;


// -- Handlers --------------------------------------------------- //

hotspot.onRelease = defaultClick;
hotspot.onRollOver = shimmerBanner;


// -- Functions -------------------------------------------------- //


function initHeadline():Void
{
	var mc:MovieClip;
	var dlay:Number = 0;
	for(var i:Number = 0; i < 3; i++)
	{
		mc = headline["c"+i];
		TweenLite.from(mc, SPEED, { _y:mc._y-mc._height-10, delay:dlay, ease:EASE });
		dlay += .2;
	};
};


function initOffer():Void
{
	if(Stage.width == 728)
	{
		TweenLite.from(offer.ds, SPEED/2, { _x:"-10", _y:"10", ease:EASE });
		TweenLite.from(offer.bg, SPEED*1.5, { _y:-10-offer.bg._height, delay:.2, ease:EASE, onComplete:animateCta, onCompleteScope:this });
	}
	else
	{
		TweenLite.from(offer.ds, SPEED/2, { _x:"10", _y:"10", ease:EASE });
		TweenLite.from(offer.bg, SPEED*1.5, { _x:-10-offer.bg._width, delay:.2, ease:EASE, onComplete:animateCta, onCompleteScope:this });
	}
	
	TweenLite.from(offer.ts, SPEED/2, { _alpha:0, delay:.2, ease:EASE });
};


function shimmerBanner():Void
{
	// -- that's right, let's shimmer the whole banner ------ //
	animateCta();
	animateCard();
	animateBg();
	// -- booyah! ------------------------------------------- //
};


function animateCta():Void
{
	if(offer.bg.cta._currentframe == 1)
	{
		offer.bg.cta.gotoAndPlay("shimmer");
	};
};


function animateCard():Void
{
	if(hero1._currentframe == 1)
	{
		hero1.gotoAndPlay("shimmer");
	};
};


function animateBg():Void
{
	if(bg._currentframe == 1)
	{
		bg.gotoAndPlay("shimmer");
	};
};


function pauseTl(t:Number):Void
{
	stop();
	clearInterval(pauseInterval);
	pauseInterval = setInterval(this, "playTl", t*1000);
};


function playTl():Void
{
	play();
	clearInterval(pauseInterval);
};


function defaultClick():Void
{
	getURL(_root.clickTag, "_blank");
};


