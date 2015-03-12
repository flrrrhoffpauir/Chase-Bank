/*******************************************************************************************************
//
// XMLLoader
//  Created by David Dinh, Sr. Rich Media Designer on 2008-02-12.
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
	import flash.events.EventDispatcher;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.net.URLRequestMethod;	
	import flash.net.URLVariables;


	public class XMLLoader extends EventDispatcher implements IXMLLoader{

		// P R O P E R T I E S
		private var _xml		:XML;
		private var _request	:URLRequest;
		private var _loader		:URLLoader;
		private var _data		:URLVariables = null;


		// C O N S T R U C T O R

		public function XMLLoader(){			
	        _loader = new URLLoader();
            _loader.addEventListener(Event.COMPLETE, completeHandler);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_loader.addEventListener(Event.INIT, initHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.addEventListener(Event.OPEN, openHandler);
			_loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.addEventListener(Event.UNLOAD, unLoadHandler);  
						          
		}

		// G E T T E R S  &  S E T T E R S
		
		public function get xml():XML{
			return _xml;
		}
		
		public function set data(d:URLVariables):void{
			_data = new URLVariables();
			_data = d;
		}
		
		
		// M E T H O D S

		/**
		* Loads XML
		*
		* @param		s		String 		Address of XML
		*/
		public function load(s:String):void{
			_request = new URLRequest(s);
			_request.method = URLRequestMethod.GET;
			
			// if no data inserted
			if(_data != null) _request.data = _data;
			
			try {
                _loader.load(_request);
            } catch (error:ArgumentError) {
                trace("An ArgumentError has occurred.");
            } catch (error:SecurityError) {
                trace("A SecurityError has occurred.");
            }
		}
	
				
		// L I S T E N E R S
		private function completeHandler(event:Event):void{
			_xml = XML(event.target.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			//trace("AssetLoader: HTTPStatus " + event)
		}

		private function initHandler(event:Event):void {
			//trace("AssetLoader: init " + event)
		}

        private function ioErrorHandler(event:IOErrorEvent):void {
			dispatchEvent(IOErrorEvent(event));
		}
		
        private function openHandler(event:Event):void {
			//trace("AssetLoader: open " + event)
		}

        private function progressHandler(event:ProgressEvent):void {
			dispatchEvent(ProgressEvent(event));
        }

        private function unLoadHandler(event:Event):void {
			//trace("AssetLoader: unload " + event)
		}
	}
}