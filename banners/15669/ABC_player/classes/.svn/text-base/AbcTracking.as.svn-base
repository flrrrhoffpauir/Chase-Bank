import mx.utils.Delegate;
import classes.utils.EventManager

class classes.AbcTracking {
	
	// private properties
	private var _result_lv:LoadVars;
	private var _tracking_lv:LoadVars;
	private var _tracking_date:Date;
	
	private var _view_url_array:Array;
	private var _cta_url_array:Array;
	
	private var _view_url:String;
	private var _cta_url:String;
	
	private var _tracking_id:Number;
	
	// Constructor
	public function AbcTracking() {
				
		// update these arrays for corresponding nav items
		// this only corresponds to nav items, not ad pods
		// for ad pod 0 and the pause ad, use the NoNavTracking class
		
		_view_url_array = ["http://ad.doubleclick.net/ad/N2886.T3ABC111/B2658340;sz=1x1;ord=",
		"http://ad.doubleclick.net/ad/N2886.T3ABC111/B2658340.2;sz=1x1;ord=",
		"http://ad.doubleclick.net/ad/N2886.T3ABC111/B2658340.3;sz=1x1;ord="];
		
		_cta_url_array = ["http://ad.doubleclick.net/clk;196734664;25670557;w?http://www.chasewhatmatters.com/?utm_source=abc&utm_medium=banner&utm_content=full%2Bepisode%2Bplayer&utm_campaign=onebrand2008", 
		"http://ad.doubleclick.net/clk;196734664;25670584;w?http://www.chasewhatmatters.com/?utm_source=abc&utm_medium=banner&utm_content=full%2Bepisode%2Bplayer&utm_campaign=onebrand2008", 
		"http://ad.doubleclick.net/clk;196734664;25670585;x?http://www.chasewhatmatters.com/?utm_source=abc&utm_medium=banner&utm_content=full%2Bepisode%2Bplayer&utm_campaign=onebrand2008"];
		
		// set up variables for the view
		_result_lv 	= new LoadVars();
		_tracking_lv 	= new LoadVars();
		_tracking_date 	= new Date();
		
		// when a view is tracked, trace it out for testing
		_result_lv.onLoad = Delegate.create(this, traceEvent);
		
		// nav item selected, set tracking
		EventManager.addEventListener("onNavItemSelected", this, "trackItem");
	};
	
	private function trackItem(o:Object):Void {
		
		_tracking_id = o.data.id;
		
		// trace("id: " + _tracking_id);
		
		// get correct URLs
		_view_url 	= _view_url_array[_tracking_id] + _tracking_date.getTime() + "?";
		_cta_url 	= _cta_url_array[_tracking_id];
		
		// track the view url
		_tracking_lv.sendAndLoad(_view_url, _result_lv, "POST");
		
		// set the CTAs URL
		EventManager.dispatchEvent("onTrackItem", { link:_cta_url });
		
		// trace the click url
		/*
		trace("\n*************************");
		trace("CTA URL HAS BEEN SET TO:");
		trace("cta url: " + _cta_url);	
		trace("*************************\n");
		//*/
		
	};
	
	
	private function traceEvent():Void {
		
		// if the 1x1 pixel was hit for the view, trace that it was
		
		if(_result_lv.toString().substr(0, 6) == "GIF89a") {
			trace("\n*************************");
			trace("TRACKING EVENT RECEIVED BY DOUBLECLICK:");
			trace(_view_url);
			trace("*************************\n");
		} else {
			trace("\n*************************");
			trace("TRACKING EVENT FAILED:");
			trace(_view_url);
			trace("*************************\n");
		};
	};
};