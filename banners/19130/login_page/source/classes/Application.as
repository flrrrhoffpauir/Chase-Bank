package {

import flash.display.*;
import flash.events.*;
import flash.utils.Timer;
import flash.utils.setTimeout;
import flash.net.navigateToURL;
import flash.net.URLRequest;
import flash.accessibility.*;
import flash.external.ExternalInterface;
import com.t3.utils.loaders.*;
import com.t3.application.*;
import gs.*;
import com.modernista.controls.AccLinkButton;
import com.modernista.swffocus.SWFFocus;





public class Application extends MovieClip {
	
	
	private var 		_tabState			: String;
	
	private var shoppingLink:String		= "https://demo.chaseultimaterewards.com/?demo=1&shell=Q&chapter=0&source=mcpgT1p";
	private var cashBackLink:String 	= "https://demo.chaseultimaterewards.com/?demo=3&shell=R&chapter=0&source=mcpgT1c";
	private var travelLink:String 		= "https://demo.chaseultimaterewards.com/?demo=2&shell=S&chapter=0&source=mcpgT2p";
	
	// SETUP OBJ PROPERTIES		
	private var _loadPath				:String =  "";
	private var _xmlLoader				:XMLLoader;
	private var _setupObj				:Object;
	private var _timer					:Timer;
	
	// MVC
	private var _model					:HeroModel;
	private var _slideView				:SliderView;
	private var _infoView				:InfoView;
	private var _picView				:PicView;
	
	public function Application()
	{
		setTimeout(checkAccessibility, 2000);
		SWFFocus.init(stage);
		
		
	}
	
	private function checkAccessibility():void {
		if (Accessibility.active) {
			//ExternalInterface.call("noFlash");
			this.accTab2_mc.accBtn1_btn.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			this.accTab2_mc.accBtn2_btn.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			this.accTab2_mc.accBtn3_btn.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			//stop();
			
			setTabTo("overview");
		} else {
			
			//this.accTab2_mc.accBtn1_btn.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			//this.accTab2_mc.accBtn2_btn.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			//this.accTab2_mc.accBtn3_btn.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			this.accTab1_mc.visible = false;
			this.accTab2_mc.visible = false;
			setTabTo("overview");
			initOverview();
			trace("document class loaded");
			this.tabs.overview.mouseChildren = false;
			this.tabs.overview.buttonMode = true;
			this.tabs.overview.addEventListener(MouseEvent.CLICK, tabHandler, false, 0, true);

			this.tabs.tour.mouseChildren = false;
			this.tabs.tour.buttonMode = true;
			this.tabs.tour.addEventListener(MouseEvent.CLICK, tabHandler, false, 0, true);
		}
	}
	
	private function initOverview():void {
		this.introAnimation.skipIntroButton.mouseChildren = false;
		this.introAnimation.skipIntroButton.buttonMode = true;
		this.introAnimation.skipIntroButton.addEventListener(MouseEvent.CLICK, skipIntroHandler, false, 0, true);
		this.introAnimation.skipIntroButton.addEventListener(MouseEvent.MOUSE_OVER, skipIntroShimmerHandler, false, 0, true);
		
	}
	
	private function initCarousel():void {
		var serverURL:String = this.loaderInfo.parameters["xmlLocation"];
		if(serverURL == null){
			//this.debugTxt.text = "***"
			_loadPath = "swf/xml/URB.xml";
		} else {
			//this.debugTxt.text = "URL loaded in: \n" + serverURL;
			_loadPath = unescape(serverURL);
		}
		
		_setupObj = {	
						debug: false,
						stage: this.stage,
						scope: this,
						loadPath: _loadPath
					};
		_xmlLoader = new XMLLoader();
		_xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		_xmlLoader.load(_loadPath);
		
		preloader_mc.visible =false;
		preloader_mc.alpha = 0;
		
		_model = new HeroModel(_setupObj);
	}
	
	private function initTour():void {
		with(this) {
			prog1ctaF2_mc.buttonMode = true;
			prog2ctaF2_mc.buttonMode = true;
			prog3ctaF2_mc.buttonMode = true;
			
			prog1ctaF2_mc.addEventListener(MouseEvent.MOUSE_OVER, ctaOverHandler, false, 0, true);
			prog2ctaF2_mc.addEventListener(MouseEvent.MOUSE_OVER, ctaOverHandler, false, 0, true);
			prog3ctaF2_mc.addEventListener(MouseEvent.MOUSE_OVER, ctaOverHandler, false, 0, true);
		
			prog1ctaF2_mc.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			prog2ctaF2_mc.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			prog3ctaF2_mc.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			
			prog1hsF2_mc.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			prog2hsF2_mc.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			prog3hsF2_mc.addEventListener(MouseEvent.CLICK, ctaClickHandler, false, 0, true);
			//*
			prog1hsF2_mc.addEventListener(MouseEvent.MOUSE_OVER, copyOverHandler, false, 0, true);
			prog2hsF2_mc.addEventListener(MouseEvent.MOUSE_OVER, copyOverHandler, false, 0, true);
			prog3hsF2_mc.addEventListener(MouseEvent.MOUSE_OVER, copyOverHandler, false, 0, true);
			
			prog1hsF2_mc.addEventListener(MouseEvent.MOUSE_OUT, copyOutHandler, false, 0, true);
			prog2hsF2_mc.addEventListener(MouseEvent.MOUSE_OUT, copyOutHandler, false, 0, true);
			prog3hsF2_mc.addEventListener(MouseEvent.MOUSE_OUT, copyOutHandler, false, 0, true);
			//*/
		}
	
	}
	
	private function releaseOverview():void {
		this.introAnimation.skipIntroButton.removeEventListener(MouseEvent.CLICK, skipIntroHandler);
		this.introAnimation.skipIntroButton.removeEventListener(MouseEvent.MOUSE_OVER, skipIntroShimmerHandler);
	}
	
	private function releaseCarousel():void {
		//*
		this.prog1ctaF2_mc.removeEventListener(MouseEvent.MOUSE_OVER, ctaOverHandler);
		this.prog2ctaF2_mc.removeEventListener(MouseEvent.MOUSE_OVER, ctaOverHandler);
		this.prog3ctaF2_mc.removeEventListener(MouseEvent.MOUSE_OVER, ctaOverHandler);
		
		this.prog1ctaF2_mc.removeEventListener(MouseEvent.CLICK, ctaClickHandler);
		this.prog2ctaF2_mc.removeEventListener(MouseEvent.CLICK, ctaClickHandler);
		this.prog3ctaF2_mc.removeEventListener(MouseEvent.CLICK, ctaClickHandler);
		//*/
	}
	
	private function releaseTour():void {
		
	}
	
	private function setTabTo(aTabName:String):void {
		if (_tabState != aTabName) {
			switch(aTabName) {
				case "overview":
			//	initOverview();
				releaseTour();
				gotoAndPlay("OVERVIEW");
				this.tabs.overview.backing.gotoAndStop("ACTIVE");
				this.tabs.tour.backing.gotoAndStop("INACTIVE");
				break;
			
				case "tour":
			//	releaseOverview();
				gotoAndPlay("TOUR");
				initTour();
				this.tabs.overview.backing.gotoAndStop("INACTIVE");
				this.tabs.tour.backing.gotoAndStop("ACTIVE");
				break;
			}
			_tabState = aTabName;
		}
	}
	
	private function startHero(evt:Event):void{
		TweenLite.to(preloader_mc, .25, {autoAlpha:0});
		
		_slideView = new SliderView(_model, null, _setupObj);
		_model.addView(_slideView);
		
		_infoView = new InfoView(_model, null, _setupObj);
		_model.addView(_infoView);
		
		_picView = new PicView(_model, null, _setupObj);
		_model.addView(_picView);
					
		_model.start();
		//_model.slideTo(0);
	}
	
	
	private function tabHandler(e:MouseEvent):void {
		setTabTo(e.target.name);
	}
	
	private function skipIntroHandler(e:MouseEvent):void {
		gotoAndPlay("CAROUSEL");
	}
	
	private function skipIntroShimmerHandler(e:MouseEvent):void {
		this.introAnimation.skipIntroButton.gotoAndPlay("SHIMMER");
	}
	
	private function ctaOverHandler(evt:MouseEvent):void {
		//trace("ctaOverHandler()");
		evt.target.gotoAndPlay("shimmer");
	}
	
		private function ctaClickHandler(evt:MouseEvent):void {
			var url:String = "";
			if(Accessibility.active) {
				
				if(evt.target.name == "accBtn1_btn") 
					url = shoppingLink;
				else if(evt.target.name == "accBtn2_btn") 
					url = cashBackLink;
				else if(evt.target.name == "accBtn3_btn")
					url = travelLink;
				
			} else {
			
				if(evt.target == prog1ctaF2_mc || evt.target == prog1hsF2_mc) 
					url = shoppingLink;
				else if(evt.target == prog2ctaF2_mc || evt.target == prog2hsF2_mc) 
					url = cashBackLink;
				else if(evt.target == prog3ctaF2_mc || evt.target == prog3hsF2_mc)
					url = travelLink;
				
			}
		
				
				if(url != "") {
					try {            
						
						if (ExternalInterface.available) {
							ExternalInterface.call("popitup", url);
			            }
						//navigateToURL(new URLRequest(url), "_blank");
					}
					catch (e:Error) {
						// handle error here
					}
				}
			
		}
		//*
		private function copyOverHandler(evt:MouseEvent):void {
			//trace("copyOverHandler()");
			if(evt.target == prog1hsF2_mc) {
				//trace("prog1hsF2_mc");
				TweenFilterLite.to(this.prog1headerF2_mc, 0, {tint: 0x095aa6});
				TweenFilterLite.to(this.prog1copyF2_mc, 0, {tint: 0x095aa6});
				prog1ctaF2_mc.gotoAndPlay("shimmer");
			}
			else if(evt.target == prog2hsF2_mc) {
				//trace("prog2hsF2_mc");
				TweenFilterLite.to(this.prog2headerF2_mc, 0, {tint: 0x095aa6});
				TweenFilterLite.to(this.prog2copyF2_mc, 0, {tint: 0x095aa6});
				prog2ctaF2_mc.gotoAndPlay("shimmer");

			}
			else if(evt.target == prog3hsF2_mc) {
				//trace("prog3hsF2_mc");
				TweenFilterLite.to(this.prog3headerF2_mc, 0, {tint: 0x095aa6});
				TweenFilterLite.to(this.prog3copyF2_mc, 0, {tint: 0x095aa6});
				prog3ctaF2_mc.gotoAndPlay("shimmer");
			}
		}
		
		private function copyOutHandler(evt:MouseEvent):void {
			//trace("copyOutHandler()");
			if(evt.target == prog1hsF2_mc) {
				//trace("prog1hsF2_mc");
				TweenFilterLite.to(this.prog1headerF2_mc, 0, {removeTint: true});
				TweenFilterLite.to(this.prog1copyF2_mc, 0, {removeTint: true});
			}
			else if(evt.target == prog2hsF2_mc) {
				//trace("prog2hsF2_mc");
				TweenFilterLite.to(this.prog2headerF2_mc, 0, {removeTint: true});
				TweenFilterLite.to(this.prog2copyF2_mc, 0, {removeTint: true});
			}
			else if(evt.target == prog3hsF2_mc) {
				//trace("prog3hsF2_mc");
				TweenFilterLite.to(this.prog3headerF2_mc, 0, {removeTint: true});
				TweenFilterLite.to(this.prog3copyF2_mc, 0, {removeTint: true});
			}
		}
	//*/
	private function xmlLoaded(evt:Event):void{
		TweenLite.to(preloader_mc, .5, {autoAlpha:1});
		_model.addEventListener(Event.COMPLETE, startHero);
		_model.addEventListener(ProgressEvent.PROGRESS, updatePreloader);
		_model.xml = _xmlLoader.xml;
	}
	
	private function updatePreloader(evt:ProgressEvent):void{
		preloader_mc.numLoaded_txt.text = evt.bytesLoaded + " of " + evt.bytesTotal;
	}
	
}



}

