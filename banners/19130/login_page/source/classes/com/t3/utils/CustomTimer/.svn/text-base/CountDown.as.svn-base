package com.t3.utils.CustomTimer{
	
	// I N C L U D E S            
	
	import com.t3.utils.CustomTimer.CustomTimerEvent;
	   	
	import flash.utils.Timer;       
    import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	
	/**
	 * Dispatched whenever a CountDown updates.
     *
     * @eventType com.t3.CustomTimer.CustomTimerEvent.COUNTDOWN
	 */
	[Event(name="countDown", type="com.t3.CustomTimer.CustomTimerEvent")] 
	
	/**
	 * Dispatched whenever a CountDown has completed.
     *
     * @eventType com.t3.CustomTimer.CustomTimerEvent.COUNTDOWN_COMPLETE
	 */
	[Event(name="countDownComplete", type="com.t3.CustomTimer.CustomTimerEvent")]	                                	 
	
	/**                              
	 * The CountDown class counts down from the System's Date to target Date. 
	 * Use the start() method to start the countdown. Add an event listener for 
	 * the countdown event to set up code to be run on the timer interval.      
	 *	   
	 * @author david vo
	 *	
	 * @langversion Actionscript 3.0
	 * @since Created on 16-Dec-2008
	 * @description Copyright (c) 2008 T3 | The Think Tank. All rights reserved.   
	 * @see	#CountDown() CountDown()
	 */	                                                             	   
	public class CountDown extends EventDispatcher {
		
		// P R O P E R T I E S	                                       		
				                         
		private var _endDate	:Date;		
		private var _timer		:Timer;
		private var _running	:Boolean;


		/** 
		* Constructs a new CountDown object with the target year, month and day.
		*  
		* <p>The count-down does not start automatically; you must call the start() method to start it.</p>     
		* 
		* @param y The target's year.
		* @param m The target's month.
		* @param d The target's day.
		*	         
		* @example The following code sets up the countdown along with the corresponding handlers: 
		* <listing version="3.0" >
		* package {
		*					import com.t3.CustomTimer.CountDown;
		*					import com.t3.CustomTimer.CustomTimerEvent;
		*	
		*					public class CountDown_constructorExample{
		*	
		*									private var countDown:CountDown = new CountDown(2009, 12, 1);
		*	
		*									public function CountDown_constructorExample() {
		*													countDown.addEventListener(CustomTimerEvent.COUNTDOWN, countHandler);
		*													countDown.addEventListener(CustomTimerEvent.COUNTDOWN_COMPLETE, completeHandler);
		*	
		*													countDown.start();
		*									}
		*	
		*									private function countHandler(e:CustomTimerEvent){
		*													trace(e.data.d + ":" + e.data.h + ":" + e.data.m + ":" + e.data.s);
		*									}
		*	
		*									private function completeHandler(e:TimerEvent):void {
		*													trace("CountDown Complete");
		*									}
		*					}
		* }
		* </listing>
 	    */                                  
		public function CountDown(y:Number, m:Number, d:Number, h:Number, min:Number){
			var delay:Number = 1000;                    
			
			_endDate = new Date(y, m-1, d, h-1, min-1)
			_timer 	 = new Timer(delay);                           
			
			_timer.addEventListener(TimerEvent.TIMER, timeHandler);
		}


		// G E T T E R S  &  S E T T E R S		
		
		/**
		* The countdown's current state; true if the count-down is running, otherwise false.
		*/
		public function get running():Boolean{ 
			return _running; 
		}     	
                  

		// M E T H O D S
		                                   
		/** 
		* Starts the count-down, if it is not already running.
		* 
		* @see	#pause() CountDown.pause()
 	    */		
		public function start():void{  
			_timer.start();   		
			_running = true;
		}                 
		                                         
		/** 
		* Pauses the count-down.
		*	
		* @see	#start() CountDown.start()
 	    */		
		public function pause():void{
			_timer.stop();
			_running = false;
		}
		                        
		/** 
		* Stops the count-down, if it is running, and removes listener(s).
 	    */		
		public function kill():void{
			_timer.removeEventListener(TimerEvent.TIMER, timeHandler);
			_running = false;
		}   
				                 			
		
		// L I S T E N E R S
           
		/** 
		* Constructs a new CountDown object with the target year, month and day.
		* 
		* @param e TimerEvent the target's year.
 	    */                      
		private function timeHandler(e:TimerEvent):void{
			    
			var curDate		:Date = new Date();
			//trace("end: " + _endDate.getFullYear() + " " + _endDate.getMonth() + " " + _endDate.getDate() )
			//trace("now: " + curDate.getFullYear() + " " + curDate.getMonth() + " " + curDate.getDate() )
			
			
			
			var timeLeft	:Number = _endDate.getTime() - curDate.getTime();
			var seconds		:Number = Math.floor(timeLeft / 1000);
			var minutes		:Number = Math.floor(seconds / 60);
			var hours		:Number = Math.floor(minutes / 60);
			var days		:Number = Math.floor(hours / 24);
                     
			
			seconds %= 60;
			minutes %= 60;
			hours %= 24;

			var s			:String = seconds.toString();
			var m			:String = minutes.toString();
			var h			:String = hours.toString();
			var d			:String = days.toString();       
			var o			:Object = new Object();                      

			if (s.length < 2) s = "0" + s;

			if (m.length < 2) m = "0" + m;

			if (h.length < 2) h = "0" + h;
			
			o.d = d;          
			o.h = h;
			o.m = m;
			o.s = s;
			
			
			
			dispatchEvent(new CustomTimerEvent(CustomTimerEvent.COUNTDOWN, o));
			
			if (days<=0 && hours<=0 && minutes<=0 && seconds<=0){
				dispatchEvent(new CustomTimerEvent(CustomTimerEvent.COUNTDOWN_COMPLETE));
				pause();
			}
			
		}      		                   
	}
	
}