/**
*      	Preloader Class
*      	Created on 2008-09-23
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-09-23
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Preloader
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenLite;
import tweening.Expo;
import tweening.Back;
import mx.utils.Delegate;

class views.Preloader extends MovieClip {
	
	private var _scope:MovieClip;
	private var _holder:MovieClip;
	private var _mcLoader:MovieClipLoader;
	private var _mcListener:Object;
	private var _loadInterval:Number;
	private var _progress:Object;
	
	public function Preloader(scope:MovieClip, holder:MovieClip) {
		_scope = scope;
		_holder = holder;
		createLoader();
		preload();
	}
	
	private function createLoader():Void {
		_mcLoader = new MovieClipLoader();
		_mcListener = {};
		_mcListener.onLoadComplete = Delegate.create(this, tweenAssets);
		_mcLoader.addListener(_mcListener);
	}
	
	private function preload():Void {
		
		// local
		// _mcLoader.loadClip("17321_flash_mod.swf", _holder);		
		
		// staging
		// _mcLoader.loadClip("http://ahnw.chase.t-3.com/cache/swfs/17321_flash_mod.swf", _holder);
		
		// live
		_mcLoader.loadClip("http://cache.chaseinformation.com/ahnw/www/swfs/17321_flash_mod.swf", _holder);
		
		clearInterval(_loadInterval);
		_loadInterval = setInterval(this, "getProgress", 10);
	}
	
	private function getProgress():Void {
		_progress = _mcLoader.getProgress(_holder);
		var perc:Number = Math.round(_progress.bytesLoaded / _progress.bytesTotal * 100);
		_scope["tab_mc"].progress_mc._xscale = perc;
		_scope["tab_mc"].t.text = "Loading " + perc + "%";
	}
	
	private function tweenAssets():Void {
		var ny:Number = (_scope._parent.utm_content == "ski") ? 21 : 109;
		TweenLite.to(_scope["tab_mc"], .5, { _y:_scope["tab_mc"]._y+40, ease:Back.easeIn, delay:.5 });
		TweenLite.to(_scope._parent["headline"], .75, { _x:78, _y:ny, ease:Expo.easeOut, delay:1.5 });
		_global.setTimeout(this, "playMovie", 500);
	};
	
	private function playMovie():Void {
		clearInterval(_loadInterval);
		_holder.gotoAndStop(2);
		
		// suddenly stopped working... HCTB
		// _holder.play();
	}
}