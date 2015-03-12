/**
 *	Main Class
 *
 *	@langversion ActionScript 3.0
 *	@playerversion 9.0
 *	@since 2010-07-09                      
 *	@author Junie Threatt
 *	@version 1.0.0
 *
 *	all code copyright (c) 2010 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 *	
 */

package
{
	// import internal
	import flash.display.*;
	import flash.utils.*;
	
	
	// import external
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	
	public class Main extends MovieClip
	{
		//---------------------------------------------------------------------
		// variables
		//---------------------------------------------------------------------
		private var _scope:MovieClip;
		private var _numOfClips:Number;
		private var _clipArray:Array;
		
		private static var SPEED:Number = .7;
		private static var EASE:Function = Expo.easeIn;
		
		
		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function Main(scope:MovieClip, numOfClips:Number)
		{
			_scope			= scope;
			_numOfClips		= numOfClips;
			_clipArray		= [];
			
			TweenPlugin.activate([BlurFilterPlugin]);
			
			initCollapsed();
			initClips();
		};
		
		
		//---------------------------------------------------------------------
		// private methods and handlers
		//---------------------------------------------------------------------
		private function initClips():void
		{
			var mc:MovieClip;
			for(var i:Number = 0; i < _numOfClips; i++)
			{
				mc = MovieClip(_scope.getChildByName("clip"+i));
				
				mc.rot 		= randRange(1, 55);										// rotation
				mc.blurx	= randRange(3, 26);										// x blur
				mc.blury 	= randRange(3, 26);										// y blur
				mc.scalex 	= randRange(80, 150) / 100;								// x scale
				mc.tox 		= _scope.collapsed.x + 150; 	// randRange(720, 950);			// _x range
				mc.toy 		= _scope.collapsed.y + 150; 	// randRange(350, 530);			// _y range
								
				// set some rotations negative
				mc.rot = (mc.rot % 2) ? 0 -mc.rot : mc.rot;
				
				_clipArray[i] = mc;
			};
			
			animateClips();
			
			var imgInterval:Number = setTimeout(animateImgs, 1000);
			var logoInterval:Number = setTimeout(animateLogo, 4000);
		};
		
		
		private function initCollapsed():void
		{
			var mc:MovieClip = _scope.collapsed.headline0;
			TweenMax.from(mc, SPEED, { x:-5-mc.width, blurFilter:{ blurX:55, blurY:5 }, ease:Cubic.easeOut });
		};
		
		
		private function animateClips():void
		{
			var mc:MovieClip;
			var dlay:Number = 1;
			for(var i:Number = 0; i < _numOfClips; i++)
			{
				mc = getClip(randRange(0, _clipArray.length-1));
				TweenMax.to(mc, SPEED, { x:mc.tox, y:mc.toy, scaleX:mc.scalex, rotation:mc.rot, blurFilter:{ blurX:mc.blurx, blurY:mc.blury }, delay:dlay, ease:EASE });
				TweenMax.to(mc, SPEED, { alpha:0, delay:dlay+.2, ease:Expo.easeIn });
				
				// onComplete:checkDone, onCompleteScope:this, onCompleteParams:[i]
				// dlay += (i < _numOfClips / 4) ? .4 : (i < _numOfClips / 3) ? .3 : (i < _numOfClips / 2) ? .2 : .1;
				
				dlay += .08;
			};
		};
		
		
		private function animateImgs():void
		{
			var mc:MovieClip;
			var dlay:Number = 0;
			for(var i:Number = 0; i < 7; i++)
			{
				mc = MovieClip(_scope.getChildByName("img"+i));
				
				var rot:Number 		= randRange(10, 55);
				var blurx:Number 	= randRange(3, 10);
				var blury:Number 	= randRange(3, 10);
				var scale:Number 	= randRange(10, 40) / 100;
				var tox:Number 		= _scope.collapsed.x + (_scope.collapsed.width / 2);
				var toy:Number 		= _scope.collapsed.y + (_scope.collapsed.height / 2);
				
				if(i == 0)
				{
					var logo:MovieClip = _scope.logo;
					logo.rot 		= rot;
					logo.blurx 		= blurx;
					logo.bluey 		= blury;
					logo.scale 		= scale;
					logo.tox 		= tox;
					logo.toy 		= toy;
				};
				
				dlay = randRange(20, 80) / 100;
				
				TweenMax.to(mc, SPEED, { rotation:rot, blurFilter:{ blurX:blurx, blurY:blury }, scaleX:scale, scaleY:scale, x:tox, y:toy, delay:dlay, ease:EASE });
				TweenMax.to(mc, SPEED, { alpha:0, delay:dlay+.3, ease:Expo.easeIn });
			};
		};
		
		
		private function animateLogo():void
		{
			var logo:MovieClip = _scope.logo;
			TweenMax.to(logo, SPEED, { rotation:logo.rot, blurFilter:{ blurX:logo.blurx, blurY:logo.blury }, scaleX:logo.scale, scaleY:logo.scale, x:logo.tox, y:logo.toy, ease:EASE });
			TweenMax.to(logo, SPEED, { alpha:0, delay:.3, ease:Expo.easeIn });
		};
		
		
		private function getClip(num:Number):MovieClip
		{
			var mc:MovieClip = _clipArray[num];
			_clipArray.splice(num, 1);
			return mc;
		};
		
		
		private function randRange(min:Number, max:Number):Number
		{
			return Math.floor( Math.random() * ( 1 + max - min )) + min;
		};
		
		
	};
	
}; // end