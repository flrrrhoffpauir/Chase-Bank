import mx.utils.Delegate;
import classes.utils.EventManager

class classes.NoNavTracking {
	
	// private properties
	private var _result_lv:LoadVars;
	private var _tracking_lv:LoadVars;
	private var _tracking_date:Date;
	
	private var _view_url:String;
	private var _cta_url:String;
	
	public function NoNavTracking(v:String, c:String) {
		
		// set up variables for the view
		_result_lv 	= new LoadVars();
		_tracking_lv 	= new LoadVars();
		_tracking_date 	= new Date();
		
		// get correct URLs
		_view_url 	= v + _tracking_date.getTime() + "?";
		_cta_url 	= c;
		
		// when a view is tracked, trace it out for testing
		_result_lv.onLoad = Delegate.create(this, traceEvent);
		
		// track the view
		_tracking_lv.sendAndLoad(_view_url, _result_lv, "POST");
		
		// set the CTAs URL
		EventManager.dispatchEvent("onTrackItem", { link:_cta_url });
	};
	
	private function traceEvent():Void {
		
		// if the 1x1 pixel was hit for the view, trace that it was
		
		if(_result_lv.toString().substr(0, 6) == "GIF89a") {
			trace("\n\n*************************");
			trace("TRACKING EVENT RECEIVED BY DOUBLECLICK:");
			trace(_view_url);
			trace("*************************\n\n");
		} else {
			trace("\n\n*************************");
			trace("TRACKING EVENT FAILED:");
			trace(_view_url);
			trace("*************************\n\n");
		};
	};
};