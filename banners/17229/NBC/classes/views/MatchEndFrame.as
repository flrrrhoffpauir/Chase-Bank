
// MatchEndFrame.as
// Created by Junie Threatt
// on 2008-08-27

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo

class classes.views.MatchEndFrame extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _score:Number;
	private var _resultsArray:Array = 	[{ head:"BEEN TO A MALL LATELY?", sub:"Get to one fast — and take note of the price tags." },
						 { head:"NOT TOO SHABBY.", sub:"But it couldn't hurt to brush up on your shopping skills." },
						 { head:"RIGHT ON!", sub:"How's the weather on Rodeo Drive?" }];
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	// constructor
	public function MatchEndFrame() {
		
		_scope = this;
		
		EventManager.addEventListener("onShowMatchEndFrame", this, "buildEndFrame");
	}
	
	private function buildEndFrame(o:Object):Void {
		
		_score = o.data.score;
		
		writeScore();
		writeHeadline();
		writeSubhead();
		
		initTryAgain();
		
		_global.setTimeout(this, "playEndFrame", 1000);
	}
	
	private function writeScore():Void {
		_scope.score.text = _score + " out of 15";
		_scope.score.text.setTextFormat(createTextFormat(12, 1));
	}
	
	private function writeHeadline():Void {
		_scope.headline.text = _resultsArray[getResultNum()].head;
		_scope.headline.text.setTextFormat(createTextFormat(24, 1));
	}
	
	private function writeSubhead():Void {
		if(getResultNum() == 0) {
			_scope.sub0._visible = true;
			_scope.subhead._visible = false
		} else {
			_scope.sub0._visible = false;
			_scope.subhead._visible = true;
			_scope.subhead.text = _resultsArray[getResultNum()].sub;
			_scope.headline.text.setTextFormat(createTextFormat(16, 1));
		}
	}
	
	private function initTryAgain():Void {
		_scope.tryAgain.onRelease = function():Void {
			EventManager.dispatchEvent("onResetGame", { });
		};
	}
	
	private function playEndFrame():Void { _scope.play(); };
	
	private function createTextFormat(fsize:Number, lspacing:Number):TextFormat {
		
		var tFormat = new TextFormat();
		tFormat.font = "akzmed";
		tFormat.size = fsize;
		tFormat.letterSpacing = lspacing;
		
		return tFormat;
	}
	
	private function getResultNum():Number {
		
		if(_score >= 0 && _score <= 5) {
			return 0;
		} else if(_score >= 6 && _score <= 10) {
			return 1;
		} else if(_score >= 11 && _score <= 15) {
			return 2;
		}
	}
	
	public function initCta():Void {
		
		_scope["cta"].onRollOver = function():Void { this._parent.card.gotoAndPlay("shimmer"); };
		_scope["cta"].onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_matchpoints" }); };

		_scope["card"].onRollOver = function():Void { this.gotoAndPlay("shimmer"); };
		_scope["card"].onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_matchpoints" }); };

		_scope["card"].gotoAndPlay("shimmer");
	}
}