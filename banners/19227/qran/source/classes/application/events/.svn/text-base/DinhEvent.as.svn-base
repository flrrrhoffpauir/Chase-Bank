/******************************************************************************************************

RHREvent

//  Created by David Dinh                   ffLL                                      LLGG
//  Sr. Rich Media Designer               LL######EEtt                            ..KK##DD
//  on 2007-05-16.                      ii############KK;;                        GG##LL..
//  Copyright (c) 2007 __T3__.          ..EE##############ff                    iiWW;;
//  All rights reserved.                  ....DD############GG                  GGii
                                       LL#####################KK::            ;;EE
                  888    888           GGDDLL#######EE##########WWii          EEtt
                  888    888                    ;;;;  tt############EEttiiiiKKKK
                  888    888                            ;;KK################KK..
88888b.   8888b.  888888 888888 .d88b.  888d888 88888b.     ..ttffLLWW######KK
888 "88b     "88b 888    888   d8P  Y8b 888P"   888 "88b            ..KK######;;
888  888 .d888888 888    888   88888888 888     888  888              ;;######tt 
888 d88P 888  888 Y88b.  Y88b. Y8b.     888     888  888                EE####LL
88888P"  "Y888888  "Y888  "Y888 "Y8888  888     888  888                ;;####LL 
888                                                                       LL##DD
888   88888b.  888  888 88888b.d88b.   8888b.                               LL##LL
888   888 "88b 888  888 888 "888 "88b     "88b                                LL##      
      888  888 888  888 888  888  888 .d888888                                jj##tt
      888 d88P Y88b 888 888  888  888 888  888                                ii##tt    
      88888P"   "Y88888 888  888  888 "Y888888                                  tt;;
      888                                      
      888                                      
      888

******************************************************************************************************/

package application.events{
	
	// I N C L U D E S
	
	import flash.events.Event;
	
	/**
	* ExdEvent basically encases a regular event with a data getter and setter
	*/
	public class DinhEvent extends Event{

		// P R O P E R T I E S

		public static const BROADCAST		:String = "send_it";
		private var _data					:Object;

		// C O N S T R U C T O R

		public function DinhEvent(type:String, d:Object, bubbles:Boolean = false, cancelable:Boolean = false){
			
			super(type, bubbles, cancelable);
			_data = d;
		}
		

		// G E T T E R S  &  S E T T E R S
		
		public function get dataObj():Object{
			return _data;
		}
		
		public function set dataObj(obj:Object):void{
			_data = obj;
		}
		
		// M E T H O D S

				
		// L I S T E N E R S


	}
}