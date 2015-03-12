
// GameLaunchController.as
// created by Junie Threatt
// on 08-18-2008

import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;
import classes.utils.EventManager;

class controllers.GameLaunchController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	public function GameLaunchController(scope:MovieClip) {
		
		_scope = scope;
		
		EventManager.addEventListener("onIconRollOver", this, "mcRollOver");
		EventManager.addEventListener("onIconRollOut", this, "mcRollOut");
	}
	
	private function mcRollOver(o:Object):Void {
		
		for(var i:Number = 0; i < 2; i++) {
			if(i == o.data.id) {
				// scale, opacity, glow, saturation, hue
				TweenFilterLite.to(_scope["icon"+i].img, SPEED, { _xscale:100, _yscale:100, _alpha:100, glowFilter:{ color:0xFFFFFF, blurX:11, blurY:11, alpha:1 }, colorMatrixFilter:{ }, ease:EASE });
				
				// tween description
				TweenFilterLite.to(_scope["icon"+i].desc.bg, SPEED, { _xscale:100, _yscale:100, _alpha:85, glowFilter:{ color:0xFFFFFF, blurX:8, blurY:8, alpha:1 }, ease:EASE });
				TweenFilterLite.to(_scope["icon"+i].desc.mask, SPEED, { _xscale:100, _yscale:100, ease:EASE });
			} else {
				// scale, opacity, glow, saturation, hue
				TweenFilterLite.to(_scope["icon"+i].img, SPEED, { _xscale:_scope["icon"+i].img.ox, _yscale:_scope["icon"+i].img.oy, _alpha:85, glowFilter:{ alpha:0 }, colorMatrixFilter:{ saturation:.6, brightness:.9 }, ease:EASE });
			}
		}
	}
	
	private function mcRollOut(o:Object):Void {
		
		for(var i:Number = 0; i < 2; i++) {
			if(i == o.data.id) {
				// scale, opacity, glow, saturation, hue
				TweenFilterLite.to(_scope["icon"+i].img, SPEED, { _xscale:_scope["icon"+i].img.ox, _yscale:_scope["icon"+i].img.oy, _alpha:100, glowFilter:{ alpha:0 }, colorMatrixFilter:{ }, ease:EASE });
		
				// tween description
				TweenFilterLite.to(_scope["icon"+i].desc.bg, SPEED, { _width:10, _height:10, _alpha:0, glowFilter:{ alpha:0 }, ease:EASE });
				TweenFilterLite.to(_scope["icon"+i].desc.mask, SPEED, { _width:10, _height:10, ease:EASE });
			} else {
				// scale, opacity, glow, saturation, hue
				TweenFilterLite.to(_scope["icon"+i].img, SPEED, { _xscale:_scope["icon"+i].img.ox, _yscale:_scope["icon"+i].img.oy, _alpha:100, glowFilter:{ alpha:0 }, colorMatrixFilter:{ }, ease:EASE });
			}
		}
	}
}
	
	