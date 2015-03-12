//
//  CTA.as
//
//  Created by Junie Threatt & Tim Harold on 2008-03-05.
//  Copyright (c) 2008 T3. All rights reserved.
//

import classes.utils.EventManager

class classes.CTA extends MovieClip {
	
	// private properties
	private var _urlString:String;
	private var _scale:Number;
	
	// public properties
	public var shimmer_mc;

	/**
	 *  CTA Constructor
	 */
	function CTA() { 
		
		_scale = 115;
		
		// when a nav item is selected
		// the tracking resets and is asigned to the cta
		EventManager.addEventListener("onTrackItem", this, "setURL");
		
	};
	
	private function setURL(o:Object):Void {
		_urlString = o.data.link;
	};
	
	public function onRelease():Void {
		
		// This is set by the tracking class
		
		getURL(_urlString, "_blank");
	};
	
	public function onRollOver():Void {
		TweenLite.to(this, .5, { _xscale:_scale, _yscale:_scale });
		this.gotoAndPlay("shimmer");
		
		// uncomment for testing
		trace(this._urlString);
	};
	
	public function onRollOut():Void {
		TweenLite.to(this, .5, { _xscale:100, _yscale:100 });
	};
};