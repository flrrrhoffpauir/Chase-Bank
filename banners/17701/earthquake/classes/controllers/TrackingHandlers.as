/**
*      	TrackingHandlers Class
*      	Created on 2008-10-28
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-28
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Just a bunch of handlers. I've never done this before. Kind of weird.
*
*/

import tracking.Tracking;
import mx.utils.Delegate;

class controllers.TrackingHandlers extends MovieClip {
	
	private var _scope:MovieClip;
		
	public function TrackingHandlers(scope:MovieClip) { 
		_scope = scope;
		setHandlers();
	}
	
	private function setHandlers():Void {
		_scope["hs0"].onRelease = function():Void {
			_root.getURL(_root.applyNowLink, "_blank");
			Tracking.googleTrack("/body/apply");
		}
		_scope["hs1"].onRelease = function():Void {
			_root.getURL(_root.applyNowLink, "_blank");
			Tracking.googleTrack("/body/apply");
		}
	}
}