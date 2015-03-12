/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV2_300x250 extends Engine {
	
		//Special image for this version
		private var airplane : MovieClip ;
		private var comparissionAsOf : MovieClip
	
		private function StandardV2_300x250 ( scope ) 
		{
			super ( scope ) ;
		}
		
		public static function create ( scope : MovieClip ) {

			instance = new StandardV2_300x250(scope);
			return instance;
		}
		
		private function setup ( ) : Void
		{
			super.setup();
			recordStartPositionAndHideElement ( "airplane");
			recordStartPositionAndHideElement ( "comparissionAsOf");
		}

		private function introThatBoughtTheFish ( ) : Void
		{
			elementRegularIntro (thatBoughtTheFish, {exitFunction:exitThatBoughtTheFish}) ;
			
			animateAirplane();
			_global.setTimeout( Proxy.create(this, introThatLedToTheNewBook), 2300) ;
			_global.setTimeout ( Proxy.create(this, finalFrame ), 2400) ;
		}
		
		private function animateAirplane  ( ) : Void
		{
			blurItem(airplane, 30, 30);
			airplane._x = -(airplane._width);
			airplane._y = STAGE_HEIGHT + airplane._height;
			airplane._alpha = 100;
			TweenLite.to ( airplane, 0.5, { 	_x : objectRecorder["airplaneX"], 
													_y : objectRecorder["airplaneY"], 
													blurFilter:{blurX:0, blurY: 0,remove:true},
													ease:Sine.easeOut
													 });
		}
		
		private function exitThatBoughtTheFish ( ) : Void
		{
			super.exitThatBoughtTheFish();
			TweenLite.to ( airplane, 0.5, { 	_x : STAGE_WIDTH + airplane._width, 
													_y : -(airplane._height), 
													blurFilter:{blurX:30, blurY: 30},
													ease:Sine.easeIn
													 });
		}
		
		private function introLearnMore ( ) : Void
		{
			super.introLearnMore();
			TweenLite.to ( comparissionAsOf, 1, {_alpha : 100, delay: 0.5 });
		}
		
}

