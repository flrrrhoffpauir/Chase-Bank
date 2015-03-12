

// -- Imports ---------------------------------------------------- //

import gs.TweenLite;
import gs.easing.*;


// -- Properties ------------------------------------------------- //

var EASE:Function = Expo.easeOut;
var SPEED:Number = .5;

var pauseInterval:Number;
var TIME:Number = 1;


// -- Handlers --------------------------------------------------- //
hotspot.onRollOver = animateCta;
hotspot.onRelease = defaultClick;


// -- Functions -------------------------------------------------- //

function tweenFrom(mc:MovieClip):Void
{
	if(Stage.height == 600)
		TweenLite.from(mc, SPEED*2, { _y:"-100", ease:EASE });
	else
		TweenLite.from(mc, SPEED, { _y:"-50", ease:EASE });
}


function tweenTo(mc:MovieClip):Void
{
	if(Stage.height == 600)
		TweenLite.to(mc, SPEED*2, { _y:"100", ease:EASE });
	else
		TweenLite.to(mc, SPEED, { _y:"50", ease:EASE });
}


function alphaTween(mc:MovieClip):Void
{
	TweenLite.from(mc, SPEED, { _y:"20", _alpha:0, ease:EASE });
}


function initReflection():Void
{
	TweenLite.from(glow, SPEED, { _alpha:0, ease:EASE });
	TweenLite.from(reflection, SPEED, { _alpha:0, _x:"20", _y:"10", ease:EASE });
}

function animateCta():Void
{                    
	if(offer._currentframe == 75 && card._currentframe == 1)
	{
		card.gotoAndPlay("shimmer");
		offer.gotoAndPlay("shimmer");
	}                                
	
	cta.gotoAndPlay("shimmer");	
}


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


function defaultClick():Void
{
	getURL(_root.clickTag, "_blank");
	
	// -- PM wanted hard coded URLs
	// getURL("http://www.chasesapphire.com/has", "_blank");
}


