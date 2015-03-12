/**
*      	OfferController Class
*      	Created on 2008-10-22
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-22
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Controller for offers
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Cubic;
import tweening.Expo;

class controllers.OfferController extends MovieClip {
	
	private var _scope:MovieClip;
	
	private static var SPEED:Number = .5;
	private static var MOVE_EASE:Function = Expo.easeOut;
	private static var FADE_EASE:Function = Cubic.easeOut;
	private static var NUM_OF_OFFERS:Number = 4;
	
	public function OfferController(scope:MovieClip) {
		_scope = scope;
		
		EventManager.addEventListener(Events.OFFER_ROLLOVER, this, "rollover");
		EventManager.addEventListener(Events.OFFER_ROLLOUT, this, "rollout");
		
		initOffers();
	}
	
	private function initOffers():Void {
		var mc:MovieClip;
		for(var i:Number = 0; i < NUM_OF_OFFERS; i++) {
			mc = _scope["offer"+i];
			mc.id = i;
			mc.grad._alpha = 0;
		}
	}
	
	private function rollover(o:Object):Void {
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["offer"+id].grad, SPEED, { _alpha:100, ease:FADE_EASE });
		TweenFilterLite.to(_scope["details"+id].panel, SPEED, { _y:0, ease:MOVE_EASE });
	}
	
	private function rollout(o:Object):Void {
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["offer"+id].grad, SPEED, { _alpha:0, ease:FADE_EASE });
		TweenFilterLite.to(_scope["details"+id].panel, SPEED, { _y:-5-_scope["details"+id].panel._height, ease:MOVE_EASE });
	}
}