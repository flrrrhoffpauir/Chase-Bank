//
//  flvPlayer.as
//
//  Created by Junie Threatt on 2008-02-08.
//  Copyright (c) 2008 T3. All rights reserved.
//

import mx.utils.Delegate;

class flvPlayer {
	
	private var _controls_mc:MovieClip;
	private var _status_mc:MovieClip;
	private var _play_mc:MovieClip;
	private var _seek_mc:MovieClip;
	private var _mask_mc:MovieClip;
	private var _dur_mc:MovieClip;
	private var _preview_mc:MovieClip;
	private var _sound_mc:MovieClip;
	private var _player_vo:Video;
	private var _flvSound:Sound;
	
	private var _connection_nc:NetConnection;
	private var _netstream_ns:NetStream;
	
	private var _flvToPlay:String;
	private var _flvHasStarted:Boolean;
	private var _goingBack:Boolean
	private var _flvDuration:Number;
	private var _percentLoaded:Number;
	private var _preloadInterval:Number;
	private var _controlsInterval:Number;
	private var _soundInterval:Number;
	private var _backToStartInterval:Number;
	
	public function flvPlayer(vo:Video, cmc:MovieClip, smc:MovieClip, pmc:MovieClip, flv:String) {
		_player_vo			= vo;
		_controls_mc		= cmc;
		_status_mc			= smc;
		_preview_mc			= pmc;
		_play_mc			= _controls_mc.play_mc;
		_seek_mc			= _controls_mc.seek_mc;
		_mask_mc			= _controls_mc.mask_mc;
		_dur_mc				= _controls_mc.durationBar_mc;
		_sound_mc			= _controls_mc.sound_mc.bar_mc;
		
		_flvToPlay			= flv;
		_flvHasStarted		= false;
		
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
		_sound_mc.onPress = Delegate.create(this, dragSound);
		_sound_mc.onRelease = Delegate.create(this, stopDrag);
		_controls_mc.createEmptyMovieClip("flvSound", _controls_mc.getNextHighestDepth());
		_controls_mc.flvSound.attachAudio(_netstream_ns);
		_flvSound = new Sound(_controls_mc.flvSound);
		
		// set buffer to 3 seconds
		_netstream_ns.setBufferTime(3);
		
		// set display value to 0
		_status_mc.status_text.text = "0%";
		
		// set handlers
		_play_mc.onRelease 	= _preview_mc.onRelease = Delegate.create(this, togglePlay);
		_netstream_ns.onStatus 		= Delegate.create(this, getNetStreamStatus);
		_netstream_ns.onMetaData	= Delegate.create(this, getNetStreamData);
		
		// play FLV, seek to 0, pause, preload
		_netstream_ns.play(_flvToPlay);
		_flvHasStarted = true;
		_netstream_ns.seek(0);
		togglePlay();
		
		// preload
		// showStatus(true);
		clearInterval(_preloadInterval);
		_preloadInterval = setInterval(this, "checkBytesLoaded", 10);
		
		// update scrubber, etc
		clearInterval(_controlsInterval);
		_controlsInterval = setInterval(this, "updateControls", 100);

		// update sound
		clearInterval(_soundInterval);
		_soundInterval = setInterval(this, "updateSound", 10);
	}
	
	private function getNetStreamStatus(info_obj:Object):Void {
		if(info_obj.code == "NetStream.Play.StreamNotFound") {
			_status_mc.status_text.text += newline + "error: " + info_obj.code;
		}
		showStatus(true);
	}
	
	private function getNetStreamData(data_obj:Object):Void {
		_flvDuration = data_obj.duration;
	}
	
	private function showStatus(vis:Boolean):Void {
		var alpha:Number = (vis == true) ? 100 : 0;
		Tweener.addTween(_status_mc, {_alpha: alpha, time: .8, transition: "Strong.easeOut"});
	}
	
	private function togglePlay():Void {
		_netstream_ns.pause();
		if(_play_mc._currentframe == 1) {
			_play_mc.gotoAndStop("play");
		} else {
			_play_mc.gotoAndStop("pause");
		}
	}
	
	private function checkBytesLoaded():Void {
		_percentLoaded = Math.round(_netstream_ns.bytesLoaded / _netstream_ns.bytesTotal * 100);
		_status_mc.status_text.text = _percentLoaded + "%";
		if(_percentLoaded >= 100) {
			clearInterval(_preloadInterval);
			_status_mc.status_text.text = "";
			showStatus(false);
			// togglePlay();
		/*
		} else if(_percentLoaded == 0) {
			// there was an error
			clearInterval(_preloadInterval);
			_status_mc.status_text.text += "error: Percent == 0";
			showStatus(true);
			*/
		}
	}
	
	private function updateControls():Void {
		_dur_mc._width = _percentLoaded / 100 * 500;
		_seek_mc._x = _netstream_ns.time / _flvDuration * 500 + 30;
		_mask_mc._x = _seek_mc._x;
		if(_netstream_ns.time >= .1 && _netstream_ns.time < 1) {
			Tweener.addTween(_preview_mc, {_alpha: 0, time: .8, transition: "Strong.easeOut"});
		}
		if(Math.round(_netstream_ns.time) == Math.round(_flvDuration) && _goingBack != true) {
				_goingBack = true;
				clearInterval(_backToStartInterval);
				_backToStartInterval = setInterval(this, "backToStart", 990);
				trace("go back to the start");
		}	
	}
	
	private function backToStart():Void {
		trace("back start");
		clearInterval(_backToStartInterval);
		_netstream_ns.seek(0);
		Tweener.addTween(_preview_mc, {_alpha: 100, time: .8, transition: "Strong.easeOut"});
		togglePlay();
	}
	
	private function dragSound():Void {
		_sound_mc.startDrag(false, 0, _sound_mc._y, 26, _sound_mc._y);
	}
	
	private function updateSound():Void {
		// sound_mc should be the bar you drag
		// need to add that to the top as a var
		var vol:Number = _sound_mc._x / 26 * 100;
		_flvSound.setVolume(vol);
	}
}