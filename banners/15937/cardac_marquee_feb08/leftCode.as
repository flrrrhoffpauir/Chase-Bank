/*
*  Left Marquee
*  Created on 2008-02-21
*
*/


import utils.EventManager;
import utils.tweening.TweenLite;
import utils.tweening.Expo;
import utils.TypeWriter;


// constants

// private properties
var __left_lc:LocalConnection;

var __currCardNum,__lastCardNum:Number;
var __cardChanged:Boolean = false;

var __cardWatchID:Number;

// public properties
var main_btn:Button;
var anim_mc,mcHeadline:MovieClip;



/**
 *   Initializes
 */
function init():Void
{
	// halt the timeline
	stop();
	
	// force the quality
	_quality = "BEST";
	
	anim_mc.mcBullets0._y = anim_mc.mcBullets1._y = anim_mc.mcBullets2._y = 100;
	
	anim_mc.mcDummyL.onRelease = function():Void {};
	anim_mc.mcDummyL.useHandCursor = false;
	
	// set up the local connections		
	__left_lc = new LocalConnection();
	__left_lc.connect("left");
	__left_lc.isLeftLoaded = isLeftLoadedStatus;
	__left_lc.removeLeftInitRollOver = removeLeftInitRollOverNow; // discard __scope.main_btn.onRollOver
	//__left_lc.startLeftAnimations = Delegate.create(this, startLeftAnimationsNow);
	
	__left_lc.newCardSelected = function(_newCardNum:Number):Void
	{
		__currCardNum = _newCardNum;
		trace("Left has rec'd the new card number: " + __currCardNum);
		TweenLite.to(anim_mc.mcHeadline, 0.5, { _y:anim_mc.mcHeadline._y - 20, _alpha:0, ease:Expo.easeOut });
	}
	
	//main_btn.onRollOver = mainBtnOver;
	
	main_btn.onRelease = ctaRelease;
	
	// start typing the mcHeadline.txtHeadline1 & mcHeadline.txtHeadline2 TextFields
	TypeWriter.startTyping(anim_mc.mcHeadline.txtHeadline1, "REWARD YOURSELF", { speed:33, toUppercase:true });
	TypeWriter.startTyping(anim_mc.mcHeadline.txtHeadline2, "THE WAY YOU WANT.", { speed:33, delay:.6, toUppercase:true });
	

	__lastCardNum = 10;
	__currCardNum = 10;

	clearInterval(__cardWatchID);
	__cardWatchID = setInterval(this, "watchCardChangeAndAnimate", 50);
	
};

function isLeftLoadedStatus():Void
{		
	__left_lc.send("right", "isLoaded");
	trace("yeah - i'm loaded. telling the right i am now...");
	//anim_mc.gotoAndPlay(1);
};

function removeLeftInitRollOverNow():Void
{
	trace("Left is removing init main_btn.onRollOver");
	delete main_btn.onRollOver;
	main_btn.onRollOver = null;
};

function mainBtnOver():Void
{
	// notify the Right to discard it's __scope.main_btn.onRollOver
	// as it's merely meant to track initial user interaction and 
	// for the Right to reveal the mcCTA
	__left_lc.send("right", "removeRightInitRollOver");
	removeLeftInitRollOverNow();
};

function watchCardChangeAndAnimate():Void
{
	if(__lastCardNum != __currCardNum)
	{
		trace("cards changed");
		displayCardRelatedText();
		resetTextAssets();
		__lastCardNum = __currCardNum;
	}
};

// type in the header, animate the new bullets onto the Stage 
function displayCardRelatedText():Void
{
	anim_mc.txtBulletHeadline.text = " ";
	switch(__currCardNum)
	{
		case 0:
			//
			TypeWriter.startTyping(anim_mc.txtBulletHeadline, "AUTOMATICALLY EARN TRIPLE", { speed:33, toUppercase:true });
			TweenLite.to(anim_mc.mcBullets0, 0.3, { _alpha:100, _y:25, delay:0.5, ease:Expo.easeOut });
			break;
		case 1:
			//
			TypeWriter.startTyping(anim_mc.txtBulletHeadline, "CHOOSE YOUR REWARDS", { speed:33, toUppercase:true });
			TweenLite.to(anim_mc.mcBullets1, 0.5, { _alpha:100, _y:24, delay:0.5, ease:Expo.easeOut });
			break;
		case 2:
			//
			TypeWriter.startTyping(anim_mc.txtBulletHeadline, "EARN FREE CASH", { speed:33, toUppercase:true });
			TweenLite.to(anim_mc.mcBullets2, 0.5, { _alpha:100, _y:24, delay:0.5, ease:Expo.easeOut });
			break;
	}
};

// animate the prev bullets off the Stage 
function resetTextAssets():Void
{
	anim_mc.txtBulletHeadline.text = " ";
	switch(__lastCardNum)
	{
		case 0:
			//
			TweenLite.to(anim_mc.mcBullets0, 0.3, { _alpha:0, _y:23, ease:Expo.easeOut, onComplete:function(){ anim_mc.mcBullets0._y = 100; }});
			break;
		case 1:
			//
			TweenLite.to(anim_mc.mcBullets1, 0.3, { _alpha:0, _y:23, ease:Expo.easeOut, onComplete:function(){ anim_mc.mcBullets1._y = 100; }});
			break;
		case 2:
			//
			TweenLite.to(anim_mc.mcBullets2, 0.3, { _alpha:0, _y:23, ease:Expo.easeOut, onComplete:function(){ anim_mc.mcBullets2._y = 100; }});
			if(anim_mc.mcDummyL._y != -2000) { anim_mc.mcDummyL._y = -2000; };
			break;
	}
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




init();



// end
