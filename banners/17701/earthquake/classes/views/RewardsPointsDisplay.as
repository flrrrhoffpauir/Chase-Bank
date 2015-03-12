/**
*      	RewardsPointsDisplay Class
*      	Created on 2008-06-04
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-06-04
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	View for points
*
*/

import events.EventManager;
import events.Events;
import tweening.TweenLite;
import tweening.Expo;
import mx.utils.Delegate;

class views.RewardsPointsDisplay extends MovieClip {
	
	// private properties
	private var _id:Number;
	
	// static properties
	private static var FADE_SPEED:Number = .5;
	
	public function RewardsPointsDisplay() {
		
		EventManager.addEventListener(Events.REWARDS_SLIDER_STOPPED, this, "changeView");
		
	};
	
	private function changeView(o:Object):Void {
		
		if(_id == o.data.id) {
			TweenLite.to(this, FADE_SPEED, { _alpha:100, ease:Expo.easeOut });
		} else {
			TweenLite.to(this, FADE_SPEED, { _alpha:0, ease:Expo.easeOut });
		};
	};
	
	public function get id():Number {
		return _id;
	};
	
	public function set id(id:Number):Void {
		_id = id;
	};
}