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



	public class RolloverButtonOverview extends MovieClip
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
		public function RolloverButtonOverview(scope:MovieClip, numOfPanels:Number, bannerID:Number, linkArray:Array)
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
			for(var i:Number = 1; i < _numOfPanels+1; i++)
			{
				mc = MovieClip(_scope.getChildByName("panel"+i));
				mc.link = _linkArray[i-1];
				mc.btn.buttonGlow.alpha = 0.0;
				mc.addEventListener(MouseEvent.ROLL_OVER, rollOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, rollOut);
				mc.addEventListener(MouseEvent.CLICK, release);
				mc.buttonMode = mc.useHandCursor = true;				
			};
		};
		
		
		private function rollOver(e:MouseEvent):void
		{
			// pause the slide show
			dispatchEvent(new SlideShowEvent(SlideShowEvent.PAUSE_SHOW));
			
			
			if(_bannerID == 2)
			{
		    	if(e.currentTarget.name == "panel1" || e.currentTarget.name == "panel5") 
		    	{
		    	    // FOR THE ONLY TWO PANELS THAT OVERLAP
		    	    var p1:Number = _scope.getChildIndex(_scope.getChildByName("panel1"));
		    	    var p5:Number = _scope.getChildIndex(_scope.getChildByName("panel5"));

					if(e.currentTarget.name == "panel1")
		    	    {
		    	        if(p1 < p5) swapPanelDepths();
		    	    }
		    	    else if(e.currentTarget.name == "panel5")
		    	    {
		    	        if(p1 > p5) swapPanelDepths();
		    	    };
		    	};
			};
			
						
			// expand the panel
			e.currentTarget.gotoAndPlay("open");
			
			// show the buttonGlow
		    TweenLite.to(e.currentTarget.btn.buttonGlow, _tweenTime, { alpha:1.0, ease:_easeType });

			// hide gray button
			TweenLite.to(e.currentTarget.btn.gray, _tweenTime/2, { alpha:0, ease:_easeType });
		};
		
		
		private function rollOut(e:MouseEvent):void
		{
			// resume the slide show
			dispatchEvent(new SlideShowEvent(SlideShowEvent.RESUME_SHOW));
			
			// collapse the panel
			e.currentTarget.gotoAndPlay("close");
			
			// hide the buttonGlow
		    TweenLite.to(e.currentTarget.btn.buttonGlow, _tweenTime, { alpha:0.0, ease:_easeType });

			// show gray button
			TweenLite.to(e.currentTarget.btn.gray, _tweenTime/2, { alpha:1, ease:_easeType });
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


	};

}; // end


