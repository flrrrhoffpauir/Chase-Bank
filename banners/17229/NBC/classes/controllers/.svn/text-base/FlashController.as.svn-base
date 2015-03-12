/**
FlashController

@author Junie Threatt
@version 1.0

@description Handles random camera flashes

*/

import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;

class classes.controllers.FlashController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _flashInterval:Number;
	
	// static properties
	private static var SPEED:Number		= .5;
	private static var EASE:Function	= Expo.easeOut;
	private static var MIN_TIME:Number	= 1;
	private static var MAX_TIME:Number	= 2;
	
	// contructor
	public function FlashController(scope:MovieClip) {
		
		_scope 		= scope;
		
		initAlpha();
		
		// wait to flash the first time
		_global.setTimeout(this, "flash", randomRange(MIN_TIME, MAX_TIME)*1000);
	}
	
	private function initAlpha():Void {
		var mc:MovieClip;
		for(var i:Number = 0; i < 3; i++) {
			mc = _scope["flash"+i];
			mc._alpha = 0;
			mc._xscale = mc._yscale = 0;
		}
	}
	
	private function flash():Void {
		
		// clear interval and set another random one
		clearInterval(_flashInterval);
		_flashInterval = setInterval(this, "flash", randomRange(MIN_TIME, MAX_TIME)*1000);
		
		// get random flash clip
		var num:Number = randomRange(0, 3);
		var mc:MovieClip = _scope["flash"+num];
		
		// show flash
		mc._alpha = 90;
				
		TweenFilterLite.from(mc, SPEED/3, { _xscale:100, _yscale:100, _rotation:mc._rotation+10, delay:SPEED/3, ease:Expo.easeOut, overwrite:false })
	}
		
	private function randomRange(min:Number, max:Number):Number { return Math.floor(Math.random() * (max - min)) + min; };
}