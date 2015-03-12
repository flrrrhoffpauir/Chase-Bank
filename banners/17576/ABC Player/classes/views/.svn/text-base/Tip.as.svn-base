/**
*      	Tip Class
*      	Created on 2008-10-17
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-17
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Updates tip with sliders point value
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;

class views.Tip extends MovieClip {
	
	private var _scope:MovieClip;
	private var _format:TextFormat;
	
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	public function Tip() {
		
		_scope = this;		
		_scope._alpha = 0;
				
		EventManager.addEventListener(Events.KNOB_PRESS, this, "showTip");
		EventManager.addEventListener(Events.KNOB_RELEASE, this, "hideTip");
		EventManager.addEventListener(Events.KNOB_DRAG, this, "updateTip");
	}
	
	private function showTip():Void {
		TweenFilterLite.to(_scope, SPEED, { _alpha:100, ease:EASE });
	}
	
	private function hideTip():Void {
		TweenFilterLite.to(_scope, SPEED, { _alpha:0, ease:EASE });
	}
	
	private function updateTip(o:Object):Void {
		_scope._x = _scope._parent.knob._x + 2;
		_scope.t._x = getPlacement(o.data.num);
		_scope.t.text = getPoints(o.data.num);
	}
	
	private function getPoints(num:Number):String {
		var s:String = num.toString();
		s = (num < 100) ? s.substring(0,2) : (num < 1000) ? s.substring(0,3) : (num < 10000) ? s.substring(0,1) + "," + s.substr(1,3) : s.substring(0,2) + "," + s.substr(1,3);
		s += " POINTS";
		
		return s;
	}
	
	private function getPlacement(num:Number):Number {		
		// just going to hardcode some numbers
		var n:Number = (num < 10) ? -27 : (num < 100) ? -28 : (num < 1000) ? -34 : (num < 10000) ? -39 : -41;
		return n;
	}
}