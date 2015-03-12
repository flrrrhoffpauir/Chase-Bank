/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;

class StandardV3 extends Engine {

		private function StandardV3 ( scope ) 
		{
			super ( scope ) ;
		}
		
		public static function create ( scope : MovieClip ) {

			instance = new StandardV3(scope);
			return instance;
		}

		private function introThatBoughtTheFish ( ) : Void
		{
			elementRegularIntro (thatBoughtTheFish, {exitFunction:exitThatBoughtTheFish}) ;
			
			_global.setTimeout( Proxy.create(this, introThatLedToTheNewBook), 2300) ;
			_global.setTimeout ( Proxy.create(this, finalFrame ), 2400) ;
		}
		
}

