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
	private var _black_mc:MovieClip;
	
	private var _isPlaying:Boolean 	= false;
	private var _isMuted:Boolean 	= false;
	private var _hasStarted:Boolean = false;
	
	// public vars
	public var _video_vo:Object;
	
	public function FlvPlayer(pl_mc, pa_mc, st_mc, mu_mc, pr_mc, video) {
		_play_mc	= pl_mc; 	// play button
		_pause_mc	= pa_mc;	// pause button
		_stop_mc	= st_mc;	// stop button
		_mute_mc	= mu_mc;	// mute button
		_preview_mc	= pr_mc; 	// preview image
		_video_vo	= video;	// video component
				
		setButtonHandlers();
				
		// check to see if the video has completed
		_video_vo.addEventListener("onVideoComplete", Delegate.create(this, videoCompleteHandler));
			};
	
	private function setButtonHandlers():Void {
		
		// handlers
		_play_mc.onRelease 	= Delegate.create(this, playVideo);
		_pause_mc.onRelease 	= Delegate.create(this, pauseVideo);
		_stop_mc.onRelease 	= Delegate.create(this, stopVideo);
		_mute_mc.onRelease 	= Delegate.create(this, muteVideo);
				
		// disable the controls until the play button is pressed
		
		disableControls();		
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
		
			enableControls();
			fadeOutPlayButton();
		};
	};
	
	private function enableControls():Void {
		
		// enable controls...
		
		_pause_mc.enabled = _stop_mc.enabled = _mute_mc.enabled = true;
	};
	
	private function disableControls():Void {
		
		// disable controls...
		
		_pause_mc.enabled = _stop_mc.enabled = _mute_mc.enabled = false;
	};
	
	private function pauseVideo():Void {
		
		// switch the pause icon to the appropriate state
		// toggle pause
		
		if(_isPlaying == true) {
			_pause_mc.gotoAndStop("play");
			_isPlaying = false;
			_stop_mc.enabled = false;
		} else {
			_pause_mc.gotoAndStop("pause");
			_isPlaying = true;
			_stop_mc.enabled = true;
		};
		
		_video_vo.pause();
	};
	
	private function stopVideo():Void {
		
		// stop the video, show the play button and preview
		
		// trace(_video_vo.DCNetStream);
		// _video_vo.seek(0);
		
		if(_hasStarted == true && _isPlaying == true) {
			// _video_vo.restart();
			// _video_vo.stop();
			// _video_vo.seek(0);
			_video_vo.pause();
			
		
			// _video_vo.stop();
			// _video_vo.restart();
		
			fadeInPlayButton();
			disableControls();
			_hasStarted = false;
			
		
			_pause_mc.gotoAndStop("pause");
		};
	};
	
	private function muteVideo():Void {
		
		// mute the video...
		
		if(_isMuted == false) {
			_isMuted = true;
			_mute_mc.gotoAndStop("mute");
		} else {
			_isMuted = false;
			_mute_mc.gotoAndStop("unmute");
		};
		
		_video_vo.mute();
	};
	
	private function fadeOutPlayButton():Void {
		
		// play button alpha = 0
		
		_play_mc.enabled = false;
		
		TweenLite.to(_play_mc, 		.5, { _alpha:0 });
		TweenLite.to(_preview_mc, 	.5, { _alpha:0 });
	};
	
	private function fadeInPlayButton():Void {
		
		// play button alpha = 100
		
		_play_mc.enabled = true;
		
		TweenLite.to(_play_mc, 		.5, { _alpha:100 });
		TweenLite.to(_preview_mc, 	.5, { _alpha:100 });
		trace("enabled: " + _play_mc.enabled);
	};
	
	private function videoCompleteHandler(event):Void {
		
		// if the video is complete
		// set back to origin
		
		_isPlaying = false;
		_hasStarted = false;
		disableControls();
		fadeInPlayButton();
	};
}