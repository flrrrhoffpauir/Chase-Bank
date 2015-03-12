/**
 *	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 */

package application.models
{
	//   import flash
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	//   import external
	import application.events.SlideShowEvent;
	
	
	//   import plugins



	/**
	 *   Model Class
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
	
	
	public class Model extends Sprite
	{
		
		//---------------------------------------
		//   VARIABLES
		//---------------------------------------
		private var _loader:URLLoader;
		private var _file:String;
		
		private static var TIME:Number;
		private static var ACCESSIBILITY:String;
		
		
		/**	
		 *   @constructor
		 */
		public function Model(file:String)
		{
			_file = file;
		};


		/******************************************************
		 *   Destroy method to be called when no longer in use
		 ******************************************************/
		public function destroy():void
		{
			// cascade

			// listeners removed

			// purged from DisplayList

			// invalidated for GC
			
		};
		
		
		public function init():void
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, loadXML);
			_loader.load(new URLRequest(_file));
		};
		
		
		
		//---------------------------------------
		//   GETTER/SETTERS
		//---------------------------------------
		
		//---------------------------------------
		//   PUBLIC METHODS
		//---------------------------------------
		
		//---------------------------------------
		//   EVENT HANDLERS
		//---------------------------------------
		
		//---------------------------------------
		//   PRIVATE & PROTECTED INSTANCE METHODS
		//---------------------------------------
		
		private function loadXML(e:Event):void 
		{
			var xml = new XML(e.target.data);
			TIME = xml.pausetime;
			ACCESSIBILITY = xml.accessibility;
			dispatchEvent(new SlideShowEvent(SlideShowEvent.MODEL_READY, xml));
		}
		
	};
	
};


