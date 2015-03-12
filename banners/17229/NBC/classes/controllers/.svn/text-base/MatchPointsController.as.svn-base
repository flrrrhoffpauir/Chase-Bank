
// MatchPointsController.as
// created by Junie Threatt
// on 08-19-2008

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;
import classes.views.MatchPoints;

class classes.controllers.MatchPointsController extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	private var _gradeInterval:Number;
	private var _gradeTimeout:Number = 1;
	private var _changeSectionTime:Number = 1;
	private var _sectionId:Number = 0;
	private var _view:Object;
	private var _scoreNum:Number = 0;
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	private static var L_TEXT:TextFormat = new TextFormat();
	private static var S_TEXT:TextFormat = new TextFormat();
	
	public function MatchPointsController(scope:MovieClip) {
				
		_scope = this._parent;
		_view = new MatchPoints(this._parent, this);
				
		L_TEXT.size = 26;
		S_TEXT.size = 24;
		
		// remove them just in case
		EventManager.removeEventListener("onTagPress", this);
		EventManager.removeEventListener("onTagRelease", this);
		EventManager.removeEventListener("onTagRollOver", this);
		EventManager.removeEventListener("onTagRollOut", this);
		EventManager.removeEventListener("onResetGame", this);
		EventManager.removeEventListener("onStartMatchGame", this);
		
		EventManager.addEventListener("onTagPress", this, "tagPress");
		EventManager.addEventListener("onTagRelease", this, "tagRelease");
		EventManager.addEventListener("onTagRollOver", this, "tagRollOver");
		EventManager.addEventListener("onTagRollOut", this, "tagRollOut");
		EventManager.addEventListener("onResetGame", this, "resetGame");
		EventManager.addEventListener("onStartMatchGame", this, "startGame");
		
		initPanel();
	}
	
	// called when a tag is pressed
	private function tagPress(o:Object):Void {
		
		_scope["tag"+o.data.id].startDrag();
		
		// if they press a tag, stop grading
		clearInterval(_gradeInterval);
		
		// enterframe to test for mouse direction
		_scope["tag"+o.data.id].onEnterFrame = function():Void {
			// cx: current _x
			// px: previous _x
			// dx: difference
			this.cx = _parent._xmouse;
			this.dx = this.cx - this.px;
			if(this.dx > 3) {
				// moving right
				this._rotation = 7;
			} else if(this.dx < -3) {
				// moving left
				this._rotation = -7;
			} else {
				this._rotation = 0;
			}
			this.px = this.cx;
		};
	}
	
	// called when a tag is released
	private function tagRelease(o:Object):Void {
		_scope["tag"+o.data.id].stopDrag();
		_scope["tag"+o.data.id]._rotation = 0;
		delete _scope["tag"+o.data.id].onEnterFrame;
		for(var i:Number = 0; i < 3; i++) {
			
			// if it was dropped on a pillars hotspot
			// i have to match a _droptarget, which is a string, which means _scope doesn't affect it. i'm testing for the string if the game was standalone or in the shell			
			if(_scope["tag"+o.data.id]._droptarget == "/gameContainer/panel/" + _scope["pillar"+i]._name + "/" + _scope["pillar"+i].hs._name || _scope["tag"+o.data.id]._droptarget == "/panel/" + _scope["pillar"+i]._name + "/" + _scope["pillar"+i].hs._name) {
				
				// if it landed on a pillar, drop it down and stop
				snapToPillar(_scope["tag"+o.data.id], _scope["pillar"+i]);
				return;
			} else {
				// else send it back home
				snapToHome(_scope["tag"+o.data.id]);
			}
		}
	}
	
	private function tagRollOver(o:Object):Void {
		if(_scope["tag"+o.data.id].onPillar != true) {
			_scope["tag"+o.data.id].gotoAndPlay("curlup");
		}
	}
	
	private function tagRollOut(o:Object):Void {
		if(_scope["tag"+o.data.id].onPillar != true) {
			_scope["tag"+o.data.id].gotoAndPlay("curldown");
		};
	}
	
	// called to snap a tag to a pillar
	private function snapToPillar(tag:MovieClip, pillar:MovieClip):Void {
		// snap to pillar location and show smaller tag
		tag._x = pillar._x + 97;
		tag._y = pillar._y - 33;
		
		// set text size and location
		tag.t.setTextFormat(S_TEXT);
		tag.t._x = -50;
		tag.t._y = -26;
		
		tag.onPillar = true;
		tag.gotoAndStop("down");
		
		// check progress to see if they have put every tag on a pillar
		// then wait _gradeTimeout seconds to grade their matches
		if(checkProgress()) {
			clearInterval(_gradeInterval);
			_gradeInterval = setInterval(this, "gradeMatches", _gradeTimeout*1000);
		}
	}
	
	// called to snap a tag back home
	private function snapToHome(tag:MovieClip):Void {
				
		// set text size and location
		tag.t.setTextFormat(L_TEXT);
		tag.t._x = -43;
		tag.t._y = -20;
		
		tag.onPillar = false;
		tag.gotoAndStop("up");
		
		// snap to original location and show normal tag
		tag._x = tag.ox;
		tag._y = tag.oy;
	}
	
	// checks progess of each round
	private function checkProgress():Boolean {
		// returns true if all tags have been put on a pillar
		var flag:Boolean;
		for(var i:Number = 0; i < 3; i++) {
			if(_scope["tag"+i]._x != _scope["tag"+i].ox) {
				flag = (flag != false) ? true : false;
			} else {
				flag = false;
			}
		}
		return flag;
	}
	
	// user has all tags on a pillar
	// grades user on accuracy
	private function gradeMatches():Void {
		
		// clear grading interval
		clearInterval(_gradeInterval);
		
		// disable tags
		disableTags();
		
		// check answers
		for(var j:Number = 0; j < 3; j++) {
			for(var k:Number = 0; k < 3; k++) {
				if(_scope["prodDisplay"+j].screen.prodid == _scope["tag"+k].prodid) {
					if(_scope["tag"+k]._x > (_scope["prodDisplay"+j]._x + 5) && _scope["tag"+k]._x < (_scope["prodDisplay"+j]._x + 80)) {
						_scope["pillar"+j].attachMovie("correct", "score", 1, { _x:32, _y:-205 });
						TweenFilterLite.from(_scope["pillar"+j].score, SPEED, { _y:_scope["pillar"+j].score._y+20, _alpha:0, ease:EASE });
						TweenFilterLite.to(_scope["prodDisplay"+j], SPEED, { glowFilter:{ color:0x0066CC, blurX:25, blurY:25, alpha:.4 }, ease:EASE });
						TweenFilterLite.to(_scope["pillar"+j].prod, SPEED, { glowFilter:{ color:0x0066CC, blurX:25, blurY:25, alpha:.3 }, ease:EASE });
						_scoreNum++;
					} else {
						_scope["pillar"+j].attachMovie("incorrect", "score", 1, { _x:32, _y:-203 });
						TweenFilterLite.from(_scope["pillar"+j].score, SPEED, { _y:_scope["pillar"+j].score._y+20, _alpha:0, ease:EASE });
						TweenFilterLite.to(_scope["prodDisplay"+j], SPEED, { colorMatrixFilter:{ saturation:0 }, ease:EASE });
						TweenFilterLite.to(_scope["pillar"+j].prod, SPEED, { colorMatrixFilter:{ saturation:0 }, ease:EASE });
					}
				}
			}
		}
				
		if(_sectionId < 4) {

			// switch to next section
			// [old] // _global.setTimeout(this, "showNextSection", 2000);
			_global.setTimeout(this, "showNextSection", _changeSectionTime*1000);
			
		} else {
			// game is over
			
			// build the end frame
			EventManager.dispatchEvent("onShowMatchEndFrame", { score:_scoreNum });
			
			// wait a few seconds and tween everything
			_global.setTimeout(this, "showEndFrame", _changeSectionTime*1000);			
		}
	}
	
	private function showNextSection():Void {
		
		var dmc:MovieClip;	// display panel mc
		var pmc:MovieClip;	// pillar mc
		var tag:MovieClip;	// tag mc
		
		// hack to cover up tags when they tween
		_scope["winHack"]._alpha = 100;
		
		for(var i:Number = 0; i < 6; i++) {
			
			// set references
			dmc = _scope["prodDisplay"+i];
			pmc = _scope["pillar"+i];
			tag = _scope["tag"+i];
			
			// tween everything offstage (238 is a hard-coded padding)
			TweenFilterLite.to(dmc, SPEED*2, { _x:dmc._x + 238*3, ease:EASE });
			TweenFilterLite.to(pmc, SPEED*2, { _x:pmc._x + 238*3, ease:EASE });
			TweenFilterLite.to(tag, 0, { _alpha:0, _x:tag._x + 238*3, ease:EASE });
		}
		_global.setTimeout(this, "showNextTags", 1000);
	}
	
	private function showNextTags():Void {
		
		var tag:MovieClip;	// tag mc
		
		// hack to cover up tags when they tween
		_scope["winHack"]._alpha = 0;
		
		// re-enable the tags
		enableTags();
		
		// set text
		_sectionId += 1;
		_view.setText(getSectionId());
		
		// dispatch event for the X of 5 counter
		EventManager.dispatchEvent("onSectionChange", { id:_sectionId });
		
		for(var i:Number = 0; i < 3; i++) {
			
			// set reference
			tag = _scope["tag"+i];
			
			// send them back to their original locations
			snapToHome(tag);
			
			// TweenFilterLite.from(tag, SPEED, { _alpha:0, ease:EASE });
			TweenFilterLite.to(tag, SPEED, { _alpha:100, ease:EASE });		
		}
		_global.setTimeout(this, "switchPillars", 1000);		
	}
	
	private function switchPillars():Void {
		
		// switch pillars so 0 - 2 are visible again
		
		var dmc:MovieClip;	// display panel mc
		var pmc:MovieClip;	// pillar mc
				
		for(var i:Number = 0; i < 6; i++) {
			
			// set references
			dmc = _scope["prodDisplay"+i];
			pmc = _scope["pillar"+i];
			
			// remove all filters
			dmc.filters = [];
			pmc.prod.filters = [];
			
			// remove score and product
			pmc.score.removeMovieClip();
			pmc.prod.removeMovieClip();
			
			// change the first 3 pillars/displays			
			if(i < 3) {
				
				// assign product ids
				dmc.screen.prodid = _view._nextProdSectArray[i].id;
				
				// change prodDisplay text
				dmc.screen.t.text = _view._nextProdSectArray[i].prod;
				dmc.screen.t.embedFonts = true;
				dmc.screen.t.setTextFormat(_view.createTextFormat(_view._nextProdSectArray[i].tSize));
				
				// adjust text location
				dmc.screen.t._y = _view._nextProdSectArray[i].py;
				
				// attach correct product
				pmc.attachMovie("prod"+_view._nextProdSectArray[i].id, "prod", pmc.getNextHighestDepth(), { _x:_view._nextProdSectArray[i].imgx, _y:_view._nextProdSectArray[i].imgy })
				
			}
			
			// switch 0-2 with 3-5 so they still in order but 0-2 are visible (238 is a hard-coded padding)
			dmc._x -= 238*3;
			pmc._x -= 238*3;
		}
		
		
		// reset next product array
		_view._nextProdSectArray = [];
		
		// create the next products
		if(_sectionId < 4) { _view.initNextProducts(getSectionId()); };
	}
		
	// init panel movie clips that don't necessarily directly effect the game
	private function initPanel():Void {
		
		_scope["close"].onRelease = function():Void {
			EventManager.dispatchEvent("onCloseRelease");
			EventManager.dispatchEvent("onChangeIcon", { id:0 });
		}
		
		// show info copy and glow
		_scope["help"].qmark.onRollOver = function():Void { 
			TweenFilterLite.to(_parent.info, SPEED, { _alpha:100, ease:EASE });
			TweenFilterLite.to(this, SPEED, { glowFilter:{ color:0x0066CC, blurX:12, blurY:12, alpha:1 }, ease:EASE });
		};
		
		_scope["help"].qmark.onRollOut = function():Void {
			TweenFilterLite.to(_parent.info, SPEED, { _alpha:0, ease:EASE });
			TweenFilterLite.to(this, SPEED, { glowFilter:{ color:0x0066CC, blurX:0, blurY:0, alpha:0 }, ease:EASE });
		};
		
		_scope["card"].onRollOver = function():Void { this.gotoAndPlay("shimmer"); };
	}
	
	private function disableTags():Void {
		for(var i:Number = 0; i < 3; i++) {
			delete _scope["tag"+i].onPress;
			delete _scope["tag"+i].onRelease;
		}
	}
	
	private function enableTags():Void {
		
		var mc:MovieClip;
		
		for(var i:Number = 0; i < 3; i++) {
			mc = _scope["tag"+i];
			_view.setHandlers(mc);
			mc.gotoAndPlay("down");
		}
	}
	
	private function showEndFrame():Void {
		
		// tween 1st 3 pillars and displays, but leave last 3 alone. hide tags
		var dmc:MovieClip;
		var pmc:MovieClip;
		var tmc:MovieClip;
		for(var i:Number = 0; i < 3; i++) {
			dmc = _scope["prodDisplay"+i];
			pmc = _scope["pillar"+i];
			tmc = _scope["tag"+i];	
			TweenFilterLite.to(dmc, SPEED, { _x:dmc._x+238*3, ease:EASE });
			TweenFilterLite.to(pmc, SPEED, { _x:pmc._x+238*3, ease:EASE });
			
			// there was a reason I made this a tween, but I can't remember why
			TweenFilterLite.to(tmc, 0, { _alpha:0, _x:tmc._x + 238*3, ease:EASE });
		}
		
		// tween end frame into view
		TweenFilterLite.to(_scope["endFrame"], SPEED, { _x:_scope["endFrame"]._x+238*3, ease:EASE });
		
		// hide counter
		TweenFilterLite.to(_scope.counter, SPEED, { _alpha:0, ease:EASE });
		
		// hide vertical lines
		TweenFilterLite.to(_scope.bars, SPEED, { _alpha:0, ease:EASE });
		
		// disable help button
		_scope.help._visible = false;
		
		_global.setTimeout(this, "resetSection", 1000);
	}
	
	private function resetSection():Void {
		// resets a section
		var dmc:MovieClip;
		var pmc:MovieClip;
		for(var i:Number = 0; i < 3; i++) {
			dmc = _scope["prodDisplay"+i];
			pmc = _scope["pillar"+i];
			
			// remove all filters
			dmc.filters = [];
			pmc.prod.filters = [];
			
			// remove score and product
			pmc.score.removeMovieClip();
			pmc.prod.removeMovieClip();
		}
	}
	
	private function resetGame():Void {
						
		_view._nextProdSectArray = [];
		_view._prodSectArray = [];
		
		_sectionId = 0;
		_scoreNum = 0;
		
		// set pillars and displays to left of stage and tween in
		var dmc:MovieClip;
		var pmc:MovieClip;
		var tmc:MovieClip;
		for(var i:Number = 0; i < 6; i++) {
			dmc = _scope["prodDisplay"+i];
			pmc = _scope["pillar"+i];
			tmc = _scope["tag"+i];
			if(i < 3) {
				dmc._x -= 238*6;
				pmc._x -= 238*6;
				snapToHome(tmc);
				TweenFilterLite.to(tmc, SPEED, { _alpha:100, ease:EASE });
			} else {
				dmc._x -= 238*3;
				pmc._x -= 238*3;
			}
			TweenFilterLite.to(dmc, SPEED, { _x:dmc._x+238*3, ease:EASE });
			TweenFilterLite.to(pmc, SPEED, { _x:pmc._x+238*3, ease:EASE });
		}	
		// tween end frame off stage to right side
		TweenFilterLite.to(_scope.endFrame, SPEED, { _x:_scope.endFrame._x+238*3, onComplete:resetEndFrame, onCompleteScope:this, ease:EASE });
		
		// tween vertical lines
		TweenFilterLite.to(_scope.bars, SPEED, { _alpha:100, ease:EASE });
		
		// enable help button
		_scope.help._visible = true;
		
		// reset text, products
		// doing this after the loop to keep the x positions of the tags
		_view.set0();
		_view.set1();
		
		// show counter
		TweenFilterLite.to(_scope.counter, SPEED, { _alpha:100, ease:EASE });
	}
	
	private function startGame():Void {
		
		// hide cursor
		_scope.demo.cursor._visible = false;
		
		// tween out objects on stage
		TweenFilterLite.to(_scope.demo.display, SPEED, { _x:_scope.demo.display._x + 238*2+150, ease:EASE });
		TweenFilterLite.to(_scope.demo.pillar, SPEED, { _x:_scope.demo.pillar._x + 238*2+150, ease:EASE });
		TweenFilterLite.to(_scope.demo.score, SPEED, { _x:_scope.demo.score._x + 238*2+150, ease:EASE });
		TweenFilterLite.to(_scope.demo.headline, SPEED, { _alpha:0, ease:EASE });
		TweenFilterLite.to(_scope.demo.subhead, SPEED, { _alpha:0, ease:EASE });
		TweenFilterLite.to(_scope.demo.getStarted, SPEED, { _alpha:0, ease:EASE });
		TweenFilterLite.to(_scope.demo.bg, SPEED, { _alpha:0, ease:EASE });
		TweenFilterLite.to(_scope.demo.mist, SPEED, { _alpha:0, ease:EASE });
		
		var dmc:MovieClip;
		var pmc:MovieClip;
		var tmc:MovieClip;
		var dbmc:MovieClip;
		var dtmc:MovieClip;
		for(var i:Number = 0; i < 3; i++) {
			dmc = _scope["prodDisplay"+i];
			pmc = _scope["pillar"+i];
			tmc = _scope["tag"+i];
			dbmc = _scope.demo["bullet"+i];
			dtmc = _scope.demo["tag"+i];
			
			TweenFilterLite.to(dmc, SPEED, { _x:dmc._x+((238*2)+150), ease:EASE });
			TweenFilterLite.to(pmc, SPEED, { _x:pmc._x+((238*2)+150), ease:EASE });
			TweenFilterLite.to(dbmc, SPEED, { _alpha:0, _visible:false, ease:EASE });
			TweenFilterLite.to(dtmc, SPEED, { _alpha:0, _visible:false, ease:EASE });
			
			tmc.enabled = true;
		}
		
		TweenFilterLite.to(_scope.counter, SPEED, { _alpha:100, ease:EASE });
		
		_global.setTimeout(this, "deleteDemo", 1000);
	}
	
	private function deleteDemo():Void { _scope.demo._visible = false; };
	
	private function resetEndFrame():Void { _scope.endFrame._x = -641; _scope.endFrame.gotoAndStop("beginning"); };
	
	public function getSectionId():Number {
		var num:Number = _sectionId * 3;
		return num;
	}
}