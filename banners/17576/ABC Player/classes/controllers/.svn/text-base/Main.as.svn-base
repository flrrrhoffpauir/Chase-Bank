/**
*      	Main Class
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
*      	Used for animating the timeline
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;
import mx.utils.Delegate;
import controllers.IconController;
import controllers.IconTextController;
import tracking.Tracking;
import views.FoodItems;

class controllers.Main extends MovieClip {
	
	private var _scope:MovieClip;
	private var _iconController:IconController;
	private var _iconTextController:IconTextController;
	private var _foodItems:FoodItems;
	
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	public function Main(scope:MovieClip) {
		
		_scope = scope;
	}
	
	public function xTween(mc:MovieClip):Void { TweenFilterLite.from(mc, SPEED, { _x:Stage.width+10, ease:EASE }); };
	public function yTween(mc:MovieClip):Void { TweenFilterLite.from(mc, SPEED, { _y:-10 - mc._height, ease:EASE }); };
	public function pTween(mc:MovieClip, t:Number):Void { mc.stop(); TweenFilterLite.delayedCall(t, Delegate.create(mc, play)); };
	
	public function initCta():Void {		
		_scope["subhead"].cta.onRollOver = Delegate.create(this, ctaRollOver);
		_scope["subhead"].card.onRollOver = Delegate.create(this, ctaRollOver);
		
		_scope["subhead"].cta.onRelease = Delegate.create(this, ctaRelease);
		_scope["subhead"].card.onRelease = Delegate.create(this, cardRelease);
		
		_scope["subhead"].cta.onRollOver();
		_scope["subhead"].card.onRollOver();
	}
	
	public function showSliderBar(t:Boolean):Void {
		
		_iconController = new IconController(_scope["sliderBar"]);
		_iconTextController = new IconTextController(_scope["sliderBar"]);
		_foodItems = new FoodItems(3, _scope["items"]);
		
		if(!t) {
			TweenFilterLite.from(_scope["sliderBar"], SPEED, { _x:-10 - _scope["sliderBar"]._width, ease:EASE });
		}
	}
	
	private function ctaRollOver():Void {
		_scope["subhead"].cta.gotoAndPlay("shimmer");
		_scope["subhead"].card.gotoAndPlay("shimmer");
	}
	
	private function ctaRelease():Void {
		Tracking.exitCanvas("learnMoreCta");
		Tracking.trackView("learnMoreCta");
	}
	private function cardRelease():Void {
		Tracking.exitCanvas("learnMoreCard");
		Tracking.trackView("learnMoreCard");
	}
}