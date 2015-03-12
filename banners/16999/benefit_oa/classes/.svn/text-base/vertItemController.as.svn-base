
import classes.tweening.TweenLite;
import classes.tweening.Expo;
import mx.utils.Delegate;
import events.EventManager;
import events.Events;

class vertItemController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _totalItems:Number = 3;
	
	private var _overMC:MovieClip;		// roll over item
	private var _outMC:MovieClip;		// roll out item
	
	private var _overCopy:MovieClip;	// roll over copy
	private var _outCopy:MovieClip;		// roll out copy
	
	private var _overName:MovieClip;	// roll over item name
	private var _outName:MovieClip;		// roll out item name
	
	private var _distArray:Array;
	private var _flag:Boolean;
	
	// public properties
	public var item0:MovieClip;
	public var item1:MovieClip;
	public var item2:MovieClip;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	private static var FADE_ALPHA:Number = 50;
	
	public function vertItemController(scope:MovieClip, dist:Array, flag:Boolean) {
		
		_scope = scope;		
		_distArray = dist;
		_flag = flag;		// 160x600 offer is an exception
		
		EventManager.addEventListener(Events.ROLL_OVER, this, "rollOverItem");
		EventManager.addEventListener(Events.ROLL_OUT, this, "rollOutItem");
		EventManager.addEventListener(Events.RELEASE, this, "releaseItem");
			
		setHandlers();
	};
	
	private function setHandlers():Void {
		var mc:MovieClip;
		var mc2:MovieClip;
		for(var i:Number = 0; i < _totalItems; i++)  {
			
			mc = _scope["item"+i];
			mc.id = i;
			mc.iy = mc._y; 		// initial _y
			
			mc2 = _scope["item"+i].img;
			mc2.xs = mc2._xscale;
			mc2.ys = mc2._yscale;
			
			mc.onRollOver 	= function():Void { EventManager.dispatchEvent(Events.ROLL_OVER, { id:this.id, mc:this, xScale:this.img.xs, yScale:this.img.ys, yOrig:this.iy }); };
			mc.onRollOut 	= function():Void { EventManager.dispatchEvent(Events.ROLL_OUT, { id:this.id, mc:this, xScale:this.img.xs, yScale:this.img.ys, yOrig:this.iy }); };
			mc.onRelease 	= function():Void { EventManager.dispatchEvent(Events.RELEASE, { }); };
		};
	};
	
	private function rollOverItem(o:Object):Void {
		for(var i:Number = 0; i < _totalItems; i++)  {
					
			_overMC 	= _scope["item"+i];
			_overCopy 	= _scope["ro"+i];
			_overName	= _scope["item"+i].txt;

			if(o.data.id == 0 && o.data.mc == _overMC) {

				fadeInItem(_overMC, _overCopy, _overName, _distArray[0]);
				fadeOutItem(_scope["item"+1], _scope["item"+1].iy, _scope["item"+2], _scope["item"+2].iy);
			};
			
			if(o.data.id == 1 && o.data.mc == _overMC) {
				
				/*
				TweenLite.to(_overMC, SPEED, { _y:_overMC.iy-50, ease:EASE });
				TweenLite.to(_overMC.img, SPEED, { _xscale:100, _yscale:100, _alpha:100, ease:EASE });
				TweenLite.to(_overCopy, SPEED, { _alpha:100, ease:EASE });
				TweenLite.to(_overName, SPEED, { _alpha:100 });
				*/

				fadeInItem(_overMC, _overCopy, _overName, _distArray[1]);
				fadeOutItem(_scope["item"+0], _scope["item"+0].iy-70, _scope["item"+2], _scope["item"+2].iy);
			};
			
			if(o.data.id == 2 && o.data.mc == _overMC) {
				
				// flag is true, this is the 160x600 offer and needs to be treated in a different way
				if(_flag == true) {
					fadeInItem(_overMC, _overCopy, _overName, _distArray[2]);
					fadeOutItem(_scope["item"+0], _scope["item"+0].iy-90, _scope["item"+1], _scope["item"+1].iy-95);
				} else {	
					fadeInItem(_overMC, _overCopy, _overName, _distArray[2]);
					fadeOutItem(_scope["item"+0], _scope["item"+0].iy-70, _scope["item"+1], _scope["item"+1].iy-70);
				}
			};
		};
		
		TweenLite.to(_scope["instructions"], SPEED, { _alpha:0, ease:EASE });
	};
	
	private function fadeInItem(mc:MovieClip, ocopy:MovieClip, oname:MovieClip, dist:Number):Void {
		
		TweenLite.to(mc, SPEED, { _y:mc.iy-dist, ease:EASE });
		TweenLite.to(mc.img, SPEED, { _xscale:100, _yscale:100, _alpha:100, ease:EASE });
		TweenLite.to(ocopy, SPEED, { _alpha:100, ease:EASE });
		TweenLite.to(oname, SPEED, { _alpha:100 });
	};
	
	private function fadeOutItem(mc0:MovieClip, pos0:Number, mc1:MovieClip, pos1:Number):Void {
		
		TweenLite.to(mc0, SPEED, { _y:pos0, ease:EASE });
		TweenLite.to(mc0.img, SPEED, { _xscale:mc0.img.xs, _yscale:mc0.img.ys, _alpha:FADE_ALPHA, ease:EASE });
		TweenLite.to(mc0.txt, SPEED, { _alpha:FADE_ALPHA, ease:EASE });
		
		TweenLite.to(mc1, SPEED, { _y:pos1, ease:EASE });
		TweenLite.to(mc1.img, SPEED, { _xscale:mc1.img.xs, _yscale:mc1.img.ys, _alpha:FADE_ALPHA, ease:EASE });
		TweenLite.to(mc1.txt, SPEED, { _alpha:FADE_ALPHA, ease:EASE });
	};
	
	private function rollOutItem(o:Object):Void {
		for(var i:Number = 0; i < _totalItems; i++) {
			
			_outMC 		= _scope["item"+i];
			_outCopy 	= _scope["ro"+i];
			_outName	= _scope["item"+i].txt;
			
			TweenLite.to(_outMC, SPEED, { _y:_outMC.iy, ease:EASE });
			TweenLite.to(_outMC.img, SPEED, { _xscale:_outMC.img.xs, _yscale:_outMC.img.ys, _alpha:100, ease:EASE });
			TweenLite.to(_outCopy, SPEED, { _alpha:0, ease:EASE });
			TweenLite.to(_outName, SPEED, { _alpha:100 });
		};
		
		TweenLite.to(_scope["instructions"], SPEED, { _alpha:100, ease:EASE });
	};
	
	private function releaseItem():Void {
		
		// there is another click tag in the shared code file
		
		getURL(_root.clickTag, "_blank");
	};
}