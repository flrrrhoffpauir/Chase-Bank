/**
 *	ScrollBar Class
 *
 *	@langversion ActionScript 3.0
 *	@playerversion 9.0
 *	@since 2010-05-05                      
 *	@author Junie Threatt
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
	import flash.net.*;
	
	// import external
	import gs.*;
	import gs.easing.*;
	import application.events.SlideShowEvent;
	
	
	public class ScrollBar extends MovieClip
	{
		//---------------------------------------------------------------------
		// variables
		//---------------------------------------------------------------------
		private var _scope:MovieClip;
		
		private var _y_offset:Number;
		private var _padding:Number;
		private var _y_min:Number;
		private var _y_max:Number;
		private var _scroll_perc:Number;
		
		private var SPEED:Number = .5;
		private var EASE:Function = Expo.easeOut;
		
		
		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function ScrollBar(scope:MovieClip)
		{
			_scope			= scope;
			_y_offset		= 30;
			_padding		= _scope.scroller.scrollUp.height;
			_y_min			= 0 + _padding;
			_y_max			= _scope.scroller.scrollTrack.height - _scope.scroller.scrollTab.height - _padding;
						
			init();
		};
		
		
		//---------------------------------------------------------------------
		// private methods and handlers
		//---------------------------------------------------------------------
		private function init():void
		{
			_scope.scroller.scrollUp.addEventListener(MouseEvent.CLICK, scrollUpClick);
			_scope.scroller.scrollDown.addEventListener(MouseEvent.CLICK, scrollDownClick);
			
			_scope.scroller.scrollUp.buttonMode = true;
			_scope.scroller.scrollDown.buttonMode = true;
		};
		
		
		private function checkRestraints():void
		{
			if(_scope.scroller.scrollTab.y <= _y_min)
			{
				_scope.scroller.scrollTab.y = _y_min;
			}
			else if(_scope.scroller.scrollTab.y >= _y_max)
			{
				_scope.scroller.scrollTab.y = _y_max;
			};
		};
		
		
		private function updateContent():void
		{
			_scroll_perc = (_scope.scroller.scrollTab.y - _y_min) / (_y_max - _y_min);
			
			var scrollDiff:Number = (_scope.scrollContent.height - _scope.scroller.scrollTrack.height);
			
			TweenLite.to(_scope.scrollContent, SPEED, { y:_y_offset-(_scroll_perc * scrollDiff), ease:EASE });
		};
		
		
		private function scrollUpClick(e:MouseEvent):void
		{
			_scope.scroller.scrollTab.y -= (_y_max - _y_min) * .5;
			checkRestraints();
			updateContent();
		};
		
		
		private function scrollDownClick(e:MouseEvent):void
		{
			_scope.scroller.scrollTab.y += (_y_max - _y_min) * .5;
			checkRestraints();
			updateContent();
		};
		
		
	};
};