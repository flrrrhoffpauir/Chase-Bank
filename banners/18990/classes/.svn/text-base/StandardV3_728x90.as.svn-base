/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-10
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import gs.plugins.TweenPlugin;
import gs.easing.Sine;
import utils.Proxy;
import utils.CreateBorder;
import utils.TweenTracker;

class StandardV3_728x90 extends Engine {
	
	private function StandardV3_728x90 ( scope )
	{

		super(scope);
	}
	
	public static function create(scope:MovieClip) {
		
		instance = new StandardV3_728x90(scope);
		return instance;
	}
	
	private function inkMeansPointsSection ( ) : Void
	{
		TweenLite.to ( inkMeansBusiness , 0.4 , {_alpha  : 0, delay : 0.7})
		TweenLite.to ( underline , 0.4 , {_alpha  : 0, delay : 0.7})
		TweenLite.to ( inkMeansPoints , 1 , {_alpha  : 100, delay : 1, onComplete : Proxy.delegate ( this, playInkMeansPoints ) } ) ;
		//TweenLite.to ( chaseCard, 0.5, {_x : "-42", delay : 1 } ) ;
		
	}
	
	private function endFrame ( ) : Void
	{
		var padding = 8;
		var delay = 0.5
		var speed = 0.8;
		
		//introducingInkFromChase._y = introducingInkFromChase._y + padding + learnMore._height;
		
		//TweenLite.to ( inkMeansPoints, speed, {_y : inkMeansPoints._y - learnMore._height - padding, delay: delay } ) ;
		TweenLite.to ( comparisonAsOf, speed, { _alpha : 100, delay : delay })
		TweenLite.to ( chaseCard, speed, {_x : 376 } ) ;
		TweenLite.to ( introducingInkFromChase, speed, { _alpha : 100, delay: delay } ) ;
		TweenLite.to ( learnMore, speed, { _alpha : 100, delay : delay });
		
	}
	
	

}