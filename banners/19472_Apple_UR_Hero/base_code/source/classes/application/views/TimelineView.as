/**
 *	TimelineView Class
 *
 *	@langversion ActionScript 3.0
 *	@playerversion 9.0
 *	@since 2009-12-11                      
 *	@author Junie
 *	@version 1.0.0
 *
 *	all code copyright (c) 2009 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 *	
 */

package application.views
{
	
	// import flash
	import flash.events.*;
	import flash.display.*;
	
	// import external
	import application.events.SlideShowEvent;

	public class TimelineView extends MovieClip 
	{
		//---------------------------------------------------------------------
		// variables
		//---------------------------------------------------------------------
		private var _scope:MovieClip;
		private static var _instance:TimelineView;
		
		
		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function TimelineView(scope:MovieClip = null)
		{
			_scope = scope;
			
			super();
			if( _instance != null ) throw new Error( "Error:TimelineView already initialized." );
			if( _instance == null ) _instance = this;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		};
		
		
		//---------------------------------------------------------------------
		// private methods and handlers
		//---------------------------------------------------------------------
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		};
		
		
		//---------------------------------------------------------------------
		// public methods
		//---------------------------------------------------------------------
		public function dispatchAnimStart():void
		{
			dispatchEvent(new SlideShowEvent(SlideShowEvent.PAUSE_SHOW));
			trace("dispatching timelineAnimStart")
		};
		
		
		public function dispatchAnimEnd():void
		{
			dispatchEvent(new SlideShowEvent(SlideShowEvent.RESUME_SHOW));
			trace("dispatching timelineAnimEnd")
		};
		
		
		public static function get instance():TimelineView { return initialize(); };
		
		
		public static function initialize():TimelineView
		{
			if(_instance == null) _instance = new TimelineView();
			return _instance;
		};
	}
}

