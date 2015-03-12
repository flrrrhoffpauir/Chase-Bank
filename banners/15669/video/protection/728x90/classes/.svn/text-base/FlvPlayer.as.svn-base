//
//  FlvPlayer.as
//
//  Created by Junie Threatt on 2008-04-07.
//  Copyright (c) 2008 T3. All rights reserved.
//

import mx.utils.Delegate;
import TweenLite;

class FlvPlayer {
	
	// private vars
	private var _play_mc:MovieClip;
	private var _preview_mc:MovieClip;
	private var _check_stream_int:Number;
	private var _stream_progress:Number;
	
	private var _hasStarted:Boolean = false;
	
	// public vars
	public var _video_vo:Object;
	
	public function FlvPlayer(pl_mc, pr_mc, video) {
		
		_play_mc	= pl_mc; 	// play button
		_preview_mc	= pr_mc; 	// preview image
		_video_vo	= video;	// video component
		
		setPlayButtonHandlers();
		
		clearInterval(_check_stream_int);
		_check_stream_int = setInterval(this, "checkStream", 100);
	};
	
	private function setPlayButtonHandlers():Void {
		trace("die");
		// handlers
		_play_mc.onRelease = Delegate.create(this, togglePlay);
		
		_play_mc.onRollOver = function():Void {
			TweenLite.to(this, .5, { _alpha:100 });
		};
		
		_play_mc.onRollOut = function():Void {
			TweenLite.to(this, .5, { _alpha:0 });
		};	
		
	};
	
	private function togglePlay():Void {
		if(_hasStarted == false) {
			_hasStarted = true;
			_video_vo.play();
		} else {
			_video_vo.pause();
		};
		updatePlayButton();
	};
	
	private function updatePlayButton():Void {
		
		// on release, fade out mc
		_play_mc.enabled = false;
		TweenLite.to(_play_mc, .6, { _alpha:0, onComplete:Delegate.create(this, switchIcons) });
	};
	
	private function switchIcons():Void {
		
		if(_play_mc._currentframe == 1) {
			_play_mc.gotoAndStop("play");			
		} else {
			_play_mc.gotoAndStop("pause");
		};
		
		_play_mc.enabled = true;
	};
	
	private function checkStream():Void {
		_stream_progress = _video_vo.getStreamProgress();
		trace("p: " + _stream_progress);
		if(_stream_progress / 10 > 0) {
			clearInterval(_check_stream_int);
			TweenLite.to(_preview_mc, .5, { _alpha:0 });
		};
	};
};
	
	

