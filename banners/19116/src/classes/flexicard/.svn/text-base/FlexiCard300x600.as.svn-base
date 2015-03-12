
import gs.*;
import gs.easing.*;

var ti:TransformItem;

_quality = "BEST";

var cardOriginalPosX:Number = 350.5;
var cardOriginalPosY:Number = 125;
var cardInitScale:Number = 70;
var timeoutVar:Number;

function makeCard(scope:MovieClip):Void
{
	clearTimeout(timeoutVar);
	if(cardLarge) { removeMovieClip(cardLarge); };
	scope.attachMovie("ChaseCardLarge", "cardLarge", scope.getNextHighestDepth());
	cardLarge._x = cardOriginalPosX;
	cardLarge._y = cardOriginalPosY;
	cardLarge._xscale = cardLarge._yscale = cardInitScale;
	ti = new TransformItem(cardLarge, { bounds:{xMin:0, xMax:500, yMin:0, yMax:600}, forceSelectionToFront:false, enabled:false });
	ti.deselect(true);
};


function startCard():Void
{
	ti.deselect(true);
	ti.enabled = true;
	delaySelectCard();
};


function delaySelectCard():Void
{
	clearTimeout(timeoutVar);
	timeoutVar = setTimeout(selectCard, 750);
};


function cleanup():Void
{
	clearTimeout(timeoutVar);
	TweenLite.killTweensOf(cardLarge);
	ti.deselect(true);
	ti.reset();
	ti.destroy();
	ti = null;
	removeMovieClip(cardLarge);
	delete cardLarge;
};


function expandCard():Void
{
	TweenLite.to(cardLarge, 1.0, { _x:250, _y:138, _xscale:90, _yscale:90, ease:Strong.easeOut, onComplete:startCard });
};


function collapseCard():Void
{
	clearTimeout(timeoutVar);
	ti.deselect(true);
	TweenLite.to(cardLarge, 0.5, { _x:cardOriginalPosX, _y:cardOriginalPosY, _xscale:cardInitScale, _yscale:cardInitScale, _rotation:0, ease:Strong.easeOut, onComplete:cleanup });
};


function selectCard():Void
{
	ti.select();
};






