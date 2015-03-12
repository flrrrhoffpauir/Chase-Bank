/*******************************************************************************************************

AssetLoader

//  Created by david.dinh
//  Sr. Rich Media Designer
//  on 2008-02-24.
//  Copyright (c) 2008 __MyCompanyName__.
//  All rights reserved.
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

******************************************************************************************************/


package com.t3.utils.loaders{
	
	// I N C L U D E S
	import flash.events.EventDispatcher;
    import flash.errors.*;
    import flash.events.*;
    import flash.display.Loader;
    import flash.display.DisplayObject;
    import flash.net.URLRequest;
	
	public class AssetLoader extends EventDispatcher implements IAssetLoader{
		
		// P R O P E R T I E S
		public static var DEBUG	:Boolean = true;
		
		protected var _content	:DisplayObject;
		private var _request	:URLRequest;
		protected var _loader	:Loader;
		
		// C O N S T R U C T O R
		
		public function AssetLoader(){
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, openHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.UNLOAD, unLoadHandler);
		}


		// G E T T E R S  &  S E T T E R S
			
		public function get content():DisplayObject{
			return _content;
		}


		// M E T H O D S
		
		/**
		* Loads Asset
		*
		* @param		s		String 		Address of XML
		*/
		public function load(s:String):void{
			_request = new URLRequest(s);
			try {
                _loader.load(_request);
            } catch (error:ArgumentError) {
				if(AssetLoader.DEBUG)
                	trace("AssetLoader: An ArgumentError has occurred.");
            } catch (error:SecurityError) {
				if(AssetLoader.DEBUG)
                	trace("AssetLoader: A SecurityError has occurred.");
            }
		}
		
		/**
		* unloads current Asset
		*/
		public function unload():void{
			_content = null;
		}
		
		
		/**
		* To be overriden.  Guarantees and concrete classes have to properly destroy their assets
		*/
		public function destroy():void{
            _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.OPEN, openHandler);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.UNLOAD, unLoadHandler);
			
			_loader = null;
			_content = null;
		}
		
		// L I S T E N E R S
		
		public function completeHandler(event:Event):void{
			_content = DisplayObject(_loader.content);
			_loader.unload();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function progressHandler(event:ProgressEvent):void {
			if(AssetLoader.DEBUG)
				trace(this + " progress: " + event.bytesLoaded + " " + event.bytesTotal)
			dispatchEvent(ProgressEvent(event));
        }
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			if(AssetLoader.DEBUG)
				trace(this + " HTTPStatus handler: " + event)
		}

		private function initHandler(event:Event):void {
			if(AssetLoader.DEBUG)
				trace(this + " init handler: " + event)
		}

        public function ioErrorHandler(event:IOErrorEvent):void {
			if(AssetLoader.DEBUG)
				trace(this + " IOError handler: " + event)
				
			dispatchEvent(IOErrorEvent(event));
		}

        private function openHandler(event:Event):void {
			if(AssetLoader.DEBUG)
				trace(this + " open handler: " + event)
		}

        private function unLoadHandler(event:Event):void {
			if(AssetLoader.DEBUG)
				trace(this + " unload handler: " + event)
		}
	}
	
}
