﻿
import TweenLite;			// default tween is Cubic
import flash.filters.BlurFilter;
import FlvPlayer;	
import mx.utils.Delegate;

// variables  -------------------------------------------------------------------------------------

_quality = "BEST";

// vars for clearing the stage
var clearSpeed:Number 	= .3;
var fadeArray:Array 	= [largePhone_mc, field4, c0, c1, c2, c3, c4, portals_mc, logo_mc];

// new FLV player
var _player:FlvPlayer;

// Functions  -------------------------------------------------------------------------------------

function blurTween(mc:MovieClip, bx:Number, by:Number):Void {
	var blur:BlurFilter = new BlurFilter(bx, by, 3);
	mc.filters = new Array(blur);
	var blur_x = TweenLite.to(blur, .2, { blurX:0, blurY:0, onComplete:stopBlur, onCompleteParams:[mc] });
};

function stopBlur(mc:MovieClip):Void {
	mc.filters = [];
};

// Collapsed state functions below

function revealAnimation():Void {
	// move mask offstage
	// set mask
	// tween it down to reveal b&w animation
	anim_mc.setMask(animMask_mc);
	animMask_mc._y = 0 - animMask_mc._height;
	TweenLite.to(animMask_mc, .7, {_y:0});
};

function pauseTL(time:Number):Void {
	// pause timeline for (time) number of seconds
	stop();
	clearInterval(pauseInterval);
	pauseInterval = setInterval(this, "unPauseTL", time * 1000);
};

function unPauseTL():Void {
	play();
	// trace("unpause");
	clearInterval(pauseInterval);
};

function animateCTA(dist:Number):Void {
	var arrow_mc:MovieClip = headline_mc.content_mc.cta_mc.arrow_mc;
	arrow_mc.ox = arrow_mc._x;
	TweenLite.to(arrow_mc, .3, {_x:arrow_mc._x + dist});
	TweenLite.to(arrow_mc, .3, {_x:arrow_mc.ox, delay: .5, overwrite:false, ease:Back.easeOut});
	
	arrow_mc._parent.gotoAndPlay("go");
};

// Expanded state functions below

function clearStage():Void {
	// remove headline
	// fade out everything in fadeArray
	TweenLite.to(headline_mc, .5, {_y:Stage.height});
	for(var i:Number = 0; i < fadeArray.length; i++) {
		TweenLite.to(fadeArray[i], clearSpeed, {_alpha:0});
	};
};

function expandBG(set_x, set_y, set_width, set_height):Void {
	
	// set speed
	var tweenSpeed:Number 	= .2;
	
	// fit mask to expanded state
	colMask_mc._width 	= Stage.width;
	colMask_mc._height 	= Stage.height;
	
	border_mc._x = set_x;
	border_mc._y = set_y;
	
	// tween background and border widths
	TweenLite.to(background_mc, tweenSpeed, { _width:Stage.width, overwrite:false });
	TweenLite.to(border_mc, tweenSpeed, 	{ _width:set_width, overwrite:false, onComplete:expandBGDown }); // add 2px hack
	TweenLite.to(background_mc, 1, { tint:0xFFFFFF, overwrite:false })
	
	// then heights
	function expandBGDown():Void {
		TweenLite.to(background_mc, tweenSpeed, { _height:Stage.height, overwrite:false });
		TweenLite.to(border_mc, tweenSpeed, 	{ _height:set_height, overwrite:false, onComplete:resumePlay });
	};
};

function initCTA():Void {
	cta_mc.onRollOver = function():Void {
		this.ctabg_mc.gotoAndPlay("shimmer");
	};
	
	cta_mc.onRelease = function():Void {
		_root.conduit.exit(2);
		//make sure you collapse or the ad will stay open after the click!
		_root.motifExpandingController.collapse();
	};
};

function showVideo():Void {
	
	// move mask offstage at bottom
	// tween back up
	expMask_mc._y = Stage.height;
	TweenLite.to(expMask_mc, .6, {_y:expMask_mc._y - expMask_mc._height});

	// same for video player
	// shimmer cta on finish
	video_mc.oy = video_mc._y;
	video_mc._y = Stage.height;
	TweenLite.to(video_mc, .6, {_y:video_mc.oy, onComplete:endBanner});
};

function endBanner():Void {
	
	// shimmer cta
	cta_mc.ctabg_mc.gotoAndPlay("shimmer");
	
	// instantiate FlvPlayer
	_player = new FlvPlayer(video_mc.play_mc, video_mc.pause_mc, video_mc.stop_mc, video_mc.mute_mc, video_mc.preview_mc, video_mc.video_vo);
};

// can't use play() with onMotionFinished for some reason
function resumePlay():Void {
	play();
};