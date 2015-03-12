
class bannerController_acc extends MovieClip {
	
	private var _scope:MovieClip;
	private var scope:MovieClip;
		
	
	public function bannerController_acc(scope:MovieClip) {
		_scope = scope;
		trace(_scope);
		initHotspot();
	}
	
	
	public function initHotspot():Void {
		_root.hotspot.scope = this._scope;
		_root.hotspot.useHandCursor = false;
		//_root.hotspot.onRelease = defaultClick;  
		// MOVING THE CTA AND HOTSPOT CODE TO THE INSTANCES PER YAHOO REQUEST
		// - for BookOrBuyIt, ExpertAdvisor, NotAutomated, ZeroTravelRestrictions banners
	}
	
	
	public function initRollover():Void {
		_root.bg.play();
		_scope.card.gotoAndPlay("shimmer");
		_scope.cta.holder.gotoAndPlay("shimmer");
		_root.hotspot.onRollOver = defaultRollover;
	}
	
	/*  MOVING THE CTA AND HOTSPOT CODE TO THE INSTANCES PER YAHOO REQUEST
	     - for BookOrBuyIt, ExpertAdvisor, NotAutomated, ZeroTravelRestrictions banners
	private function defaultClick():Void {
		trace("die plz");
		_root.getURL(_root.clickTag, "_blank");
		trace("didn't get url");
	}
	*/
	
	
	private function defaultRollover():Void {
		if(this.scope.card._currentframe == 1) {
			_root.bg.play();
			this.scope.card.gotoAndPlay("shimmer");
			this.scope.cta.holder.gotoAndPlay("shimmer");
		}
	}
}