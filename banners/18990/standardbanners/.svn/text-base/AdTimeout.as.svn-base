import mx.utils.Delegate;
import mx.events.EventDispatcher;

// Version 1.2

class AdTimeout extends EventDispatcher{ 
	//==============================================
	// PROPERTIES
	//==============================================
		public static var START:String		= "start";
		public static var TRIGGER:String	= "trigger";
		public static var CANCEL:String 	= "cancel";
		public static var enableTrace:Boolean = true;
	
		public var absolute:Number=0;
		public var relative:Number=0;
		public var isLocked:Boolean=false;
	
		private var timeout_to:Number;
		private var isCancelled:Boolean=false;
		private var interactionListener:Object;
	//==============================================
	// CONSTRUCTOR
	//==============================================
		//declare the dispatchEvent
		function dispatchEvent() {};
		function addEventListener() {};
		function removeEventListener() { };
		
		function AdTimeout() {
			EventDispatcher.initialize(this);
		}
		
	//==============================================
	// METHODS
	//==============================================
	// PUBLIC
	//----------------------------------------------
		public function start(abs:Number, rel:Number, bLock:Boolean){
			reset();
			
			// Set defaults for any undefined properties
			if(abs==undefined) abs=0;
			if(rel==undefined) rel=0;
			if(bLock==undefined) bLock=false;
			this.absolute = abs;
			this.relative = rel;
			this.isLocked = bLock;
			
			// Report the successful initialization
			this.doTrace("Initialized:"
				+"\n\t• Absolute (from ad start): "+abs+" second(s)"
				+"\n\t• Relative (from video end): "+rel+" second(s)"
				+"\n\t• Timeouts Locked?: " + bLock + " (user interaction will " + (bLock?"not ":"") + "cancel timeouts)");
				
			if(abs<=0 && rel<=0){
				this.doTrace("\n\t• No timeouts defined. Start timeout using adTimeout.trigger(n)");
			}
				
			if (relative > 0) 
			{
				_global.Unicast.addEventListener("UnicastVideoEvent", Delegate.create(this, videoListener));
			}
			
			var videoIsActive:Boolean = (relative > 0 && _global.Unicast.current_vid != null && _global.Unicast.current_vid.isActive == true) ? true : false;
			trace("------------------->>>>>>>>>>>>>>>>>videoIsActive: "+videoIsActive);
			if (absolute > 0 && videoIsActive == false) {
				startTimeout(absolute);
			}

//			if (absolute) startTimeout(absolute);
			
			// If unlocked, enable the user to cancel auto-timeouts
			if(!isLocked) enableCancelTimeout();
		}
		
		public function cancel(force:Boolean){
			doTrace("Timeout Cancelled.");
			if(!force && this.isLocked) return;
			cancelTimeout();
		}
		
		public function trigger(delay:Number) {
			if (isCancelled) return;		// If user already cancelled timeout, ignore this call
			
			if (!delay) {					// If no delay is specified...
				onTimeout();				// ...trigger immediately
				
			}else {							// Otherwise
				startTimeout(delay);		// ...trigger after custom delay
			}
		}
	//----------------------------------------------
	// PRIVATE
	//----------------------------------------------
		// Video listener is used auto-detect video & cancel absolute timeout in leu of relative timeout
		private function videoListener(e:Object) {
			if (relative <= 0) return;
			
			switch(e.subtype){
				case "Start":
					// Video detected, cancel absolute timeout
					_global.clearTimeout(timeout_to);
					doTrace("Video detected.\n\t• Absolute timeout cancelled.\n\t• Relative timeout will start when video ends.");
					break;
				case "End":
					// Video ended, start relative timeout
					startTimeout(relative); // Relative Video Timeout
					break;
			}
		}
		
		private function reset(){
			stopTimeout();
			isCancelled=false;
		}		
		
		private function startTimeout(timeInSec:Number){
			if(isCancelled || timeInSec<=0)return;
			doTrace("Timeout Started ("+timeInSec+" seconds)");
			_global.clearTimeout(timeout_to);
			timeout_to = _global.setTimeout(Delegate.create(this,onTimeout),timeInSec*1000);
			var obj:Object = {type:START, target:this, length:timeInSec};
			this.dispatchEvent(obj);
		}
	
		private function stopTimeout(){
			_global.clearTimeout(timeout_to);
//			Mouse.removeListener(interactionListener);
			Mouse.removeListener(this);
		}
		private function onMouseDown(){
			doTrace("User Interaction Detected.\n\tTimeout Cancelled.");
			cancelTimeout();
		}
		private function cancelTimeout(){
			stopTimeout();
			isCancelled=true;
			var obj:Object = {type:CANCEL, target:this};
			this.dispatchEvent(obj);
		}
		
		private function enableCancelTimeout(){
			isCancelled=false;
//			Mouse.addListener(interactionListener);
			Mouse.addListener(this);
		}
					
		private function onTimeout(){
			doTrace("Timeout Triggered.");
			var obj:Object = {type:TRIGGER, target:this};
			this.dispatchEvent(obj);
		}
		
		private function doTrace(str:String){
			if(enableTrace) trace("[TIMEOUT] "+str);
		}		
		public function toString():String{
			return "[PanelTimeout Instance]";
		};
}