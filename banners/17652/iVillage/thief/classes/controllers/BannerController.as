/**
*      	BannerController Class
*      	Created on 2008-11-11
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-11-11
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Controller for banners
*
*/

import tweening.TweenLite;
import tweening.Quint;
import mx.utils.Delegate;

class controllers.BannerController extends MovieClip {
	
	private var _scope:MovieClip;
	
	private static var TEXT_SPEED:Number = .4;
	private static var MOVE_SPEED:Number = .5;
	private static var EASE:Function = Quint.easeOut;
	
	public function BannerController(scope:MovieClip) {
		_scope = scope;
		_scope["hotspot"].onRelease = Delegate.create(this, defaultClick);
		_scope["hotspot"].onRollOver = Delegate.create(this, defaultOver);
		_scope["hotspot"].onRollOut = Delegate.create(this, defaultOut);
	}
	
	public function aTween(mc:MovieClip, a:Number):Void { TweenLite.to(mc, MOVE_SPEED, { _alpha:a }); };
	public function xTween(mc:MovieClip):Void { TweenLite.from(mc, TEXT_SPEED, { _x:-10-mc._width, ease:EASE }); };
	public function pTween(num:Number):Void { _scope.stop(); TweenLite.delayedCall(num, Delegate.create(_scope, play)); };
		
	public function initBottomMenu():Void {		
		TweenLite.from(_scope["bottomMenu"], MOVE_SPEED, { _y:Stage.height+_scope["bottomMenu"]._height+10, ease:EASE, onComplete:Delegate.create(this, shimmerCta) });
		setBottomHandlers();
	}
	
	public function setBottomHandlers():Void {
		_scope["bottomMenu"].cta.onRollOver = Delegate.create(this, shimmerCta);
		_scope["bottomMenu"].cta.onRelease = Delegate.create(this, defaultClick);
	}
	
	public function initExpandedBanner():Void {
		TweenLite.to(_scope["border"], MOVE_SPEED, { _height:383, ease:EASE });
		TweenLite.to(_scope["bodyMask"], MOVE_SPEED, { _height:380, ease:EASE });
		TweenLite.to(_scope["bottomMenu"].bg, MOVE_SPEED, { _height:309, ease:EASE });
	}
	
	public function collapseExpandedBanner():Void {
		TweenLite.to(_scope["border"], MOVE_SPEED, { _height:90, ease:EASE });
		TweenLite.to(_scope["bodyMask"], MOVE_SPEED, { _height:90, ease:EASE });
		TweenLite.to(_scope["bottomMenu"].bg, MOVE_SPEED, { _height:18, ease:EASE });
	}
	
	private function shimmerCta():Void { _scope["bottomMenu"].cta.gotoAndPlay("shimmer"); };
	
	private function defaultClick():Void { getURL(_root.clickTag, "_blank"); };
	
	private function defaultOver():Void {
		//
	}
	
	private function defaultOut():Void {
		//
	}
}