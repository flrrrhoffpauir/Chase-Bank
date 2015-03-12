
//   spin_change_code.as

// import classes.utils.Params;    
import classes.tweening.TweenLite;
import classes.tweening.Expo;
import classes.tweening.Back;

/*
// ---- DART + FORM SUBMISSION --------------------- //     
// using _root.clickTag for DART call
var _submitString:String = "http://staging.chasefreedomnow.com";
var paramObjectRef:String = "ID_SPIN_CHANGE_1";    
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
//*/

// -- Tweening Functions -------------------------- //
var TEXT_SPEED:Number = .5;
var TEXT_DELAY:Number = .2;
var ITEM_SPEED:Number = .4;
var STAGE_PADDING:Number = 20;

function xTween(mc:MovieClip, dlay:Number):Void {
	TweenLite.from(mc, TEXT_SPEED, { _x:-(STAGE_PADDING)-mc._width, ease:Expo.easeOut, delay:dlay });
};

function xTweenTo(mc:MovieClip, num:Number, dlay:Number):Void {
	TweenLite.to(mc, ITEM_SPEED, { _x:num, ease:Back.easeOut, delay:dlay });
};

function xTweenFrom(mc:MovieClip, dlay:Number):Void {
	TweenLite.from(mc, ITEM_SPEED, { _x:Stage.width+STAGE_PADDING, ease:Back.easeOut, delay:dlay });
};

function yTween(mc:MovieClip, dlay:Number):Void {
	TweenLite.from(mc, TEXT_SPEED, { _y:-(STAGE_PADDING)-mc._height, ease:Expo.easeOut, delay:dlay });
};

function yTweenTo(mc:MovieClip, num:Number, dlay:Number):Void {
	TweenLite.to(mc, ITEM_SPEED, { _y:num, ease:Back.easeOut, delay:dlay });
};

function yTweenFrom(mc:MovieClip, dlay:Number):Void {
	TweenLite.from(mc, ITEM_SPEED, { _y:Stage.height+STAGE_PADDING, ease:Back.easeOut, delay:dlay });
};

function fadeTween(mc:MovieClip, num:Number):Void {
	TweenLite.to(mc, TEXT_SPEED, { _alpha:num });
};

function backYTweenFrom(mc:MovieClip):Void {
	TweenLite.from(mc, ITEM_SPEED, { _y:Stage.height+STAGE_PADDING, ease:Back.easeOut });
};
  
// inits
switch(bsize)
{
	case 300 :
		// not needed
		break;
	case 120 :
		var counter:Number = 0;
		var nextY = 20;	
		break;
	case 160 :
		var counter:Number = 0;
		var nextY = 0;
		break;
	case 468 :
		// not built yet!!!
		break;
	case 728 :
		// not built yet!!!
		break;
}

function backXTweenTo(mc:MovieClip, dlay:Number):Void {
	// determine functionality based on bsize of banner
	switch(bsize)
	{
		case 300 :
			// USES backYTweenTo()
			break;
		case 120 :
			if (counter == 1) nextY = 55;
		    if (counter == 2) nextY = 90;
			counter++;
		    TweenLite.to(mc, ITEM_SPEED, { _y:mc._y - nextY, _x:Stage.width/2, _xscale:87, _yscale:87, ease:Back.easeInOut, delay:dlay });
			break;
		case 160 :
			if (counter == 1) nextY = 60;
			if (counter == 2) nextY = 120;
			counter++;
			TweenLite.to(mc, ITEM_SPEED, { _y:mc._y - nextY, _x:Stage.width/2, _xscale:75, _yscale:75, ease:Back.easeInOut, delay:dlay });
			break;
		case 468 :
			// not built yet!!!
			break;
		case 728 :
			// not built yet!!!
			break;
	}
};  


function backYTweenTo(mc:MovieClip, dlay:Number):Void {
	// determine functionality based on bsize of banner
	switch(bsize)
	{
		case 300 :
			TweenLite.to(mc, ITEM_SPEED, { _y:Stage.height+STAGE_PADDING, ease:Back.easeIn, delay:dlay });
			break;
		case 120 :
			// USES backXTweenTo()
			break;
		case 160 :
			// USES backXTweenTo()
			break;
		case 468 :
			// not built yet!!!
			break;
		case 728 :
			// not built yet!!!
			break;
	}
};


// -- Handlers ------------------------------------ //
function initTopMenu(w:Number, cy:Number, ny:Number):Void {
	
	var defaultWidth:Number = w;	// collapsed menu background width
	var defaultY:Number = cy;		// collapsed menu _y
	var newY:Number = ny;			// expanded menu _y
	
	TweenLite.from(topMenu, .5, { _y:0-topMenu._height-10, ease:Expo.easeOut });
		
	topMenu.onRollOver = function():Void {
		// determine _xscale for size of banner
		var bgXScaleVal:Number;
		switch(bsize)
		{
			case 300 :
				bgXScaleVal = 100;
				break;
			case 120 :
				bgXScaleVal = 68;
				break;
			case 160 :
				bgXScaleVal = 93;
				break;
			case 468 :
				// not built yet!!!
				break;
			case 728 :
				// not built yet!!!
				break;
		}
		
		TweenLite.to(this, .5, { _y:newY, ease:Expo.easeOut });		
		TweenLite.to(this.bg, .5, { _xscale:xScaleVal, ease:Expo.easeOut });
		TweenLite.to(this.msk, .5, { _xscale:100, ease:Expo.easeOut });
		TweenLite.to(this.txt, .5, { _alpha:100, ease:Expo.easeOut });
		TweenLite.to(copy6, .5, { _alpha:0, ease:Expo.easeOut });
		TweenLite.to(copy7, .5, { _alpha:0, ease:Expo.easeOut });
		TweenLite.to(this.details, .5, { _y:151, ease:Expo.easeOut });
		this.hotspot.enabled = true;
	};
	
	topMenu.onRollOut = function():Void {
		TweenLite.to(this, .5, { _y:defaultY, ease:Expo.easeOut });
		TweenLite.to(this.bg, .5, { _width:defaultWidth, ease:Expo.easeOut });
		TweenLite.to(this.msk, .5, { _xscale:0, ease:Expo.easeOut });
		TweenLite.to(this.txt, .5, { _alpha:0, ease:Expo.easeOut });
		TweenLite.to(copy6, .5, { _alpha:100, ease:Expo.easeOut });
		TweenLite.to(copy7, .5, { _alpha:100, ease:Expo.easeOut });
		TweenLite.to(this.details, .5, { _y:133, ease:Expo.easeOut });
		this.hotspot.enabled = false;
	};
	
	topMenu.onRelease = topMenu.onRollOut;
};

function initBottomMenu():Void {
	
	TweenLite.from(bottomMenu, .5, { _y:Stage.height+10, ease:Expo.easeOut, onComplete:shimmerCTA });
	
	bottomMenu.onRollOver = function():Void {
		shimmerCTA();
	};
	
	bottomMenu.onRelease = defaultClick;
};

function shimmerCTA():Void {
	bottomMenu.cta.gotoAndPlay("shimmer");
	bottomMenu.card.gotoAndPlay("shimmer");
};

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

// -- Items --------------------------------------- // 
// inits
var item0PlacementArray:Array;
var item1PlacementArray:Array;
switch(bsize)
{
	case 300 :
	    item0PlacementArray = [72, 20];
		item1PlacementArray = [106];
		break;
	case 120 :
		item0PlacementArray = [240, 175];
		item1PlacementArray = [310]; 
		break;
	case 160 :
		item0PlacementArray = [240, 175];
		item1PlacementArray = [310]; 
		break;
	case 468 :
		// not built yet!!!
		break;
	case 728 :
		// not built yet!!!
		break;
}

hotspot.onRelease = defaultClick;

// -- Click Functions --------------------------- //
function defaultClick():Void {
	// trace("_submitString + _paramsString: " + _submitString + _paramsString);
	// loadMovieNum(_root.clickTag, 10); // for DART tracking
	// getURL(_submitString + _paramsString, "_blank"); // for our GET or POST FORM SUBMIT
	getURL(_root.clickTag, "_blank");
};

