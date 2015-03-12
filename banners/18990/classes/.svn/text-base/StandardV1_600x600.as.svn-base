/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-10
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV1_600x600 extends Engine {
	
	private function StandardV1_600x600 ( scope )
	{

		super(scope);
	}
	
	public static function create(scope:MovieClip) {
		
		instance = new StandardV1_600x600(scope);
		return instance;
	}
	
	
	private function endFrame ( ) : Void
	{
		var padding = 8;
		var delay = 0.5
		var speed = 0.8;
		
		introducingInkFromChase._y = introducingInkFromChase._y + padding + learnMore._height;
		
		TweenLite.to ( inkMeansPoints, speed, {_y : 118, delay: delay } ) ;
		TweenLite.to ( chaseCard, speed, {_y : 335, delay: delay } ) ;
		TweenLite.to ( introducingInkFromChase, speed, {_y : 352, _alpha : 100, delay: delay } ) ;
		TweenLite.to ( learnMore, speed, { _alpha : 100, delay : delay });
		
	}
	

}