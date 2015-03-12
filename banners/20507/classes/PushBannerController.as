
class PushBannerController extends MovieClip {
	
	private var _scope:MovieClip;
	private var _hasInit:Boolean = false;
		
	
	public function PushBannerController(scope:MovieClip) {
		_scope = scope;
		initHotspot();
	}
	
	
	public function initHotspot():Void {
		_scope.hotspot.onRelease = defaultClick;
	}
	
	
	public function initRollover():Void {
		_scope.shimmers.play();
		_scope.card.gotoAndPlay("shimmer");
		_scope.cta.holder.gotoAndPlay("shimmer");
		
		if(_hasInit == false) {
			_hasInit = true;
			_scope.hotspot.onRollOver = defaultRollover;
		}
	}
	
	
	private function defaultClick():Void {
		// _root.getURL(_root.clickTAG, "_blank");
	}
	
	
	private function defaultRollover():Void {
		if(this._parent.card._currentframe == 1) {
			this._parent.shimmers.play();
			this._parent.card.gotoAndPlay("shimmer");
			this._parent.cta.holder.gotoAndPlay("shimmer");
		}
	}
}