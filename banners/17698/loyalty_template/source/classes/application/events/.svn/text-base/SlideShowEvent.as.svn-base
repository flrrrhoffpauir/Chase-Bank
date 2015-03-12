/**
 *	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 */

package application.events
{
	//   import flash
	import flash.events.Event;
	
	
	//   import external
		
	//   import plugins



	/**
	 *   SlideShowEvent Class
	 *   Created on 2008-11-25
	 *
	 *   @langversion ActionScript 3.0
	 *   @playerversion 9.0
	 *   @since 2008-11-25                      
	 *   @author timmy
	 *   @version 1.0.0
	 *
	 *   @description	
	 */
	
	
	public class SlideShowEvent extends Event
	{
		
		//---------------------------------------
		//   VARIABLES
		//---------------------------------------
		
		public static const MODEL_READY:String = "onModelReady";
		public static const NAV_INIT:String = "onNavInit";
		public static const PAUSE_SHOW:String = "onItemRollOver";
		public static const RESUME_SHOW:String = "onItemRollOut";
		
		public var _data:*;
		
		
		/**	
		 *   @constructor
		 */
		public function SlideShowEvent(type:String, data:*=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		};
		
		
		//---------------------------------------
		//   GETTER/SETTERS
		//---------------------------------------
		
		/**
		 *   returns the data being passed with the event
		 *   @return the data being passed with the event
		 */
		public function get data():* { return _data; };
		
		//---------------------------------------
		//   PUBLIC METHODS
		//---------------------------------------
		
		override public function clone():Event
		{
			return new SlideShowEvent(type, _data, bubbles, cancelable);
		};
		
		override public function toString():String
		{
			return formatToString("SlideShowEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
		};
		
		//---------------------------------------
		//   EVENT HANDLERS
		//---------------------------------------
		
		//---------------------------------------
		//   PRIVATE & PROTECTED INSTANCE METHODS
		//---------------------------------------
		
	};
	
};


