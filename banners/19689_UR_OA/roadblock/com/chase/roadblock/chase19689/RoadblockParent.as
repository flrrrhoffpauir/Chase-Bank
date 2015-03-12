/**
 *	StandardBannerPV3D Class
 *	Created on 2010-06-01
 *
 *	@langversion ActionScript 2.0
 *	@playerversion 8.0
 *	@since 2010-06-01                      
 *	@author timmy
 *	@version 1.0.0
 *
 *	all code copyright (c) 2010 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 *	
 */

import mx.utils.Delegate;


class com.chase.roadblock.chase19689.RoadblockParent extends MovieClip
{
	private var _scope:MovieClip;
	private var _isLoadingInt:Number;
	public var _send_lc,_recieve_lc:LocalConnection;
	

	public function RoadblockParent(scope:MovieClip)
	{
		/*******   clickTag is on the hotspot in the fla per the vendors instructions   *******/
		trace("RoadblockParent(" + scope + ")");
		_scope = scope;
		_scope._quality = "BEST";
		
		_send_lc = new LocalConnection();
		_recieve_lc = new LocalConnection();
		_recieve_lc.isLoaded = Delegate.create(this, isLoaded);
		_recieve_lc.rollOver = Delegate.create(this, rollOver);
		_recieve_lc.connect("parent");

		clearInterval(_isLoadingInt);
		_isLoadingInt = setInterval(this, "isLoadedRequest", 250); // start checking to see if the child has loaded

	};


	/**
	 *   go time, called on Main Timeline
	 */
	public function init():Void
	{
		trace("[RoadblockParent] init()...");
		_scope.gotoAndPlay("start");
	};
	
	
	private function isLoadedRequest():Void
	{
		trace("[RoadblockParent] to [RoadblockChild] \"are you loaded yet?\"...");
		_send_lc.send("child", "areYouLoaded");
	};

	
	public function isLoaded():Void
	{
		// stop the interval from checking, 
		clearInterval(_isLoadingInt);
		trace("[RoadblockParent] the child has loaded, starting child and parent banners now...");
		
		// notify the child to start and start the parent, too
		_send_lc.send("child", "startChildBannner");
		init();
	};
	
	
	private function rollOver():Void
	{
		_scope.cta.gotoAndPlay("shimmer");
	};
	
	
}; // end


