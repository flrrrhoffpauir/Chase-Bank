/**
*      	ThumbHolder Class
*      	Created on 2008-09-17
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-09-17
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	The scrollers thumbnails - this is more of a view and a controller
*	Allthough I suppose it would just be a controller...
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenLite;
import tweening.Expo;
import mx.utils.Delegate;

class views.ThumbHolder extends MovieClip {
	
	private var _id:Number;
	
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	public function ThumbHolder() {
		this.onRelease = Delegate.create(this, release);
		this.onRollOver = Delegate.create(this, rollover);
		this.onRollOut = Delegate.create(this, rollout);
		
		EventManager.addEventListener(Events.SCROLLER_THUMB_RELEASE, this, "selectThumb");
	}
	
	private function release():Void { EventManager.dispatchEvent(Events.SCROLLER_THUMB_RELEASE, { id:_id }); };
	
	private function rollover():Void { TweenLite.to(this["playIcon"], SPEED, { _alpha:100, ease:EASE }); };
	
	private function rollout():Void { TweenLite.to(this["playIcon"], SPEED, { _alpha:0, ease:EASE }); };
	
	private function selectThumb(o:Object):Void {
		
		// disable all thumbs until location has time to change
		this.enabled = false;
		_global.setTimeout(this, "setEnabledThumbs", 750, o.data.id);
		
		if(_id == o.data.id) {
			TweenLite.to(this["playIcon"], SPEED, { _alpha:0, ease:EASE });
			TweenLite.to(this["selector"], SPEED, { _alpha:100, ease:EASE });
		} else {
			TweenLite.to(this["selector"], SPEED, { _alpha:0, ease:EASE });
		}
	}
	
	
	private function setEnabledThumbs(id):Void {
		// disable clicked clip
		
		/*
		if(_id != id) {
			this.enabled = true;
		} else {
			this.enabled = false;
		}
		*/
		this.enabled = true;		
	}
	
	public function get id():Number { return _id; };
	public function set id(id:Number):Void { _id = id; };
}