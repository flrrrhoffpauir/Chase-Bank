//
//  VideoControl.as
//
//  Created by Junie Threatt & Tim Harold on 2008-03-05.
//  Copyright (c) 2008 T3. All rights reserved.
//

import classes.utils.EventManager
import mx.utils.Delegate;

class classes.VideoControl extends MovieClip {

	// private properties
	private var _connection_nc:NetConnection;
	private var _netstream_ns:NetStream;
	
	// private var _video_array:Array = [];		// local testing
	private var _video_array:Array = [];		// live

	// public properties
	public var video_vo:MovieClip;
	public var status_txt:TextField;

	/**
	 *  VideoControl Constructor
	 */
	function VideoControl() { init(); };

	// private methods --------------------------------------------------------------------------------------------------------
	/**
	 *   Initializes
	 */
	private function init():Void {
		
		EventManager.addEventListener("onPlayVideo", this, "playVideo");
		
		// clear any previous video data
		killVideo();
		
		// array: local / live
		// _video_array = ["flv/flv0.flv", "flv/flv1.flv", "flv/flv2.flv", "flv/flv3.flv"];
		_video_array = [_root.adPath+"chase232/flv0.flv", _root.adPath+"chase232/flv1.flv", _root.adPath+"chase232/flv2.flv", _root.adPath+"chase232/flv3.flv"]
		
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
	};
	
	private function playVideo(o:Object):Void {

		// killVideo();		// clear any previous video data	
		setVidStatus("");	// clear any previous status messages
		
		// Load the new FLV
		
		TweenLite.from(this, 2, { _alpha:0, overwrite:false });
		_netstream_ns.play(_video_array[o.data.id]);
	};
	
	private function killVideo():Void {
		
		// Close the netstream and clear the video object
		
		trace("! KILLING VIDEO !");
		
		_netstream_ns.close();
		video_vo.clear();
	};
	
	private function getNetStreamStatus(o:Object):Void {
		
		// Throw an error if the FLV can't be found		
		if(o.code == "NetStream.Play.StreamNotFound") { setVidStatus(newline + "error: " + o.code); };
	};
	
	private function setVidStatus(t:String):Void {
		
		// Sets status textfield
		status_txt.text = t;
	};
};