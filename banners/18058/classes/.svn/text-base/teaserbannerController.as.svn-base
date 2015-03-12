
class teaserbannerController extends MovieClip {
	
	private var _scope:MovieClip;
		
	
	public function teaserbannerController(scope:MovieClip) {
		_scope = scope;
		initHotspot();
	}
	
	
	public function initHotspot():Void {
		_scope.hotspot.onRelease = defaultClick;
	}
	
	
	public function initRollover():Void {
		_scope.bg.play();
		_scope.shimmers.play();
		_scope.cta.holder.gotoAndPlay("shimmer");
		_scope.hotspot.onRollOver = defaultRollover;
	}
	
	
	private function defaultClick():Void {
		trace("die plz");
		_root.getURL(_root.clickTag, "_blank");
		trace("didn't get url");
	}
	
	
	private function defaultRollover():Void {
		if(this._parent.cta.holder._currentframe == 1) {
			this._parent.shimmers.play();
			this._parent.bg.play();
			this._parent.cta.holder.gotoAndPlay("shimmer");
		}
	}
}