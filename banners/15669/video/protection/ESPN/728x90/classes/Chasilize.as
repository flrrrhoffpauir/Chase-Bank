//
//  Chasilize.as
//
//  Created by Junie Threatt on 2008-02-26.
//  Copyright (c) 2008 T3. All rights reserved.
//

class Chasilize {
		
	public function Chasilize() {
		trace("");
	};
	
	public function initPortals(prefix:String, numberOfPortals:Number, xPos:Number, yPos:Number, range:Number, offSet:Number, scale:Boolean, alpha:Boolean):Array {
		
		var ta:Array	 	= [];							// create temp array
		var mc:MovieClip								// create temp movie clip
		
		for(var i:Number = 0; i < numberOfPortals; i++) {
			mc		= eval(prefix + i);					// find portal clip
			mc.dlay		= random(9) / 10;					// tween delay
			mc.ns 		= (scale == true) ? randomRange(0, 100) : mc._xscale;	// new scale
			mc.na		= (alpha == true) ? randomRange(0, 100) : mc._alpha;	// new alpha			
			
			if(i % 2 == 0) {
				mc.m 	= "yes: ";
				mc.nx 	= offSet + randomRange(xPos-range, xPos+range);		// new x pos
				mc.ny 	= offSet + randomRange(yPos, yPos+range);		// new y pos
			} else {
				mc.m 	= " no: ";
				mc.nx 	= offSet + randomRange(xPos, xPos+range);		// new x pos
				mc.ny 	= offSet + randomRange(yPos-range, yPos+range);		// new y pos
			};
			
			ta.push(mc);
			
			// trace(mc.m + "(" + mc.nx + ", " + mc.ny + ")");
		};
		return ta; // return temp array
	};
	
	private function randomRange(minNum:Number, maxNum:Number):Number {
		
		// returns a random number within a range
		
		var randomNum = Math.floor(Math.random() * (maxNum - minNum) + minNum);
		return randomNum;		
	};
	
	public function tweenPortals(portalArray:Array, speed:Number):Void {
		
		// iterate through portals and tween them to new coordinates
		
		var tl:Number = portalArray.length;
		var mc:MovieClip;
		
		for(var i:Number = 0; i < tl; i++) {
			
			mc 		= portalArray[i];
			mc._xscale 	= mc._yscale = mc.ns; // set width/height to new scale
			mc._alpha 	= mc.na;
			
			TweenLite.to(mc, speed, { _x:mc.nx, _y:mc.ny, delay:mc.dlay});			
		};
	};
	
	public function addStaticPortals(prefix:String, num:Number):Void {
		
		// takes num of portals and tweens them to _alpha:100
		var mc:MovieClip;
		
		for(var i:Number = 0; i < num; i++) {
			
			mc = eval(prefix + i);
			mc.dlay = random(9) / 10;
			TweenLite.to(mc, .5, { _alpha:100, delay:mc.dlay });
		};
	};
};