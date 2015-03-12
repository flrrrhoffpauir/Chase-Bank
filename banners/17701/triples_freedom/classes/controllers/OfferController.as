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
	private static var MASK_WIDTH:Number = 385;
	private static var NUM_OF_OFFERS:Number = 3;
	
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
			_scope["details"+i].msk._width = (i == 0) ? MASK_WIDTH : 1;
		}
	}
	
	private function rollover(o:Object):Void {
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["details0"].msk, SPEED/2, { _width:1, ease:MOVE_EASE });
		TweenFilterLite.to(_scope["details"+id].msk, SPEED, { _width:MASK_WIDTH, ease:MOVE_EASE });
	}
	
	private function rollout(o:Object):Void {
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["details"+id].msk, SPEED/2, { _width:1, ease:MOVE_EASE });
		TweenFilterLite.to(_scope["details0"].msk, SPEED, { _width:MASK_WIDTH, ease:MOVE_EASE });
	}
}