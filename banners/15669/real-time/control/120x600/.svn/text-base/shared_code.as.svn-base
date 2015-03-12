_quality = "best";

var typeInterval:Number;
var i:Number = 0;

var swipeBottomInterval:Number;
var b:Number = 0;

// Sets an interval to type out the text
function typeWrite(txt:String, t:TextField):Void {
	stop();
	i = 0;
	txt = txt.toUpperCase();
	clearInterval(typeInterval);
	typeInterval = setInterval(this, "typeChar", 20, txt, t);
}

// Types text like a type writer
function typeChar(txt:String, t:TextField):Void {
	if(i == txt.length) {
		t.text = txt;
		clearInterval(typeInterval);
		play();
	} else {
		t.text = txt.substr(0, i);
		i++;
	}
}

// Slides text in the carousel items
function moveTextIn(mc:MovieClip):Void {
	mc._x += 40;
	mc._alpha = 0;
	Tweener.addTween(mc, {_x: mc._x - 40, time: .5, transition:"Strong.easeOut"});
	Tweener.addTween(mc, {_alpha: 100, time: .8, transition:"Strong.easeOut"});
}

// Places portals at random places within range and assigns them properties
function initPortals(xRange:Number, yRange:Number):Void {
	for(var i:Number = 0; i < numOfPortals; i++) {
		var mc:MovieClip = eval("p" + i);
		mc.id = i;
		mc.t.text = mc.id;
		
		// Should be placed manually on stage
		// mc.ox = mc._x = -10 + Math.ceil(Math.random() * xRange);
		// mc.ox = mc._y = -10 + Math.ceil(Math.random() * yRange);
		mc.ox = mc._x;
		mc.oy = mc._y;
		
		// Should to be static, not random
		// Find new position with range at bottom right
		/*
		if(Stage.height != 90) {
			mc.nx = Stage.width - Math.ceil(Math.random() * xRange);
			mc.ny = Stage.height - Math.ceil(Math.random() * yRange);
		} else {
			mc.nx = Stage.width - Math.ceil(Math.random() * xRange);
			mc.ny = Stage.height - Math.ceil(Math.random() * (yRange - 80));
		}
		//*/
		// New X and Y need to go off the stage, but still be in the corner
		mc.nx = Stage.width - Math.ceil(Math.random() * xRange - 200);
		mc.ny = Stage.height - Math.ceil(Math.random() * yRange - 60);
		
		// Scale should be set manually
		// mc._xscale = mc._yscale = Math.ceil(Math.random() * 160);
		
		// mc._alpha = Math.ceil(Math.random() * 100);
		
		portalArray.push(mc);
	}
}

// Moves the portals from top left range to bottom right range
function movePortals():Void {
	for(var i:Number = 0; i < numOfPortals; i++) {
		var mc:MovieClip = portalArray[i];		
		// add a delay so they don't all go at once
		// mc.dlay = Math.random();
		mc.dlay = random(9) / 10;
		Tweener.addTween(mc, {_x: mc.nx, _y: mc.ny, _alpha: 100, transition:"Strong.easeOut", time:.6, delay: mc.dlay});
	}
}

function setHotSpot():Void {
	hotspot.onRollOver = function():Void {
		cta_mc.bg.gotoAndPlay("shimmer");
		//*
		if(Stage.width == 728) {
			Tweener.addTween(cta_mc.arrow_mc, {_x: 51, time: .5, transition: "Strong.easeOut"});
		} else if(Stage.width == 468) {
			// do nothing
		} else {
			Tweener.addTween(cta_mc.arrow_mc, {_x: 53, time: .5, transition: "Strong.easeOut"});
		}
		//*/
	}
	hotspot.onRollOut = function():Void {
		//*
		if(Stage.width == 728) {
			Tweener.addTween(cta_mc.arrow_mc, {_x: 48, time: .5, transition: "Strong.easeOut"});
		} else if(Stage.width == 468) {
			// do nothing
		} else {
			Tweener.addTween(cta_mc.arrow_mc, {_x: 48, time: .5, transition: "Strong.easeOut"});
		}
		//*/
	}
}

// ------------------------------------------------------------------------------------------------------------ //
// ----- Old Portal Functions --------------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------------------------------ //

function swipeBottomPortals():Void {
	clearInterval(swipeBottomInterval);
	swipeBottomInterval = setInterval(this, "swipeBottom", 5);
}

function swipeBottom():Void {
	var mc:MovieClip = eval("bp" + b);
	mc.newScale = Math.random() / 2 * 100;
	Tweener.addTween(mc, {_xscale: mc.newScale, _yscale: mc.newScale, time: .3, transition: "Strong.easeOut"});
	if((b % 2) == 0) {
		Tweener.addTween(mc, {_x: mc._x + -(Math.random() * Stage.width + Stage.width), _y: mc._y + -(Math.random() * Stage.height + Stage.height), time: 1.5, transition: "Strong.easeOut"});
	} else {
		Tweener.addTween(mc, {_x: mc._x + -(Math.random() * Stage.width + (Stage.width / 2)), _y: mc._y + -(Math.random() * Stage.height + (Stage.height / 2)), time: 1.5, transition: "Strong.easeOut"});
	}
	
	Tweener.addTween(mc, {_alpha: 0, time: 2, transition: "Strong.easeOut"});
	
	b++;
		
	if(b >= 16) {
		clearInterval(swipeBottomInterval);
	}
}

// ------------------------------------------------------------------------------------------------------------ //

function defaultClick():Void {
	getURL(_root.clickTag, "_blank");
}

cta_mc.hotspot.onRelease = defaultClick;
hotspot.onRelease = defaultClick;