/**
*      	IconText Class
*      	Created on 2008-10-15
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-15
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Handlers for icon text
*
*/

import events.Events;
import events.EventManager;
import mx.utils.Delegate;

class views.IconText extends MovieClip {
	
	private var _id:Number;
	
	public function IconText() { setHandlers(); };
	
	private function setHandlers():Void { this.onRelease = Delegate.create(this, released); };
	
	private function released():Void { EventManager.dispatchEvent(Events.ICON_TEXT_RELEASED, { id:_id }); };
	
	public function get id():Number { return _id; };
	public function set id(id:Number):Void { _id = id; };
}