
// Main.as
// Created by Junie Threatt
// on 2008-08-22

import classes.utils.EventManager;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;
import mx.utils.Delegate;

class classes.views.Main {
	
	// private properties
	private var _scope:MovieClip;
	private var _mcLoader:MovieClipLoader;
	private var _mcListener:Object;
	private var _mcTarget:MovieClip;
	private var _launcherDelay:Number = 5;
	
	// local / live
	private var _swfArray:Array = ["17229_nbc_game_launcher.swf", "17229_nbc_game_matchPoints.swf", "17229_nbc_game_getQuizzical.swf"];
	// private var _swfArray:Array = ["http://video.nbcuni.com/ads/swf/17229_nbc_game_launcher.swf", "http://video.nbcuni.com/ads/swf/17229_nbc_game_matchPoints.swf", "http://video.nbcuni.com/ads/swf/17229_nbc_game_getQuizzical.swf"];
	
	// static properties
	private static var SPEED:Number = .5;
	private static var EASE:Function = Expo.easeOut;
	
	// constructor	
	public function Main(scope:MovieClip) {
		
		_scope = scope;
		
		EventManager.addEventListener("onShoeRelease", this, "loadShoe");
		EventManager.addEventListener("onGiftRelease", this, "loadGift");
		EventManager.addEventListener("onCloseRelease", this, "exitGame");
		
		initClipLoader();
		
		// wait a few, then show game launcher
		_global.setTimeout(this, "showGameLauncher", _launcherDelay*1000);
	}
	
	// init clip loader and listener
	private function initClipLoader():Void {
		_mcLoader = new MovieClipLoader();
		_mcListener = {};
		_mcListener.onLoadInit = Delegate.create(this, mcLoaded);
		_mcLoader.addListener(_mcListener);
	}
	
	// loads game launcher
	private function showGameLauncher():Void { _scope.launcherContainer.loadMovie(_swfArray[0]); };
	
	// called when clip is loaded through movie clip loader
	private function mcLoaded(targetMc:MovieClip):Void {
		_mcTarget = targetMc;
		
		TweenFilterLite.from(_scope["gameContainer"].panel, SPEED, { _y:Stage.height+10, ease:EASE });
		TweenFilterLite.from(_scope["gameContainer"].bg, SPEED, { _alpha:0, delay:SPEED/2, ease:EASE });
	}
	
	// load match points game
	private function loadShoe():Void {
		_mcLoader.unloadClip(_scope["gameContainer"]);
		_mcLoader.loadClip(_swfArray[1], _scope["gameContainer"]);
		_scope.c.toggleClouds("off");
		_scope.flashes.gotoAndStop("stop");
	}
	
	// load gift game
	private function loadGift():Void {
		_mcLoader.unloadClip(_scope["gameContainer"]);
		_mcLoader.loadClip(_swfArray[2], _scope["gameContainer"]);
		_scope.c.toggleClouds("off");
		_scope.flashes.gotoAndStop("stop");
	}
	
	// exit animation for whichever game is playing
	private function exitGame():Void {
		TweenFilterLite.to(_scope["gameContainer"].panel, SPEED, { _y:Stage.height+10, ease:EASE });
		TweenFilterLite.to(_scope["gameContainer"].bg, SPEED, { _alpha:0, delay:SPEED, ease:EASE, onComplete:Delegate.create(this, unloadGame) });
	}
	
	private function unloadGame():Void {		
		_mcLoader.unloadClip(_mcTarget);
		_scope.c.toggleClouds("on");
		_scope.flashes.play();
	}
	
	// init products on the canvases
	public function xTween(mc:MovieClip):Void { TweenFilterLite.from(mc, SPEED, { _x:Stage.width+10, ease:EASE }); };
	
	// actually only used for the video player on canvas0
	public function yTween(mc:MovieClip):Void { TweenFilterLite.from(mc, SPEED*2, { _y:-mc._height-10, ease:EASE }); };
	public function aTween(mc:MovieClip):Void { TweenFilterLite.from(mc, SPEED*5, { _alpha:0, _yscale:70, _xscale:70, ease:EASE }); };
	
	public function initCta():Void {
		
		_scope.cardGroup.cta.gotoAndPlay("shimmer");			
		_scope.cardGroup.cta.onRollOver = function():Void { this.gotoAndPlay("shimmer"); this._parent.card.gotoAndPlay("shimmer"); };		
		_scope.cardGroup.cta.onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_main" }); };
		
		_scope.cardGroup.card.gotoAndPlay("shimmer");
		_scope.cardGroup.card.onRollOver = function():Void { this.gotoAndPlay("shimmer"); this._parent.cta.gotoAndPlay("shimmer"); };
		_scope.cardGroup.card.onRelease = function():Void { EventManager.dispatchEvent("onExit", { loc:"_main" }); };
	}
}