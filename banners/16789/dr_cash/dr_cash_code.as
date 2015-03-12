 
//   dr_cash_code.as    

// import classes.utils.Params; 
import classes.tweening.TweenLite;
import classes.tweening.Expo;

/*
// ---- DART + FORM SUBMISSION --------------------- //     
// using _root.clickTag for DART call
var _submitString:String = "http://staging.chasefreedomnow.com";
var paramObjectRef:String = "ID_DR_CASH_1";   
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
var STAGE_PADDING:Number = 20;

var _pauseTime:Number = 1.5;

function xTween(mc:MovieClip, dlay:Number):Void {
	TweenLite.from(mc, TEXT_SPEED, { _x:-(STAGE_PADDING)-mc._width, ease:Expo.easeOut, delay:dlay });
};

// -- Handlers ------------------------------------ //
function initBottomMenu():Void {
	if(bsize == 468 || bsize == 728)
	{
		var dataObj:Object = { _y:-80, ease:Back.easeOut, onComplete:shimmerCTA };
	}     
	else
	{
		var dataObj:Object = { _y:Stage.height+10, ease:Expo.easeOut, onComplete:shimmerCTA };
	}
	TweenLite.from(bottomMenu, .5, dataObj);   
	
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

// -- Timing -------------------------------------- //
var pauseInterval:Number;
var timeToPause:Number = 2;

function pauseTimeLine(num:Number):Void {
	stop();
	clearInterval(pauseInterval);
	pauseInterval = setInterval(this, "playTimeLine", num*1000);
};

function playTimeLine():Void {
	play();
	clearInterval(pauseInterval);
};

// -- Click Functions --------------------------- //
function defaultClick():Void {
	// trace("_submitString + _paramsString: " + _submitString + _paramsString);
	// loadMovieNum(_root.clickTag, 10); // for DART tracking
	// getURL(_submitString + _paramsString, "_blank"); // for our GET or POST FORM SUBMIT
	getURL(_root.clickTag, "_blank");
};
