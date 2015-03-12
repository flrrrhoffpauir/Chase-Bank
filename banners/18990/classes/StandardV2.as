/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV2 extends Engine {
	

	
		private function StandardV2 ( scope ) 
		{
			super ( scope ) ;
		}
		
		public static function create ( scope : MovieClip ) {

			instance = new StandardV2(scope);
			return instance;
		}
		
		private function inkMeansPointsSection ( ) : Void
		{
			TweenLite.to ( inkMeansBusiness , 0.4 , {_alpha  : 0, delay : 0.7})
			TweenLite.to ( underline , 0.4 , {_alpha  : 0, delay : 0.7})
			TweenLite.to ( inkMeansPoints , 1 , {_alpha  : 100, delay : 1, onComplete : Proxy.delegate ( this, playInkMeansPoints ) } ) ;
			
		}
		
		
}

