
//
// code.as
//
// Created by Junie Threatt
// on 2008-06-05
//

import gs.TweenLite;
import gs.Expo;

// -- Properties ---------------------------------- //

var _pauseInterval:Number;
var _pauseTime:Number = 5.25;
var _posArray:Array = [];
var SPEED:Number = .5;

// -- Functions ----------------------------------- //

function headlineTween():Void {
	TweenLite.from(headline, SPEED, { _y:-10-headline._height, ease:Expo.easeOut });
};

function initBodyCopy():Void {
	
	var mc:MovieClip;
	var dlay:Number = 0;
	
	for(var i:Number = 0; i < 3; i++) {
		mc = this["copy"+i];
		if(i != 1) {
			TweenLite.from(mc, SPEED, { _x:-10-mc._width, ease:Expo.easeOut, delay:dlay });
		} else {
			TweenLite.from(mc, SPEED*2, { _x:-10-mc._width, ease:Expo.easeOut, delay:dlay });
		}
		dlay += .2;
	};
};

function fadeObjectRight(mc:MovieClip):Void {
	TweenLite.from(mc, SPEED*1.5, { _x:mc._x-20, _alpha:0, ease:Expo.easeOut });
};

function offerTween():Void {
	TweenLite.from(offer, SPEED, { _y:offer._y-20, _alpha:0, ease:Expo.easeOut });
};

function initCta():Void {
	TweenLite.from(cta, SPEED, { _y:cta._y+20, alpha:0, ease:Expo.easeOut });
	
	cta.onRollOver = function():Void {
		cta.gotoAndPlay("shimmer");
	};
	
	cta.onRelease = defaultClick;
}

function initAccordion():Void {
	
	var mc:MovieClip;
	var dlay:Number = 0;
	
	for(var i:Number = 0; i < 3; i++) {
		mc = this["tile"+i];
		_posArray.push(mc._y);
		TweenLite.from(mc, SPEED*1.5, { _y:Stage.height+10, ease:Expo.easeOut, delay:dlay });
		dlay += .2;
	};
};

function expandAccordion(collapseTile:MovieClip, expandTile:MovieClip):Void {
	
	collapseTile.gotoAndPlay("collapse");
	expandTile.gotoAndPlay("expand");
	
	switch(expandTile) {
		
		case tile0 :
		moveTilesDown(1, 2, 3);
		break;
		
		case tile1 :
		TweenLite.to(tile1, SPEED*1.5, { _y:_posArray[1], ease:Expo.easeOut });
		break;
		
		case tile2 :
		TweenLite.to(tile2, SPEED*1.5, { _y:_posArray[2], ease:Expo.easeOut });
		break;
		
		case tile3:
		TweenLite.to(tile3, SPEED*1.5, { _y:_posArray[3], ease:Expo.easeOut });
	};
	
	
};

function moveTilesDown():Void {
	var mc:MovieClip;
	for(var i:Number = 0; i < arguments.length; i++) {
		mc = this["tile"+arguments[i]];
		TweenLite.to(mc, SPEED*2, { _y:mc._y+81, ease:Expo.easeOut });
	};
};

function pauseTimeLine(num:Number):Void {
	stop();
	clearInterval(_pauseInterval);
	_pauseInterval = setInterval(this, "playTimeLine", num*1000);
};

function playTimeLine():Void {
	play();
	clearInterval(_pauseInterval);
};

function defaultClick():Void {
	getURL(_root.clickTag, "_blank");
};

hotspot.onRelease = defaultClick;