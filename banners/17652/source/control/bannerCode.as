
//   bannerCode.as    
 
// import classes.utils.Params; 
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;
import classes.tweening.Linear;

// -- Tweening Functions -------------------------- //
var TEXT_SPEED:Number = .5;
var TEXT_DELAY:Number = .2;
var STAGE_PADDING:Number = 20;

function alphaTween(mc:MovieClip, num:Number):Void {
	TweenFilterLite.to(mc, TEXT_SPEED, { _alpha:num });
};

function xTween(mc:MovieClip, dlay:Number):Void {
	TweenFilterLite.from(mc, TEXT_SPEED, { _x:-(STAGE_PADDING)-mc._width, ease:Expo.easeOut, delay:dlay });
};

function bgTween(yPos:Number):Void {
	TweenFilterLite.to(bg, 4, { _y:yPos, ease:Linear.easeOut });
};

// -- Handlers ------------------------------------ //
function flipCard(mc0:MovieClip, mc1:MovieClip):Void {

	TweenFilterLite.to(mc0, .5, { _x:mc0._x + 20, _alpha:0, blurFilter:{blurX:20}, ease:Expo.easeOut});
	TweenFilterLite.from(mc1, .5, { _x:mc1._x - 20, _alpha:0, blurFilter:{blurX:20}, ease:Expo.easeOut, onComplete:wigglePhone, onCompleteParams:[mc1]});
	
}

function wigglePhone(p:MovieClip):Void {
	
	p.gotoAndPlay(2);
	TweenFilterLite.from(p, .5, {blurFilter:{blurX:8}});
	//TweenFilterLite.to(p, .5, {blurFilter:{blurX:0}, delay:0.6});
	
}

// -- Handlers ------------------------------------ //
function initTopMenu(w:Number, cy:Number, ny:Number):Void {
	
	var defaultWidth:Number = w;	// collapsed menu background width
	var defaultY:Number = cy;		// collapsed menu _y
	var newY:Number = ny;			// expanded menu _y
	
	// tween menu into view
	TweenFilterLite.from(topMenu, .5, { _y:0-topMenu._height-10, ease:Expo.easeOut });
		
	topMenu.onRollOver = function():Void {
		
		// tween menu down
		TweenFilterLite.to(this, .5, { _y:newY, ease:Expo.easeOut });
		
		// tween bg/mask width to 100%
		TweenFilterLite.to(this.bg, .5, { _xscale:100, ease:Expo.easeOut });
		TweenFilterLite.to(this.msk, .5, { _xscale:100, ease:Expo.easeOut });
		
		// tween text alpha to 100
		TweenFilterLite.to(this.txt, .5, { _alpha:100, ease:Expo.easeOut });
		
		// hide text on stage
		TweenFilterLite.to(copy4, .5, { _alpha:0, ease:Expo.easeOut });
		TweenFilterLite.to(copy5, .5, { _alpha:0, ease:Expo.easeOut });
		
		// tween close button
		TweenFilterLite.to(this.details, .5, { _y:151, ease:Expo.easeOut });
	};
	
	topMenu.onRollOut = function():Void {
		TweenFilterLite.to(this, .5, { _y:defaultY, ease:Expo.easeOut });
		TweenFilterLite.to(this.bg, .5, { _width:defaultWidth, ease:Expo.easeOut });
		TweenFilterLite.to(this.msk, .5, { _xscale:0, ease:Expo.easeOut });
		TweenFilterLite.to(this.txt, .5, { _alpha:0, ease:Expo.easeOut });
		TweenFilterLite.to(copy4, .5, { _alpha:100, ease:Expo.easeOut });
		TweenFilterLite.to(copy5, .5, { _alpha:100, ease:Expo.easeOut });
		TweenFilterLite.to(this.details, .5, { _y:133, ease:Expo.easeOut });
	};
	
	topMenu.onRelease = topMenu.onRollOut;
	
	
};

function initBottomMenu():Void {
	
	TweenFilterLite.from(bottomMenu, .5, { _y:Stage.height+10, ease:Expo.easeOut, onComplete:shimmerCTA });
	
	bottomMenu.onRollOver = function():Void {
		shimmerCTA();
	};
	
	bottomMenu.onRelease = defaultClick;
};

function shimmerCTA():Void {
	bottomMenu.cta.gotoAndPlay("shimmer");
	bottomMenu.card.gotoAndPlay("shimmer");
};

hotspot.onRelease = defaultClick;

// -- Click Functions --------------------------- //
function defaultClick():Void {
	// _root.conduit.exit(1);
	getURL(_root.clickTag, "_blank");
};
