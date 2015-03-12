/**
*      ThumbScrollerButton Class
*      Created on 2008-09-12
*
*      @langversion ActionScript 2.0
*      @playerversion 8.0
*      @since 2008-09-12
*
*      all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      Re-use of this code without express written permission is prohibited.
*
*      The scrollers left and right buttons
*
*/

import events.Events;
import events.EventManager;
import mx.utils.Delegate;

class views.ThumbScrollerButton extends MovieClip {
	
	private var _id:Number;
	
	public function ThumbScrollerButton() {
		this.onRelease = Delegate.create(this, release);
	}
	
	private function release():Void { EventManager.dispatchEvent(Events.SCROLLER_BUTTON_CLICK, { id:_id }); };
	
	public function get id():Number { return _id; };
	public function set id(id:Number):Void { _id = id; };
}