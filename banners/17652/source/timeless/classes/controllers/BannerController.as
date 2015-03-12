/**
*      	BannerController Class
*      	Created on 2008-10-22
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-22
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Controller for banners
*
*/

import tweening.TweenFilterLite;
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
	}
	
	public function aTween(mc:MovieClip, a:Number):Void { TweenFilterLite.to(mc, MOVE_SPEED, { _alpha:a }); };
	public function xTween(mc:MovieClip):Void { TweenFilterLite.from(mc, TEXT_SPEED, { _x:-10-mc._width, ease:EASE }); };
	public function pTween(num:Number):Void { _scope.stop(); TweenFilterLite.delayedCall(num, Delegate.create(_scope, play)); };
		
	public function initBottomMenu():Void {
		
		TweenFilterLite.from(_scope["bottomMenu"], MOVE_SPEED, { _y:Stage.height+_scope["bottomMenu"]._height+10, ease:EASE, onComplete:Delegate.create(this, shimmerCta) });
		if(_root.h != 728) {
			TweenFilterLite.to(_scope["bg"], MOVE_SPEED, { _y:_scope["bg"]._y-_scope["bottomMenu"]._height+_root.h, delay:.1, ease:EASE });
		}
		_scope["bottomMenu"].cta.onRollOver = Delegate.create(this, shimmerCta);
		_scope["bottomMenu"].cta.onRelease = Delegate.create(this, defaultClick);
	}
	
	private function shimmerCta():Void { _scope["bottomMenu"].cta.gotoAndPlay("shimmer"); };
	private function defaultClick():Void { getURL(_root.clickTag, "_blank"); };
}