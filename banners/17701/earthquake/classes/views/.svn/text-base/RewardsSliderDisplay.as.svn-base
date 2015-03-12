
// RewardsSliderDisplay.as
//
// Created by Junie Threatt
// on 2008-06-04
//

import events.EventManager;
import events.Events;
import tweening.TweenLite;
import tweening.Expo;
import mx.utils.Delegate;

class views.RewardsSliderDisplay extends MovieClip {
	
	// private properties
	private var _id:Number;
	
	// static properties
	private static var FADE_SPEED:Number = .5;
	
	public function RewardsSliderDisplay() {
		
		EventManager.addEventListener(Events.REWARDS_SLIDER_STOPPED, this, "changeView");
		
	};
	
	private function changeView(o:Object):Void {
		trace(o.data.id + ": " + _id);	
		if(_id == o.data.id) {
			TweenLite.to(this, FADE_SPEED, { _alpha:100, ease:Expo.easeOut });
		} else {
			TweenLite.to(this, FADE_SPEED, { _alpha:0, ease:Expo.easeOut });
		};
	};
	
	public function get id():Number { return _id; };	
	public function set id(id:Number):Void { _id = id; };
}