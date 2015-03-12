/**
 *	RolloverButtonOverview4 Class
 *
 *	@langversion ActionScript 3.0
 *	@playerversion 9.0
 *	@since 2009-09-04                      
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
	import application.events.PanelEvent;


	public class RolloverButtonOverview4 extends MovieClip
	{
		//---------------------------------------------------------------------
		// variables
		//---------------------------------------------------------------------
		private var _scope:MovieClip;
		private var _numOfPanels:Number;
		private var _linkArray:Array;
		private var _bannerID:Number;
        
        private var _tweenTime:Number = 0.7;
        private var _easeType:Function = Expo.easeOut;

		private var _oldPanel:String = "panel1";
		private var _currentSelection:String = "btn1";
		private var _lastSelection:String = "none";
	
		private var _totalNavItems:Number = 3;
		private var _pauseTime:Number = 3.0;
		private var _isPaused:Boolean = false;
		private var _timer:Timer;
		private var _timerHasStarted:Boolean = false;
		
		private var _currPanel:Number = 1;

        

		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function RolloverButtonOverview4(scope:MovieClip, numOfPanels:Number, bannerID:Number, linkArray:Array)
		{
			_scope = scope;
			_numOfPanels = numOfPanels;
			_bannerID = bannerID;
			_linkArray = linkArray;
			initPanels();
		};
		
		
		//---------------------------------------------------------------------
		// private methods and handlers
		//---------------------------------------------------------------------
		private function initPanels():void
		{
			var mc:MovieClip;
			var button:MovieClip;
			
			for(var i:Number = 1; i < _numOfPanels+1; i++)
			{
				mc = MovieClip(_scope.getChildByName("panel"+i));
				button = MovieClip(_scope.getChildByName("btn"+i));
				
				mc.link = _linkArray[i-1];
				button.buttonGlow.alpha = 0.0;
				button.addEventListener(MouseEvent.ROLL_OVER, rollOver);
				button.addEventListener(MouseEvent.ROLL_OUT, rollOut);
				mc.addEventListener(MouseEvent.ROLL_OVER, panelRollOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, rollOut);
				mc.addEventListener(MouseEvent.CLICK, release);
				mc.buttonMode = mc.useHandCursor = button.buttonMode = button.useHandCursor = true;
				
				if(i > 1) { mc.alpha = 0.0; }; 
				TweenLite.to(MovieClip(_scope.getChildByName("btn1")).gray, _tweenTime/2, { alpha:0.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn2")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn3")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn1")).buttonGlow, 0.3, { alpha:1.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn2")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn3")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });		
			};
			
			this.addEventListener(PanelEvent.PAUSE_SHOW, pauseShow);
			this.addEventListener(PanelEvent.RESUME_SHOW, resumeShow);
			
			startTimer();
			
		};
		
		
		private function rollOver(e:MouseEvent):void
		{
			var newPanel:String;
			
			if(_currentSelection != e.currentTarget.name)
			{
				_lastSelection = _currentSelection;
				_currentSelection = e.currentTarget.name;

				// pause the slide show
				dispatchEvent(new SlideShowEvent(SlideShowEvent.PAUSE_SHOW));
				// resume the slide show
				dispatchEvent(new PanelEvent(PanelEvent.PAUSE_SHOW));
			
				// show the buttonGlow
			    TweenLite.to(MovieClip(_scope.getChildByName("btn1")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn2")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn3")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });
				TweenLite.to(e.currentTarget.buttonGlow, _tweenTime, { alpha:1.0, ease:_easeType });
				
				// hide gray button
				TweenLite.to(MovieClip(_scope.getChildByName("btn1")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn2")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
				TweenLite.to(MovieClip(_scope.getChildByName("btn3")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
				TweenLite.to(e.currentTarget.gray, _tweenTime/2, { alpha:0.0, ease:_easeType });

				switch(e.currentTarget.name)
				{
					case "btn1" :
						_currPanel = 1;
						newPanel = "panel1";
						break;
					case "btn2" :
						_currPanel = 2;
						newPanel = "panel2";
						break;
					case "btn3" :
						_currPanel = 3;
						newPanel = "panel3";
						break;
				}

				// show the new panel, hide the old panel
				crossfadePanels(newPanel, _oldPanel);
				_oldPanel = newPanel;
			
			}
		};
		
		private function panelRollOver(e:MouseEvent):void
		{
			// pause the slide show
			dispatchEvent(new SlideShowEvent(SlideShowEvent.PAUSE_SHOW));
			// resume the slide show
			dispatchEvent(new PanelEvent(PanelEvent.PAUSE_SHOW));
		};
		
		
		private function rollOut(e:MouseEvent):void
		{
			// resume the slide show
			//dispatchEvent(new SlideShowEvent(SlideShowEvent.RESUME_SHOW));
			// resume the slide show
			// dispatchEvent(new PanelEvent(PanelEvent.RESUME_SHOW));
		};
		
		
		private function release(e:MouseEvent):void
		{
			if(e.currentTarget.link != "")
			{
				var req:URLRequest = new URLRequest(e.currentTarget.link);
				// trace(req.url);
				navigateToURL(req, "_blank");
			};
			
			_timer.stop();
			restartTimer();
		};
		
		
		private function crossfadePanels(newPanel:String, oldPanel:String):void
		{
			TweenLite.to(_scope.getChildByName(newPanel), _tweenTime, { alpha:1.0, ease:_easeType });
			TweenLite.to(_scope.getChildByName(oldPanel), _tweenTime, { alpha:0.0, ease:_easeType });
		};
		
		
		private function pauseShow(e:*):void
		{
			_timer.stop();
			trace("pause panel");
		};
		
		
		private function resumeShow(e:*):void
		{
			restartTimer();
			trace("resume panel");
		};
		
		
		private function startTimer():void
		{
			_timer = new Timer(_pauseTime * 1000);
			_timer.addEventListener(TimerEvent.TIMER, showNextImage);
			_timer.start();
		};
		
		private function showNextImage(e:Event):void
		{
			_timer.stop();
			
			var newPanel,newBtn:String;

			switch(_currPanel)
			{
				case 1 :
					_currPanel = 2;
					newPanel = "panel2";
					newBtn = "btn2";
					break;
				case 2 :
					_currPanel = 3;
					newPanel = "panel3";
					newBtn = "btn3";
					break;
				case 3 :
					_currPanel = 1;
					newPanel = "panel1";
					newBtn = "btn1";
					break;
			}
			
			_currentSelection = newBtn;
				
			TweenLite.to(MovieClip(_scope.getChildByName("btn1")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });
			TweenLite.to(MovieClip(_scope.getChildByName("btn2")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });
			TweenLite.to(MovieClip(_scope.getChildByName("btn3")).buttonGlow, 0.3, { alpha:0.0, ease:_easeType });
			TweenLite.to(MovieClip(_scope.getChildByName(newBtn)).buttonGlow, _tweenTime, { alpha:1.0, ease:_easeType });
				

			// hide gray button
			TweenLite.to(MovieClip(_scope.getChildByName("btn1")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
			TweenLite.to(MovieClip(_scope.getChildByName("btn2")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
			TweenLite.to(MovieClip(_scope.getChildByName("btn3")).gray, _tweenTime/2, { alpha:1.0, ease:_easeType });
			TweenLite.to(MovieClip(_scope.getChildByName(newBtn)).gray, _tweenTime/2, { alpha:0.0, ease:_easeType });
			

			// show the new panel, hide the old panel
			crossfadePanels(newPanel, _oldPanel);
			_oldPanel = newPanel;
			
			restartTimer();
			
		};
		
		private function restartTimer():void { _timer.start(); }

	};

}; // end


