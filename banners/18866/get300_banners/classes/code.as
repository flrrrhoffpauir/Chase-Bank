

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
hotspot.onRollOver = animateBanner;


// -- Functions -------------------------------------------------- //

function initHeadline():Void
{
	TweenLite.from(headline0, SPEED*2, { _x:-10-headline0._width, ease:EASE });
	TweenLite.from(headline0b, SPEED*2, { _x:Stage.width+10, ease:EASE });
};


function transition():Void
{
	TweenLite.to(headline0, SPEED, { _alpha:0, ease:EASE });
	TweenLite.to(headline0b, SPEED, { _alpha:0, ease:EASE });
	
	TweenLite.from(headline1, SPEED*2, { _alpha:100, _y:"20", ease:EASE });
	
	TweenLite.from(cta, SPEED*2, { _alpha:0, ease:EASE });
	
	var t:Number = (Stage.width == 728) ? .8 : .5;
	TweenLite.delayedCall(t, initCard, [], this);
	
	initCta();
};


function initBullets():Void
{
	var mc:MovieClip;
	var dlay:Number = 0;
	for(var i:Number = 0; i < 4; i++)
	{
		mc = this["bullet"+i];
		if(Stage.width == 728)
		{
			TweenLite.from(mc, SPEED, { _y:Stage.height+mc._height, delay:dlay, ease:EASE });
		}
		else
		{
			TweenLite.from(mc, SPEED, { _x:-10-mc._width, delay:dlay, ease:EASE });
		};
		
		TweenLite.delayedCall(2.5, animateCta, [], this);
		
		dlay += .7;
	};
};


function initCta():Void
{
	// cta.onRollOver = animateCta;
	cta.onRelease = defaultClick;
};


function initCard():Void
{
	animateCard();
	// card.onRollOver = animateCard;
	card.onRelease = defaultClick;
};


function animateBanner():Void
{
	if(card._currentFrame == 1&& cta._currentFrame == 1)
	{
		animateCard();
		animateCta();
	};
};

function animateCard():Void
{
	if(card._currentframe == 1)
	{
		card.gotoAndPlay("shimmer");
	};
};


function animateCta():Void
{
	if(cta._currentframe == 1)
	{
		cta.gotoAndPlay("shimmer");
	};
};


function pauseTl(t:Number):Void
{
	this.stop();
	clearInterval(pauseInterval);
	pauseInterval = setInterval(this, "playTl", t*1000);
};


function playTl():Void
{
	this.play();
	clearInterval(pauseInterval);
};


function defaultClick():Void
{
	getURL(_root.clickTag, "_blank");
};


