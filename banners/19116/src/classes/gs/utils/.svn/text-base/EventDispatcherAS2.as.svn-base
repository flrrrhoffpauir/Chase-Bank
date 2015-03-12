/*
VERSION: 1.2
DATE: 2/15/2008
DESCRIPTION:
	An AS2 EventDispatcher that mimics the funtionality of the Event model in AS3.

EXAMPLE: 
	To make a class able to dispatch these events (and have other objects "subscribe" to it using the addEventListener() method),
	make sure you add 3 public properties to the class (addEventListener:Function, removeEventListener:Function, dispatchEvent:Function,
	and listeners:Array) and then in the contructor, call the EventDispatcherAS2.initialize(this) function, passing an instance of the class
	like so:
	
		import gs.utils.EventDispatcherAS2;
		class MyClass {
			var addEventListener:Function;
			var removeEventListener:Function;
			var dispatchEvent:Function;
			var listeners:Array;
			
			function myClass() {
				EventDispatcherAS2.initialize(this);
			}
			
			function onPress():Void {
				dispatchEvent("onPress", {target:this, type:"press", time:getTimer()});
			}
		}
		
	And then to add a listener, do:
		
		var my_obj = new MyClass();
		my_obj.addEventListener("onPress", onPressHandler);
		function onPressHandler(event_obj:Object):Void {
			trace("onPress triggered at "+event_obj.time);
		}
		my_obj.onPress();

		
NOTES:
	- You can specify the scope for the listener function by passing it in as the third parameter in addEventListener, like:
	  my_obj.addEventListener("onLoad", myOnLoad, this);

CODED BY: Jack Doyle, jack@greensock.com
*/

class gs.utils.EventDispatcherAS2 {
	static var dispatcher:EventDispatcherAS2;
	
	static function initialize($o:Object):Void {
		if (dispatcher == undefined) {
			dispatcher = new EventDispatcherAS2();
		}
		$o.addEventListener = dispatcher.addEventListener;
		$o.removeEventListener = dispatcher.removeEventListener;
		$o.dispatchEvent = dispatcher.dispatchEvent;
		$o.listeners = [];
	}
	
	public function addEventListener($type:String, $handler:Function, $scope:Object):Void {
		var thisProxy = this;
		var a:Array = thisProxy.listeners;
		$type = $type.toLowerCase();
		for (var i:Number = 0; i < a.length; i++) {
			if (a[i].type == $type && a[i].handler == $handler) {
				return;
			}
		}
		a.push({type:$type, handler:$handler, scope:$scope});
	}
	
	public function removeEventListener($type:String, $handler:Function):Void {
		var thisProxy = this;
		var a:Array = thisProxy.listeners;
		$type = $type.toLowerCase();
		for (var i:Number = a.length - 1; i > -1 ; i--) {
			if (a[i].handler == $handler && a[i].type == $type) {
				a.splice(i, 1);
				return;
			}
		}
	}
	
	public function dispatchEvent($type:String, $event:Object):Void {
		var thisProxy = this;
		var a:Array = thisProxy.listeners.slice();
		$type = $type.toLowerCase();
		for (var i:Number = 0; i < a.length; i++) {
			if (a[i].type == $type) {
				if (a[i].scope != undefined) {
					a[i].handler.apply(a[i].scope, [$event]);
				} else {
					a[i].handler($event);
				}
			}
		}
	}
	
}