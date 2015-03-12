
// QuizView.as
// Created by Junie Threatt
// on 2008-08-24

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;

class classes.views.QuizView extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _controller:Object;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	// constructor
	public function QuizView(scope:MovieClip, controller:Object) {
		
		_scope = scope;
		_controller = controller;
				
		initQuestions();
		initScoreBoard();
		initButtons();
	}
	
	private function initQuestions():Void {
		var mc:MovieClip;
		for(var i:Number = 0; i < 10; i++) {
			mc = _scope["question"+i];
			mc.id = i;
			mc._alpha = 0;
			mc._visible = false;
			
			mc.correct._alpha = 0;
			mc.correct._visible = false;
			mc.correct.oy = mc.correct._y;

			mc.incorrect._alpha = 0;
			mc.incorrect._visible = false;
			mc.incorrect.oy = mc.correct._y;		
			
			// question number 7 is a bit different
			if(i == 6) {
				
				// it has a different incorrect mc
				// depening on what the user chooses
				
				mc.incorrect0._alpha = 0;
				mc.incorrect2._alpha = 0;
				mc.incorrect3._alpha = 0;
				
				mc.incorrect0._visible = false;
				mc.incorrect2._visible = false;
				mc.incorrect3._visible = false;
				
				mc.incorrect0.oy = mc.incorrect0._y
				mc.incorrect2.oy = mc.incorrect2._y
				mc.incorrect3.oy = mc.incorrect3._y
			}
		}
	}
	
	private function initScoreBoard():Void {
		TweenFilterLite.from(_scope.scoreBoard, SPEED*2, { _y:_scope.scoreBoard._y - _scope.scoreBoard._height - 10, delay:SPEED, ease:EASE });
	}
	
	private function initButtons():Void {
		
		// ok, maybe more than buttons...
		
		// interstitial
		_scope.inter._visible = false;
		
		// end frame
		_scope.endFrame._visible = false;
		
		// -- Next Question -------------------------------------------------------------------- //
		
		_scope.nextQuestion.onRelease = function():Void {
			// show next question
			EventManager.dispatchEvent("onShowQuestion", { });
		};
		
		// -- Try Again ------------------------------------------------------------------------ //
		
		_scope.tryAgain._alpha = 0;
		_scope.tryAgain._visible = false;
		
		_scope.tryAgain.onRollOver = function():Void { };
		
		_scope.tryAgain.onRelease = function():Void {
			// reset variables and start over
			EventManager.dispatchEvent("onRestart", { });		
		}
		
		// -- Skip Button ---------------------------------------------------------------------- //
		
		_scope.skipThis._alpha = 0;
		_scope.skipThis._visible = false;
		
		_scope.skipThis.onRelease = function():Void {
			
			clearInterval(this._parent.controller0._interstitialInterval);
			
			// show next question button again
			this._parent["nextQuestion"]._visible = true;
			
			// hide this one
			TweenFilterLite.to(this, SPEED, { _alpha:0, _visible:false, ease:EASE });
			
			// hide interstitial
			TweenFilterLite.to(this._parent["inter"], SPEED, { _alpha:0, _visible:false, ease:EASE });
			
			EventManager.dispatchEvent("onShowQuestion", { skipped:true });
		}
		
		// -- Legal ---------------------------------------------------------------------------- //
		
		_scope.legal.oy = _scope.legal._y;
		_scope.legal.arrow.oy = _scope.legal.arrow._y;
		
		_scope.legal.onRollOver = function():Void {
			
			TweenFilterLite.to(this, SPEED, { _y:this.oy - this._height + 15, ease:EASE });
			this.arrow._rotation = 180;
			this.arrow._y = this.arrow.oy - 1;
			
			// doesn't look good
			// TweenFilterLite.to(this.arrow, SPEED, { _rotation:180, ease:EASE });
		};
		
		_scope.legal.onRollOut = function():Void {
			
			TweenFilterLite.to(this, SPEED, { _y:this.oy, ease:EASE });
			this.arrow._rotation = 0;
			this.arrow._y = this.arrow.oy;
			
			// doesn't look good
			// TweenFilterLite.to(this.arrow, SPEED, { _rotation:0, ease:EASE });
		};
		
		// -- Close ---------------------------------------------------------------------------- //
		
		// close the panel when closed
		_scope["close"].onRelease = function():Void {
			EventManager.dispatchEvent("onCloseRelease");
			EventManager.dispatchEvent("onChangeIcon", { id:0 });
		}
		
		// -- Card ----------------------------------------------------------------------------- //
		
		// card rollover
		_scope.card.onRollOver = function():Void { this.gotoAndPlay("shimmer"); };
		_scope.card.onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_quiz" }); };
		
		// -- Help ----------------------------------------------------------------------------- //
		
		// show info copy and glow
		_scope["help"].qmark.onRollOver = function():Void { 
			TweenFilterLite.to(_parent.info, SPEED, { _alpha:100, ease:EASE });
			TweenFilterLite.to(this, SPEED, { glowFilter:{ color:0x0066CC, blurX:12, blurY:12, alpha:1 }, ease:EASE });
		};
		
		_scope["help"].qmark.onRollOut = function():Void {
			TweenFilterLite.to(_parent.info, SPEED, { _alpha:0, ease:EASE });
			TweenFilterLite.to(this, SPEED, { glowFilter:{ color:0x0066CC, blurX:0, blurY:0, alpha:0 }, ease:EASE });
		};
	}
}