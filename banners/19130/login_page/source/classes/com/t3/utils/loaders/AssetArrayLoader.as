/*******************************************************************************************************
//
// AssetArrayLoader
//  Created by David Dinh, Sr. Rich Media Designer on 2008-11-07.
//  Copyright (c) 2008 __T3__. All rights reserved.
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

package com.t3.utils.loaders{
	
	// I N C L U D E S
    import flash.errors.*;
    import flash.events.*;
    import flash.display.Loader;
    import flash.display.DisplayObject;
    import flash.display.Bitmap;
    import flash.net.URLRequest;

	public class AssetArrayLoader extends AssetLoader {

		// P R O P E R T I E S
		public static var DEBUG	:Boolean = false;
		
		private var _addressArray		:Array;	// holds addresses of assets
		private var _loadedArray		:Array;	// holds booleans of what's loaded
		private var _contentArray		:Array;	// holds loaded content(BMPs, PNGs, etc)
		
		private var _currentlyLoading	:Number = -1;
		private var _totalLoaded		:Number = 0;
		private var _loadingAll			:Boolean = false;

		// C O N S T R U C T O R

		public function AssetArrayLoader(contentLocations:Array){
			if(contentLocations.length == 0)
				throw new Error("AssetArrayLoader: Cannot submit empty array");
				
			_addressArray = contentLocations;
			_loadedArray = new Array(contentLocations.length);
			_contentArray = new Array(contentLocations.length);
			
			for (var i:Number = 0; i< _loadedArray.length; i++){
				_loadedArray[i] = false;
				_contentArray[i] = null;
			}
		}

		// G E T T E R S  &  S E T T E R S
			
		public function get contentArray():Array{
			return _contentArray;
		}
		
		public function get allLoaded():Boolean{
			var result:Boolean = true;
			for(var i:Number = 0; i < _loadedArray.length; i++){
				if(!_loadedArray[i])
					result = false;
			}
			return result;
		}
		
		public function get loadedArray():Array{
			return _loadedArray;
		}
		
		// M E T H O D S
		/**
		* Returns whether an asset index has been loaded yet
		*
		* @param		index		Number 		index of asset you are checking
		*/
		public function isLoaded(index:Number):Boolean{
			if(index < 0 || index >= _loadedArray.length)
				throw new Error("AssetArrayLoader: isLoaded index out of range error");
				
			return _loadedArray[index];
		}
		
		public function loadAll():void{
			_loadingAll = true;
			loadByNum(0);
		}
		
		/**
		* Loads Asset
		*
		* @param		s		String 		Address of asset
		*/
		public override function load(s:String):void{
			if(AssetArrayLoader.DEBUG)
				trace("AssetArrayLoader: loading " + s)
			_currentlyLoading = searchForIndex(s);
			if(_currentlyLoading == -1)
				throw new Error("AssetArrayLoader: Invalid string given to load -- " + s);
						
			else {
				if(AssetArrayLoader.DEBUG)
					trace("AssetArrayLoader: " + s + " found at " + _currentlyLoading);
					
				if(!_loadedArray[_currentlyLoading]){ // not loaded
					
					super.load(_addressArray[_currentlyLoading]);
					
				} else { 	// currently loaded
					//load content from array					
					this._content = _contentArray[_currentlyLoading];
					_currentlyLoading = -1;
					
					//dispatch event
					dispatchEvent(new Event(Event.COMPLETE));
				}
			}				
		}
		
		/**
		* Loads Asset
		*
		* @param		n		Number 		index of asset
		*/
		public function loadByNum(n:Number):void{
			if(AssetArrayLoader.DEBUG)
				trace("AssetArrayLoader: loading item " + n);
				
			if(n >= _loadedArray.length)
				throw new Error("AssetArrayLoader: loadByNum out of index error");
			
			_currentlyLoading = n;
						
			if(!_loadedArray[_currentlyLoading]){ // not loaded
				super.load(_addressArray[_currentlyLoading]);
				
			} else { 	// currently loaded
				//load content from array		
				if(AssetArrayLoader.DEBUG)
					trace("AssetArrayLoader: " + _currentlyLoading + " already loaded");
					
				this._content = _contentArray[_currentlyLoading];
				_currentlyLoading = -1;
				
				//dispatch event
				dispatchEvent(new Event(Event.COMPLETE));
			}
							
		}
		
		public override function unload():void{
			// dont want to unload since we're retaining the SWF in array
		}
		
		/** 
		* To be overriden.  Guarantees and concrete classes have to properly destroy their assets
		*/
		public override function destroy():void{
			for (var i:Number = 0; i< _loadedArray.length; i++){
				_loadedArray[i] = null;
				_addressArray[i] = null;
			}
			_addressArray = null;
			_loadedArray = null;
			
			super.destroy();
		}
	
		/**
		* Private method to search for valid addresses provided in the array
		*/
		private function searchForIndex(s:String):Number{
			var found:Number = -1;
			
			for (var i:Number = 0; i< _addressArray.length; i++){
				if(_addressArray[i] == s){
					found = i;
					break;
				}
			}
			
			return i;
		}
				
		// L I S T E N E R S
				
		public override function completeHandler(event:Event):void{
			_contentArray[_currentlyLoading] = DisplayObject(_loader.content);
			_loadedArray[_currentlyLoading] = true;
			//trace(_currentlyLoading)
			this._content = _contentArray[_currentlyLoading];
			
			if(AssetArrayLoader.DEBUG)
				trace("AssetArrayLoader: Completed Loading. contentArray: " + _contentArray + " loadedArray: " + _loadedArray + " current content: " + this._content );
							
			_loader.unload();
			_totalLoaded++;
			
			if(_loadingAll){ // loading all
				if(_totalLoaded == _addressArray.length) { // if all are loaded
					_currentlyLoading = -1;
					_loadingAll = false;
					dispatchEvent(new Event(Event.COMPLETE));
				} else {
					_currentlyLoading++;
					loadByNum(_currentlyLoading);
					dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _totalLoaded, _addressArray.length));
				}
			} else { // if its not loading all at once	
				_currentlyLoading = -1;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public override function progressHandler(event:ProgressEvent):void {
			if(!_loadingAll){ // if its not loading all
				super.progressHandler(event);
			}		
		}
		
		public override function ioErrorHandler(event:IOErrorEvent):void {
			//super.ioErrorHandler(event);
			_contentArray[_currentlyLoading] = new Bitmap(new NoImg(232,232));
			_loadedArray[_currentlyLoading] = true;
			
			this._content = _contentArray[_currentlyLoading];
			
			if(AssetArrayLoader.DEBUG)
				trace("AssetArrayLoader: ioErrorHandler. contentArray: " + _contentArray + " loadedArray: " + _loadedArray + " current content: " + this._content );
							
			_loader.unload();
			_totalLoaded++;
			
			if(_loadingAll){ // loading all
				if(_totalLoaded == _addressArray.length) { // if all are loaded
					_currentlyLoading = -1;
					_loadingAll = false;
					dispatchEvent(new Event(Event.COMPLETE));
				} else {
					_currentlyLoading++;
					loadByNum(_currentlyLoading);
					dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _totalLoaded, _addressArray.length));
				}
			} else { // if its not loading all at once	
				_currentlyLoading = -1;
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
		}
		

	}
}