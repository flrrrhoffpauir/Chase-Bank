/**
*      	IconController Class
*      	Created on 2008-10-01
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-01
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Controller for icons on the slider bar
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;
import tweening.OverwriteManager;
import views.Icon;
import views.Slider;
import tracking.Tracking;

class controllers.IconController extends MovieClip {
	
	private var _scope:MovieClip;
	private var _view:Icon;
	private var _slider:Slider;
	private var _isOpen:Boolean;
	// private var _pulsateInterval:Number;
	
	// private static var PULSE_TIME:Number = 10;
	
	// icons
	private static var NUM_OF_ICONS:Number = 1;
	private static var INIT_ALPHA:Number = 100;
	
	// tweening
	private static var SPEED:Number = .4;
	private static var EASE:Function = Expo.easeOut;

	public function IconController(scope:MovieClip) {
		
		_scope = scope;
		
		// only overwrite same properties
		// so I can tween _x and _alpha with different timing
		OverwriteManager.init(OverwriteManager.AUTO);
		
		initIcons();
	}
	
	private function initIcons():Void {

		// give each icon an ID
		var mc:MovieClip;
		for(var i:Number = 0; i < NUM_OF_ICONS; i++) {
			mc = _scope["icon"+i];
			mc.id = i;
			mc.img._alpha = INIT_ALPHA;
		}

		// set event listeners
		EventManager.addEventListener(Events.ICON_ROLLOVER, this, "rollover");
		EventManager.addEventListener(Events.ICON_ROLLOUT, this, "rollout");
		EventManager.addEventListener(Events.ICON_RELEASED, this, "released");
		EventManager.addEventListener(Events.ICON_TEXT_RELEASED, this, "showSlider");
		EventManager.addEventListener(Events.OPEN_RELEASED, this, "setToOpen");
		EventManager.addEventListener(Events.CLOSE_RELEASED, this, "setToClosed");
	}
	
	
	private function rollover(o:Object):Void {
		var id:Number = o.data.id;
				
		// highlight icon
		hlIcon(id);
				
		// tween slider and instructions
		hideSlider();
		
		// show icon text
		showIconText(id);
		
		// hide divider
		hideDivider(id);
		
		EventManager.dispatchEvent(Events.STOP_POPUP, { });
		
		Tracking.trackView("iconRollOver");
	}
	
	private function rollout(o:Object):Void {
		var id:Number = o.data.id;
		
		// unhighlight icon
		uhlIcon(id);
		
		// show slider
		showSlider();
		
		// hide icon text
		hideIconText(id);
		
		// show divider
		showDivider(id);		
	}
	
	private function released(o:Object):Void {
		Tracking.trackView("rewardsCta");
		Tracking.exitCanvas("rewardsCta");
	}
	
	private function glowIcon(o:Object):Void {
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["icon"+id].img, SPEED, { _alpha:100, glowFilter:{ alpha:.3, blurX:6, blurY:6, color:0x0066CC }, ease:EASE });
	}
	
	private function uglowIcon(o:Object):Void {
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["icon"+id].img, SPEED, { _alpha:INIT_ALPHA, glowFilter:{ alpha:0 }, ease:EASE });
	}
	
	private function hlIcon(id:Number):Void {
		// highlight icon
		TweenFilterLite.to(_scope["icon"+id].img, SPEED, { _alpha:100, glowFilter:{ alpha:.3, blurX:6, blurY:6, color:0x0066CC }, tint:0x0066CC, ease:EASE });
	}
	
	private function uhlIcon(id:Number):Void {
		// unhighlight icon
		TweenFilterLite.to(_scope["icon"+id].img, SPEED, { _alpha:INIT_ALPHA, glowFilter:{ alpha:0 }, removeTint:true, ease:EASE });
	}
	
	private function showSlider(o:Object):Void {		
		// tween slider and instructions
		if(_isOpen != false) {
			
			// reset handlers
			_scope["sliderContainer"].knob.enabled = true;
			_scope["sliderContainer"].setHandlers();
			
			TweenFilterLite.to(_scope["sliderContainer"], SPEED, { _alpha:100, ease:EASE });
			TweenFilterLite.to(_scope["instructions"], SPEED, { _alpha:100, ease:EASE });
		}
	}
	
	private function hideSlider():Void {
		// tween slider and instructions
		
		// delete handlers so this clip can live above the icon
		delete _scope["sliderContainer"].knob.onPress;
		delete _scope["sliderContainer"].knob.onRelease;
		delete _scope["sliderContainer"].knob.onReleaseOutside;
		_scope["sliderContainer"].knob.enabled = false;

		TweenFilterLite.to(_scope["sliderContainer"], SPEED, { _alpha:0, ease:EASE });
		TweenFilterLite.to(_scope["instructions"], SPEED, { _alpha:0, ease:EASE });
	}
	
	private function showIconText(id:Number):Void {
		TweenFilterLite.to(_scope["icon"+id].rect, SPEED, { _width:405, ease:EASE });
		TweenFilterLite.to(_scope["icon"+id].rectMask, SPEED, { _width:405, ease:EASE });
	}
	
	private function hideIconText(id:Number):Void {
		TweenFilterLite.to(_scope["icon"+id].rect, SPEED/2, { _width:92, ease:EASE });
		TweenFilterLite.to(_scope["icon"+id].rectMask, SPEED/2, { _width:92, ease:EASE });
	}
	
	private function hideDivider(id:Number):Void {
		TweenFilterLite.to(_scope["icon"+id].divider, SPEED, { _x:410, ease:EASE });
		TweenFilterLite.to(_scope["icon"+id].divider, SPEED, { _alpha:0, delay:.1, ease:EASE });
	}
	
	private function showDivider(id:Number):Void {
		_scope["icon"+id].divider._x = 91;
		TweenFilterLite.to(_scope["icon"+id].divider, SPEED, { _x:91, _alpha:100, ease:EASE });
	}
	
	private function setToOpen():Void {
		_isOpen = true;
	}
	
	private function setToClosed():Void {
		_isOpen = false;
	}
}