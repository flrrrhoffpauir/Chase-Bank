/**
*      	Popup Class
*      	Created on 2008-10-20
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-20
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Shows popup on a timer
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;
import tweening.Back;
import tweening.Elastic;

class views.Popup extends MovieClip {
	
	private var _scope:MovieClip;
	private var _popInterval:Number;
	
	private static var TIME:Number = 10;
	private static var SPEED:Number = .5;
	private static var EASE:Function = Back.easeOut;
	
	public function Popup() {
		
		_scope = this;
		
		EventManager.addEventListener(Events.STOP_POPUP, this, "stopPopup");
		EventManager.addEventListener(Events.START_POPUP, this, "startPopupTimer");
				
		initPopup();
	}
	
	private function initPopup():Void { TweenFilterLite.delayedCall(SPEED*2.5, playPopup, null, _scope); };
	
	private function playPopup():Void {
		delete _scope.num;
		clearInterval(_popInterval);
		_scope._alpha = 100;
		_scope.gotoAndPlay("start");
	}
	
	private function stopPopup():Void {
		_scope.stop();
		clearInterval(_popInterval);
		TweenFilterLite.to(_scope, SPEED, { _alpha:0, ease:EASE });
	}
	
	private function startPopupTimer():Void {
		clearInterval(_popInterval);
		_popInterval = setInterval(this, "playPopup", TIME*1000);
	}
}