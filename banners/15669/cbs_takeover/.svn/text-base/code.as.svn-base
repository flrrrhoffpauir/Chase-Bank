_quality = "best";

var typeInterval:Number;
var i:Number = 0;

var trailingPortalInterval:Number
var n:Number = 0;

var swipeBottomInterval:Number;
var b:Number = 1;

function typeWrite(txt:String, t:TextField):Void {
	stop();
	i = 0;
	txt = txt.toUpperCase();
	clearInterval(typeInterval);
	typeInterval = setInterval(this, "typeChar", 20, txt, t);
}

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

// ------------------------------------------------------------------------------------------------------------ //
// ----- Old Portal Functions  -------------------------------------------------------------------------------- //
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

function setTrailingPortals():Void {
	clearInterval(trailingPortalInterval);
	trailingPortalInterval = setInterval(this, "dupePortalTrail", 10);
}

function dupePortalTrail():Void {
	duplicateMovieClip(trailing_portal, "tp" + n, getNextHighestDepth());
	duplicateMovieClip(trailing_portal, "tpp" + n, getNextHighestDepth());
	duplicateMovieClip(trailing_portal, "tppp" + n, getNextHighestDepth());
	n++;
}

function initPortals(xRange:Number, yRange:Number):Void {
	for(var i:Number = 0; i < numOfPortals; i++) {
		var mc:MovieClip = this["p" + i];
		mc.id = i;
		mc.t.text = mc.id;
		
		mc.ox = mc._x;
		mc.oy = mc._y;
		
		mc.nx = Stage.width - Math.ceil(Math.random() * xRange - 200);
		mc.ny = Stage.height - Math.ceil(Math.random() * yRange - 60);
		
		portalArray.push(mc);
	}
}

function movePortals():Void {
	for(var i:Number = 0; i < numOfPortals; i++) {
		var mc:MovieClip = portalArray[i];		
		mc.dlay = random(9) / 10;
		Tweener.addTween(mc, {_x: mc.nx, _y: mc.ny, _alpha: 100, transition:"Strong.easeOut", time:.6, delay: mc.dlay});
	}
}

function setHotSpot():Void {
	hotspot.onRollOver = function():Void {
		smallPhone_mc.gotoAndPlay("shake");
		cta_mc.bg.gotoAndPlay("shimmer");
		Tweener.addTween(cta_mc.arrow, {_x: 69, time: .5, transition: "Strong.easeOut"});
	}
	hotspot.onRollOut = function():Void {
		Tweener.addTween(cta_mc.arrow, {_x: 64, time: .5, transition: "Strong.easeOut"});
	}
}