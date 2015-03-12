
// GameLauncher.as
// created by Junie Threatt
// on 08-18-2008

import classes.tweening.TweenFilterLite;
import classes.tweening.Back;
import classes.tweening.Expo;
import classes.utils.EventManager;

class views.GameLauncher extends MovieClip {
	
	// private properties
	private var _id:Number;
	
	// static properties
	private static var SPEED:Number = .5;
	
	// contructor
	public function GameLauncher() { };
	
	// show horizontal line
	public function revealHorzLine(mc:MovieClip):Void {
		TweenFilterLite.to(mc, 1, { _x:0, ease:Expo.easeOut });
	}
	
	// show instructions
	public function revealInstructions(mc:MovieClip):Void {
		TweenFilterLite.from(mc, SPEED, { _y:mc._y-mc._height-30, ease:Back.easeOut });
	}

	// show icons then set handlers
	public function revealIcons(mc0:MovieClip, mc1:MovieClip, mc2:MovieClip):Void {
		TweenFilterLite.from(mc0, SPEED, { _y:mc0._y + 200, ease:Back.easeOut });
		TweenFilterLite.from(mc1, SPEED, { _y:mc1._y + 200, ease:Back.easeOut });
		TweenFilterLite.from(mc2, SPEED, { _y:mc2._y + 200, ease:Back.easeOut });
		setHandlers(mc0, mc2);
	}
	
	// set icon handlers
	private function setHandlers(mc0:MovieClip, mc1:MovieClip):Void {
		
		mc0.img.ox = mc0.img._xscale;
		mc0.img.oy = mc0.img._yscale;
		
		mc1.img.ox = mc1.img._xscale;
		mc1.img.oy = mc1.img._yscale;
		
		mc0.onRollOver = function():Void {
			EventManager.dispatchEvent("onIconRollOver", { id:0 });
		};
		
		mc0.onRollOut = function():Void {
			EventManager.dispatchEvent("onIconRollOut", { id:0, ox:this.img.oxScale, oy:this.img.oyScale });
		};
		
		mc0.onRelease = function():Void {
			EventManager.dispatchEvent("onShoeRelease", { id:0 });
			EventManager.dispatchEvent("onChangeIcon", { id:0 });
		};
		
		mc1.onRollOver = function():Void {
			EventManager.dispatchEvent("onIconRollOver", { id:1 });
		};
		
		mc1.onRollOut = function():Void {
			EventManager.dispatchEvent("onIconRollOut", { id:1, ox:this.img.oxScale, oy:this.img.oyScale });
		};
		
		mc1.onRelease = function():Void {
			EventManager.dispatchEvent("onGiftRelease", { id:1 });
			EventManager.dispatchEvent("onChangeIcon", { id:0 });					
		};
	}
	
	
	/*
	public function get id():Number {
		return _id;
	}
	
	public function set id(id:Number):Void {
		_id = id;
	}
	*/
}

