/**
*	GlobeBanner Class
*	Created on 2009-11-03
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2009-11-03                      
*	@author 
*	@version 1.0.0
*
*	all code copyright (c) 2009 T3 The Think Tank. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import mx.utils.Delegate;
import gs.*;
import gs.easing.*;

class globe.GlobeBanner
{
	private var _bannerID:Number; // 0:160x600, 1:300x250, 2:336x280, 3:300x600, 4:728x90
	public var hotspot,disclaimer,splatterMask,splatter,card,cta,inkMeans,accepted,rollOverForMore,stroke,access,control,flexibility,business:MovieClip;
	
	private var _cardEndX:Number;
	private var _rollOverForMoreEndX:Number;
	
	
	/**
	 *  GlobeBanner Constructor
	 */
	public function GlobeBanner(bannerID:Number) { _bannerID = bannerID; };
	

	/**
	 *   Inits
	 */
	public function init():Void
	{
		// trace("GlobeBanner.init()");
		_root._quality = "BEST";
		_root.hotspot.onRelease = Delegate.create(this, defaultClick);
		_root.cta.onRollOver = Delegate.create(this, ctaRollOver);
	    _root.cta.onRollOut = Delegate.create(this, ctaRollOut);
	    _root.cta.onRelease = Delegate.create(this, defaultClick);
		hideAllObjects();
		
		step1();
		_global.setTimeout(step2, 500);
		_global.setTimeout(step3, 3500);
		_global.setTimeout(step4, 5500);
		_global.setTimeout(step5, 7500);
		_global.setTimeout(step6, 10200, _bannerID);
		_global.setTimeout(step7, 12800, _bannerID, _rollOverForMoreEndX);
	};
	
	
	// show the card
	private function step1():Void
	{
		// trace("step1 starting...");
		switch(_bannerID) // 0:160x600, 1:300x250, 2:336x280, 3:300x600, 4:728x90
		{
			case 0 :
			case 1 :
			case 2 :
			case 3 :
			case 4 :
				var rollOverPropsObj:Object = { _x:_cardEndX, _alpha:100, ease:Strong.easeOut };
				break;
		}
		TweenLite.to(_root.card, 0.5, rollOverPropsObj);
	};
	
	// show inkMeans then stroke then access
	private function step2():Void
	{
		// trace("step2 starting...");
		_root.stroke._alpha = 100;
		TweenLite.to(_root.inkMeans, 0.5, { delay:0.2, _alpha:100, ease:Strong.easeOut, onComplete:function(){ _root.stroke.gotoAndPlay("draw1"); } });
		TweenLite.to(_root.access, 0.5, { delay:0.8, _alpha:100, ease:Strong.easeOut, onComplete:function(){ _root.access.gotoAndPlay("write"); } });
	};
	
	// crossfade access into control
	private function step3():Void
	{
		// trace("step3 starting...");
		TweenLite.to(_root.access, 0.5, { _alpha:0.0, ease:Strong.easeOut });
		TweenLite.to(_root.control, 0.5, { _alpha:100, ease:Strong.easeOut, onComplete:function(){ _root.control.gotoAndPlay("write"); } });
	};
	
	// crossfade control into flexibility
	private function step4():Void
	{
		// trace("step4 starting...");
		TweenLite.to(_root.control, 0.5, { _alpha:0.0, ease:Strong.easeOut });
		TweenLite.to(_root.flexibility, 0.5, { _alpha:100, ease:Strong.easeOut, onComplete:function(){ _root.flexibility.gotoAndPlay("write"); } });
		
	};
	
	// crossfade flexibility into business
	private function step5():Void
	{
		// trace("step5 starting...");
		TweenLite.to(_root.flexibility, 0.5, { _alpha:0.0, ease:Strong.easeOut });
		TweenLite.to(_root.business, 0.5, { _alpha:100, ease:Strong.easeOut, onComplete:function(){ _root.business.gotoAndPlay("write"); } });
		
	};
	
	// crossfade business into accepted
	private function step6(bannerID:Number):Void
	{
		// trace("step6 starting...");
		
		_root.stroke.gotoAndPlay("draw2");
		
		if(bannerID == 4) // 0:160x600, 1:300x250, 2:336x280, 3:300x600, 4:728x90
		{
			TweenLite.to(_root.stroke, 0.5, { _y:32, ease:Strong.easeOut });
			TweenLite.to(_root.inkMeans, 0.5, { _y:13, ease:Strong.easeOut });
		}
		
		TweenLite.to(_root.business, 0.5, { _alpha:0.0, ease:Strong.easeOut });
		TweenLite.to(_root.accepted, 0.5, { delay:0.3, _alpha:100, ease:Strong.easeOut });
	};
	
	
	private function step7(bannerID:Number, rx:Number):Void
	{
		// trace("step7 starting...");
		
		_root.cta._y -= 10;
		_root.disclaimer._y -= 10;
		_root.cta._visible = true;
		
		var ctaObj:Object = { _y:_root.cta._y + 10, _alpha:100, ease:Strong.easeOut, onComplete:function(){ _root.cta.gotoAndPlay("shimmer"); } };
		var disclaimerObj:Object = { delay:0.2, _y:_root.disclaimer._y + 10, _alpha:100, ease:Strong.easeOut };
		var rollOverPropsObj:Object = { delay:0.9, _x:rx, _alpha:100, ease:Strong.easeOut, onComplete:function(){ _root.rollOverForMore.gotoAndPlay("hideArrows"); } };
		
		TweenLite.to(_root.rollOverForMore, 1.0, rollOverPropsObj);
		TweenLite.to(_root.cta, 1.0, ctaObj);
		TweenLite.to(_root.disclaimer, 1.0, disclaimerObj);
	};
	
	
	private function startWriting(obj:MovieClip):Void
	{
		obj.gotoAndPlay("write");
	};
	
	
	private function ctaRollOver():Void { _root.cta.gotoAndPlay("shimmer"); };
    private function ctaRollOut():Void { };
    private function defaultClick():Void { _root.conduit.exit(1); };
	
	
	private function hideAllObjects():Void
	{
		_root.disclaimer._alpha =
		_root.splatterMask._alpha =
		_root.card._alpha =
		_root.inkMeans._alpha =
		_root.rollOverForMore._alpha =
		_root.stroke._alpha =
		_root.access._alpha =
		_root.control._alpha =
		_root.flexibility._alpha =
		_root.business._alpha =
		_root.accepted._alpha =
		//_root.stroke._alpha =
		_root.cta._alpha = 0.0;
		
		_root.cta._visible = false;
		//_root.stroke._xscale = 1;
		
		_cardEndX = _root.card._x;
		_root.card._x += (_bannerID == 3) ? -200 : -100;  // 0:160x600, 1:300x250, 2:336x280, 3:300x600, 4:728x90
		_rollOverForMoreEndX = _root.rollOverForMore._x;
		_root.rollOverForMore._x = _cardEndX;
	};
	
} // end





