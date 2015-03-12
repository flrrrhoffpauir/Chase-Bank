
// QuizAnswerController.as
// Created by Junie Threatt
// on 2008-08-24

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;

class classes.controllers.QuizAnswerController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _id:Number;
	private var _isCorrect:Boolean;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	// constructor
	public function QuizAnswerController() {
		
		_scope = this;
		
		// listens for it's own event, and disable when an answer is clicked
		EventManager.addEventListener("onAnswerRelease", this, "disableAnswer");
		
		// listen for new question being loaded
		EventManager.addEventListener("onNextQuestion", this, "enableAnswer");
		
		initAnswer();
	}
	
	private function initAnswer():Void {
										
		_scope.onRollOver = function():Void {
			// fade in
			TweenFilterLite.to(this.t, SPEED, { tint:0x0066CC });
			TweenFilterLite.to(this.bullet, SPEED, { colorMatrixFilter:{  colorize:0x0066CC, amount:.7 } });
			
			// saturation and hue don't do anything when you colorize
			// TweenFilterLite.to(this.bullet, SPEED, { colorMatrixFilter:{ colorize:0x0066FF, brightness:1, saturation:0.6, hue:210 } });
		};
		
		_scope.onRollOut = function():Void {
			// fade out
			TweenFilterLite.to(this.t, SPEED, { removeTint:true });
			TweenFilterLite.to(this.bullet, SPEED, { colorMatrixFilter:{ } });
		};
		
		_scope.onRelease = function():Void {
			var score:Number = (_isCorrect == true) ? 1 : 0;
			EventManager.dispatchEvent("onAnswerRelease", { id:_id, score:score });
		};
		
		_scope.onReleaseOutside = function():Void {
			var score:Number = (_isCorrect == true) ? 1 : 0;
			EventManager.dispatchEvent("onAnswerRelease", { id:_id, score:score });
		};
	}
	
	private function disableAnswer():Void {
		this.enabled = false;
	}
	
	private function enableAnswer():Void {
		this.enabled = true;
		this.onRollOut();
	}
	
	public function get id():Number { return _id; };	
	public function set id(id:Number):Void { _id = id; };
	
	public function get isCorrect():Boolean { return _isCorrect; };
	public function set isCorrect(isCorrect:Boolean):Void { _isCorrect = isCorrect; };
}