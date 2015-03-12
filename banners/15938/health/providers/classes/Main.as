/**
*      	Main Class
*      	Created on 2008-11-06
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-11-06
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Main class for animation
*
*/

import tweening.TweenFilterLite;
import tweening.Expo;
import tweening.OverwriteManager;
import Accordion;

class Main {
	
	private var _scope:MovieClip;
	private var _pauseInterval:Number;
	
	private static var SPEED:Number = .5;
	private static var EXPO:Function = Expo.easeOut;
	
	public function Main(scope:MovieClip) {
		_scope = scope;
		OverwriteManager.init(OverwriteManager.NONE);
	}
	
	public function alphaTween(mc:MovieClip, num:Number, SPEED:Number):Void { TweenFilterLite.to(mc, SPEED, { _alpha:num, ease:EXPO }); };
	public function scaleTween(mc:MovieClip, num:Number, SPEED:Number):Void { TweenFilterLite.to(mc, SPEED, { _xscale:num, _yscale:num, ease:EXPO }); };
	public function yTween(mc:MovieClip, num:Number, SPEED:Number):Void { TweenFilterLite.to(mc, SPEED, { _y:num, ease:EXPO }); };
	
	public function pauseTl(t:Number):Void {
		stop();
		clearInterval(_pauseInterval);
		_pauseInterval = setInterval(this, "unpauseTl", t*1000);
	}

	public function unpauseTl():Void {
		play();
		clearInterval(_pauseInterval);
	}
	
	public function initAccordion():Void {
		var mc:MovieClip;
		var dlay:Number = 0;
		for(var i:Number = 4; i > -1; i--) {
			mc = _scope["acc"+i];
			TweenFilterLite.from(mc, SPEED/2, { _y:mc._x-80, _alpha:0, _xscale:25, _yscale:25, delay:dlay, ease:EXPO });
			dlay += .1;
		}
	}
}