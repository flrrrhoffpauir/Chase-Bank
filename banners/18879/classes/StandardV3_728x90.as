/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV3_728x90 extends Engine {

		private function StandardV3_728x90 ( scope ) 
		{
			super ( scope ) ;
		}
		
		public static function create ( scope : MovieClip ) {

			instance = new StandardV3_728x90(scope);
			return instance;
		}

		private function introThatBoughtTheFish ( ) : Void
		{
			elementRegularIntro (thatBoughtTheFish, {exitFunction:exitThatBoughtTheFish}) ;
			_global.setTimeout( Proxy.create(this, introThatLedToTheNewBook), 2300) ;
			_global.setTimeout ( Proxy.create(this, finalFrame ), 2400) ;
		}
		
		private function finalFrame ( ) : Void
		{
		
			moveOffScreen ( introducingEnd, "top", true );
			//blurItem(introducingCard, 30, 0)
			TweenLite.to ( introducingEnd, 0.3, { 	_y : objectRecorder["introducingEndY"], 
														ease:Sine.easeIn,
														delay: 2.5,
														onComplete: Proxy.create( this, introCardEnd )
														 });

			
			

		}
		
}

