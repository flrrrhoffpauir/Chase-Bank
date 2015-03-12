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


class com.chase.roadblock.chase19689.RoadblockChild extends MovieClip
{
	private var _scope:MovieClip;
	public var _send_lc,_recieve_lc:LocalConnection;
	
	
	public function RoadblockChild(scope:MovieClip)
	{
		/*******   clickTag is on the hotspot in the fla per the vendors instructions   *******/
		trace("RoadblockChild(" + scope + ")");
		_scope = scope;
		_scope._quality = "BEST";
		
		_send_lc = new LocalConnection();
		_recieve_lc = new LocalConnection();
		_recieve_lc.areYouLoaded = Delegate.create(this, areYouLoaded);
		_recieve_lc.startChildBannner = Delegate.create(this, startChildBannner);
		_recieve_lc.connect("child");	
		
		
		_scope.hotspot.onRollOver = Delegate.create(this, hotspotRollOver);
	};


	/**
	 *   go time, called on Main Timeline
	 */
	public function init():Void
	{
		trace("[RoadblockChild] init()...");
		_scope.gotoAndPlay("start");
	};

	
	private function areYouLoaded():Void
	{
		trace("[RoadblockChild] notifying [RoadblockParent] that [RoadblockChild] has loaded...");
		_send_lc.send("parent", "isLoaded");
	};
	
	
	private function startChildBannner():Void
	{
		trace("[RoadblockChild] starting child banner now...");
		init();
	};
	
	
	private function hotspotRollOver():Void
	{
		_send_lc.send("parent", "rollOver");
	};
	
	
}; // end


