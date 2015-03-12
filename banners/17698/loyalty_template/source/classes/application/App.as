/**
 *	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 */

package application
{
	//   import flash
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.text.TextField;

	
	//   import external
	import application.models.Model;
	import application.events.SlideShowEvent;
	
	
	//   import plugins
	import gs.TweenFilterLite;
	import gs.easing.Expo;
		
	
	public class App extends MovieClip
	{
		
		//---------------------------------------
		//   VARIABLES
		//---------------------------------------
		
		private var _model:Model;
		
		private var _totalNavItems:Number = 0;
		private var _lastBtnX:Number = 656;
		private var _btnSpacing:Number = 20;
		private var _pauseTime:Number;
		private var _isPaused:Boolean = false;
		private var _loader:Loader;
		private var _preloader:MovieClip;
		public var _pauseButton:MovieClip;
		private var _accessibility:String;
		private var _timer:Timer;
		private var _timerHasStarted:Boolean = false;
		
		private var _currImage:Number;
		private var _prevImage:Number;
		
		// static properties
		private static var PAUSE_ID:Number = 5;
		private static var SPEED:Number = 1;
		private static var EASE:Function = Expo.easeOut;
		
		
		
		/**	
		 *   @constructor
		 */
		public function App()
		{
			addEventListener(SlideShowEvent.MODEL_READY, makeNav, false, 0, true);
			addEventListener(SlideShowEvent.PAUSE_SHOW, pauseShow, false, 0, true);
			addEventListener(SlideShowEvent.RESUME_SHOW, resumeShow, false, 0, true);
			
			_model = new Model("data/data.xml");
			addChild(_model);
			_model.init();
		};


		/******************************************************
		 *   Destroy method to be called when no longer in use
		 ******************************************************/
		public function destroy():void
		{
			// cascade

			// listeners removed
			removeEventListener(SlideShowEvent.MODEL_READY, makeNav, false);
			removeEventListener(SlideShowEvent.PAUSE_SHOW, pauseShow, false);
			removeEventListener(SlideShowEvent.RESUME_SHOW, resumeShow, false);

			// purged from DisplayList

			// invalidated for GC
			
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
		
		private function makeNav(e:SlideShowEvent):void
		{
			_totalNavItems = e.data.nav.navitem.length();
			_accessibility = e.data.accessibility;
			_pauseTime = e.data.pausetime;
			
			// make the inistances now
			makeHolders(e.data);
			buildNav(e.data);
		};
		
		
		private function pauseShow(e:SlideShowEvent):void
		{
			trace("pause show");
		}
		
		
		private function resumeShow(e:SlideShowEvent):void
		{
			trace("resume show");
		}
		
		
		private function rollover(e:MouseEvent):void
		{
			// trace(e.type + " " + e.target + " id: " + e.target.id);
		};
		
		
		private function rollout(e:MouseEvent):void
		{
			// trace(e.type + " " + e.target + " id: " + e.target.id);
		};
		
		
		private function clicked(e:MouseEvent):void
		{
			// trace(e.type + " " + e.target + " id: " + e.target.parent.id);
		
			highlightNav(e.target.parent.id);
			showImage(e.target.parent.id);
			_timer.stop();
			restartTimer();
		};
		
		
		private function pauseClicked(e:MouseEvent):void
		{
			// trace(e.type + " " + e.target + " id: " + e.target.parent.id);
			
			if(_isPaused == false)
			{
				_isPaused = true;
				_timer.stop();
				TweenFilterLite.to(_pauseButton.grey, SPEED, { alpha:0, ease:EASE });
			}
			else
			{
				_isPaused = false;
				restartTimer();				
				TweenFilterLite.to(_pauseButton.grey, SPEED, { alpha:1, ease:EASE });
			}
		}
		
		
		private function hsReleased(e:Event):void
		{
			var req:URLRequest = new URLRequest(e.target.parent.urlString);
			navigateToURL(req, "_blank");
		}
		
		
		//---------------------------------------
		//   PRIVATE & PROTECTED INSTANCE METHODS
		//---------------------------------------
		
		
		private function makeHolders(xmlData:XML):void
		{
			for(var i:Number = 0; i < _totalNavItems; i++)
			{
				// make the holder
				var mc:MovieClip = new MovieClip();
				mc.name = "holder" + i;
				mc.x = mc.y = 0;
				mc.alpha = 0;
				addChild(mc);
				
				// insert a picholder to store the image
				var picHolder:MovieClip = new MovieClip();
				picHolder.name = "picHolder";
				picHolder.x = picHolder.y = 0;
				mc.addChild(picHolder);
				
				// insert a hotspot
				var hs:MovieClip = new MovieClip();
				hs.name = "hs";
				hs.urlString = xmlData.nav.navitem[i].hotspot.url;
				hs.x = xmlData.nav.navitem[i].hotspot.x_coord;
				hs.y = xmlData.nav.navitem[i].hotspot.y_coord;
				
				// hotspot "area"
				var hsArea:MovieClip = new MovieClip();
				hsArea.graphics.beginFill(0x00FF00);
            			hsArea.graphics.drawRect(0, 0, xmlData.nav.navitem[i].hotspot.width, xmlData.nav.navitem[i].hotspot.height); 
            			hsArea.graphics.endFill();
				hs.addChild(hsArea);
				
				hs.alpha = (xmlData.nav.navitem[i].hotspot.visible == "true") ? 1 : 0;
				hs.buttonMode = true;
				hs.addEventListener(MouseEvent.CLICK, hsReleased, false, 0, true);
				mc.addChild(hs);
			}
		}
		
		
		public function buildNav(xmlData:XML):void
		{
			if(_totalNavItems > 1)
			{
				_pauseButton = new Pause() as MovieClip;
				_pauseButton.x = _lastBtnX + _btnSpacing;
				_pauseButton.y = 275;
				_pauseButton.id = PAUSE_ID;
				_pauseButton.addEventListener(MouseEvent.CLICK, pauseClicked, false, 0, true);
				_pauseButton.buttonMode = true;
				addChild(_pauseButton);

				for(var i:Number = _totalNavItems-1; i > -1; i--)
				{
					var mc:MovieClip = new NavButton();
					mc.name = "nav" + i;
					mc.id = i;
					mc.txt.text = mc.shadow.text = i+1;
					mc.grey.mouseEnabled = false;
					mc.txt.mouseEnabled = false;
					mc.shadow.mouseEnabled = false;
					mc.buttonMode = true;
					mc.x = _lastBtnX;
					mc.y = 275;
					mc.addEventListener(MouseEvent.ROLL_OVER, rollover, false, 0, true);
					mc.addEventListener(MouseEvent.ROLL_OUT, rollout, false, 0, true);
					mc.addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
					addChild(mc);
					
					_lastBtnX -= _btnSpacing;
				}
			}
			else
			{			
				_totalNavItems = 1;
				_isPaused = true;
			}
			loadMovies(xmlData);
			loadAccessibility();
		}
		
		
		private function loadMovies(xmlData:XML):void
		{			
			var mc:MovieClip;
			for(var i:Number = 0; i < _totalNavItems; i++)
			{
				_loader	= new Loader();
				if(i < 1)
				{
					_loader.contentLoaderInfo.addEventListener(Event.OPEN, showPreloader);
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, initImage); 
				}
				
				mc = MovieClip(getChildByName("holder" + i));
				MovieClip(mc.getChildByName("picHolder")).addChild(_loader);
				
				if(_totalNavItems > 1)
				{
					_loader.load(new URLRequest(xmlData.nav.navitem[i].image));
				}
				else
				{
					_loader.load(new URLRequest(xmlData.nav.navitem[0].image));
				}			
			}
		}
		
		
		private function highlightNav(id:Number):void
		{
			var nav:MovieClip;
			for(var i:Number = 0; i < _totalNavItems; i++)
			{
				nav 	= MovieClip(getChildByName("nav" + i));
				if(i == id)
				{
					TweenFilterLite.to(nav.grey, SPEED, { alpha:0, ease:EASE });
					nav.removeEventListener(MouseEvent.ROLL_OVER, rollover, false);
					nav.removeEventListener(MouseEvent.ROLL_OUT, rollout, false);
					nav.removeEventListener(MouseEvent.CLICK, clicked, false);
				}
				else
				{
					TweenFilterLite.to(nav.grey, SPEED, { alpha:1, ease:EASE });
					nav.addEventListener(MouseEvent.ROLL_OVER, rollover, false, 0, true);
					nav.addEventListener(MouseEvent.ROLL_OUT, rollout, false, 0, true);
					nav.addEventListener(MouseEvent.CLICK, clicked, false, 0, true);
				}
			}
		}
		
		
		private function initImage(e:Event):void
		{
			TweenFilterLite.to(_preloader, SPEED/2, { alpha:0, ease:EASE, onComplete:removeObjectFromDisplayList, onCompleteParams:[_preloader] });
			if(_currImage != 0) showImage(0);
		}
		
		
		private function showImage(id:Number):void
		{
			if(_totalNavItems > 1) highlightNav(id);
			_prevImage = _currImage;
			_currImage = id;
			
			var mc:MovieClip;
			var num:Number;
			for(var i:Number = 0; i < _totalNavItems; i++) {
				mc = MovieClip(getChildByName("holder"+i));
				num = (i == id) ? 1 : 0;
				if(i != id) setChildIndex(mc, stage.numChildren+1);
				TweenFilterLite.to(mc, SPEED, { alpha:num, ease:EASE });
			}
			
			if(_isPaused != true && _totalNavItems > 1) {
				if(_timerHasStarted == false) {
					startTimer();
				}
				else
				{
					restartTimer();
				}
			}
		}
		
		private function showNextImage(e:Event):void {
			_timer.stop();
			var id:Number = (_currImage < _totalNavItems-1) ? _currImage + 1 : 0;
			if(_isPaused != true) showImage(id);
		}
		
		
		private function showPreloader(e:Event):void
		{
			_preloader = new PreloaderClip();
			_preloader.x = 358;
			_preloader.y = 150;
			addChild(_preloader);
			TweenFilterLite.to(_preloader, SPEED/2, { alpha:1, ease:EASE });
		}
		
		
		private function startTimer():void {
			_timer = new Timer(_pauseTime*1000);
			_timer.addEventListener(TimerEvent.TIMER, showNextImage);
			_timer.start();
			_timerHasStarted = true;
		}
		
		private function restartTimer():void { _timer.start(); }		
		private function loadAccessibility():void { accessibility.text = _accessibility; }		
		private function removeObjectFromDisplayList(obj:MovieClip):void { if(this.contains(obj)) removeChild(obj); }
		
	};
	
};






		




