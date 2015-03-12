//
// VideoController.as
// Created by Junie Threatt
//

import classes.utils.EventManager
import mx.utils.Delegate;

class controllers.VideoController extends MovieClip {

	// private properties
	private var _connection_nc:NetConnection;
	private var _netstream_ns:NetStream;
	private var _isPlaying:Boolean = false;
	private var _hasEnded:Boolean = false;
	private var _video_num:Number;
	
	private var _video_array:Array = [];

	// public properties
	public var video_vo:MovieClip;
	public var status_txt:TextField;

	// contructor
	function VideoController() { init(); }

	private function init():Void {
		
		EventManager.addEventListener("onPlayVideo", this, "playVideo");
		EventManager.addEventListener("onToggleVideo", this, "toggleVideo");
		
		// clear any previous video data
		killVideo();
		
		// array: local / live
		_video_array = ["flv/flv0.flv", "flv/flv1.flv", "flv/flv2.flv"];
		// _video_array = ["http://video.nbcuni.com/ads/swf/flv0.flv", "http://video.nbcuni.com/ads/swf/flv1.flv", "http://video.nbcuni.com/ads/swf/flv2.flv"];
		
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
		_netstream_ns.play(_video_array[_video_num]);
	}
	
	private function killVideo():Void {
		
		// Close the netstream and clear the video object
		
		_netstream_ns.close();
		video_vo.clear();
	}
	
	private function toggleVideo(o:Object):Void {
		if(o.data.id == 0) {
			// pause
			_netstream_ns.pause(true);
			_isPlaying = false;
			return;
		}
		
		if(_hasEnded == true) {
			// video_vo.clear();
			_netstream_ns.play(_video_array[_video_num]);
			_hasEnded = false;
		}
		
		// otherwise toggle
		
		if(_isPlaying == true) {
			// pause
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
			setVidStatus(newline + "error: " + o.code);
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
}