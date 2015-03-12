/*******************************************************************************************************
//
// ApplicationController
//  Created by ,  on 2009-05-06.
//  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
//
//                                             ffLL                                      LLGG
//                                           LL######EEtt                            ..KK##DD
//                                         ii############KK;;                        GG##LL..
//                                         ..EE##############ff                    iiWW;;
//                                           ....DD############GG                  GGii
//                                         LL#####################KK::            ;;EE
//                    888    888           GGDDLL#######EE##########WWii          EEtt
//                    888    888                    ;;;;  tt############EEttiiiiKKKK
//                    888    888                            ;;KK################KK..
//  88888b.   8888b.  888888 888888 .d88b.  888d888 88888b.     ..ttffLLWW######KK
//  888 "88b     "88b 888    888   d8P  Y8b 888P"   888 "88b            ..KK######;;
//  888  888 .d888888 888    888   88888888 888     888  888              ;;######tt 
//  888 d88P 888  888 Y88b.  Y88b. Y8b.     888     888  888                EE####LL
//  88888P"  "Y888888  "Y888  "Y888 "Y8888  888     888  888                ;;####LL 
//  888                                                                       LL##DD
//  888   88888b.  888  888 88888b.d88b.   8888b.                               LL##LL
//  888   888 "88b 888  888 888 "888 "88b     "88b                                LL##      
//        888  888 888  888 888  888  888 .d888888                                jj##tt
//        888 d88P Y88b 888 888  888  888 888  888                                ii##tt    
//        88888P"   "Y88888 888  888  888 "Y888888                                  tt;;
//        888                                      
//        888                                      
//        888
//  
//	Description:
//
//	Public Methods:
//
******************************************************************************************************/

package com.t3.application{
	
	// I N C L U D E S
	import flash.display.MovieClip;
	import flash.display.LoaderInfo;
	//import flash.text.TextField;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.accessibility.*;
	import flash.utils.Timer;
	import com.t3.utils.loaders.*;
	import gs.*;

	public class ApplicationController extends MovieClip {

		// P R O P E R T I E S
		
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
		//private var _accessView				:AccessibilityView;


		// C O N S T R U C T O R

		public function ApplicationController(){
			var serverURL:String = this.loaderInfo.parameters["xmlLocation"];
			if(serverURL == null){
				//this.debugTxt.text = "***"
				_loadPath = "swf/xml/actualxmlfromChase.xml";
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

		// G E T T E R S  &  S E T T E R S
		
		
		// M E T H O D S
	
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
		
		/*
		private function startAccessibleHero(evt:Event):void{
			
			_accessView = new AccessibilityView(_model, null, _setupObj);
			_model.addView(_accessView);
			
			_model.startAccessibly();
		}*/
				
				
		// L I S T E N E R S
		
		private function xmlLoaded(evt:Event):void{
			//_timer = new Timer(1500,1);
			//_timer.addEventListener(TimerEvent.TIMER, checkAccessibility);
			//_timer.start();
			TweenLite.to(preloader_mc, .5, {autoAlpha:1});
			_model.addEventListener(Event.COMPLETE, startHero);
			_model.addEventListener(ProgressEvent.PROGRESS, updatePreloader);
			
			//this.debugTxt.appendText(_xmlLoader.xml);
			_model.xml = _xmlLoader.xml;
		}
		
		private function updatePreloader(evt:ProgressEvent):void{
			preloader_mc.numLoaded_txt.text = evt.bytesLoaded + " of " + evt.bytesTotal;
			//if(evt.bytesLoaded == evt.bytesTotal)
				
		}
		
		/*
		private function checkAccessibility(evt:TimerEvent):void{
			_model.xml = _xmlLoader.xml;
			if(Accessibility.active)
				_model.addEventListener(Event.COMPLETE, startAccessibleHero);
			else 
				_model.addEventListener(Event.COMPLETE, startHero);
		}
		*/

	}
}