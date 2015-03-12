/**
*      	Open Class
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
*      	Handlers for open button
*
*/

import events.Events;
import events.EventManager;
import mx.utils.Delegate;

class views.Open extends MovieClip {
	
	private var _scope:MovieClip;

	
	public function Open() {		
		_scope 			= this;		
		_scope.enabled 		= false;
		_scope._alpha 		= 0;
		_scope.onRelease 	= Delegate.create(this, released);
	}
	
	private function released():Void { EventManager.dispatchEvent(Events.OPEN_RELEASED, { }); };
}