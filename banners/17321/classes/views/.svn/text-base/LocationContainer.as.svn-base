/**
*      	LocationContainer Class
*      	Created on 2008-09-17
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-09-17
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Container for location clips
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenLite;
import tweening.Expo;
import mx.utils.Delegate;

class views.LocationContainer extends MovieClip {
	
	/**
	 *   private properties
	 */
	private var _currLocation:Number;
	private var _nextLocation:Number;
	
	/**
	 *   static properties
	 */
	private static var SPEED:Number = .75;
	private static var EASE:Function = Expo.easeOut;
	private static var DIST:Number = 518;
	
	/**
	 *   contructor
	 */
	public function LocationContainer() {
		
		EventManager.addEventListener(Events.INIT_LOCATION, this, "initLocation");
		EventManager.addEventListener(Events.SCROLLER_THUMB_RELEASE, this, "switchLocation");
	}
	
	
	/**
	 *   loads initial location
	 */
	private function initLocation(o:Object):Void {
		_currLocation = o.data.id;
		this.attachMovie("location"+_currLocation, "location"+_currLocation, this.getNextHighestDepth(), { id:_currLocation });
		this["location"+_currLocation].gotoAndPlay("end");
	}
	
	
	/**
	 * switches to another location
	 */
	private function switchLocation(o:Object):Void {
		
		if(_currLocation == o.data.id) {
			this["location"+_currLocation].gotoAndPlay("beginning");
			this["location"+_currLocation].doFade = true;
			return;
		}
		
		_nextLocation = o.data.id;
		
		this.attachMovie("location"+_nextLocation, "location"+_nextLocation, this.getNextHighestDepth(), { _x:-DIST, id:_nextLocation });		
		
		var nextMc:MovieClip = this["location"+_nextLocation];
		var currMc:MovieClip = this["location"+_currLocation];				
		TweenLite.to(nextMc, SPEED, { _x:0, ease:EASE, overwrite:false });
		TweenLite.to(currMc, SPEED, { _x:DIST, ease:EASE, onComplete:Delegate.create(this, removeLocation), overwrite:false });
	}
	
	
	/**
	 *   removes location once it has been tweened offstage
	 */
	private function removeLocation():Void { 
		this["location"+_currLocation].removeMovieClip();
		_currLocation = _nextLocation;
	}
}