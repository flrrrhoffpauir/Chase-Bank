/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-10
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import gs.plugins.*;
import gs.easing.Sine;
import utils.Proxy;
import utils.CreateBorder;
import utils.TweenTracker;

class Engine extends MovieClip {

		public static var instance : Engine;
		private var objectRecorder : Object;
		private var STAGE_WIDTH : Number = 300;
		private var STAGE_HEIGHT : Number = 250;
		private var _learnMoreActive : Boolean;
		private var _urlTarget : String ;
		private var _tweenTracker : TweenTracker;
		
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
			Stage.align = "TL"
			
			_tweenTracker = TweenTracker.getInstance("standardBanners");
			
			
			TweenPlugin.activate([BlurFilterPlugin]);
			
			objectRecorder = new Object;
			
			_learnMoreActive = false;
			_urlTarget = "";
			_urlTarget = _root.clickTAG;
			
			createBorder();
			createCTA ( ) ;
			
			recordStartPositionAndHideElement ( "thisIsTheBusinessCard" ) ;
			recordStartPositionAndHideElement ( "thatBoughtTheFish" ) ;
			recordStartPositionAndHideElement ( "thatLedToTheNewBook" );
			recordStartPositionAndHideElement ( "thatBroughtInMorePeople");
			recordStartPositionAndHideElement ( "introducingEnd");
			recordStartPositionAndHideElement ( "cardEnd");
			recordStartPositionAndHideElement ( "creditLimitsThat");
			recordStartPositionAndHideElement ( "writeYourOwn");
			recordStartPositionAndHideElement ( "learnMore");
			
			
			for (var i in this ) {
				_tweenTracker.addTarget(this[i]);
			}
			
			_tweenTracker.killAll();
		}
		
		private function createBorder ( ) : Void
		{
			var border = new CreateBorder(this);
		}
		
		private function createCTA ( ) : Void
		{
			
			invisibleButton._width = STAGE_WIDTH;
			invisibleButton._height = STAGE_HEIGHT;
			invisibleButton.onRollOver = Proxy.create ( this, onRollOverCTAHandler ) ;
			invisibleButton.onRelease = Proxy.create  ( this, onReleaseCTAHandler ) ;
		}
		
		private function start ( ) : Void
		{
			elementRegularIntro (thisIsTheBusinessCard, {exitFunction:exitThisIsTheBusinessCard, delay: 1}) ;
		}
		
		
		
		private function introThatBoughtTheFish ( ) : Void
		{
			trace("------")
			elementRegularIntro (thatBoughtTheFish, {exitFunction:exitThatBoughtTheFish}) ;
			
			TweenLite.delayedCall(2.3, Proxy.create( this, introThatLedToTheNewBook ) ) ;
			TweenLite.delayedCall(4.6, Proxy.create( this, introThatBroughtInMorePeople ) ) ;
			TweenLite.delayedCall(5.5, Proxy.create( this, finalFrame ) ) ;	
			
		}
		
		private function exitThisIsTheBusinessCard ( ) : Void
		{
			elementRegularExit (thisIsTheBusinessCard , { onCompleteFunction: introThatBoughtTheFish, delay: 1})
		}
		
		private function exitThatBoughtTheFish ( ) : Void
		{
			
			elementRegularExit (thatBoughtTheFish)
		}
		
		private function introThatLedToTheNewBook ( ) : Void
		{
			
			elementRegularIntro (thatLedToTheNewBook, {exitFunction:exitThatLedToTheNewBook})
		}
		
		private function exitThatLedToTheNewBook ( ) : Void
		{
			elementRegularExit (thatLedToTheNewBook)
		}
		
		private function introThatBroughtInMorePeople ( ) : Void
		{
			
			elementRegularIntro (thatBroughtInMorePeople, {exitFunction:exitThatBroughtInMorePeople})
		}
		
		private function exitThatBroughtInMorePeople ( ) : Void
		{
			elementRegularExit (thatBroughtInMorePeople, {exitSpeed: 1.5})
		}
		
		
		
		private function finalFrame ( ) : Void
		{
		
			moveOffScreen ( introducingEnd, "top", true );
			TweenLite.to ( introducingEnd, 0.3, { 	_y : objectRecorder["introducingEndY"], 
														ease:Sine.easeIn,
														delay: 2.5,
														onComplete: Proxy.create( this, introCardEnd )
														 });
														
														
			TweenLite.to ( inkLogo, 0.7, { 	_x : -inkLogo._width, 
														blurFilter:{blurX:30, blurY: 0,remove:true},
														ease:Sine.easeIn,
														delay: 1.8
														 });
			

		}
		
		private function introCardEnd ( ) : Void
		{
			moveOffScreen ( cardEnd, "right", true );
			TweenLite.to ( cardEnd, 0.3, { 	_x : objectRecorder["cardEndX"], 
														ease:Sine.easeIn,
														onComplete: Proxy.create( this, introCreditLimitsThat )
														 });
		}
		
		private function introCreditLimitsThat ( ) : Void
		{
			creditLimitsThat._y = creditLimitsThat._y - (creditLimitsThat._height + 10 );
			creditLimitsThat._alpha = 100;
			TweenLite.to ( creditLimitsThat, 0.5, { _y : objectRecorder["creditLimitsThatY"], 
														ease:Sine.easeOut,
														delay: 0.2,
														onComplete : Proxy.create ( this, introWriteYourOwn)
														 });	
		}
		
		private function introWriteYourOwn ( ) : Void
		{
			
			writeYourOwn._xscale = 150;
			writeYourOwn._yscale = 150;
			TweenLite.to ( writeYourOwn, 0.2, { _alpha : 100, 
														_xscale : 100,
														_yscale : 100,
														ease:Sine.easeOut,
														delay: 0.2,
														onComplete : Proxy.create ( this, introLearnMore)
														 });
		}
		
		private function introLearnMore ( ) : Void
		{
			moveOffScreen( learnMore, "bottom", true)
			TweenLite.to ( learnMore, 0.5, { _y : objectRecorder["learnMoreY"], 
														ease:Sine.easeOut,
														delay: 0.2,
														onComplete : Proxy.create ( this, activateCTA)
														 });
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
		
		
		private function elementRegularIntro ( theElement : MovieClip , params : Object ) : Void
		{
			var exitFunction : Function;
			var exitSpeed : Number ;
			var delay : Number ;
			
			params.exitFunction ? exitFunction = params.exitFunction :exitFunction =  null ;
			params.exitSpeed ? exitSpeed = params.exitSpeed : exitSpeed = 2;
			delay = (params.delay) ? params.delay : 0;
			
			
			moveOffScreen ( theElement, "top", true );
			
			blurItem(theElement, 0, 30)
			TweenLite.to ( theElement, 0.4, { 	_y : objectRecorder[theElement._name+"Y"], 
														blurFilter:{blurX:0, blurY: 0,remove:true},
														ease:Sine.easeOut, 
														delay : delay
														 });
			_global.setTimeout(Proxy.create( this, exitFunction), (exitSpeed * 1000 ) ) ;
											
		}
		
		private function elementRegularExit ( theElement : MovieClip, params : Object ) : Void
		{
			var exitFunction : Function;
			var exitSpeed : Number ;
			var delay : Number ;
			var onCompleteFunction : Function;
			
			params.exitFunction ? exitFunction = params.exitFunction :exitFunction =  null ;
			params.exitSpeed ? exitSpeed = params.exitSpeed : exitSpeed = 0.6;
			delay = (params.delay) ? params.delay : 0;
			onCompleteFunction = (params.onCompleteFunction) ? params.onCompleteFunction : null;
			
			TweenLite.to(theElement, exitSpeed, {	_x:-(theElement._width+20),
														blurFilter:{blurX:20, blurY:0}, 
														ease:Sine.easeIn,
														delay : delay,
														onComplete : Proxy.create(this,onCompleteFunction)
														});
			
		}

		
		private function moveOffScreen ( theItem : MovieClip, direction : String, show :Boolean ) : Void
		{
			if (show == undefined) show = false;
			if (direction == undefined ) direction = "top";
			
			if (direction == "top") {
				theItem._y = - (theItem._height + 50);
			} else if (direction == "right") {
				theItem._x = 20 + STAGE_WIDTH;
			} else if ( direction == "bottom") {
				theItem._y = STAGE_HEIGHT + 20;
			}
			
			show ? theItem._alpha = 100 : theItem._alpha = 0;
		}
		
		private function blurItem ( theItem : MovieClip, blurX : Number , blurY : Number, quality : Number ) : Void
		{
			if (blurX == undefined ) blurX = 0;
			if (blurY == undefined ) blurY = 0;
			if (quality == undefined ) quality = 4;
			TweenLite.to (theItem, 0, { blurFilter : { blurX : blurX, blurY : blurY, quality: quality} } ) ;
		}
		
		private function recordStartPositionAndHideElement ( theElement ) : Void
		{
			objectRecorder[theElement + "X"] = this[theElement]._x;
			objectRecorder[theElement + "Y"] = this[theElement]._y;
			
			this[theElement]._alpha = 0;
		}

}