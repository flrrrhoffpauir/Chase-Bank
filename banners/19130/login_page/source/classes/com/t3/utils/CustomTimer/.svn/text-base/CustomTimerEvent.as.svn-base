package com.t3.utils.CustomTimer{              
	
	// I N C L U D E S	       
	
	import flash.events.Event;
	                             
	
	/**                              
	 * The CustomTimerEvent class represents events that are broadcast by the com.t3.CustomTimer class.
	 *	
	 * @author David Vo
	 * 
	 * @langversion Actionscript 3.0
	 * @since Created on 16-Dec-2008
	 * @description Copyright (c) 2008 T3 | The Think Tank. All rights reserved.
	 * @see	com.t3.CustomTimer.CountDown
	 */
	public class CustomTimerEvent extends Event{	
		                            
		// P R O P E R T I E S	                                       		    		
		                                                
		/**
		* Dispatched whenever a CountDown object reaches an interval of 1000ms.
		*
		* <p>This event has the following properties:</p>
		* <table class=innertable>
		* <tr><th>Property</th><th>Value</th></tr>
		* <tr><td>bubbles</td><td>true</td>
		* <tr><td>cancelable</td><td>false</td>
		* <tr><td>currentTarget</td><td>The object that is actively processing the Event object with an event listener.</td>
		* <tr><td>target</td><td>The object that dispatched the event.</td>
		* <tr><td>data</td><td>The object containing the month, day, minute and seconds remaining, when the event occured.</td>
		* </table>
		*	
		* @eventType countDown
		*/
		public static const COUNTDOWN			:String = "countDown"; 
		
		/**
		* Dispatched whenever a CountDown has counted down to 00:00:00:00.
		*
		* <p>This event has the following properties:</p>
		* <table class=innertable>
		* <tr><th>Property</th><th>Value</th></tr>
		* <tr><td>bubbles</td><td>true</td>
		* <tr><td>cancelable</td><td>false</td>
		* <tr><td>currentTarget</td><td>The object that is actively processing the Event object with an event listener.</td>
		* <tr><td>target</td><td>The object that dispatched the event.</td>
		* </table>
		*	
		* @eventType countDownComplete
		*/
		public static const COUNTDOWN_COMPLETE 	:String = "countDownComplete";
		
		/**
		* Dispatched whenever a StopWatch object reaches an interval specified according to the delay set by user.
		*
		* <p>This event has the following properties:</p>
		* <table class=innertable>
		* <tr><th>Property</th><th>Value</th></tr>
		* <tr><td>bubbles</td><td>true</td>
		* <tr><td>cancelable</td><td>false</td>
		* <tr><td>currentTarget</td><td>The object that is actively processing the Event object with an event listener.</td>
		* <tr><td>target</td><td>The object that dispatched the event.</td>
		* <tr><td>data</td><td>The object containing the month, day, minute and seconds remaining, when the event occured.</td>
		* </table>
		*	
		* @eventType stopWatch
		*/
		public static const STOPWATCH			:String = "stopWatch";		

		private var _data		   				:Object;
		

		/** 
		* Constructs a new CountDownEvent event.
		* 
		* @param type 		String	the Event name
		* @param data 		Object	data passed as an Object 
		* @param bubbles 	Boolean bubble or not
		* @param cancelable	Boolean cancelable or not
 	    */
		public function CustomTimerEvent(type:String, data:Object=null, bubbles:Boolean=true, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			_data = data;
		}
		                
		
		// G E T T E R S  &  S E T T E R S 		
		 		                                           
		/**
		* Get Event Data.
		*	
		* @private
		*/
		public function get data():Object{ 
			return _data; 
		}                   
		                       
		
		// M E T H O D S		                        
		    
		/**
		* Creates a copy of the CustomTimerEvent object and sets each property's value to match that of the original.
		*	
		* @return Creates a copy of the CustomTimerEvent object and sets each property's value to match that of the original.
		*/		
		public override function clone():Event{
			return new CustomTimerEvent(type, data, bubbles, cancelable);
		}		                       
		      		
		/**
		* Returns a string that contains all the properties of the CustomTimerEvent object. The string is in the following format:
		* <p>[CustomTimerEvent data=value type=value bubbles=value cancelable=value]</p>
		*	
		* @return Returns a string that contains all the properties of the Event object.
		*/		
		public override function toString():String {
            return formatToString("CustomTimerEvent", "data", "type", "bubbles", "cancelable");
        }		
		
		
		// L I S T E N E R S   		
		
	}
	
}