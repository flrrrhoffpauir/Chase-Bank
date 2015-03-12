/**
*      	LocationHolder Class
*      	Created on 2008-09-17
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-09-17
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Functions for animating each locations assets
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenLite;
import tweening.Expo;
import tweening.Back;
import tweening.Elastic;
import mx.utils.Delegate;

class views.LocationHolder extends MovieClip {
	
	/**
	 *   static properties
	 */
	private static var SPEED:Number = .55;
	private static var EASE:Function = Expo.easeOut;
	
	public function LocationHolder() { };
	
	// _x, _y tween
	public function xTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _x:-10-mc._width, ease:EASE }); };
	public function yTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _y:-10-mc._height, ease:EASE }); };
	
	// _alpha, 'sub' tween
	public function aTween(mc:MovieClip):Void { TweenLite.to(mc, SPEED, { _alpha:0, ease:EASE }); };
	public function sTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _y:mc._y+25, _alpha:0, ease:EASE }); };
	
	// 'pause' tween
	public function pTween(t:Number):Void { stop(); TweenLite.delayedCall(t, Delegate.create(this, play)); };
	
	// 'shadow' tween
	public function shadowTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _alpha:0, ease:EASE }); };
	
	// cta tween
	public function cTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _x:mc._x+260, ease:EASE }); };
	
	// black overlay tween
	public function wTween(mc:MovieClip):Void { TweenLite.from(mc, SPEED, { _alpha:100, ease:EASE }); };
	
	// dispatch that location has played to end
	public function dispatchHasLoaded():Void { EventManager.dispatchEvent(Events.LOCATION_HAS_LOADED, { }); };
	
	// for the music location
	public function randomizeFlames(mc:MovieClip):Void { for(var i:Number = 0; i < 5; i++) { mc["flame_" + i].gotoAndPlay(Math.ceil(Math.random()*35)); } };
	
	public function initCta(mc:MovieClip, link:String):Void {
		mc.onRollOver = function():Void {
			this["a"]._x = 6;
			TweenLite.to(this["a"], SPEED*2, { _x:2, ease:Elastic.easeOut});
		};
		
		mc.onRollOut = function():Void {
			// TweenLite.from(this["a"], SPEED, { _x:2, ease:Elastic.easeOut});
		};
		
		mc.onRelease = function():Void {
			EventManager.dispatchEvent(Events.CTA_RELEASE, { });
			getUrl(link, "_top");
		};
	}

}