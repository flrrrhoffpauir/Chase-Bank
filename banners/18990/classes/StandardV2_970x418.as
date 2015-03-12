/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV2_970x418 extends Engine {
	
		
		
		private function StandardV2_970x418 ( scope ) 
		{
			super ( scope ) ;
		}
		
		public static function create ( scope : MovieClip ) {

			instance = new StandardV2_970x418(scope);
			return instance;
		}
		
		private function inkMeansPointsSection ( ) : Void
		{
			
			TweenLite.to ( inkMeansBusiness , 0.4 , {_alpha  : 0, delay : 0.7})
			TweenLite.to ( underline , 0.4 , {_alpha  : 0, delay : 0.7})
			TweenLite.to ( inkMeansPoints , 1 , {_alpha  : 100, delay : 1, onComplete : Proxy.delegate ( this, playInkMeansPoints ) } ) ;
			
		}
		
		private function playInkMeansPoints ( ) : Void
		{
			inkMeansPoints.gotoAndPlay(2);
			inkMeansPoints.onEnterFrame = Proxy.delegate( this, checkInkMeansAnimation);
		}
		
		private function endFrame ( ) : Void
		{
			var padding = 8;
			var delay = 0.5
			var speed = 0.8;
			
			introducingInkFromChase._y = introducingInkFromChase._y + padding + learnMore._height;
			
			TweenLite.to ( inkMeansPoints, speed, {_y : inkMeansPoints._y - 20, delay: delay } ) ;
			TweenLite.to ( chaseCard, speed, {_y : chaseCard._y - 20, delay: delay } ) ;
			TweenLite.to ( introducingInkFromChase, speed, {_y : introducingInkFromChase._y - learnMore._height - padding, _alpha : 100, delay: delay } ) ;
			TweenLite.to ( learnMore, speed, { _alpha : 100, delay : delay });
			
		}
		
		private function onCloseHandler():Void
		{
			//getURL(_urlTarget, "_blank");
			trace("close clicked")
		}

		
		
}
