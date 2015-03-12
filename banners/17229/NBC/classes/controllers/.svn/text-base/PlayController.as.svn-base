
// PlayController.as
// Created by Junie Threatt
// on 2008-08-28

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;

class classes.controllers.PlayController extends MovieClip {
	
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
	}
	
	private function fadeEndFrame(num:Number):Void { TweenFilterLite.to(_scope.endFrame, SPEED, { _alpha:num, ease:EASE }); };	
}