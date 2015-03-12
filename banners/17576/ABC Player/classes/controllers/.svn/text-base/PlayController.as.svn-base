/**
*      	PlayController Class
*      	Created on 2008-08-28
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-17
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Video player play/pause button controller
*
*/

import events.EventManager;
import tweening.TweenFilterLite;
import tweening.Expo;

class controllers.PlayController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _isPlaying:Boolean = true;
	private var _endFrame:Boolean = false;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	// constructor
	public function PlayController() {
	
		_scope = this;
		
		EventManager.addEventListener("onChangeIcon", this, "togglePlay");
		EventManager.addEventListener("onPlayStop", this, "setToReset");
		
		setHandlers();
	};
	
	private function setHandlers():Void {
		_scope.onRollOver = function():Void { TweenFilterLite.to(_scope.icons, SPEED, { _alpha:100, ease:EASE }); };
		_scope.onRollOut = function():Void { TweenFilterLite.to(_scope.icons, SPEED, { _alpha:0, ease:EASE }); };
		_scope.onRelease = togglePlay;
	}
	
	private function togglePlay(o:Object):Void {
		
		if(o.data.id == 0) {
			// if id==0, pause it
			_scope.icons.gotoAndStop("showPlay");
			_isPlaying = false
			EventManager.dispatchEvent("onToggleVideo", { id:0 });
			return;
		}
		
		// otherwise toggle
		if(_isPlaying == true) {
			_scope.icons.gotoAndStop("showPlay");
			_isPlaying = false
		} else {
			_scope.icons.gotoAndStop("showPause");
			_isPlaying = true
			_endFrame = false;
		}
		
		if(_endFrame == false) { fadeEndFrame(0); };
		
		EventManager.dispatchEvent("onToggleVideo", { });
	}
	
	private function setToReset():Void {
		_isPlaying = false;
		_scope.icons.gotoAndStop("showPlay");
		fadeEndFrame(100);
		_endFrame = true;
		TweenFilterLite.to(_scope.icons, SPEED, { _alpha:100, ease:EASE });
	}
	
	private function fadeEndFrame(num:Number):Void { TweenFilterLite.to(_scope.endFrame, SPEED, { _alpha:num, ease:EASE }); };	
}