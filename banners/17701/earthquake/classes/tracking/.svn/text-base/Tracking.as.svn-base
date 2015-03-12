/**
*      	Tracking Class
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
*      	Passes tracking string to external javascript
*
*/

import flash.external.*;

class tracking.Tracking {
	
	private static var FUNCTION:String = "googleTrack";
					
	public function Tracking() { trace("no need to instatiate"); };
	
	public static function googleTrack(s:String):Void { trace("s: " + s); ExternalInterface.call(FUNCTION, s); };
	
}