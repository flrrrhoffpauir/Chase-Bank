//
//  Chasilize.as
//
//  Created by Junie Threatt on 2008-02-08.
//  Copyright (c) 2008 T3. All rights reserved.
//

import utils.tweening.TweenLite;
import utils.tweening.Expo;

class utils.Chasilize {
	
	private var __scope:MovieClip;
	private var _tPortalInterval:Number;
	private var _bPortalInterval:Number;
	private var _tCount:Number;
	private var _bCount:Number;
	
	private var _tPortalArray:Array = [];
	private var _bPortalArray:Array = [];
	
	private var _numOfPortals:Number;
	private var _topPrefix:String;
	private var _botPrefix:String;
		
	public function Chasilize(_scope:MovieClip) {
		__scope = _scope;
		_tCount = _bCount = 0; // initialize the counts
	}
	
	public function tweenTopAndBotPortals(numOfPortals:Number, topPrefix:String, botPrefix:String):Void
	{
		_numOfPortals = numOfPortals; // number of portals on either side of stage
		_topPrefix = topPrefix; // top portals prefix
		_botPrefix = botPrefix; // bottom portals prefix
		
		// populate arrays
		generatePortalArray(_tPortalArray, _topPrefix);
		generatePortalArray(_bPortalArray, _botPrefix);
		
		// tween top and bottom portals
		// can't use setInterval in FP7
		startInterval(_tPortalInterval, "tweenTopPortals", 40);
		startInterval(_bPortalInterval, "tweenBotPortals", 40);
		//_global.setTimeout(this, "startInterval", 20, _tPortalInterval, "tweenTopPortals", 40);		
		//_global.setTimeout(this, "startInterval", 1000, _bPortalInterval, "tweenBotPortals", 40);
	}
	
	
	private function generatePortalArray(array:Array, prefix:String):Void {
		for(var i:Number = 0; i < _numOfPortals; i++) {
			var mc:MovieClip = eval(__scope + "." + prefix + i);
			array.push(mc);
		}
	}
	
	private function startInterval(interval:Number, f:String, t:Number):Void {
		clearInterval(interval);
		interval = setInterval(this, f, t);		
	}
	
	private function tweenTopPortals():Void {
		var mc:MovieClip 	= _tPortalArray[_tCount];
		// get a new scale, x, and y values
		mc.nscale 		= Math.random() * 100;
		
					// use a new x if you don't want them to go straight down
		// mc.nx 		= Stage.width - Math.ceil(Math.random() * 260 - 200);		
		mc.ny 			= Stage.height - Math.ceil(Math.random() * 150 - 170);
		
		TweenLite.to(mc, .5, {_x:mc.nx, _y:mc.ny, _xscale:mc.nscale, _yscale:mc.nscale, ease:Expo.easeOut});
		
		_tCount++;
		
		if(_tCount >= _numOfPortals) {
			clearInterval(_tPortalInterval);
		}
	
	}
	
	private function tweenBotPortals():Void {
		var mc:MovieClip 	= _bPortalArray[_bCount];
					// change the scale of the mc
		mc._xscale 		= mc._yscale = Math.round(Math.random() / 2 * 100);
		
		// if even
		if((_bCount % 2) == 0) {
			mc.nx 		= mc._x + Math.floor(-(Math.random() * Stage.width + Stage.width));
			mc.ny 		= mc._y + Math.floor(-(Math.random() * Stage.height + Stage.height));
			
		// or odd	
		} else {
			mc.nx 		= mc._x + Math.floor(-(Math.random() * Stage.width + (Stage.width / 2)));
			mc.ny 		= mc._y + Math.floor(-(Math.random() * Stage.height + (Stage.height / 2)));
		}
		
		TweenLite.to(mc, .8, {_x:mc.nx, _y:mc.ny, ease:Expo.easeOut});
		TweenLite.to(mc, 1, {_alpha: 0, overwrite: false, ease:Expo.easeOut});
		
		_bCount++;
		
		if(_bCount >= _numOfPortals) {
			clearInterval(_bPortalInterval);
		}
	}
	
	public function tweenStaticPortals(prefix:String, num:Number, dist:Number):Void {
		for(var i:Number = 0; i < num; i++) {
			
			var mc:MovieClip 	= eval(__scope + "." + prefix + i);
			mc._y 			-= dist;
			mc.ny 			= mc._y + dist;
			mc.dlay 		= random(9) / 10;
			
			TweenLite.to(mc, .5, {_y:mc.ny, delay:mc.dlay, ease:Expo.easeOut});
		}
	}
}