/**
 *	Collapsed Class
 *
 *	@langversion ActionScript 3.0
 *	@playerversion 9.0
 *	@since 2010-07-15                     
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
	import com.greensock.easing.*;
	
	
	public class Collapsed extends MovieClip
	{
		//---------------------------------------------------------------------
		// variables
		//---------------------------------------------------------------------
		private var _scope:MovieClip;
		
		private static var SPEED:Number = .7;
		private static var EASE:Function = Expo.easeIn;
		
		
		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function Collapsed(scope:MovieClip)
		{
			_scope = scope;
			
			init();
		};
		
		
		//---------------------------------------------------------------------
		// private methods and handlers
		//---------------------------------------------------------------------
		private function init():void
		{
			var mc:MovieClip;
			for(var i:Number = 1; i < 6; i++)
			{
				mc = MovieClip(_scope.collapsed.getChildByName("headline"+i));
				mc.alpha = 0;
			};
			
			animate();
		};
		
		
		private function animate():void
		{
			var mc:MovieClip;
			var dlay:Number = 0;
			
			var ribbonInterval:Number = setTimeout(playRibbon, 500);
			
			for(var i:Number = 0; i < 6; i++)
			{
				mc = MovieClip(_scope.collapsed.getChildByName("headline"+i));
				if(i == 0)
				{
					TweenMax.to(mc, .5, { alpha:0, delay:dlay, ease:EASE });
				} else {
					mc.alpha = 1;
					TweenMax.from(mc, .5, { x:-20-mc.width, delay:dlay+.2, ease:Expo.easeOut });
					dlay += .2;
				};
			};
		};
		
		
		private function playRibbon():void
		{
			_scope.collapsed.bow.gotoAndPlay("animate");
		};
		
		
	};
	
}; // end