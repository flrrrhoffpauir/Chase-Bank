/**
*      	SliderBar Class
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
*      	Handles visual aspects of sliderbar
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;

class views.SliderBar extends MovieClip {
	
	private var _scope:MovieClip;
	
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	private static var OPEN_X:Number = -36;
	private static var CLOSE_X:Number = -390;
	
	public function SliderBar() {
		
		_scope = this;
		
		EventManager.addEventListener(Events.CLOSE_RELEASED, this, "closeSliderBar");
		EventManager.addEventListener(Events.OPEN_RELEASED, this, "openSliderBar");
	}
	
	private function closeSliderBar(o:Object):Void {
		disableCloseButton();
		enableOpenButton();
		hideSlider();
		TweenFilterLite.to(_scope, SPEED, { _x:CLOSE_X, ease:EASE });
	}
	
	private function openSliderBar(o:Object):Void {
		enableCloseButton();
		disableOpenButton();
		showSlider();
		TweenFilterLite.to(_scope, SPEED, { _x:OPEN_X, ease:EASE });
	}
	
	private function enableCloseButton():Void {
		_scope["close"].enabled = true;
		TweenFilterLite.to(_scope["close"], SPEED, { _alpha:100, ease:EASE });
	}
	
	private function disableCloseButton():Void {
		_scope["close"].enabled = false;
		TweenFilterLite.to(_scope["close"], SPEED, { _alpha:0, ease:EASE });
	}
	
	private function enableOpenButton():Void {
		_scope["open"].enabled = true;
		TweenFilterLite.to(_scope["open"], SPEED, { _alpha:100, ease:EASE });
	}
	
	private function disableOpenButton():Void {
		_scope["open"].enabled = false;
		TweenFilterLite.to(_scope["open"], SPEED, { _alpha:0, ease:EASE });
	}
	
	private function showSlider():Void {
		_scope["sliderContainer"].knob.enabled = true;
		TweenFilterLite.to(_scope["instructions"], SPEED, { _alpha:100, ease:EASE });
		TweenFilterLite.to(_scope["sliderContainer"], SPEED, { _alpha:100, ease:EASE });
	}
	
	private function hideSlider():Void {
		TweenFilterLite.to(_scope["instructions"], SPEED, { _alpha:0, ease:EASE });
		TweenFilterLite.to(_scope["sliderContainer"], SPEED, { _alpha:0, ease:EASE });
	}
}