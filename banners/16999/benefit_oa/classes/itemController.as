
import classes.tweening.TweenLite;
import classes.tweening.Expo;
import mx.utils.Delegate;
import events.EventManager;
import events.Events;

class itemController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _totalItems:Number = 3;
	
	private var _overMC:MovieClip;		// roll over item
	private var _outMC:MovieClip;		// roll out item
	
	private var _overCopy:MovieClip;	// roll over copy
	private var _outCopy:MovieClip;		// roll out copy
	
	private var _overName:MovieClip;	// roll over item name
	private var _outName:MovieClip;		// roll out item name
	
	// public properties
	public var item0:MovieClip;
	public var item1:MovieClip;
	public var item2:MovieClip;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	private static var FADE_ALPHA:Number = 50;
	
	public function itemController(scope:MovieClip) {
		
		_scope = scope;
		
		EventManager.addEventListener(Events.ROLL_OVER, this, "rollOverItem");
		EventManager.addEventListener(Events.ROLL_OUT, this, "rollOutItem");
		EventManager.addEventListener(Events.RELEASE, this, "releaseItem");
			
		setHandlers();
	};
	
	private function setHandlers():Void {
		var mc:MovieClip;
		for(var i:Number = 0; i < _totalItems; i++)  {
			
			mc = _scope["item"+i].img;
			mc.xs = mc._xscale;
			mc.ys = mc._yscale;
			
			mc.onRollOver 	= function():Void { EventManager.dispatchEvent(Events.ROLL_OVER, { mc:this, xScale:this.xs, yScale:this.ys }); };
			mc.onRollOut 	= function():Void { EventManager.dispatchEvent(Events.ROLL_OUT, { mc:this, xScale:this.xs, yScale:this.ys }); };
			mc.onRelease 	= function():Void { EventManager.dispatchEvent(Events.RELEASE, { }); };
		};
	};
	
	private function rollOverItem(o:Object):Void {
		for(var i:Number = 0; i < _totalItems; i++)  {
			
			_overMC 	= _scope["item"+i].img;
			_overCopy 	= _scope["ro"+i];
			_overName	= _scope["item"+i].txt;
			
			if(o.data.mc != _overMC) {
				TweenLite.to(_overMC, SPEED, { _xscale:_overMC.xs, _yscale:_overMC.ys, _alpha:FADE_ALPHA, ease:EASE });
				TweenLite.to(_overCopy, SPEED, { _alpha:0, ease:EASE });
				TweenLite.to(_overName, SPEED, { _alpha:FADE_ALPHA });
			} else {
				TweenLite.to(o.data.mc, SPEED, { _xscale:100, _yscale:100, _alpha:100, ease:EASE });
				TweenLite.to(_overCopy, SPEED, { _alpha:100, ease:EASE });
				TweenLite.to(_overName, SPEED, { _alpha:100 });
			};
		};
		
		TweenLite.to(_scope["instructions"], SPEED, { _alpha:0, ease:EASE });
	};
	
	private function rollOutItem(o:Object):Void {
		for(var i:Number = 0; i < _totalItems; i++) {
			
			_outMC 		= _scope["item"+i].img;
			_outCopy 	= _scope["ro"+i];
			_outName	= _scope["item"+i].txt;
			
			TweenLite.to(_outMC, SPEED, { _xscale:_outMC.xs, _yscale:_outMC.ys, _alpha:100, ease:EASE });
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