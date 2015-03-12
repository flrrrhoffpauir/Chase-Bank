/**
*      	ThumbTracking Class
*      	Created on 2008-09-23
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-09-23
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Tracks thumb clicks and sets cookies
*
*/

import events.Events;
import events.EventManager;
import flash.external.*;

class tracking.ThumbTracking {
	
	// music, belize, ski, napa, pike
	private var trackingArray:Array = [{c1:"home", c2:"change_reward", c3:"music"},
					{c1:"home", c2:"change_reward", c3:"belize"},
					{c1:"home", c2:"change_reward", c3:"ski"},
					{c1:"home", c2:"change_reward", c3:"napa"},
					{c1:"home", c2:"change_reward", c3:"pike"}];
	
	private static var TRACKING_FUNCTION_0:String = "track";
	private static var TRACKING_FUNCTION_1:String = "setCookie";
	
	public function ThumbTracking() {
		EventManager.addEventListener(Events.SCROLLER_THUMB_RELEASE, this, "trackThumb");
		EventManager.addEventListener(Events.SCROLLER_BUTTON_CLICK, this, "trackScroll");
		EventManager.addEventListener(Events.CTA_RELEASE, this, "trackCta");
		EventManager.addEventListener(Events.SET_COOKIE, this, "setFlashCookie");
	}
	
	private function trackThumb(o:Object):Void {
		var trackObj:Object = trackingArray[o.data.id];
		ExternalInterface.call(TRACKING_FUNCTION_0, trackObj.c1 + "/" + trackObj.c2, trackObj.c3);
		
		// trace("tracking click: " + trackObj.c1 + ", " + trackObj.c2 + ", " + trackObj.c3);
		
		setFlashCookie({data:{id:o.data.id}});
	}
	
	private function trackScroll():Void { ExternalInterface.call(TRACKING_FUNCTION_0, "home/change_reward", "scroll"); };
	
	private function setFlashCookie(o:Object):Void {
		ExternalInterface.call(TRACKING_FUNCTION_1, "banner", trackingArray[o.data.id].c3, 365);
		// trace("setting cookie: " + trackingArray[o.data.id].c3);
	}
	
	private function trackCta():Void { ExternalInterface.call(TRACKING_FUNCTION_0, "home/body", "learn_more"); };
	
}