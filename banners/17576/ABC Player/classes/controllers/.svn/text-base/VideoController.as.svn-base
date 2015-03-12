/**
*      	VideoController Class
*      	Created on 2008-01-01
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-17
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Video player controller
*
*/

import events.Events;
import events.EventManager
import mx.utils.Delegate;
import tracking.Tracking;

class controllers.VideoController extends MovieClip {

	// private properties
	private var _connection_nc:NetConnection;
	private var _netstream_ns:NetStream;
	private var _isPlaying:Boolean = false;
	private var _hasEnded:Boolean = false;
	private var _serverPath:String;
	private var _video_num:Number;
	
	private var _video_array:Array = [];

	// public properties
	public var video_vo:MovieClip;
	public var status_txt:TextField;

	// contructor
	function VideoController() { init(); }

	private function init():Void {
		
		_serverPath = getServerPath();
		
		EventManager.addEventListener(Events.PLAY_VIDEO, this, "playVideo");
		EventManager.addEventListener("onToggleVideo", this, "toggleVideo");
		
		// clear any previous video data
		killVideo();
		
		// local
		// _video_array = ["flv/flv0.flv"];
		
		// live: adPath
		// _video_array = [_root.adPath+"chase464/flv0.flv"];
		
		// live: serverPath
		_video_array = [_serverPath+"flv0.flv"];
		
		// live: absolute url
		// _video_array = ["http://a.verdict.abc.go.com/chase464/flv0.flv"];
		
		// initial setup
		_connection_nc = new NetConnection();
		_connection_nc.connect(null);
		
		// attach netstream to video object
		_netstream_ns = new NetStream(_connection_nc);
	 	video_vo.attachVideo(_netstream_ns);
		
		// set buffer to 3 seconds
		_netstream_ns.setBufferTime(3);
		
		// make sure we can locate the video
		_netstream_ns.onStatus = Delegate.create(this, getNetStreamStatus);
		
		setVidStatus("not playing");
	}
	
	private function playVideo(o:Object):Void {
		
		setVidStatus("");	// clear any previous status messages
		
		// Load the new FLV
		
		// TweenLite.from(this, 2, { _alpha:0, overwrite:false });
		_video_num = o.data.id;
		_netstream_ns.play(_video_array[_video_num] + "?mydong=hi");
	}
	
	private function killVideo():Void {
		
		// Close the netstream and clear the video object
		
		_netstream_ns.close();
		video_vo.clear();
	}
	
	private function toggleVideo(o:Object):Void {
		if(o.data.id == 0) {
			// pause
			Tracking.trackView("videoPause");
			_netstream_ns.pause(true);
			_isPlaying = false;
			return;
		}
		
		if(_hasEnded == true) {
			// video_vo.clear();
			// replay the video
			Tracking.trackView("videoReplay");
			_netstream_ns.play(_video_array[_video_num]);
			_hasEnded = false;
		}
		
		// otherwise toggle
		
		if(_isPlaying == true) {
			// pause
			Tracking.trackView("videoPause");
			_netstream_ns.pause(true);
			_isPlaying = false;
		} else {
			// play
			_netstream_ns.pause(false);
			_isPlaying = true;
		}
	}
	
	private function getNetStreamStatus(o:Object):Void {
		// Throw an error if the FLV can't be found		
		if(o.code == "NetStream.Play.StreamNotFound") {
			setVidStatus(newline + "error: " + o.code + newline + newline + "flv: " + _video_array[_video_num]);
			_isPlaying = false;
		} else if (o.code == "NetStream.Buffer.Empty") {
			EventManager.dispatchEvent("onPlayStop", { });
			_isPlaying = false;
			_hasEnded = true;
		} else {
			_isPlaying = true;
		}
	}
	
	private function setVidStatus(t:String):Void {
		// Sets status textfield
		status_txt.text = t;
	}
	
	private function getServerPath():String {
		// sort of a hack to work with ABC
		var urlString:String = this._parent._parent._url;
		if(this._parent._parent._url.lastIndexOf("?") > 0) {
			urlString = urlString.slice(0, this._parent._parent._url.lastIndexOf("?"));
		}
		var serverPath:String = urlString.slice(0, urlString.lastIndexOf("/")+1);
		return serverPath;
	}
}