/**
 *	MultipleExits Class
 *
 *	@langversion ActionScript 3.0
 *	@playerversion 9.0
 *	@since 2010-09-15
 *	@author 
 *	@version 1.0.0
 *
 *	all code copyright (c) 2010 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 *	
 */

package application.views
{
	// import flash
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
    import flash.utils.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	// import external
	import gs.*;
	import gs.easing.*;
	import application.events.SlideShowEvent;



	public class MultipleExits extends MovieClip
	{
		//---------------------------------------------------------------------
		// variables
		//---------------------------------------------------------------------
		private var _scope:MovieClip;
		private var _linkArray:Array;
		private var _heroID:int;
        
        private static var SPEED:Number = 0.5;
        private static var EASE:Function = Cubic.easeOut;
        

		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function MultipleExits(scope:MovieClip, linkArray:Array, id:int)
		{
			_scope 			= scope;
			_linkArray		= linkArray;
			_heroID			= id;
			
			init();
		};
		
		
		//---------------------------------------------------------------------
		// private methods and handlers
		//---------------------------------------------------------------------
		private function init():void
		{
			var mc:MovieClip;
			for(var i:int = 0; i < _linkArray.length; i++)
			{
				mc = MovieClip(_scope.getChildByName("hotspot"+i));
				
				mc.link = _linkArray[i];
				
				mc.addEventListener(MouseEvent.CLICK, hotspotClickHandler);
				mc.addEventListener(MouseEvent.ROLL_OVER, hotspotRollOverHandler);
				mc.addEventListener(MouseEvent.ROLL_OUT, hotspotRollOutHandler);
				
				mc.addEventListener(FocusEvent.FOCUS_IN, hotspotFocusInHandler);
				mc.addEventListener(FocusEvent.FOCUS_OUT, hotspotFocusOutHandler);
				
				mc.buttonMode = true;
			};
		};
		
		
		private function hotspotClickHandler(e:MouseEvent):void
		{
			if(e.currentTarget.link != "")
			{
				var req:URLRequest = new URLRequest(e.currentTarget.link);
				navigateToURL(req, "_blank");
			};
		};
		
		
		private function hotspotRollOverHandler(e:MouseEvent):void
		{
			pauseSlideShow();
			
			// add animation here, specific to _heroID
			
			switch(_heroID)
			{
				case 1:
					//
				break;
				
				case 2:
					//
				break;
			};
		};
		
		
		private function hotspotRollOutHandler(e:MouseEvent):void
		{
			resumeSlideShow();
		};
		
		
		private function hotspotFocusInHandler(e:FocusEvent):void
		{
			pauseSlideShow();
		};
		
		
		private function hotspotFocusOutHandler(e:FocusEvent):void
		{
			resumeSlideShow();
		};
		
		
		private function pauseSlideShow():void
		{
			dispatchEvent(new SlideShowEvent(SlideShowEvent.PAUSE_SHOW));
		};
		
		
		private function resumeSlideShow():void
		{
			dispatchEvent(new SlideShowEvent(SlideShowEvent.RESUME_SHOW));
		};
			
	};

}; // end


