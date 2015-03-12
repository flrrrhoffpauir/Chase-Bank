
//
// code.as
//
// Created by Junie Threatt
// on 2008-06-15
//

import gs.TweenLite;
import gs.Expo;

// -- Properties ---------------------------------- //

var _startPanelInterval:Number;

var _panelInterval:Number;
var _currentPanelArray:Array = [panel0, panel1, panel2, panel3, panel4];
var _count:Number = 0;
var _deathCount:Number = 0;

var _curPanel:MovieClip;
var _nextPanel:MovieClip;

var SPEED:Number = .55;
var PANEL_HEIGHT:Number = 35;
var PANEL_INTERVAL_SPEED:Number = 3500;

// -- Tweening Functions -------------------------- //

function initCard():Void {
	TweenLite.from(card, .5, { _y:0-card._height, delay:SPEED+.2, ease:Expo.easeOut });
};

function initPanel():Void {
	TweenLite.to(_currentPanelArray[0], SPEED, { _y:0, delay:SPEED, ease:Expo.easeOut });
};

function startPanelInterval():Void {
	clearInterval(_startPanelInterval);
	clearInterval(_panelInterval);
	_panelInterval = setInterval(this, "animatePanels", PANEL_INTERVAL_SPEED);
};

function animatePanels():Void {
	
	// set the current panel
	_curPanel = _currentPanelArray[_count];
	
	// if count is 4, set it back to 0
	// the next panel should be the first one
	_count = (_count == 4) ? -1 : _count;
	
	// next panel is one more than the current
	_nextPanel = _currentPanelArray[_count+1];
	
	// place next panel at top of Stage for tweening
	_nextPanel._y = 0 - PANEL_HEIGHT;
	
	// tween both panels
	TweenLite.to(_nextPanel, SPEED, { _y:0, ease:Expo.easeOut });
	TweenLite.to(_curPanel, SPEED, { _y:Stage.height, ease:Expo.easeOut });
	
	// iterate the count
	_count++;
	
	// kill the interval after awhile
	if(_deathCount == 19) {
		clearInterval(_panelInterval);
	};
	
	// iterate death count
	_deathCount++;
	
	// shimmer the cta
	cta.gotoAndPlay("shimmer");
};

// -- Handlers ------------------------------------ //

hotspot.onRollOver = function():Void {
	cta.gotoAndPlay("shimmer");
};

hotspot.onRelease = defaultClick;

// -- Click Function ------------------------------ //

function defaultClick():Void {
	getURL(_root.clickTag, "_blank");
};