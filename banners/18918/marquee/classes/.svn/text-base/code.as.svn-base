

// -- Imports ---------------------------------------------------- //

import gs.TweenLite;
import gs.easing.*;


// -- Properties ------------------------------------------------- //

var EASE:Function = Expo.easeOut;
var SPEED:Number = .75;

var pauseInterval:Number;
var TIME:Number = 1;


// -- Handlers --------------------------------------------------- //
_parent.main_btn.onRollOver = animateCard;

// -- Functions -------------------------------------------------- //


function initCenter():Void
{
	headline2._visible = headline3._visible = hero._visible = false;
	
	TweenLite.from(headline0, SPEED, { _y:"35", delay:.5, ease:EASE });
	TweenLite.from(headline1, SPEED, { _y:"35", delay:.5+SPEED/2, ease:EASE });
	TweenLite.delayedCall(3, addCenter, null);
}

function addCenter():Void
{
	headline2._visible = headline3._visible = true;
	TweenLite.to(headline0, SPEED, { _y:"-35", ease:EASE });
	TweenLite.from(headline2, SPEED, { _y:"35", ease:EASE });
	
	var dlay:Number = 0; // .75;
	TweenLite.to(headline1, SPEED, { _y:"-35", delay:dlay, ease:EASE });	
	TweenLite.from(headline3, SPEED, { _y:"35", delay:dlay, ease:EASE });
	
	TweenLite.delayedCall(2, finishCenter, null);
}


function finishCenter():Void
{
	hero._visible = true;
	TweenLite.to(headline2, SPEED, { _y:"-45", ease:EASE });
	TweenLite.to(headline3, SPEED, { _y:"-35", ease:EASE });
	
	TweenLite.from(hero, 1, { _alpha:0, _x:"-20", delay:.2, ease:EASE });
}


function initRight():Void
{
	// offer._visible = 
	cta._visible = false;
	TweenLite.from(card, SPEED, { _x:Stage.width+10+card._width, delay:.5, ease:EASE, onComplete:animateCard, onCompleteScope:this });
	TweenLite.delayedCall(5, finishRight, null);
}


function finishRight():Void
{
	// offer._visible =
	cta._visible = true;
	// TweenLite.to(card, SPEED, { _x:"-60", ease:EASE, onComplete:initCard, onCompleteScope:this });
	// TweenLite.from(offer, SPEED, { _x:Stage.width+10, ease:EASE });
	initCard();
	TweenLite.from(cta, SPEED, { _y:Stage.height+10+cta._height, ease:EASE, delay:.5, onComplete:initCta, onCompleteScope:this });
}


function initCta():Void
{
	cta.onRollOver = animateCta;
	// cta.onRelease = defaultClick;
	card.gotoAndPlay("shimmer");
	cta.gotoAndPlay("shimmer");	
}


function initCard():Void
{
	card.onRollOver = animateCard;
	// card.onRelease = defaultClick;
	// card.gotoAndPlay("shimmer");
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