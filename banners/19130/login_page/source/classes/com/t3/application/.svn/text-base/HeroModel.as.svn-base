/*******************************************************************************************************
//
// HeroModel
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
	import com.t3.mvc.abstract.*;
	import com.t3.utils.loaders.AssetArrayLoader;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;

	public class HeroModel extends AbstractModel{

		// P R O P E R T I E S
		private var _setupObject		:Object;
		private var _currentSection		:Number = 0;
		private var _totalSections		:Number = 0;	
		private var _xml				:XML;
		
		private var _loader				:AssetArrayLoader;
		private var _numPicsLoaded		:Number = 0;
		
		private var _timer				:Timer;
		private var _interacted			:Boolean = false;
		

		// C O N S T R U C T O R

		public function HeroModel(setupObj:Object){
			_setupObject = setupObj;
			super();
		}
		

		// G E T T E R S  &  S E T T E R S
		
		public function set xml(_target:XML):void{
			_xml = _target;
			
			//load up the pics
			var addressArray:Array = new Array();			
			for each (var property:XML in _xml.item){
				addressArray.push(property.image);
			}
			
			_loader = new AssetArrayLoader(addressArray);
			_loader.addEventListener(ProgressEvent.PROGRESS, imageProgressHandler);
			_loader.addEventListener(Event.COMPLETE, imageCompleteHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, ioerrorHandler);
			_loader.loadAll();	
			
			// setupTimer
			_timer = new Timer(9000);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		public function set interacted(b:Boolean):void{
			_interacted = b;
		}
		
		public function get totalSections():Number{
			return _totalSections;
		}
		
		
		// M E T H O D S

		/**
		* Adds view to the array of listeners
		*
		* @param		o		View to be added
		*/
		public function addView(o:AbstractView):void{
			addObserver(HeroEvent.UPDATED, o);
			addObserver(HeroEvent.START, o);
		}

		/**
		* Removes view from the array of listeners
		*
		* @param		o		View to be added
		*/
		public function removeView(o:AbstractView):void{
			removeObserver(HeroEvent.UPDATED, o);
			removeObserver(HeroEvent.START, o);
		}
		
		/**
		* starts the model
		*
		*/
		public function start():void{
			_currentSection = 0;
			_totalSections = _xml.item.length();
			setChanged();
			notifyObservers(HeroEvent.START, {_section:_currentSection, sections:_totalSections, imgs:_loader.contentArray, info:_xml} );
		}
		
		/**
		* starts the model, accessibly
		*
		*/
		/*public function startAccessibly():void{
			_currentSection = 0;
			_totalSections = _xml.item.length();
			setChanged();
			notifyObservers(HeroEvent.START, {_section:_currentSection, sections:_totalSections, imgs:_loader.contentArray, _allInfo:_xml} );
		}*/
		
		/**
		* Changes current content and dispatches event of change to all registered views
		*
		* @param		section		new section number to focus on
		*/	
		public function slideTo(section:Number):void{
			//trace("changing " + section)
			_currentSection = section;
			setChanged();
			notifyObservers(HeroEvent.UPDATED, {_section:_currentSection, _info:_xml.item[_currentSection] } );
		}
		
		public function previous():void{
			//trace("next:" + _currentSection + "-1")
			if(_currentSection > 0){
				slideTo(_currentSection-1);
			}
		}
		
		public function next():void{
			//trace("next:" + _currentSection + "+1")
			if(_currentSection < _totalSections-1){
				slideTo(_currentSection+1);
			}
		}
	
		public function autoPlay(startNum:Number):void{
			if(startNum<0 || startNum >_xml.item.length() )
				throw new Error("HeroModel: invalid autoPlay start")
			
			_currentSection = startNum;
			// run once 1st
			slideTo(_currentSection);
			//_currentSection++;
			if(_currentSection == _xml.item.length() ){
				_currentSection = 0;
			}
				
			_timer.start();
		}
				
		// L I S T E N E R S
		
		private function timerHandler(evt:TimerEvent):void{
			if(!_interacted){
				trace("HeroModel: auto Timer shot")
				_currentSection++;
				if(_currentSection == _xml.item.length() ){
					_currentSection = 0;
				}
				slideTo(_currentSection);
				
			} else {
				trace("HeroModel: autoTimer off")
				_timer.stop();
			}
		}
		
		private function imageProgressHandler(evt:ProgressEvent):void{
			dispatchEvent(evt);//(evt.bytesLoaded + " " + evt.bytesTotal);
		}

		
		private function imageCompleteHandler(evt:Event):void{
			//trace(_loader.contentArray);
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function ioerrorHandler(evt:IOErrorEvent):void{
			//trace("sdvjsgdvlglkjghvlksdg")
			evt.stopPropagation();
		}
	}
}