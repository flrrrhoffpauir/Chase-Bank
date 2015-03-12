/**
 *	RolloverButtonOverview Class
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



	public class RolloverButtonOverview3 extends MovieClip
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
        

		//---------------------------------------------------------------------
		// constructor
		//---------------------------------------------------------------------
		public function RolloverButtonOverview3(scope:MovieClip, numOfPanels:Number, bannerID:Number, linkArray:Array)
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
			TweenLite.to(_scope.getChildByName("presents"), _tweenTime, { x:0, ease:_easeType });
			
			var mc:MovieClip;
			for(var i:Number = 1; i < _numOfPanels+1; i++)
			{
				mc = MovieClip(_scope.getChildByName("panel"+i));
				mc.link = _linkArray[i-1];
				mc.btn.buttonGlow.alpha = 0.0;
				// mc.hitArea = mc.btn.hotspot;
				mc.addEventListener(MouseEvent.ROLL_OVER, rollOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, rollOut);
				mc.addEventListener(MouseEvent.CLICK, release);
				mc.buttonMode = mc.useHandCursor = true;
				
				
				var dd:Number = i * 0.2;
				TweenLite.to(_scope.getChildByName("t" + i), _tweenTime, { delay:dd, alpha:1.0, ease:_easeType });
				TweenLite.to(_scope.getChildByName("panel" + i), _tweenTime, { delay:dd, alpha:1.0, ease:_easeType });				
			};
		};
		
		
		private function rollOver(e:MouseEvent):void
		{
			// pause the slide show
			dispatchEvent(new SlideShowEvent(SlideShowEvent.PAUSE_SHOW));
			
			// set to the highest depth to avoid overlapping by other objects
			_scope.setChildIndex(MovieClip(_scope.getChildByName(e.currentTarget.name)), _scope.numChildren - 1);
	
			// expand the panel
			e.currentTarget.gotoAndPlay("open");
			var targ:String;
			var excludeID:Number;
			switch(e.currentTarget.name)
			{
				case "panel1" :
					targ = "t1";
					excludeID = 1;
					break;
				case "panel2" :
					targ = "t2";
					excludeID = 2;
					break;
				case "panel3" :
					targ = "t3";
					excludeID = 3;
					break;
				case "panel4" :
					targ = "t4";
					excludeID = 4;
					break;
				case "panel5" :
					targ = "t5";
					excludeID = 5;
					break;
			}
			MovieClip(_scope.getChildByName(targ)).gotoAndPlay("open");
			
			// show the buttonGlow
		    TweenLite.to(e.currentTarget.btn.buttonGlow, _tweenTime, { alpha:1.0, ease:_easeType });

			// hide gray button
			TweenLite.to(e.currentTarget.btn.gray, _tweenTime/2, { alpha:0, ease:_easeType });
			
			blurOutPanels(excludeID);
		};
		
		
		private function rollOut(e:MouseEvent):void
		{
			// resume the slide show
			// dispatchEvent(new SlideShowEvent(SlideShowEvent.RESUME_SHOW));
			
			
			// collapse the panel
			e.currentTarget.gotoAndPlay("close");
			var targ:String;
			switch(e.currentTarget.name)
			{
				case "panel1" :
					targ = "t1";
					break;
				case "panel2" :
					targ = "t2";
					break;
				case "panel3" :
					targ = "t3";
					break;
				case "panel4" :
					targ = "t4";
					break;
				case "panel5" :
					targ = "t5";
					break;
			}
			MovieClip(_scope.getChildByName(targ)).gotoAndPlay("close");
			
			// hide the buttonGlow
		    TweenLite.to(e.currentTarget.btn.buttonGlow, _tweenTime, { alpha:0.0, ease:_easeType });

			// show gray button
			TweenLite.to(e.currentTarget.btn.gray, _tweenTime/2, { alpha:1, ease:_easeType });
			
			unBlurOutPanels();
		};
		
		
		private function release(e:MouseEvent):void
		{
			if(e.currentTarget.link != "")
			{
				var req:URLRequest = new URLRequest(e.currentTarget.link);
				// trace(req.url);
				navigateToURL(req, "_blank");
			};
		};
		
		
		private function swapPanelDepths():void
		{
		    _scope.swapChildren(_scope.getChildByName("panel5"), _scope.getChildByName("panel1"));
		};
		
		
		
		private function blurOutPanels(excludeID:Number):void
		{
			var mc:MovieClip;
			var mc2:MovieClip;
			for(var i:Number = 1; i < _numOfPanels+1; i++)
			{
				
				if(excludeID != i)
				{
					TweenFilterLite.to(_scope.getChildByName("panel"+i), 0.5, { alpha:0.7, xscale:0.8, yscale:0.8, blurFilter:{ blurX:5, blurY:5 }, ease:_easeType});
					TweenFilterLite.to(_scope.getChildByName("t"+i), 0.5, { alpha:0.7, xscale:0.8, yscale:0.8, blurFilter:{ blurX:5, blurY:5 }, ease:_easeType});
				}
			}
		};
		
		private function unBlurOutPanels():void
		{
			var mc:MovieClip;
			var mc2:MovieClip;
			for(var i:Number = 1; i < _numOfPanels+1; i++)
			{
				TweenFilterLite.to(_scope.getChildByName("panel"+i), 0.5, { alpha:1.0, xscale:1.0, yscale:1.0, blurFilter:{ blurX:0, blurY:0 }, ease:_easeType });
				TweenFilterLite.to(_scope.getChildByName("t"+i), 0.5, { alpha:1.0, xscale:1.0, yscale:1.0, blurFilter:{ blurX:0, blurY:0 }, ease:_easeType });
			}
		};


	};

}; // end

