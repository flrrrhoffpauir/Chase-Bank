

// ------------------------------------------------------------------
// -- Imports
// ------------------------------------------------------------------

import gs.TweenLite;
import gs.easing.*;


// ------------------------------------------------------------------
// -- Properties
// ------------------------------------------------------------------

var EASE:Function = Expo.easeOut;
var SPEED:Number = .5;

var pauseInterval:Number;
var TIME:Number = 1;


// ------------------------------------------------------------------
// -- Handlers
// ------------------------------------------------------------------

hotspot.onRelease = defaultClick;


// ------------------------------------------------------------------
// -- Functions
// ------------------------------------------------------------------


// ------------------------------------------------------------------
// 170x30

function initHeadline(num:Number):Void
{
	var mc:MovieClip = this["headline"+num];
	TweenLite.from(mc, SPEED, { _y:"-30", ease:EASE });
};


function killHeadline(num:Number):Void
{
	var mc:MovieClip = this["headline"+num];
	TweenLite.to(mc, SPEED, { _y:"30", ease:EASE });
};


function killCard():Void
{
	TweenLite.to(card, SPEED, { _y:"50", ease:EASE });
};


function selectWord(num:Number):Void
{
	var mc = this["headline"+num]
	mc.gotoAndStop(2);
};


// ------------------------------------------------------------------
// 240x90

function initHotspot():Void
{
	_root.hotspot.onRelease = defaultClick;
};


function initRollover():Void
{
	card.gotoAndPlay("shimmer");
	_root.bg.play();
	
	_root.bg.onRollOver = function():Void
	{
		this.play();
	};
	
	card.onRelease = defaultClick;
	_root.bg.onRollOver = defaultClick;
};


// ------------------------------------------------------------------

function initCta():Void
{
	cta.onRollOver = animateCta;
	cta.onRelease = defaultClick;
};


function animateCta():Void
{
	cta.gotoAndPlay("shimmer");
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


