
// QuizController
// Created by Junie Threatt
// on 2008-08-24

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;
import classes.views.QuizView;

class classes.controllers.QuizController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _view:Object;
	private var _currQuestion:Number;
	private var _hasSeenMiddle:Boolean = false;
	private var _score:Number = 0;
	private var _points:Number = 5000;
	
	// public properties
	public var _interstitialInterval:Number;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	public function QuizController() {
		
		// add listener before instantiating the view
		EventManager.addEventListener("onShowQuestion", this, "showQuestion");
		
		// listen for question to be clicked
		EventManager.addEventListener("onAnswerRelease", this, "updateScore");
		
		// listen for game restart
		EventManager.addEventListener("onRestart", this, "restartGame");
		
		// listen for game start
		EventManager.addEventListener("onStartQuizGame", this, "startGame");
		
		_scope = this._parent;
		_view = new QuizView(_scope, this);
		
		// ** TESTING ** //
		// _scope.endFrame._visible = true;
		// EventManager.dispatchEvent("onShowEndFrame", { score:7 });		
	}
	
	private function showQuestion(o:Object):Void {
		
		// if there is no _currQuestion, set to 0, otherwise increment
		_currQuestion = (_currQuestion == undefined) ? 0 : _currQuestion + 1;
		
		// going to question 6, we need to see the interstitial first
		if(_currQuestion == 5 && _hasSeenMiddle == false) {
			showInterstitial();
			_hasSeenMiddle = true;
			return;
		}
		
		// skipped interstitial, lets see question 6
		if(o.data.skipped == true) { _currQuestion = 5; };
		
		EventManager.dispatchEvent("onSectionChange", { id:_currQuestion });
		
		if(_currQuestion == 9) {
			// last question, so hide next button and disable it
			unHighliteButton(_scope.nextQuestion);
			TweenFilterLite.to(_scope.nextQuestion, SPEED, { _alpha:0, delay:SPEED*2, ease:EASE, overwrite:false });
			_scope.nextQuestion.enabled = false;
		} else {
			// not last question so keep it there, but disabled
			unHighliteButton(_scope.nextQuestion);
			_scope.nextQuestion.enabled = false;
		}

		var mc:MovieClip;
		for(var i:Number = 0; i < 10; i++) {
			mc = _scope["question"+i];
			if(i == _currQuestion) {
				// show the question
				mc._visible = true;
				TweenFilterLite.to(mc, SPEED, { _alpha:100, delay:SPEED, ease:EASE });
				EventManager.dispatchEvent("onNextQuestion", { });
			} else if(i == _currQuestion - 1) {
				if(mc._alpha != 0) {
					// hide visible question
					TweenFilterLite.to(mc.correct, SPEED, { _alpha:0, _visible:false, ease:EASE });
					TweenFilterLite.to(mc.incorrect, SPEED, { _alpha:0, _visible:false, ease:EASE });
					TweenFilterLite.to(mc, SPEED, { _alpha:0, _visible:false, ease:EASE });
					
					if(i == 6) {
						for(var j:Number = 0; j < 4; j++) {
							TweenFilterLite.to(_scope.question6["incorrect"+j], SPEED, { _alpha:0, _visible:false, ease:EASE });
						}
					}					
				}
			}
		}
	}
	
	private function updateScore(o:Object):Void {
		
		// track the score
		if(o.data.score > 0) {
			_score += o.data.score;
			_scope.scoreBoard.t.text = getScore();
		} else if(o.data.reset == true) {
			// used for resetting
			_score = 0
			_scope.scoreBoard.t.text = "0";
		}
		_scope.scoreBoard.t.setTextFormat(createTextFormat());
		
		// show message
		showAnswer(o.data.id, o.data.score);		
	}
	
	private function showAnswer(id:Number, num:Number) {
		
		// lets the user know if they got the question correct
		if(num > 0) {
			// show correct
			_scope["question"+_currQuestion].correct._visible = true;
			_scope["question"+_currQuestion].correct._y = _scope["question"+_currQuestion].correct.oy
			TweenFilterLite.to(_scope["question"+_currQuestion].correct, SPEED, { _alpha:100, _y:_scope["question"+_currQuestion].correct._y - 20, ease:EASE });
			_scope["question"+_currQuestion].correct.onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_quiz" }); };
		} else {
			// show false

			// if they are on question #7, show the message based on which answer they made
			if(_currQuestion == 6) {
				_scope["question"+_currQuestion]["incorrect"+id]._visible = true;
				_scope["question"+_currQuestion]["incorrect"+id]._y = _scope["question"+_currQuestion]["incorrect"+id].oy
				TweenFilterLite.to(_scope["question"+_currQuestion]["incorrect"+id], SPEED, { _alpha:100, _y:_scope["question"+_currQuestion]["incorrect"+id]._y - 20, ease:EASE });
				_scope["question"+_currQuestion]["incorrect"+id].onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_quiz" }); };
			} else {
				// it's another question and there should only be one 'incorrect' message
				_scope["question"+_currQuestion].incorrect._visible = true;
				_scope["question"+_currQuestion].incorrect._y = _scope["question"+_currQuestion].incorrect.oy;
				TweenFilterLite.to(_scope["question"+_currQuestion].incorrect, SPEED, { _alpha:100, _y:_scope["question"+_currQuestion].incorrect._y - 20, ease:EASE });
				_scope["question"+_currQuestion].incorrect.onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_quiz" }); };
			}
		}
		
		// there is only one more question and i don't want to show the button then
		if(_currQuestion < 9) {
			highliteButton(_scope.nextQuestion);
			_scope.nextQuestion.enabled = true;
		} else {
			// delay for 7 seconds, then fade out and show the end frame
			_global.setTimeout(this, "showEndFrame", 7000);
		}
	}
	
	private function showEndFrame():Void {
		
		TweenFilterLite.to(_scope["question9"].correct, SPEED, { _alpha:50, _visible:false, ease:EASE });
		TweenFilterLite.to(_scope["question9"].incorrect, SPEED, { _alpha:50, _visible:false, ease:EASE });
		TweenFilterLite.to(_scope["question9"], SPEED, { _alpha:0, _visible:false, ease:EASE });


		// hide the counter
		TweenFilterLite.to(_scope.counter, SPEED, { _alpha:0, ease:EASE });
		
		// show the try again button
		_scope.tryAgain._visible = true;
		TweenFilterLite.to(_scope.tryAgain, SPEED, { _alpha:100, delay:SPEED*2, ease:EASE });
		
		// show the end frame and dispatch event to it
		_scope.endFrame._visible = true;
		EventManager.dispatchEvent("onShowEndFrame", { score:_score });
		
		TweenFilterLite.to(_scope.endFrame, SPEED, { _alpha:100, delay:SPEED*2, ease:EASE });
	}
	
	private function createTextFormat():TextFormat {
		
		var tFormat = new TextFormat();
		tFormat.font = "digital";
		tFormat.size = 26;
		tFormat.bold = true;
		tFormat.leading = -2;
		tFormat.letterSpacing = .5;
		
		return tFormat;
	}
	
	private function getScore():String {
		
		var score:String;
		
		// they have 5,000
		if(_score < 2) {
			score = "5,000";
		// they have more than 5,000
		} else {
			var calc:Number = _score * _points;
			score = calc.toString();
			score = score.substr(0,2) + "," + score.substr(2);
		}
		return score;
	}
	
	// shows a frame between question 5 and 6
	private function showInterstitial():Void {
		
		clearInterval(_interstitialInterval);
		_interstitialInterval = setInterval(this, "closeInterstitial", 15000);
		
		TweenFilterLite.to(_scope["question"+4], SPEED, { _alpha:0, _visible:false, ease:EASE });
		TweenFilterLite.to(_scope["question"+4].correct, SPEED, { _alpha:0, _visible:false, ease:EASE });
		TweenFilterLite.to(_scope["question"+4].incorrect, SPEED, { _alpha:0, _visible:false, ease:EASE });
		TweenFilterLite.to(_scope["nextQuestion"], SPEED, { _alpha:0, _visible:false, ease:EASE });
		
		_scope.skipThis._visible = true;
		TweenFilterLite.to(_scope["skipThis"], SPEED, { _alpha:100, ease:EASE });
		
		_scope["inter"]._visible = true;
		_scope["inter"]._alpha = 100;
		_scope["inter"].gotoAndPlay("start");
	}
	
	public function closeInterstitial():Void {
		clearInterval(_interstitialInterval);
		_scope.skipThis.onRelease();
	}
	
	private function restartGame():Void {
				
		// _scope.endFrame.pillar.unloadMovie();
		
		_currQuestion = -1;
		_hasSeenMiddle = false;
		_score = 0;
		
		// hide try again
		TweenFilterLite.to(_scope.tryAgain, SPEED, { _alpha:0, _visible:false, ease:EASE });
		
		// show counter
		TweenFilterLite.to(_scope.counter, SPEED, { _alpha:100, ease:EASE });
		
		// hide end frame
		TweenFilterLite.to(_scope.endFrame, SPEED, { _alpha:0, _visible:false, onComplete:setEndFrameAlpha, onCompleteScope:this, ease:EASE });
		
		// reset scoreboard
		EventManager.dispatchEvent("onAnswerRelease", { reset:true });
		
		// show first question
		showQuestion();
				
		// show next question button
		_scope.nextQuestion._visible = true;
		TweenFilterLite.to(_scope.nextQuestion, SPEED, { _alpha:100, ease:EASE });
	}
	
	private function setEndFrameAlpha():Void {
		
		// kind of a hack, but whatever, it's faster	
		_scope.endFrame.desc._alpha = 0;
		_scope.endFrame.desc0._alpha = 0;
		_scope.endFrame.desc2._alpha = 0;
		
		_scope.endFrame.headline._alpha = 0;
		_scope.endFrame.headline2._alpha = 0;
		_scope.endFrame.subhead._alpha = 0;		
	}
	
	private function startGame():Void {
		
		TweenFilterLite.to(_scope.counter, SPEED, { _alpha:100, ease:EASE });
		
		_scope.scoreBoard.t.text = "0";
		_scope.scoreBoard.t.setTextFormat(createTextFormat());
		TweenFilterLite.to(_scope.scoreBoard, SPEED, { glowFilter:{ alpha:0 }, ease:EASE });
		
		TweenFilterLite.to(_scope.counter, SPEED, { _alpha:100, ease:EASE });		
		
		TweenFilterLite.to(_scope.demo, SPEED, { _alpha:0, _visible:false, ease:EASE });
		_scope.nextQuestion._visible = true;
		
		EventManager.dispatchEvent("onShowQuestion", { });
	}
	
	private function highliteButton(mc:MovieClip):Void { TweenFilterLite.to(mc, SPEED, { _alpha:100, removeTint:true, ease:EASE }); };	
	private function unHighliteButton(mc:MovieClip):Void { TweenFilterLite.to(mc, SPEED, { _alpha:100, tint:0x999999, ease:EASE }); };
}