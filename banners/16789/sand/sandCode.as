
//   sandCode.as    
 
// import classes.utils.Params; 
import classes.tweening.TweenLite;
import classes.tweening.Expo;
import classes.tweening.Linear;

/*
// ---- DART + FORM SUBMISSION --------------------- //     
// using _root.clickTag for DART call
var _submitString:String = "http://staging.chasefreedomnow.com";
var paramObjectRef:String = "ID_SAND_1";    
var _paramsString:String; 

_paramsString = "?";

// site params
_paramsString += "b=" + Params[paramObjectRef].b;
_paramsString += "&o=" + Params[paramObjectRef].o;

// UTM tracking  
_paramsString += "&utm_source=" + Params[paramObjectRef].utm_source;  
_paramsString += "&utm_medium=" + Params[paramObjectRef].utm_medium;  
_paramsString += "&utm_campaign=" + Params[paramObjectRef].utm_campaign;
_paramsString += "&utm_content=" + Params[paramObjectRef].utm_content;
*/


// -- Tweening Functions -------------------------- //
var TEXT_SPEED:Number = .5;
var TEXT_DELAY:Number = .2;
var STAGE_PADDING:Number = 20;

function alphaTween(mc:MovieClip, num:Number):Void {
	TweenLite.to(mc, TEXT_SPEED, { _alpha:num });
};

function xTween(mc:MovieClip, dlay:Number):Void {
	TweenLite.from(mc, TEXT_SPEED, { _x:-(STAGE_PADDING)-mc._width, ease:Expo.easeOut, delay:dlay });
};

function bgTween(yPos:Number):Void {
	TweenLite.to(bg, 4, { _y:yPos, ease:Linear.easeOut });
};

// -- Handlers ------------------------------------ //
function initTopMenu(w:Number, cy:Number, ny:Number):Void {
	
	var defaultWidth:Number = w;		// collapsed menu background width
	var defaultY:Number = cy;		// collapsed menu _y
	var newY:Number = ny;			// expanded menu _y
	
	// tween menu into view
	TweenLite.from(topMenu, .5, { _y:0-topMenu._height-10, ease:Expo.easeOut });
		
	topMenu.onRollOver = function():Void {
		
		// tween menu down
		TweenLite.to(this, .5, { _y:newY, ease:Expo.easeOut });
		
		// tween bg/mask width to 100%
		TweenLite.to(this.bg, .5, { _xscale:100, ease:Expo.easeOut });
		TweenLite.to(this.msk, .5, { _xscale:100, ease:Expo.easeOut });
		
		// tween text alpha to 100
		TweenLite.to(this.txt, .5, { _alpha:100, ease:Expo.easeOut });
		
		// hide text on stage
		TweenLite.to(copy4, .5, { _alpha:0, ease:Expo.easeOut });
		TweenLite.to(copy5, .5, { _alpha:0, ease:Expo.easeOut });
		
		// tween close button
		TweenLite.to(this.details, .5, { _y:151, ease:Expo.easeOut });
	};
	
	topMenu.onRollOut = function():Void {
		TweenLite.to(this, .5, { _y:defaultY, ease:Expo.easeOut });
		TweenLite.to(this.bg, .5, { _width:defaultWidth, ease:Expo.easeOut });
		TweenLite.to(this.msk, .5, { _xscale:0, ease:Expo.easeOut });
		TweenLite.to(this.txt, .5, { _alpha:0, ease:Expo.easeOut });
		TweenLite.to(copy4, .5, { _alpha:100, ease:Expo.easeOut });
		TweenLite.to(copy5, .5, { _alpha:100, ease:Expo.easeOut });
		TweenLite.to(this.details, .5, { _y:133, ease:Expo.easeOut });
	};
	
	topMenu.onRelease = topMenu.onRollOut;
};

function initBottomMenu():Void {
	
	if(Stage.width == 728 || Stage.width == 468) {
		TweenLite.from(bottomMenu, .5, { _y:-10-bottomMenu._height, ease:Expo.easeOut, onComplete:shimmerCTA });
	} else {
		TweenLite.from(bottomMenu, .5, { _y:Stage.height+10, ease:Expo.easeOut, onComplete:shimmerCTA });
	};
	
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
	// trace("_submitString + _paramsString: " + _submitString + _paramsString);
	// loadMovieNum(_root.clickTag, 10); // for DART tracking
	// getURL(_submitString + _paramsString, "_blank"); // for our GET or POST FORM SUBMIT
	// getURL(_root.clickTag, "_blank");
};
