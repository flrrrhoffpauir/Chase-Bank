/* AS2

	@langversion ActionScript 2.0
	@playerversion Flash 8.0
	
	@author Helmut Granda
	@since  2008-12-01
	
	Copyright 2008 T3.
	
	@description
	Application
	
*/

import mx.utils.Delegate;
import gs.TweenLite;
import gs.easing.Quart;
import Proxy;
import Tracking;

class Application extends MovieClip {

		private var activeButtons 		: Array 	;
		private var activePanels 		: Array 	;
		private var activePanelsInfo	: Object	;
		private var transitionSpeed		: Number 	;
		private var transitionType		: Object 	;
		private var ccType				: String	;
		private var applyNowLinkURL		: String	;
		private var logoLinkURL			: String	;
		
		private var visaLogo			: MovieClip ;
		private var mastercardLogo		: MovieClip ;
		private var earnButtonPanel		: MovieClip ;
		private var rewardButtonPanel	: MovieClip ;
		private var percentButtonPanel	: MovieClip ;
		private var earnButton			: MovieClip ;
		private var rewardButton		: MovieClip ;
		private var percentButton		: MovieClip ;
		private var cardNumbers			: MovieClip ;
		private var cardNumbers1234		: MovieClip ;
		
		private var applyNowTop			: MovieClip ;
		private var applyNowBottom 		: MovieClip ;
		private var chaseLogo			: MovieClip ;
		private var carDart				: MovieClip ;
		

		function Application ( ) { } 

		public static function create( mc:MovieClip ) : Void
		{
			mc.__proto__ = Application.prototype;
	       	mc.init();
		} 
		
		private function init ( ) : Void
		{
			ccType 				= _root.cardtype;
			applyNowLinkURL 	= _root.applyNowLink;
			logoLinkURL			= _root.logo;
			
			transitionSpeed		= 0.5;
			transitionType		= Quart.easeOut;
			activePanels 		= new Array (earnButtonPanel, rewardButtonPanel, percentButtonPanel);
			activeButtons 		= new Array(earnButton, rewardButton, percentButton);
			activePanelsInfo 	= new Object;

			setCardType();
			hideElements();
			addListeners();
		}
		
		function setCardType ( ) : Void
		{
			visaLogo._visible 	= false;
			mastercardLogo._visible = false;
			switch (ccType) {
				case "visa" :
				visaLogo._visible = true;
				cardNumbers1234._visible = false;
				break;
				case "mastercard" :
				cardNumbers1234._visible = false;
				cardNumbers._visible = false;
				mastercardLogo._visible = true;
				break;
			}
		}

		function hideElements ( ) : Void
		{
			for ( var i : Number = 0 ; i < activeButtons.length ; i++ ) {
				activeButtons[ i ]._alpha = 0;
			}

			for ( var i : Number = 0 ; i < activePanels.length ; i++ ) 
			{
				activePanelsInfo[ activePanels[ i ] ] = activePanels[ i ]._y ;
				activePanels[ i ]._y = activePanelsInfo [ activePanels[ i ] ] + activePanels[ i ]._height;
			}	
		}

		function addListeners ( ) : Void
		{
			
			for ( var i : Number = 0 ; i < activeButtons.length ; i++ ) {
				var target : MovieClip ;
				target = activeButtons[ i ];
				target.onRelease 		= Proxy.create ( this, releaseEvent, 	target ) ;
				target.onRollOver 		= Proxy.create ( this, rollOverEvent, 	target ) ;
				target.onRollOut 		= Proxy.create ( this, rollOutEvent,  	target ) ;
			}
			
			applyNowTop.onRelease 		= Proxy.create ( this, onReleaseEvent, applyNowTop );
			applyNowBottom.onRelease 	= Proxy.create ( this, onReleaseEvent, applyNowBottom );
			chaseLogo.onRelease 		= Proxy.create ( this, onReleaseEvent, chaseLogo );
			carDart.onRelease 			= Proxy.create ( this, onReleaseEvent, carDart );
			
		}
		
		private function onReleaseEvent ( $target : MovieClip ) : Void
		{
			doTrackingEvent($target);
			var trackID 		: String ;
			var linkURL			: String ;
			var target			: String;
			trackID = $target._name;
			switch ( trackID ) {
				case "chaseLogo":
					linkURL = logoLinkURL;
					target = "_blank";
				break;
				case "applyNowTop":
				case "applyNowBottom":
				case "carDart":
					linkURL = applyNowLinkURL;
					target = "_self";
				break;
			}
		
			getURL(linkURL, target);
			
		}
		
		private function doTrackingEvent ( $target : MovieClip ) : Void
		{
			var trackID 		: String ;
			var ccTypeShort 	: String ;
			var trackingString 	: String ;
						
			trackID = $target._name;
			
			switch(ccType) {
				case "visa" :
				ccTypeShort = "visa";
				break;
				case "mastercard":
				ccTypeShort = "mc";
				break;
				default :
				ccTypeShort = "";
				break;
			}

			switch ( trackID ) {
				case "earnButton":
				trackingString = 'rollover/earn';
				break;
				case "rewardButton":
				trackingString = 'rollover/any_reward';
				break;
				case "percentButton":
				trackingString = 'rollover/0_percent';
				break;
				case "chaseLogo":
				trackingString = 'chase_logo';
				break;
				case "applyNowTop":
				trackingString = 'apply_top';
				break;
				case "applyNowBottom":
				trackingString = 'apply_main';
				break;
				case "carDart":
				trackingString = 'cardart';
				break;
			}
			
			//Tracking.track ( '/freedom/points'+ccTypeShort+'/'+trackingString )
			Tracking.track ( trackingString )
		}

		private function rollOverEvent ( $target : MovieClip ) : Void
		{
			var target  = $target;
			var panel 	= this[ target._name + "Panel" ] ;
			var panelY 	= activePanelsInfo[ panel ] ;
			
			TweenLite.to ( panel, transitionSpeed, { _y : panelY, ease : transitionType } ) ;
			TweenLite.to ( target, transitionSpeed, { _alpha : 100, ease : transitionType } ) ;
			
			doTrackingEvent ( target ) ;
		}

		private function rollOutEvent ( $target : MovieClip ) : Void
		{
			var target  = $target;
			var panel 	= this[ target._name + "Panel" ] ;
			var panelY 	= activePanelsInfo[ panel ] ;
			TweenLite.to ( panel, transitionSpeed, { _y : panelY + panel._height, ease : transitionType } ) ;
			TweenLite.to ( target, transitionSpeed, { _alpha : 0, ease : transitionType } ) ;
		}

		private function releaseEvent ( $target : MovieClip ) : Void
		{
			var target  = $target;
			var panel 	= this[ target._name + "Panel" ] ;
			var panelY 	= activePanelsInfo[ panel ] ;
			TweenLite.to ( panel, transitionSpeed, { _y : panelY + panel._height, ease : transitionType } ) ;
		}
		
		

}