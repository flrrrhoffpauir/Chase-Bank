/**
*      	Icon Class
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
*      	Handlers for icons
*
*/

import events.Events;
import events.EventManager;
import mx.utils.Delegate;

class views.Icon extends MovieClip {
	
	private var _id:Number;
	
	public function Icon() { setHandlers(); };
	
	private function setHandlers():Void {
		this.onRollOver = Delegate.create(this, rollover);
		this.onRollOut = Delegate.create(this, rollout);
		this.onRelease = Delegate.create(this, released);
	}
	
	private function rollover():Void { EventManager.dispatchEvent(Events.ICON_ROLLOVER, { id:_id }); };
	private function rollout():Void { EventManager.dispatchEvent(Events.ICON_ROLLOUT, { id:_id }); };
	private function released():Void { EventManager.dispatchEvent(Events.ICON_RELEASED, { id:_id }); };
	
	public function get id():Number { return _id; };
	public function set id(id:Number):Void { _id = id; };
}