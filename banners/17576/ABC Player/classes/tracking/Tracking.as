/**
*      	Tracking Class
*      	Created on 2008-10-23
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-23
*		@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Tracking for ABC Player using DoubleClick DART MSC T3013822
*
*/

import events.Events;
import events.EventManager;


class tracking.Tracking {
	
	 private static var _viewUrls:Object = { learnMoreCta:"http://ad.doubleclick.net/ad/N2886.T3ABC111/B3216255.2;sz=1x1;ord=", 
					learnMoreCard:"http://ad.doubleclick.net/ad/N2886.T3ABC111/B3216255.3;sz=1x1;ord=",
					rewardsCta:"http://ad.doubleclick.net/ad/N2886.T3ABC111/B3216255.4;sz=1x1;ord=",
					iconRollOver:"http://ad.doubleclick.net/ad/N2886.T3ABC111/B3216255.6;sz=1x1;ord=",
					sliderPress:"http://ad.doubleclick.net/ad/N2886.T3ABC111/B3216255.7;sz=1x1;ord=",
					videoReplay:"http://ad.doubleclick.net/ad/N2886.T3ABC111/B3216255.9;sz=1x1;ord=",
					videoPause:"http://ad.doubleclick.net/ad/N2886.T3ABC111/B3216255.10;sz=1x1;ord=" };
					
	private static var _exitUrls:Object = { learnMoreCta:"http://www.chasefreedomnow.com?mkid=6WRS&MSC=T3013822&utm_medium=banner&utm_source=abc&utm_campaign=freedom_q3_2008&utm_content=full_episode",
					learnMoreCard:"http://www.chasefreedomnow.com?mkid=6WRS&MSC=T3013822&utm_medium=banner&utm_source=abc&utm_campaign=freedom_q3_2008&utm_content=full_episode",
					rewardsCta:"http://www.chasefreedomnow.com?mkid=6WRS&MSC=T3013822&utm_medium=banner&utm_source=abc&utm_campaign=freedom_q3_2008&utm_content=full_episode" };
	
	public function Tracking() { trace("no need to instantiate the tracking class"); };
	
	static public function trackView(s:String):Void {
		var result_lv:LoadVars = new LoadVars();
		result_lv.onLoad = function(success:Boolean):Void {
			if(success) {
				trace("\n*********************************************");
				trace("TRACKED THE FOLLOWING VIEW:");
				trace(tracking_url);
				trace("*********************************************\n");
			} else {
				trace("COULD NOT TRACK: " + tracking_url);
			}
		}
		
		var tracking_lv:LoadVars = new LoadVars();
		var tracking_date:Date = new Date();
		var tracking_url:String = _viewUrls[s] + tracking_date.getTime() + "?";
		tracking_lv.sendAndLoad(tracking_url, result_lv, "POST");
	}
	
	static public function exitCanvas(s:String):Void { getUrl(_exitUrls[s], "_blank"); };
}