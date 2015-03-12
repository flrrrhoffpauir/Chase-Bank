
// QuizEndFrame.as
// Created by Junie Threatt
// on 2008-08-25

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;

class classes.views.QuizEndFrame extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _score:Number;
	
	private var _resultsArray:Array = 	[{ headline:"REALLY? NOT ONE?", desc:"Luckily it’s a lot easier to earn and spend points in real life."},
						 { headline:"YOU HAVE SEEN THE SHOW, RIGHT?", desc:"fabulous pair of cheetah print pumps.", px:8, py:-63 },
						 { headline:"ANOTHER VIEWING COULDN'T HURT.", desc:"rockin' crocodile handbag.", px:20, py:-96 },
						 { headline:"GOOD GOLLY, MISS MOLLY!", desc:"luxurious day at a spa.", px:23, py:-83 }];
	
	// static properties
	private static var SPEED:Number = .75;
	private static var EASE:Function = Expo.easeOut;
	
	// constructor
	public function QuizEndFrame() {
		
		_scope = this;
		
		EventManager.addEventListener("onShowEndFrame", this, "buildEndFrame");
	}
	
	private function buildEndFrame(o:Object):Void {
				
		_score = o.data.score;
		
		 var num:Number = getResultNum();
		
		writeHeadline(num);
		writeSubhead(num);
		writeDesc(num);
		showCta();
		attachClipToPillar(num);
	}
	
	private function writeHeadline(num:Number):Void {
		var mc:MovieClip = (num != 2) ? _scope.headline : _scope.headline2;
		_scope.headline.t.text = _resultsArray[num].headline;
		TweenFilterLite.to(mc, SPEED, { _y:-20 + 20, _alpha:100, delay:SPEED, ease:EASE });
	}
	
	private function writeSubhead(num:Number):Void {
		var thousand:String = (num > 0) ? ",000" : "";
		_scope.subhead.t.htmlText = "You correctly answered <font color=\"#0066CC\">" + _score + "</font> out of <font color=\"#0066CC\">10</font> questions,\nearning <font color=\"#0066CC\">" + _score*5 + "" + thousand + "</font> virtual points.";
		TweenFilterLite.to(_scope.subhead, SPEED*2, { _alpha:100, delay:SPEED*1.5, ease:EASE });
	}
	
	private function writeDesc(num:Number):Void {
		if(num == 0) {
			TweenFilterLite.to(_scope.desc0, SPEED, { _x:-18 + 20, _alpha:100, delay:SPEED*2, ease:EASE });
		} else if(num == 2) {
			TweenFilterLite.to(_scope.desc2, SPEED, { _x:-18 + 20, _alpha:100, delay:SPEED*2, ease:EASE });
		} else {
			var disclaimer:String = (num > 0) ? "With that many points you could get a" : _resultsArray[0].desc;
			
			_scope.desc.t.text = disclaimer;
			_scope.desc.c.text = (num > 0 ) ? _resultsArray[num].desc : "";
			_scope.desc.c.embedFonts = true;
			_scope.desc.c.setTextFormat(createTextFormat(14, 0));
			
			TweenFilterLite.to(_scope.desc, SPEED, { _x:-18 + 20, _alpha:100, delay:SPEED*2, ease:EASE });
		}
	}
	
	private function showCta():Void {
		TweenFilterLite.from(_scope.cta, SPEED, { _x:_scope.cta._x - 20, _alpha:0, delay:SPEED*2.5, ease:EASE });
		_scope.cta.onRollOver = function():Void { this._parent._parent.card.gotoAndPlay("shimmer"); };
		_scope.cta.onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_quiz" }); };
	}
	
	private function attachClipToPillar(num:Number):Void {
		if(num > 0) {
			_scope.pillar.attachMovie("prod"+num, "prod", 100, { _x:_resultsArray[num].px, _y:_resultsArray[num].py });
			_scope.pillar._visible = true;
			TweenFilterLite.from(_scope.pillar, SPEED, { _y:_scope.pillar._y+300, delay:SPEED*3, ease:EASE });
		} else {
			_scope.pillar._visible = false;
		}
	}
	
	private function createTextFormat(fsize:Number, lspacing:Number):TextFormat {
		
		var tFormat = new TextFormat();
		tFormat.font = "akzmed";
		tFormat.size = fsize;
		tFormat.letterSpacing = lspacing;
		
		return tFormat;
	}
	
	private function getResultNum():Number {
		
		if(_score == 0) {
			return 0;
		} else if(_score >= 1 && _score <= 3) {
			return 1;
		} else if(_score >= 4 && _score <= 7) {
			return 2;
		} else {
			return 3;
		}
	}
	
}