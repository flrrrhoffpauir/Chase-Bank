/**
 *	Disclosure Class
 *
 *	@langversion ActionScript 3.0
 *	@playerversion 9.0
 *	@since 2010-07-20                      
 *	@author 
 *	@version 1.0.0
 *
 *	all code copyright (c) 2009 T3 The Think Tank. All rights reserved.
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



	public class Disclosure extends MovieClip
	{
		//---------------------------------------------------------------------
		// variables
		//---------------------------------------------------------------------
		private var _scope:MovieClip;
		private var _open_y:Number;
		private var _closed_y:Number;
		private var _panelIsOpen:Boolean;
        
        private static var SPEED:Number = 0.5;
        private static var EASE:Function = Cubic.easeOut;
        

		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function Disclosure(scope:MovieClip, open_y:Number, closed_y:Number)
		{
			_scope 			= scope;
			_open_y 		= open_y;
			_closed_y 		= closed_y;
			_panelIsOpen	= false;
			
			init();
		};
		
		
		//---------------------------------------------------------------------
		// private methods and handlers
		//---------------------------------------------------------------------
		private function init():void
		{
			_scope.panel.buttonMode = true;
			_scope.panel.closebtn.alpha = 0;
			
			_scope.panel.addEventListener(MouseEvent.CLICK, panelClicked, false, 0, true);
			_scope.panel.addEventListener(FocusEvent.FOCUS_IN, focusInHandler, false, 0, true);
			_scope.panel.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, false, 0, true);
		};
		
		
		function panelClicked(e:MouseEvent):void
		{	
			if(_panelIsOpen)
			{
				closePanel();
			} else {
				openPanel();
			};
		};
		
		
		private function focusInHandler(e:FocusEvent):void
		{
			if(!_panelIsOpen) openPanel();
		};
		
		
		function focusOutHandler(e:FocusEvent):void
		{
			if(_panelIsOpen) closePanel();
		};
		
		
		private function openPanel():void
		{
			pauseSlideShow();
			
			TweenLite.to(_scope.panel, SPEED, { y:_open_y, ease:EASE });
			TweenLite.to(_scope.panel.closebtn, SPEED/2, { alpha:1, ease:EASE });
			TweenLite.to(_scope.panel.openbtn, SPEED/2, { alpha:0, ease:EASE });
			_panelIsOpen = true;
		};
		
		
		private function closePanel():void
		{
			resumeSlideShow();
			
			TweenLite.to(_scope.panel, SPEED, { y:_closed_y, ease:EASE });
			TweenLite.to(_scope.panel.closebtn, SPEED/2, { alpha:0, ease:EASE });
			TweenLite.to(_scope.panel.openbtn, SPEED/2, { alpha:1, ease:EASE });
			_panelIsOpen = false;
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


