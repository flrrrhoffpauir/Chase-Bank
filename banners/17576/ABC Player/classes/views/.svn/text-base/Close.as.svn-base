/**
*      	Close Class
*      	Created on 2008-10-20
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-20
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Mouse listener for close button
*
*/

import events.Events;
import events.EventManager;
import mx.utils.Delegate;

class views.Close extends MovieClip {
	
	private var _scope:MovieClip;
	private var _closeListener:Object;
	
	
	public function Close() {
		
		_scope = this;
		
		initCloseListener();
		
		EventManager.addEventListener(Events.CLOSE_RELEASED, this, "disableClose");
		EventManager.addEventListener(Events.OPEN_RELEASED, this, "enableClose");
		
		_scope.onRollOver = function():Void {};
	}
	
	
	private function initCloseListener():Void {
		_closeListener = {};
		_closeListener.onMouseUp = Delegate.create(this, checkCloseClicked);
		enableClose();
	}


	private function checkCloseClicked():Void {
		if(_scope.hitTest(_root._xmouse, _root._ymouse, true)) {
			EventManager.dispatchEvent(Events.CLOSE_RELEASED, { });
		}
	}
	
	private function disableClose():Void {
		Mouse.removeListener(_closeListener);
	}
	
	private function enableClose():Void {
		Mouse.addListener(_closeListener);
	}
}