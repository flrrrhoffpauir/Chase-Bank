

// -- Imports ---------------------------------------------------- //

import gs.TweenLite;
import gs.easing.*;


// -- Properties ------------------------------------------------- //

var EASE:Function = Expo.easeOut;
var SPEED:Number = .5;

var pauseInterval:Number;
var TIME:Number = 1;


// -- Handlers --------------------------------------------------- //


// -- Functions -------------------------------------------------- //


function initCenter():Void
{
	headline2._visible = headline3._visible = headline4._visible = false;
	
	TweenLite.from(mask0, SPEED, { _rotation:90, ease:EASE });
	TweenLite.from(mask1, SPEED, { _rotation:90, delay:SPEED/2, ease:EASE });
	TweenLite.delayedCall(2.5, finishCenter, null);
}

function finishCenter():Void
{
	TweenLite.to(mask0, SPEED, { _y:"-40", ease:EASE });
	TweenLite.to(mask1, SPEED, { _y:"-40", ease:EASE });
	
	var dlay:Number = .5;
	headline2._visible = headline3._visible = headline4._visible = true;
	TweenLite.from(mask2, SPEED, { _rotation:90, delay:dlay, ease:EASE });
	TweenLite.from(mask3, SPEED, { _rotation:90, delay:dlay+SPEED/2, ease:EASE });
	TweenLite.from(headline4, SPEED, { _y:"-30", delay:dlay+(SPEED/2)*2, ease:EASE });	
}


function initRight():Void
{
	TweenLite.from(card, SPEED, { _x:Stage.width+10+card._width, delay:0, ease:EASE });
	TweenLite.from(cta, SPEED, { _y:Stage.height+10+cta._height, delay:3.5, ease:EASE, onComplete:initCta, onCompleteScope:this });
}


function finishRight():Void
{
	
}


function initCta():Void
{
	cta.onRollOver = animateCta;
	cta.onRelease = defaultClick;
	
	card.onRollOver = animateCard;
	card.onRelease = defaultClick;
	
	cta.gotoAndPlay("shimmer");
	card.gotoAndPlay("shimmer");
}


function animateCta():Void { if(cta._currentframe == 1) cta.gotoAndPlay("shimmer"); };
function animateCard():Void { if(card._currentframe == 1) card.gotoAndPlay("shimmer"); };


function pauseTl(t:Number):Void
{
	stop();
	clearInterval(pauseInterval);
	pauseInterval = setInterval(this, "playTl", t*1000);
}


function playTl():Void
{
	play();
	clearInterval(pauseInterval);
}