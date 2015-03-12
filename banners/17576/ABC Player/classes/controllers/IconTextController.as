/**
*      	IconTextController Class
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
*      	Controller for icons on the slider bar
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;
import views.IconText;

class controllers.IconTextController extends MovieClip {
	
	private var _scope:MovieClip;
	
	// icon text
	private static var NUM_OF_TEXT:Number = 1;
	private static var INIT_ALPHA:Number = 0;
	
	// tweening
	private static var SPEED:Number = .4;
	private static var EASE:Function = Expo.easeOut;
	
	public function IconTextController(scope:MovieClip) {
		
		_scope = scope;
		
		initIconText();
	}
	
	private function initIconText():Void {
		// give ids, set alpha to 0
		var mc:MovieClip;
		for(var i:Number = 0; i < NUM_OF_TEXT; i++) {
			mc = _scope["iconText"+i];
			mc.id = i;
			mc._alpha = 0;
		}
		
		// set event listeners
		EventManager.addEventListener(Events.ICON_ROLLOVER, this, "showText");
		EventManager.addEventListener(Events.ICON_TEXT_RELEASED, this, "released");
	}
	
	private function showText(o:Object):Void {
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["iconText"+id], SPEED, { _alpha:100, ease:EASE });
	}
	
	private function released(o:Object):Void { closeText(o); };
	
	private function closeText(o:Object):Void {		
		var id:Number = o.data.id;
		TweenFilterLite.to(_scope["iconText"+id], SPEED, { _alpha:0, ease:EASE });
	}
}