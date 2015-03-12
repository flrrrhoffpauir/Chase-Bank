/*
*  Right Marquee
*  Created on 2008-02-21
*
*/

import utils.EventManager;
import utils.tweening.TweenLite;
import utils.tweening.Expo;



var __isLoadedID:Number;
var __right_lc:LocalConnection;
var __currCardNum:Number;

var __autoCardID:Number;
var __initialPauseID:Number;
var __autoCardCount:Number = 0;
var __initialPauseCount:Number = 0;


var __inactivityID:Number; 
var __inactivityCount:Number = 0;
var __inactivityLimit:Number = 22; // this should be set to 30 secs, it will then swap cards
var __cardRotation:Number;

var __ctaRevealed:Boolean = false;
var __rollOverBadgeRevealed:Boolean = false;


var url_string_0:String = "URL_string0";
var url_string_1:String = "URL_string1";
var url_string_2:String = "URL_string2";


var main_btn:Button;
var anim_mc:MovieClip;


function init():Void
{
	// registers listeners
	EventManager.addEventListener("onNewCardSelected", this, "notifyLeftCardChange");
	EventManager.addEventListener("onCTARelease", this, "ctaRelease");
	EventManager.addEventListener("onResetInactivityWatch", this, "resetInactivityWatchCount");
	
	// halt the Timeline
	stop();
	
	// force the quality
	_quality = "BEST";

	// set up the local connections		
	__right_lc = new LocalConnection();
	__right_lc.connect("right");
	__right_lc.isLoaded = leftIsLoaded;		
	__right_lc.removeRightInitRollOver = removeRightInitRollOverNow;
	
	//main_btn.onRollOver = mainBtnOver;
	
	main_btn.onRelease = ctaRelease;
	
	anim_mc.mcDummy.onRelease = function():Void {};
	anim_mc.mcDummy.useHandCursor = false;
	
	// query the left swf for load status
	clearInterval(__isLoadedID); 
	__isLoadedID = setInterval(this, "leftLoadedRequest", 100);
	
	// hide the mcRollOver badge, mcCTA
	anim_mc.mcRollOver._y -= 150;
	anim_mc.mcCTA._y += 100;
	
};


/**
 *  Call the Left hand swf of the marquee and checking it's status.
 */
function leftLoadedRequest():Void { __right_lc.send("left", "isLeftLoaded"); };

/**
 *  Handle notification from the Left hand swf of the marquee that it's loaded.
 */
function leftIsLoaded():Void
{
	clearInterval(__isLoadedID);
	trace("Left is loaded so let's get started.");
	
	// ***************  start the show  ****************************************************
	EventManager.dispatchEvent("onShowCards", this); // reveal the cards
	// start the auto cycle throught the cards, when complete start the watch
	// __rollOverBadgeRevealed = true;
	// TweenLite.to(anim_mc.mcRollOver, 0.5, { _alpha:100, _y:anim_mc.mcRollOver._y + 150, delay:0.5, ease:Expo.easeOut }); // and the mcRollOver badge   *************************************
	//_global.setTimeout(_root, "autoDisplayCardsAtStart", 1000);
	initialPause();
};


function initialPause():Void
{
	trace("\ninitialPause() called");
	clearInterval(__initialPauseID);
	__initialPauseID = setInterval(this, "countPause", 1000);
}

function countPause():Void
{
	__initialPauseCount++;
	trace("__initialPauseCount: " + __initialPauseCount);
	if(__initialPauseCount == 4)
	{
		autoDisplayCardsAtStart();
		clearInterval(__initialPauseID);
	}
}



function autoDisplayCardsAtStart():Void
{
	trace("\nautoDisplayCardsAtStart() called");
	clearInterval(__autoCardID);
	__autoCardID = setInterval(this, "autoCycleCardsAtStart", 10000);
	// notify the CardManager to switch out the cards
	EventManager.dispatchEvent("onSwitchCards", this);
}

function autoCycleCardsAtStart():Void
{
	__autoCardCount++;
	// notify the CardManager to switch out the cards
	EventManager.dispatchEvent("onSwitchCards", this);
	if(__autoCardCount >= 3)
	{
		autoDisplayComplete();
		clearInterval(__autoCardID);
	}
}

function autoDisplayComplete():Void
{
	clearInterval(__inactivityID);
	__inactivityID = setInterval(this, "watchInactivity", 1000);
	
	//main_btn.onRollOver = mainBtnOver;
	initShowApplyNowCTA();
	__ctaRevealed = true;
	
	anim_mc.mcDummy._y = -2000; // displace the dummy
	
	// display the mcRollOver badge
	__rollOverBadgeRevealed = true;
	TweenLite.to(anim_mc.mcRollOver, 0.5, { _alpha:100, _y:anim_mc.mcRollOver._y + 150, delay:0.5, ease:Expo.easeOut });	
}





/**
 *  Call the Left hand swf of the marquee and check it's status.
 */
function removeRightInitRollOverNow():Void
{
	trace("Right is removing init main_btn.onRollOver and showing mcCTA");
	delete main_btn.onRollOver;
	main_btn.onRollOver = null;
	initShowApplyNowCTA();
	__ctaRevealed = true;
};

function mainBtnOver():Void
{
	// notify the Left to discard it's __scope.main_btn.onRollOver
	// as it's merely meant to track initial user interaction 
	// and for this side to reveal the mcCTA
	__right_lc.send("left", "removeLeftInitRollOver");
	removeRightInitRollOverNow();
};

/**
 *  tell the left side to start animating
 */
function startLeftAnimations():Void
{
	__right_lc.send("left", "startLeftAnimations");
}

/**
 *  reveal the cta 
 */
function initShowApplyNowCTA():Void
{		
	TweenLite.to(anim_mc.mcCTA, 0.5, { _y:anim_mc.mcCTA._y - 100, ease:Expo.easeOut });
};


/**
 *  notified by the CTA Class that btn was clicked. Using the current card in focus, 
 *  process the appropriate query string.
 */
function ctaRelease():Void
{
	// change of plan - one size fits all
	getURL("http://resources.chase.com/ViewAd.aspx?AD=|||33468|||", "_blank");
	/*
	switch(__currCardNum)
	{
		case 0:
			//
			var qString:String = url_string_0;
			break;
		case 1:
			//
			var qString:String = url_string_1;
			break;
		case 2:
			//
			var qString:String = url_string_2;
			break;
		default :
			//
			var qString:String = url_string_0;
			break;
	}
	//getURL(qString, "_blank"); 
	*/
};


/**
 *  xxxxxxxxxxxxxxxxxxxxx
 *
 *  @param _evt The event Object
 */
function notifyLeftCardChange(_evt:Object):Void
{
	// notify the Left to start animation related to new Card selected
	__currCardNum = _evt.data.cardNum;
	__right_lc.send("left", "newCardSelected", _evt.data.cardNum);
};


function watchInactivity():Void
{
	__inactivityCount++;
	if(__inactivityCount >= __inactivityLimit)
	{
		__inactivityCount = 0;
		
		// reveal the cta mainBtnOver()
		if(__ctaRevealed == false) { mainBtnOver(); };
		if(__rollOverBadgeRevealed == false)
		{
			__rollOverBadgeRevealed = true; 
			TweenLite.to(anim_mc.mcRollOver, 0.5, { _alpha:100, _y:anim_mc.mcRollOver._y + 150, delay:0.5, ease:Expo.easeOut }); // and the mcRollOver badge
		}
		
		// notify the CardManager to switch out the cards
		EventManager.dispatchEvent("onSwitchCards", this);
	}
}

function resetInactivityWatchCount():Void
{
	trace("resetInactivityWatchCount");
	__inactivityCount = 0;
}


// start the app
init();



// end
