
class bannerController extends MovieClip {
	
	private var _scope:MovieClip;
	private var _pauseInterval:Number;
		
	
	public function bannerController(scope:MovieClip) {
		_scope = scope;
		initHotspot();
	}
	
	
	public function initHotspot():Void {
		_scope.hotspot.onRelease = defaultClick;
	}
	
	
	public function initRollover():Void {
		_scope.bg.play();
		_scope.card.gotoAndPlay("shimmer");
		_scope.cta.holder.gotoAndPlay("shimmer");
		_scope.hotspot.onRollOver = defaultRollover;
	}
	
	
	private function defaultClick():Void {
		_root.getURL(_root.clickTag, "_blank");
	}
	
	
	private function defaultRollover():Void {
		if(this._parent.card._currentframe == 1) {
			this._parent.bg.play();
			this._parent.card.gotoAndPlay("shimmer");
			this._parent.cta.holder.gotoAndPlay("shimmer");
		}
	}
	
	
	public function pauseTl( t:Number ):Void {
		_scope.stop();
		clearInterval(_pauseInterval);
		_pauseInterval = setInterval(this, "unpauseTl", t*1000);
	}
	
	
	private function unpauseTl():Void {
		_scope.play();
		clearInterval(_pauseInterval);
	}
}