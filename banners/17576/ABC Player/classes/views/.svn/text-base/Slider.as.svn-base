/**
*      	Slider Class
*      	Created on 2008-10-03
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-03
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Handles the slider MC
*
*/

import mx.utils.Delegate;
import views.FoodItems;
import events.Events;
import events.EventManager;
import tracking.Tracking;

class views.Slider extends MovieClip {
	
	private var _scope:MovieClip;
	private var _knob:MovieClip;
	private var _hl:MovieClip;
	private var _foodItems:FoodItems;
	
	private static var MIN_NUM:Number = 13;
	private static var MAX_NUM:Number = 283;
	
	
	public function Slider() {
		
		_scope = this;
		_hl = _scope["hl"];
		
		_knob = _scope["knob"];
		_knob.ox = _knob._x;
		
		// _foodItems = new FoodItems(3, this._parent._parent);
		
		updateHl();
		setHandlers();
	}
	
	
	public function setHandlers():Void {
		_knob.onPress = Delegate.create(this, startDragging);
		_knob.onRelease = Delegate.create(this, stopDragging);
		_knob.onReleaseOutside = Delegate.create(this, stopDragging);
	}
	
	
	private function startDragging():Void {
		Tracking.trackView("sliderPress");
		EventManager.dispatchEvent(Events.KNOB_PRESS, { });
		_knob.startDrag(false, _knob.ox, _knob._y, 283, _knob._y);
		_hl.onEnterFrame = Delegate.create(this, updateHl);
	}
	
	
	private function stopDragging():Void {
		EventManager.dispatchEvent(Events.KNOB_RELEASE, { });
		_knob.stopDrag();
		delete _hl.onEnterFrame;
		updateHl();		
	}
	
	
	private function updateHl():Void {
		_hl._width = _knob._x - _knob.ox;
				
		var range:Number = MAX_NUM - MIN_NUM;
		var num:Number = Math.floor(_knob._x / range * 100 - 4)*100;
		num = (num < 200) ? 200 : num;
		
		EventManager.dispatchEvent(Events.KNOB_DRAG, { num:num });
		// _foodItems.updateFood(num/100);
	}
}