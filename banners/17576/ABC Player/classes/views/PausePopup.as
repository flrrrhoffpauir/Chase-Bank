/**
*      	PausePopup Class
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
*      	Shows popup for the pause ad
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;
import tweening.Back;
import tweening.Elastic;

class views.Popup extends MovieClip {
	
	private var _scope:MovieClip;
	
	private static var SPEED:Number = .5;
	private static var EASE:Function = Back.easeOut;
	
	public function Popup() {
		
		_scope = this;
		
		EventManager.addEventListener(Events.STOP_POPUP, this, "stopPopup");
				
		initPopup();
	}
	
	private function initPopup():Void { _scope._alpha = 100; };	
	private function stopPopup():Void { TweenFilterLite.to(_scope, SPEED, { _alpha:0, ease:EASE }); };
	
}