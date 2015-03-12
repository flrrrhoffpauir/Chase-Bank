/*******************************************************************************************************
//
// InfoView
//  Created by ,  on 2009-05-11.
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
	import com.t3.mvc.abstract.*;
	import com.t3.mvc.events.DataEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.*;
	import flash.text.TextFieldAutoSize;
	import gs.*;
	

	public class InfoView extends AbstractView{

		// P R O P E R T I E S
		private var _setup					:Object;
		private var _stage					:MovieClip;
		private var _currentSection			:Number;
		private var _ctaURL					:String;


		// C O N S T R U C T O R

		public function InfoView(m:AbstractModel, c:AbstractController, setupObj:Object){
			super(m,c);
			_setup = setupObj;	
			_stage = setupObj.scope;
		}

		// G E T T E R S  &  S E T T E R S
		
		
		// M E T H O D S
				
		
		// L I S T E N E R S
		public override function start(evt:DataEvent):void {
			
		}
		
		public override function updated(evt:DataEvent):void{
			if(_setup.debug)
				trace("section"+evt.data._section)
				
			if(_currentSection != evt.data._section){
				// grab the XML
				var xmlEntry:XML = XML(evt.data._info);
				trace(xmlEntry.frameNum);
				_stage.textPanel.gotoAndStop(xmlEntry.frameNum);
				_stage.textPanel.alpha = 0;
				TweenLite.to(_stage.textPanel, 0.5, {alpha:1, overwrite:true});	
				
				//change sections
				_currentSection = evt.data._section;				
			}
		}
		
		private function addComma(str:String, rem:Boolean):String{
			var result:String = "";
			
			var wholeNumbers:String = "";
			var remainder:String = "";
			var decimalPlace:Number = str.indexOf(".");
			
			if(decimalPlace != -1){
				wholeNumbers = str.substring(0, decimalPlace);
				remainder = str.substr(decimalPlace+1);
				if(remainder.length == 1)
					remainder = "0" + remainder;
					
			} else {
				wholeNumbers = str;
				remainder = "00";
			}
			
			while(wholeNumbers.length>3){
				result= "," + wholeNumbers.substr(wholeNumbers.length-3) + result;
				wholeNumbers = wholeNumbers.substring(0,wholeNumbers.length-3);
			}
			if(rem)
				result = wholeNumbers+result + "." + remainder;
			else 
				result = wholeNumbers+result;
				
			return result;
		}
		
		private function rollOverHandler(evt:MouseEvent):void{
			evt.target.gotoAndPlay(1);
		}
		
		
		private function auctionCTAClickHandler(evt:MouseEvent):void{
			if(_setup.debug)
				trace("auction CTA clicked");
			
			var _url:URLRequest = new URLRequest(_ctaURL);
			navigateToURL(_url, "_self");
		}
		
		private function saleCTAClickHandler(evt:MouseEvent):void{
			if(_setup.debug)
				trace("sale CTA clicked");
			
			var _url:URLRequest = new URLRequest(_ctaURL);
			navigateToURL(_url, "_self");
		}

	}
}