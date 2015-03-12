//
//  FlvPlayer.as
//
//  Created by Junie Threatt on 2008-02-08.
//  Copyright (c) 2008 T3. All rights reserved.
//

import mx.utils.Delegate;
import TweenLite;

class FlvPlayer {
	
	private var _player_mc:MovieClip;
	private var _status_mc:MovieClip;
	private var _play_mc:MovieClip;
	private var _preview_mc:MovieClip;
	private var _player_vo:Video;
	
	// this player doesn't have sound
	// leaving this in case we need a mute button
	// private var _flvSound:Sound;
	
	private var _connection_nc:NetConnection;
	private var _netstream_ns:NetStream;
	
	private var _flvToPlay:String;
	private var _goingBack:Boolean
	private var _flvDuration:Number;
	private var _percentLoaded:Number;
	private var _preloadInterval:Number;
	private var _controlsInterval:Number;
	private var _backToStartInterval:Number;
	
	public function FlvPlayer(v_mc:MovieClip, v_obj:Video, pl_mc, s_mc:MovieClip, pr_mc:MovieClip, flv:String) {
		_player_mc	= v_mc;		// container
		_player_vo	= v_obj;	// video player object
		_status_mc	= s_mc;		// used for testing/displaying errors
		_preview_mc	= pr_mc;	// mc to simulate video preview
		_play_mc	= pl_mc;	// play/pause mc
		_flvToPlay	= flv;		// flv url/file name
				
		initPlayer();
	}
	
	private function initPlayer():Void {
		// connect to self
		_connection_nc = new NetConnection();
		_connection_nc.connect(null);
		
		// attach netstream to video object
		_netstream_ns = new NetStream(_connection_nc);
		_player_vo.attachVideo(_netstream_ns);
		
		// put audio in a new clip
		// attach the netstream to it
		// set that object as a new sound
		// _player_mc.createEmptyMovieClip("flvSound", _player_mc.getNextHighestDepth());
		// _player_mc.flvSound.attachAudio(_netstream_ns);
		// _flvSound = new Sound(_player_mc.flvSound);
		
		// set buffer to 3 seconds
		_netstream_ns.setBufferTime(3);
		
		// don't know why i did this. you can't even see it at this point
		// set display value to 0
		// _status_mc.status_text.text = "0%";
		
		// set handlers
		_play_mc.onRelease 		= Delegate.create(this, togglePlay);
		_netstream_ns.onStatus 		= Delegate.create(this, getNetStreamStatus);
		_netstream_ns.onMetaData	= Delegate.create(this, getNetStreamData);
		
		// for cue points in flv
		_netstream_ns.onCuePoint 	= Delegate.create(this, onCuePointEvent);
		
		// disable _play_mc until video is loaded
		_play_mc.enabled = false;
		
		// play FLV, seek to 0, pause, preload
		_netstream_ns.play(_flvToPlay);
		_netstream_ns.seek(0);
		_netstream_ns.pause(); // togglePlay();
		
		// preload
		showStatus(false);
		clearInterval(_preloadInterval);
		_preloadInterval = setInterval(this, "checkBytesLoaded", 10);
		
		// updates preview, sends back to beginning when flv ends
		clearInterval(_controlsInterval);
		_controlsInterval = setInterval(this, "updateControls", 100);

	}
	
	
	private function onCuePointEvent(_infoObject:Object):Void
	{
		// video will contain cue point event at 15 secs
		if(_infoObject.name == "vidMidPoint")
		{
			_root.conduit.counter(5, true);
			_root.conduit.stopTimer(1, true);
			trace("motif event: \"video_mid_point\" & stopTimer");
		}
	}
	
	
	private function getNetStreamStatus(info_obj:Object):Void {
		if(info_obj.code == "NetStream.Play.StreamNotFound") {
			_status_mc.status_text.text += newline + "error: " + info_obj.code;
		}
		
		// broadcast the event for "video_completed"
		if(info_obj.code == "NetStream.Play.Stop") {
			_root.conduit.counter(3, true);
			trace("motif event: \"video_completed\"");
		}
		
		showStatus(true);
	}
	
	private function getNetStreamData(data_obj:Object):Void {
		_flvDuration = data_obj.duration;
	}
	
	private function showStatus(vis:Boolean):Void {
		var alpha:Number = (vis == true) ? 100 : 0;
		TweenLite.to(_status_mc, .6, {_alpha: alpha});
		// Tweener.addTween(_status_mc, {_alpha: alpha, time: .8, transition: "Strong.easeOut"});
	}
	
	private function togglePlay():Void {
		_netstream_ns.pause();
		updatePlayButton();
	}
	
	private function checkBytesLoaded():Void {
		_percentLoaded = Math.round(_netstream_ns.bytesLoaded / _netstream_ns.bytesTotal * 100);
		// _status_mc.status_text.text = _percentLoaded + "%";
		if(_percentLoaded >= 100) {
			clearInterval(_preloadInterval);
			// clear status and hide it
			// fade in/enable _play_mc
			_status_mc.status_text.text = "";
			showStatus(false);
			TweenLite.to(_play_mc, .6, {_alpha: 100});
			// Tweener.addTween(_play_mc, {_alpha: 100, time: .8, transition: "Strong.easeOut"});
			_play_mc.enabled = true;
		}
	}
	
	private function updateControls():Void {
		if(_netstream_ns.time >= .1 && _netstream_ns.time < 1) {
			// video has started
			// fade out preview
			// set handler for play/pause mc
			TweenLite.to(_preview_mc, .6, {_alpha: 0});
			setPlayButtonHandlers();
		}
		if(Math.round(_netstream_ns.time) == Math.round(_flvDuration) && _goingBack != true) {
				_goingBack = true;
				clearInterval(_backToStartInterval);
				_backToStartInterval = setInterval(this, "backToStart", 990);
		}	
	}
	
	private function setPlayButtonHandlers():Void {
		_play_mc.onRollOver = function():Void {
			TweenLite.to(this, .5, {_alpha: 100});
		}
		_play_mc.onRollOut = function():Void {
			TweenLite.to(this, .5, {_alpha: 0});
		}
	}
	
	private function updatePlayButton():Void {
		// on release, fade out mc
		_play_mc.enabled = false;
		TweenLite.to(_play_mc, .6, {_alpha: 0, onComplete: Delegate.create(this, switchIcons)});
	}
	
	private function switchIcons():Void {
		if(_play_mc._currentframe == 1) {
			_play_mc.gotoAndStop("play");
			
			// broadcast the event for "repeat_video_plays"
			if(_root.hasVidEverPlayed == false)
			{
				_root.hasVidEverPlayed = true;
				trace("hasVidEverPlayed = " + _root.hasVidEverPlayed);
			}
			else // it's already been played at least once...
			{
				// if video is currently in playback, don't broadcast
				// repeat plays until the video has completed
				if(_root.vidInPlayback == false)
				{
					_root.vidInPlayback = true;
					_root.conduit.counter(6, true);
					trace("motif event: \"repeat_video_plays\" ::: hasVidEverPlayed = " + _root.hasVidEverPlayed);
				}
			}
			
			// broadcast the events for "video_play" & start the timer
			// tracking the length of time user watched video
			_root.conduit.counter(1, true);
			_root.conduit.startTimer(1, true);
			trace("motif event: \"video_play\"");
			
		} else {
			_play_mc.gotoAndStop("pause");
			// broadcast the events for "video_paused" & stop the timer
			// tracking the length of time user watched video
			_root.conduit.counter(2, true);
			_root.conduit.stopTimer(1, true);
			trace("motif event: \"video_paused\"");
		}
		_play_mc.enabled = true;
	}
	
	private function backToStart():Void {
		clearInterval(_backToStartInterval);
		_netstream_ns.seek(0);
		TweenLite.to(_preview_mc, .6, {_alpha: 100});
		TweenLite.to(_play_mc, .6, {_alpha: 100});
		_netstream_ns.pause();
		switchIcons();
	}
	
	private function updateSound():Void {
		// may need to mute at some point
		// var vol:Number = _sound_mc._x / 26 * 100;
		// _flvSound.setVolume(vol);
	}
	
	public function killVideo():Void {
		_netstream_ns.close();
		_player_vo.clear();
	}
}