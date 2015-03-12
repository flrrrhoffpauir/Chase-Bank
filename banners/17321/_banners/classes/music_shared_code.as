/**
*	ski_shared_code Class
*	Created on 2008-09-18
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2008-09-18                      
*	@author timmy
*	@version 1.0.0
*
*	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import gs.TweenLite;
import gs.Expo;
import gs.Linear;


var TEXT_SPEED:Number = 0.5;
var TEXT_DELAY:Number = 0.2;
var STAGE_PADDING:Number = 20;

	

// start the show  //////////////////////////////////////////////////////////
init();








function randomizeFlames():Void
{
	for(var i:Number = 0; i < 5; i++) { flames_mc["flame_" + i].gotoAndPlay(Math.ceil(Math.random()*35)); }
};

function curtainCall(endPos:Number, time:Number):Void
{
	trace("curtainCall(" + endPos + ", " + time + ")");
	TweenLite.to(curtains_mc, time, { _y:endPos, ease:Linear.easeNone });
};

function alphaTween(mc:MovieClip, num:Number, tweenTime:Number):Void
{
	var time:Number = (tweenTime != undefined) ? tweenTime : TEXT_SPEED;
	TweenLite.to(mc, time, { _alpha:num });
};

function xTween(mc:MovieClip, dlay:Number):Void
{
	TweenLite.from(mc, TEXT_SPEED, { _x:-(STAGE_PADDING)-mc._width, ease:Expo.easeOut, delay:dlay });
};

function yTween(mc:MovieClip, dlay:Number):Void
{
	TweenLite.from(mc, TEXT_SPEED, {  _alpha:0, ease:Linear.easeOut, delay:dlay });
};

function tweenLogosToWhite():Void
{
	var time:Number = 0.5;
	TweenLite.to(logo_mc.logoBlack_mc, time, { _alpha:0, ease:Expo.easeOut });
	TweenLite.to(logo_mc.logoWhite_mc, time, { _alpha:100, ease:Expo.easeOut });
};

function defaultClick():Void
{
	// trace("defaultClick()");
	// _root.conduit.exit(1);
	//getURL(_root.clickTag, "_blank");
};

function init():Void
{
	hotspot_mc.onRelease = defaultClick;
	
	switch(banner)
	{
		case "120x600" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;
		case "160x600" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;
		case "250x250" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;	
		case "300x250" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;
		case "300x600" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;
		case "336x280" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;
		case "336x850" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;
		case "728x90" :
			logo_mc.logoBlack_mc._alpha = 100;
			logo_mc.logoWhite_mc._alpha = 0;
			break;			
	}	
};


function initBottomMenu():Void
{
	trace("initBottomMenu()");
	hotspot_mc.onRollOver = function():Void
	{
		shimmer();
	};
	shimmer();
};


function initTopMenu(w:Number, cy:Number, ny:Number, cx:Number, nx:Number):Void
{

	var defaultWidth:Number = w;	// collapsed menu background width
	var defaultY:Number = cy;		// collapsed menu _y
	var newY:Number = ny;			// expanded menu _y
	var defaultX:Number = cx;		// collapsed menu _x
	var newX:Number = nx;			// expanded menu _x
	
	// hide the bullets until the panel expands
	topMenu_mc.txt._alpha = 0;

	// tween menu into view
	TweenLite.from(topMenu_mc, .5, { _y:0-topMenu_mc._height-10, ease:Expo.easeOut });
	
	topMenu_mc.onRollOver = function():Void
	{
		// tween menu down
		TweenLite.to(this, .5, { _y:newY, _x:newX, ease:Expo.easeOut });
		
		// show the bullets
		TweenLite.to(this.txt, .5, { _alpha:100, ease:Expo.easeOut });
	
		// tween close button
		TweenLite.to(this.details, .5, { _alpha:0, ease:Expo.easeOut });
	};
	
	topMenu_mc.onRollOut = function():Void
	{
		TweenLite.to(this, .5, { _y:defaultY, _x:defaultX, ease:Expo.easeOut });
		TweenLite.to(this.txt, .5, { _alpha:0, ease:Expo.easeOut });
		TweenLite.to(this.details, .5, { _alpha:100, ease:Expo.easeOut });
	};
	
	topMenu_mc.onRelease = defaultClick;
};

function shimmer():Void
{
	bottomMenu_mc.cta_mc.gotoAndPlay("shimmer");
	bottomMenu_mc.card_mc.gotoAndPlay("shimmer");
};
