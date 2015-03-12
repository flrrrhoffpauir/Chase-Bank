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

class Engine extends MovieClip {

		public static var instance : Engine;
		private var objectRecorder : Object;
		private var STAGE_WIDTH : Number = 300;
		private var STAGE_HEIGHT : Number = 250;
		private var ENDFRAME_PULLUP : Boolean = false;
		private var _learnMoreActive : Boolean;
		private var _urlTarget : String ;
		
		//Movieclips on stage
		private var inkLogo;
		private var thisIsTheBusinessCard;
		private var thatBoughtTheFish;
		private var thatLedToTheNewBook;
		private var thatBroughtInMorePeople;
		private var introducingCard;
		private var creditLimitsThat;
		private var introducingEnd;
		private var cardEnd;
		private var writeYourOwn;
		
		private var chaseCard;
		
		private var comparisonAsOf;
		private var underline;
		private var underlineMask;
		private var inkMeansBusiness;
		private var inkMeansPoints;
		private var introducingInkFromChase;
		
		private var inkMeansBusinessMask;
		
		
		private var learnMore;
		private var invisibleButton;
		
		private function Engine ( scope )
		{
			scope.__proto__ = this.__proto__;
			scope.__constructor__ = Engine;
			this = scope;
			setup();
			start()
		}
		
		public static function create(scope:MovieClip) {
			
			instance = new Engine(scope);
			return instance;
		}
		
		private function setup ( ) : Void
		{
			Stage.scaleMode = "noScale"
			Stage.showMenu = false;
			Stage.align = "TL";
			
			stop();
			
			objectRecorder = new Object;
			
			_learnMoreActive = false;
			_urlTarget = "";
			_urlTarget = _root.clickTAG;
			
			createBorder();
			createCTA ( ) ;
			
			recordStartPositionAndHideElement ( "learnMore" ) ;
			recordStartPositionAndHideElement ( "chaseCard");
			recordStartPositionAndHideElement ( "comparisonAsOf");
			recordStartPositionAndHideElement ( "underline");
			recordStartPositionAndHideElement ( "inkMeansBusiness");
			recordStartPositionAndHideElement ( "inkMeansPoints");
			recordStartPositionAndHideElement ( "introducingInkFromChase");
			

		}
		
		private function createBorder ( ) : Void
		{
			var border = new CreateBorder(this);
		}
		
		private function createCTA ( ) : Void
		{
			
			invisibleButton._width = STAGE_WIDTH;
			invisibleButton._height = STAGE_HEIGHT;
			invisibleButton.onRollOver = Proxy.delegate ( this, onRollOverCTAHandler ) ;
			invisibleButton.onRelease = Proxy.delegate  ( this, onReleaseCTAHandler ) ;
		}
		
		private function start ( ) : Void
		{
			chaseCard._y = chaseCard._y + Stage.height + chaseCard._height;
			chaseCard._alpha = 100;
			TweenLite.to ( chaseCard , 1 , {_alpha : 100, delay: 0.75, _y : objectRecorder["chaseCardY"] , onComplete : Proxy.delegate(this, inkMeansBusinessSection) })
			
			//TweenLite.to ( chaseCard , 0.5 , {_alpha : 100, delay: 0.75, onComplete : Proxy.delegate(this, inkMeansBusinessSection) })
		}
		
		private function inkMeansBusinessSection ( ) : Void
		{
			
			//setUpInkMeansBusiness();
			
				inkMeansBusiness._alpha = 100;
				inkMeansBusiness.ink._alpha = 0;
				inkMeansBusiness.means._alpha = 0;
				inkMeansBusiness.business._alpha = 0;
				
			inkMeansBusiness._y -= 4;
			
			TweenLite.to (inkMeansBusiness.ink, 0.5, { _alpha : 100 , delay : 0 } ) ;
			TweenLite.to (inkMeansBusiness.means, 0.5, { _alpha : 100 , delay : 0.50 } ) ;
			TweenLite.to (inkMeansBusiness.business, 0.5, { _alpha : 100 , delay : 1 } ) ;
			
			
			setUpUnderline() ;
			//TweenLite.to ( inkMeansBusinessMask , 1 , {_width : inkMeansBusiness._width})
			TweenLite.to ( underlineMask , 0.75 , {_width : underline._width, delay: 1.5, onComplete : Proxy.delegate ( this, inkMeansPointsSection) } );	
		}
		
		private function inkMeansPointsSection ( ) : Void
		{
			TweenLite.to ( inkMeansBusiness , 0.4 , {_alpha  : 0, delay : 0.7})
			TweenLite.to ( underline , 0.4 , {_alpha  : 0, delay : 0.7})
			TweenLite.to ( inkMeansPoints , 1 , {_alpha  : 100, delay : 1, onComplete : Proxy.delegate ( this, playInkMeansPoints ) } ) ;
			TweenLite.to ( chaseCard, 0.5, {_y : chaseCard._y - comparisonAsOf._height, delay : 1 } ) ;
			TweenLite.to ( comparisonAsOf, 0.5, { _alpha : 100, delay : 1.5 })
			
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
			
			TweenLite.to ( inkMeansPoints, speed, {_y : inkMeansPoints._y - learnMore._height - padding, delay: delay } ) ;
			TweenLite.to ( chaseCard, speed, {_y : chaseCard._y - learnMore._height - padding, delay: delay } ) ;
			TweenLite.to ( introducingInkFromChase, speed, {_y : introducingInkFromChase._y - learnMore._height - padding, _alpha : 100, delay: delay } ) ;
			if (ENDFRAME_PULLUP) {
				learnMore._y = STAGE_HEIGHT + learnMore._height;
				TweenLite.to ( learnMore, speed, { _alpha : 100, _y : objectRecorder["learnMoreY"], delay : delay });
			}else{
				learnMore._x = STAGE_WIDTH + learnMore._width;
				TweenLite.to ( learnMore, speed, { _alpha : 100, _x : objectRecorder["learnMoreX"], delay : delay });	
			}
			
		}
		
		private function checkInkMeansAnimation ( ) : Void
		{
				if (inkMeansPoints._currentFrame == inkMeansPoints._totalFrames){
					delete inkMeansPoints.onEnterFrame;
					endFrame();
				} 
			
		}
		
		
		private function setUpInkMeansBusiness ( ) : Void
		{
			inkMeansBusinessMask = attachMovie("maskObject", "inkMeansBusinessMask", this.getNextHighestDepth() )
			inkMeansBusinessMask._x = inkMeansBusiness._x;
			inkMeansBusinessMask._y = inkMeansBusiness._y;
			inkMeansBusinessMask._width = 1;
			inkMeansBusiness.setMask(inkMeansBusinessMask);
			inkMeansBusiness._alpha = 100;
			inkMeansBusiness._y -= 4;
		}
		
		private function setUpUnderline ( ) : Void
		{
			underlineMask = attachMovie("maskObject", "underlineMask", this.getNextHighestDepth() ) ;
			underlineMask._x = underline._x;
			underlineMask._y = underline._y;
			underlineMask._width = 1;
			underline.setMask(underlineMask);
			underline._alpha = 100;
			
		}

		private function activateCTA ( ) : Void
		{
			_learnMoreActive = true;
			learnMore.gotoAndPlay(2);
			cardEnd.gotoAndPlay(2);
		}
		
		// ________________________________________ EVENTS
		private function onRollOverCTAHandler ( ) : Void
		{
			if (_learnMoreActive && learnMore._currentFrame == 1) {
				learnMore.gotoAndPlay(2);
			}
			if (_learnMoreActive && cardEnd._currentFrame == 1) {
				cardEnd.gotoAndPlay(2);
			}
		}
		
		private function onReleaseCTAHandler ( ) : Void
		{
			getURL(_urlTarget, "_blank");
		}
		
		// ________________________________________ INTERNAL UTILS
		
		



		
		private function recordStartPositionAndHideElement ( theElement ) : Void
		{
			objectRecorder[theElement + "X"] = this[theElement]._x;
			objectRecorder[theElement + "Y"] = this[theElement]._y;
			
			this[theElement]._alpha = 0;
		}

}