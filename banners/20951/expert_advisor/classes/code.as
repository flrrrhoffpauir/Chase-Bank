

// ------------------------------------------------------------------
// -- Imports
// ------------------------------------------------------------------


// ------------------------------------------------------------------
// -- Properties
// ------------------------------------------------------------------


// ------------------------------------------------------------------
// -- Handlers
// ------------------------------------------------------------------

_root.hotspot.onRelease = defaultClick;


// ------------------------------------------------------------------
// -- Functions
// ------------------------------------------------------------------

function maskHeadline(num:Number):Void
{
	var mask:MovieClip = this["headline"+num+"mask"];
	var angle:MovieClip = this["headline"+num+"angle"];
	
	mask.cacheAsBitmap = true;
	angle.cacheAsBitmap = true;
	angle.setMask(mask);
};


function initRollover():Void
{
	card.gotoAndPlay("shimmer");
	cta.holder.gotoAndPlay("shimmer");
	_root.bg.play();
	_root.hotspot.onRollOver = defaultRollover;
};


function defaultRollover():Void
{
	if(card._currentframe == 1)
	{
		_root.bg.play();
		card.gotoAndPlay("shimmer");
		cta.holder.gotoAndPlay("shimmer");
	};
};


function initCta():Void
{
	cta.onRollOver = animateCta;
	cta.onRelease = defaultClick;
};


function animateCta():Void
{
	cta.gotoAndPlay("shimmer");
};


function defaultClick():Void
{
	getURL(_root.clickTag, "_blank");
};


