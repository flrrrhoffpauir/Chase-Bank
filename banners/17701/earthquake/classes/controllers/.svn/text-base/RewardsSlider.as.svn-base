
// RewardsSlider.as
//
// Created by Junie Threatt
// on 2008-06-04
//

import events.EventManager;
import events.Events;
import tweening.TweenLite;
import mx.utils.Delegate;
import tracking.Tracking;

class controllers.RewardsSlider extends MovieClip {
	
	// private properties
	private var _barPortion:Number;
	private var _totalViews:Number;
	private var _currentView:Number;
	private var _newView:Number;
	
	// tracking
	private var _sliderMoved:Boolean = false;
	
	// public properties
	public var knob:MovieClip;
	public var bar:MovieClip;
	public var lightBar:MovieClip;
	
	public function RewardsSlider() { init(); };
	
	private function init():Void {
		
		_totalViews = 4;
		_barPortion = bar._width / _totalViews;
		
		// timing hack -----------------------
		_currentView = 0;
		knob._x = bar._width - 5;
		_newView = 3;
		// changeView();
		updateLightBar();
		// -----------------------------------
		
		knob.onPress = Delegate.create(this, startDragKnob);
		knob.onRelease = knob.onReleaseOutside = Delegate.create(this, stopDragKnob);
		
	}
	
	private function startDragKnob():Void {
		
		// call tracking ONLY once
		if(!_sliderMoved) {
						
			_sliderMoved = true;
			Tracking.googleTrack("/body/use_slider");
		}
			
		knob.startDrag(false, 5, knob._y, bar._width-5, knob._y);
		knob.onEnterFrame = Delegate.create(this, changeView);		
	}
	
	private function changeView():Void {
		
		updateLightBar();
		
		// for four
		if(knob._x < _barPortion) {
			_newView = 0;
		} else if (knob._x > _barPortion && knob._x < _barPortion * 2) {
			_newView = 1;
		} else if (knob._x > _barPortion * 2 && knob._x < _barPortion * 3) {
			_newView = 2;
		} else if (knob._x > _barPortion * 3) {
			_newView = 3;
		}
		
		// for five
		/*
		if(knob._x < _barPortion) {
			_newView = 0;
		} else if (knob._x > _barPortion && knob._x < _barPortion * 2) {
			_newView = 1;
		} else if (knob._x > _barPortion * 2 && knob._x < _barPortion * 3) {
			_newView = 2;
		} else if (knob._x > _barPortion * 3 && knob._x < _barPortion * 4) {
			_newView = 3;
		} else if(knob._x > _barPortion * 4) {
			_newView = 4;
		}
		*/
		
		// just in case!
		updateLightBar();
		dispatchViewEvent();
	}
	
	private function stopDragKnob():Void {
		
		// stop dragging
		// decide where to snap the knob
		
		knob.stopDrag();
		delete knob.onEnterFrame;
		updateLightBar();
		
		// for four
		if(knob._x < _barPortion) {
			knob._x = bar._x + 5;
			_newView = 0;
		} else if (knob._x > _barPortion && knob._x < _barPortion * 2) {
			knob._x = _barPortion + 15;
			_newView = 1;
		} else if (knob._x > _barPortion * 2 && knob._x < _barPortion * 3) {
			knob._x = _barPortion * 3 - 15;
			_newView = 2;
		} else if (knob._x > _barPortion * 3) {
			knob._x = bar._width - 5;
		};
		
		// for five
		/*
		if(knob._x < _barPortion) {
			knob._x = bar._x + 5;
			_newView = 0;
		} else if (knob._x > _barPortion && knob._x < _barPortion * 2) {
			knob._x = _barPortion + 15;
			_newView = 1;
		} else if (knob._x > _barPortion * 2 && knob._x < _barPortion * 3) {
			knob._x = _barPortion * 3 - 15;
			_newView = 2;
		} else if (knob._x > _barPortion * 3 && knob._x < _barPortion * 4) {
			knob._x = _barPortion * 4 - 15;
			_newView = 3;
		} else if(knob._x > _barPortion * 4) {
			knob._x = bar._width - 5;
		}
		*/
		
		// just in case!
		updateLightBar();
		dispatchViewEvent();	
	}
	
	private function dispatchViewEvent():Void {
		if(_currentView != _newView) {
			_currentView = _newView;
			EventManager.dispatchEvent(Events.REWARDS_SLIDER_STOPPED, { id:_currentView });
		}
	}
	
	private function updateLightBar():Void { lightBar._width = knob._x; };
}