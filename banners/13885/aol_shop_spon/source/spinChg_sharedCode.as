﻿// 13885_spinChg_sharedCode.asimport Tweens;// variables  -------------------------------------------------------------------------------------_quality = "BEST";var replayInt:Number;var ctaStartScale:Number = 100;var ctaEndScale:Number = 108;_global._tweens = new Tweens();// functions  -------------------------------------------------------------------------------------function defaultClick():Void {	getURL(_root.clickTag, "_blank");}function showCTA():Void{	cta_mc.onRollOver = function():Void	{		_tweens.scaleTween(this, ctaStartScale, ctaEndScale, .25);		this.gotoAndPlay("shimmer");	}	cta_mc.onRollOut = function():Void	{		_tweens.scaleTween(this, ctaEndScale, ctaStartScale, .25);	}	cta_mc.onRelease = defaultClick;	_tweens.yTween(cta_mc, cta_mc._y + 100, cta_mc._y, .5);	}function splitClip(clip:MovieClip, theDirection:String, splitDistance:Number):Void{	var amt:Number = (theDirection == "left") ? -splitDistance : splitDistance;	_tweens.xTween(clip, clip._x, clip._x + amt, .4);	_tweens.fadeTween(clip, clip._alpha, 0, .4);}function joinClip(clip:MovieClip, theDirection:String, splitDistance:Number):Void{	var amt:Number = (theDirection == "left") ? -splitDistance : splitDistance;	_tweens.xTween(clip, clip._x + amt, 0, .4);	_tweens.fadeTween(clip, clip._alpha, 100, .4);}// handlers  --------------------------------------------------------------------------------------hotSpot_btn.onRelease = defaultClick;// run at once  -----------------------------------------------------------------------------------