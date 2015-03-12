//
//  FlvPlayer.as
//
//  Created by Junie Threatt on 2008-04-22.
//  Copyright (c) 2008 T3. All rights reserved.
//

import mx.utils.Delegate;

import TweenLite;

class FlvPlayer extends MovieClip {
	
	// private vars
	private var _play_mc:MovieClip;
	private var _pause_mc:MovieClip;
	private var _stop_mc:MovieClip;
	private var _mute_mc:MovieClip;
	private var _preview_mc:MovieClip;
	
	private var _isPlaying:Boolean 	= false;
	private var _hasStarted:Boolean = false;
	
	// public vars
	public var _video_vo:Object;
	
	public function FlvPlayer(pl_mc, pr_mc, video) {
		_play_mc	= pl_mc; 	// play button
		_preview_mc	= pr_mc; 	// preview image
		_video_vo	= video;	// video component
		
		setButtonHandlers();
				
		// check to see if the video has completed
		_video_vo.addEventListener("onVideoComplete", Delegate.create(this, videoCompleteHandler));
	};
	
	private function setButtonHandlers():Void {
		
		// handlers
		_play_mc.onRelease 	= Delegate.create(this, playVideo);
		_play_mc.onRollOver 	= Delegate.create(this, fadeInPlayButton);
		_play_mc.onRollOut	= Delegate.create(this, fadeOutPlayButton);		
	};
	
	private function playVideo():Void {
		
		// when play button is clicked
		// seek to 0 and play
		// fade out button and preview
		// enable other controls
		
		if(_hasStarted != true) {	
		
			_video_vo.seek(0);
			_video_vo.play();
		
			_isPlaying = true;
			_hasStarted = true;
			
			TweenLite.to(_preview_mc, 	.5, { _alpha:0 });
			_play_mc.gotoAndStop("play");
		} else {
			pauseVideo();
		};
	};
	
	private function pauseVideo():Void {
		
		// switch the pause icon to the appropriate state
		// toggle pause
		
		if(_isPlaying == true) {
			_play_mc.gotoAndStop("pause");
			_isPlaying = false;
		} else {
			_play_mc.gotoAndStop("play");
			_isPlaying = true;
		};
		
		_video_vo.pause();
	};
	
	private function fadeOutPlayButton():Void {
		
		// play button alpha = 0
		
		TweenLite.to(_play_mc, 		.5, { _alpha:0 });
		// TweenLite.to(_preview_mc, 	.5, { _alpha:0 });
	};
	
	private function fadeInPlayButton():Void {
		
		// play button alpha = 100
		
		TweenLite.to(_play_mc, 		.5, { _alpha:100 });
		// TweenLite.to(_preview_mc, 	.5, { _alpha:100 });
	};
	
	private function videoCompleteHandler(event):Void {
		
		// if the video is complete
		// set back to origin
		
		_play_mc.gotoAndStop("pause");
		_isPlaying = false;
		_hasStarted = false;
		fadeInPlayButton();
		TweenLite.to(_preview_mc, 	.5, { _alpha:100 });
	};
}