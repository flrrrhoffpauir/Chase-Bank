/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV1_468x60 extends Engine {
	

	
		private function StandardV1_468x60 ( scope ) 
		{
			super ( scope ) ;
		}
		
		public static function create ( scope : MovieClip ) {

			instance = new StandardV1_468x60(scope);
			return instance;
		}
		
		private function inkMeansPointsSection ( ) : Void
	{
		TweenLite.to ( inkMeansBusiness , 0.4 , {_alpha  : 0, delay : 0.7})
		TweenLite.to ( underline , 0.4 , {_alpha  : 0, delay : 0.7})
		TweenLite.to ( inkMeansPoints , 1 , {_alpha  : 100, delay : 1, onComplete : Proxy.delegate ( this, playInkMeansPoints ) } ) ;
		// TweenLite.to ( chaseCard, 0.5, {_x : 212, delay : 1 } ) ;
		TweenLite.to ( comparisonAsOf, 0.5, { _alpha : 100, delay : 1.5 })
		
	}
	
	private function endFrame ( ) : Void
	{
		var padding = 8;
		var delay = 0.5
		var speed = 0.8;
		
		//introducingInkFromChase._y = introducingInkFromChase._y + padding + learnMore._height;
		
		//TweenLite.to ( inkMeansPoints, speed, {_y : inkMeansPoints._y - learnMore._height - padding, delay: delay } ) ;
		TweenLite.to ( chaseCard, speed, {_x : 214 } ) ;
		TweenLite.to ( introducingInkFromChase, speed, { _alpha : 100, delay: delay } ) ;
		TweenLite.to ( learnMore, speed, { _alpha : 100, delay : delay });
		
	}
		
		
}


