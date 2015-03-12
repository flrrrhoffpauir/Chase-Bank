/**
*      	Offer Class
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
*      	Handlers for offers
*
*/

import events.Events;
import events.EventManager;
import mx.utils.Delegate;

class views.Offer extends MovieClip {
	
	private var _id:Number;
	private var _scope:MovieClip;
	
	public function Offer() {
		_scope = this;
		_scope.onRollOver = Delegate.create(this, rollover);
		_scope.onRollOut = Delegate.create(this, rollout);
		_scope.onReleaseOutside = Delegate.create(this, rollout);
	}
	
	private function rollover():Void { EventManager.dispatchEvent(Events.OFFER_ROLLOVER, { id:_id }); };
	private function rollout():Void { EventManager.dispatchEvent(Events.OFFER_ROLLOUT, { id:_id }); };
	
	public function get id():Number { return _id; };
	public function set id(id:Number):Void { _id = id; };
	
}