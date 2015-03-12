/**
Tracking

@author Junie Threatt
@version 1.0

@description Tracks exit urls for 2008 NBC player

*/

import classes.utils.EventManager;

class classes.utils.Tracking {
	
	// private properties
	private var _canvas	: String;
	private var _prefix	: String;
	private var _suffix	: String;
	private var _track	: String;
	
	public function Tracking(canvas:String, pixel:String) {
		
		_canvas 	= canvas;
		_track		= pixel;
		_prefix		= "http://www.chasefreedomnow.com/?mol=flash&MKID=6WRS&MSC=T301290";
		_suffix		= "&utm_source=USA&utm_medium=banner&utm_campaign=Freedom_Q3_2008&utm_content=";
		
		EventManager.addEventListener("onExit", this, "exitCanvas");
		EventManager.addEventListener("onView", this, "trackView");
	}
	
	private function exitCanvas(o:Object):Void {
		var id:String	 = parseId(o.data.loc);
		var link:String  = _prefix + id + _suffix + _canvas + o.data.loc;
		
		getURL(link, "_blank");
		
		trace("\n-----------------------------------------------------------");
		trace("EXIT URL: " + link);
		trace("-----------------------------------------------------------\n");
	}
	
	// since the same games are used in each canvas
	// there is no way to receive their ids
	private function parseId(s:String):String {
		switch(_canvas) {
			
			case "rodeo" :
			switch(s) {
				
				case "_main" :
				return "0";
				break;
				
				case "_matchpoints" :
				return "1";
				break;
				
				case "_quiz" :
				return "2";
				break;
			}
			break;
			
			case "redcarpet" :
			switch(s) {
				
				case "_main" :
				return "3";
				break;
				
				case "_matchpoints" :
				return "4";
				break;
				
				case "_quiz" :
				return "5";
				break;
			}
			break;
			
			case "hollywood" :
			switch(s) {
				
				case "_main" :
				return "6";
				break;
				
				case "_matchpoints" :
				return "7";
				break;
				
				case "_quiz" :
				return "8";
				break;
			}
			break;
		}
	}
	
	private function trackView(o:Object):Void {
		
		switch(_canvas) {
			
			case "rodeo" :
			switch(o.data.game) {
				case "matchpoints" :
				_track = "http://ad.doubleclick.net/ad/N2886.NBC/B3111385.8;sz=1x1;ord=";
				break;
				case "quiz" :
				_track = "http://ad.doubleclick.net/ad/N2886.NBC/B3111385.9;sz=1x1;ord=";
				break;
			}
			break;
			
			case "redcarpet" :
			switch(o.data.game) {
				case "matchpoints" :
				_track = "http://ad.doubleclick.net/ad/N2886.NBC/B3111385.5;sz=1x1;ord=";
				break;
				case "quiz" :
				_track = "http://ad.doubleclick.net/ad/N2886.NBC/B3111385.6;sz=1x1;ord=";
				break;
			}
			break;
			
			case "hollywood" :
			switch(o.data.game) {
				case "matchpoints" :
				_track = "http://ad.doubleclick.net/ad/N2886.NBC/B3111385.2;sz=1x1;ord=";
				break;
				case "quiz" :
				_track = "http://ad.doubleclick.net/ad/N2886.NBC/B3111385.3;sz=1x1;ord=";
				break;
			}
			break;
		}
		var result_lv:LoadVars = new LoadVars();
		result_lv.onLoad = function(success:Boolean):Void {
			/*
			if(this.toString().substr(0, 6) == "GIF89a"){
				trace("\n************************");
				trace("TRACKED A 1x1 PIXEL IMAGE:");
				trace(tracking_url);
				trace("************************\n");
			} else {
				trace("COULD NOT TRACK: " + this)
			}
			*/
			if(success){
				trace("\n************************");
				trace("TRACKED A 1x1 PIXEL IMAGE:");
				trace(tracking_url);
				trace("************************\n");
			} else {
				trace("COULD NOT TRACK: " + this)
			}
		}
		var tracking_lv:LoadVars = new LoadVars();
		var tracking_date:Date = new Date();
		var tracking_url:String = _track + tracking_date.getTime() + "?";
		tracking_lv.sendAndLoad(tracking_url, result_lv, "POST");
	}
}