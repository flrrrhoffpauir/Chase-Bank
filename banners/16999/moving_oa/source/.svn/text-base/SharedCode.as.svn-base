/**
*	CH_Retail_Moving_Get100_Aug08 Shared Code
*	Created on 2008-08-12
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2008-08-12                      
*	@version 1.0.0
*	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import gs.TweenLite;
import gs.Expo;


_quality = "best";
var mcBigPic,mxTXT1,mcTXT2,mcTXT3,mcTXT4,mcChaseChecking,mcCheckbook,mcOffer,mcCTA,mcHotSpot:MovieClip;
var _easeType:Function = Expo.easeOut;


// INITS ------------------------------------------------------------------------------------------

switch(Stage.width)
{
	case 300 :
		mcTXT1._x = mcTXT2._x = mcChaseChecking._x = mcTXT3._x = mcTXT4._x = mcCheckbook._x = mcOffer._x = -300;
		mcTXT1._alpha = mcTXT2._alpha = mcChaseChecking._alpha = mcTXT3._alpha = mcTXT4._alpha = mcCheckbook._alpha = mcOffer._alpha = 0;
		mcCTA._y = 350;
		break;
	case 120 :
		mcTXT1._x = mcTXT2._x = mcChaseChecking._x = mcTXT3._x = mcTXT4._x = mcCheckbook._x = mcOffer._x = mcCTA._x = -300;
		mcTXT1._alpha = mcTXT2._alpha = mcChaseChecking._alpha = mcTXT3._alpha = mcTXT4._alpha = mcCheckbook._alpha = mcOffer._alpha = 0;
		break;
	case 160 :
		mcTXT1._x = mcTXT2._x = mcChaseChecking._x = mcTXT3._x = mcTXT4._x = mcCheckbook._x = mcOffer._x = mcCTA._x = -300;
		mcTXT1._alpha = mcTXT2._alpha = mcChaseChecking._alpha = mcTXT3._alpha = mcTXT4._alpha = mcCheckbook._alpha = mcOffer._alpha = 0;
		break;
	case 468 :
		mcTXT1._x = mcTXT2._x = mcChaseChecking._x = mcTXT3._x = mcTXT4._x = -300;
		mcTXT1._alpha = mcTXT2._alpha = mcChaseChecking._alpha = mcTXT3._alpha = mcTXT4._alpha = mcCheckbook._alpha = mcOffer._alpha = 0;
		mcCheckbook._y = mcOffer._y = mcCTA._y = 120;
		break;
	case 728 :
		mcTXT1._x = mcTXT2._x = mcChaseChecking._x = mcTXT3._x = mcTXT4._x = -300;
		mcTXT1._alpha = mcTXT2._alpha = mcChaseChecking._alpha = mcTXT3._alpha = mcTXT4._alpha = mcCheckbook._alpha = mcOffer._alpha = 0;
		mcCheckbook._y = mcOffer._y = mcCTA._y = 120;
		break;
}






setUpCTAReflectionMask(); // apply the reflection to the mcCTA


// FUNCTIONS --------------------------------------------------------------------------------------
function animate(obj:MovieClip, time:Number, newX:Number, newY:Number, newAlpha:Number):Void
{
	TweenLite.to(obj, time, { _x:newX, _y:newY, _alpha:newAlpha, ease:_easeType });
};

function defaultClick():Void
{
	trace("clickTag");
	getURL(_root.clickTag, "_blank");
};

function setUpCTAReflectionMask():Void
{
	// set up the reflection
	mcCTA.mcReflection.cacheAsBitmap = true;
	mcCTA.mcGradMask.cacheAsBitmap = true;
	mcCTA.mcReflection.setMask(mcCTA.mcGradMask);
};

function playCTAShimmer():Void
{
	mcCTA.mcShimmer.gotoAndPlay("shimmer");
};


// HANDLERS ---------------------------------------------------------------------------------------
mcHotSpot.onRelease = defaultClick;

mcCTA.onRelease = defaultClick;
mcCTA.onRollOver = function():Void { playCTAShimmer(); };



