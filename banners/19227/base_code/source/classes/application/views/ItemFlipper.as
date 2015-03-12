﻿/** *	ItemFlipper Class * *	@langversion ActionScript 3.0 *	@playerversion 9.0 *	@since 2010-03-09                       *	@author Junie Threatt *	@version 1.0.0 * *	all code copyright (c) 2009 T3 The Think Tank. All rights reserved. *	Re-use of this code without express written permission is prohibited. *	 */package application.views{	// import flash	import flash.display.*;	import flash.events.*;	import flash.external.*;    import flash.utils.*;	import flash.net.URLRequest;	import flash.net.navigateToURL;	// import external	import gs.*;	import gs.easing.*;	import gs.plugins.*;			import application.events.SlideShowEvent;	public class ItemFlipper extends MovieClip	{		//---------------------------------------------------------------------		// variables		//---------------------------------------------------------------------		private var _scope:MovieClip;		private var _numOfItems:Number;		private var _bannerID:Number;		private var _linkArray:Array;		private var _prevNum:Number;		private var _recursionCheck:Number;		private var _timer:Timer;                static private var SPEED:Number = 0.7;        static private var EASE:Function = Expo.easeOut;		static private var PAUSE_TIME:Number = 3;        		//---------------------------------------------------------------------		// constructor		//---------------------------------------------------------------------		public function ItemFlipper(scope:MovieClip, numOfItems:Number, bannerID:Number, linkArray:Array)		{			_scope 				= scope;			_numOfItems 		= numOfItems;			_bannerID 			= bannerID;			_linkArray			= linkArray;			_prevNum			= -1;			_recursionCheck		= 0;						TweenPlugin.activate([GlowFilterPlugin]);						addEventListener(Event.ADDED_TO_STAGE, init);		};						//---------------------------------------------------------------------		// private methods and handlers		//---------------------------------------------------------------------				private function init(e:Event):void		{						removeEventListener(Event.ADDED_TO_STAGE, init);						var item:MovieClip;			var dlay:Number = 1;			for(var i:Number = 0; i < _numOfItems; i++)			{				// -- init "item" clips															item = MovieClip(_scope.getChildByName("item"+i));				item.vis = true;								if(i >= _numOfItems/2)				{					item.vis = false;					item.scaleY = 0;					item.visible = false;				};								switch(_bannerID)				{					case 1:					//								break;																				default:					//				};								item.link = _linkArray[i];				item.addEventListener(MouseEvent.CLICK, checkRelease);				item.buttonMode = item.mouseEnabled = true;								TweenLite.from(item, SPEED, { y:300+item.height, delay:dlay, ease:EASE });				dlay += .1;			};			startTimer();		};						private function startTimer():void		{			_timer = new Timer(3000, 0);			_timer.addEventListener(TimerEvent.TIMER, flipItem);			_timer.start();		};						private function flipItem(e:TimerEvent):void		{			/*			var num:Number = randNum(_numOfItems/2);			var mc:MovieClip = MovieClip(_scope.getChildByName("item"+num));			var mc2:MovieClip = MovieClip(_scope.getChildByName("item"+(num+_numOfItems/2)));						if(mc.vis)			{				TweenLite.to(mc, SPEED, { scaleY:0, ease:Expo.easeIn });				TweenLite.to(mc2, SPEED, { scaleY:1, delay:SPEED, ease:Expo.easeOut });				mc.vis = false;			} else {				TweenLite.to(mc, SPEED, { scaleY:1, delay:SPEED, ease:Expo.easeOut });				TweenLite.to(mc2, SPEED, { scaleY:0, ease:Expo.easeIn });				mc.vis = true			};			//*/									var mc:MovieClip;			var mc2:MovieClip;			for(var i:Number = 0; i < _numOfItems/2; i++)			{				mc = MovieClip(_scope.getChildByName("item"+i));				mc2 = MovieClip(_scope.getChildByName("item"+(i+_numOfItems/2)));				if(mc.vis)				{					TweenLite.to(mc, SPEED, { scaleY:0, ease:Expo.easeIn, onComplete:hideItem, onCompleteScope:this, onCompleteParams:[mc] });					TweenLite.to(mc2, SPEED, { scaleY:1, delay:SPEED, ease:Expo.easeOut });					mc2.visible = true;					mc.vis = false;				} else {					TweenLite.to(mc, SPEED, { scaleY:1, delay:SPEED, ease:Expo.easeOut });					TweenLite.to(mc2, SPEED, { scaleY:0, ease:Expo.easeIn, onComplete:hideItem, onCompleteScope:this, onCompleteParams:[mc2] });					mc.vis = true;					mc.visible = true;				};			};		};						private function hideItem(mc:MovieClip):void		{			mc.visible = false;		}						private function randNum(num:Number):Number		{			_recursionCheck += 1;			var n:Number = Math.floor(Math.random()*num);						if(_prevNum == n && _recursionCheck < 10)			{				return randNum(num);			} else {				_recursionCheck = 0;				_prevNum = n;			};						return n;		};						private function checkRelease(e:MouseEvent):void		{			if(e.currentTarget.link != "")			{				var req:URLRequest = new URLRequest(e.currentTarget.link);				navigateToURL(req, "_self");			};		};					};	}; // end