/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV2_640x480 extends Engine {
	
		//Special image for this version
		private var airplane : MovieClip ;
	
		private function StandardV2_640x480 ( scope ) 
		{
			super ( scope ) ;
		}
		
		public static function create ( scope : MovieClip ) {

			instance = new StandardV2_640x480(scope);
			return instance;
		}
		
		private function setup ( ) : Void
		{
			super.setup();
			recordStartPositionAndHideElement ( "airplane");
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
		
		private function introCardEnd ( ) : Void
		{
			moveOffScreen ( cardEnd, "right", true );
			creditLimitsThat._alpha = 0;
			TweenLite.to ( cardEnd, 0.3, { 	_x : objectRecorder["cardEndX"], 
														ease:Sine.easeIn,
														onComplete: Proxy.create( this, introCreditLimitsThat )
														 });
		}
		
		private function introCreditLimitsThat ( ) : Void
		{
			creditLimitsThat._y = creditLimitsThat._y - (creditLimitsThat._height + 10 );
			TweenLite.to ( creditLimitsThat, 0.5, {_alpha: 100, _y : objectRecorder["creditLimitsThatY"], 
														ease:Sine.easeOut,
														delay: 0.2,
														onComplete : Proxy.create ( this, introWriteYourOwn)
														 });
		}
		
		private function finalFrame ( ) : Void
		{
		
			moveOffScreen ( introducingEnd, "top", true );
			TweenLite.to ( introducingEnd, 0.3, { 	_y : objectRecorder["introducingEndY"], 
														ease:Sine.easeIn,
														delay: 2.5,
														onComplete: Proxy.create( this, introCardEnd )
														 });
		
			
			

		}
		
		private function createCTA ( ) : Void
		{
			
			invisibleButton._width = STAGE_WIDTH;
			invisibleButton._height = STAGE_HEIGHT;
			//invisibleButton.onRollOver = Proxy.create ( this, onRollOverCTAHandler ) ;
			//invisibleButton.onRelease = Proxy.create  ( this, onReleaseCTAHandler ) ;
		}
		
}

