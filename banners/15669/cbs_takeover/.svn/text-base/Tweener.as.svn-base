import mx.transitions.Tween;
import mx.transitions.easing.*;


class Tweener{

	
	public function Tweener(){
		//
		// Add additonal tween class methods as needed
		// must be declared here or you'll get erros
		//
		mx.transitions.easing.Strong;
		mx.transitions.easing.Elastic;
		mx.transitions.easing.Back;
	};
	
	
	public static function addTween(objs){
		
		// get object that contians animateable properties
		// and tween settings (delay, transition type, time, etc)
		var properties		= arguments[arguments.length - 1];
		
		// determine if we need to delay running the tween
		var delay			= (properties.delay) ? properties.delay*1000 : false;
		
		// if we need to wait, set a timer to run the tween
		if(delay){
			_global.setTimeout(applyTween, delay, arguments);
			return;
		};
		
		// start tween if no delay exists
		applyTween(arguments);
	}
	
	
	// executes tweens by looping through properties
	// passed into addTween and creating
	// indiviual tweens for each
	
	public static function applyTween(objs){
		
		// get the amount of things that will animate
		var totalObjs 		= objs.length - 2;
		
		// get the object that holds the properties we should animate
		var properties		= objs[objs.length - 1];
		
		// loop through all valid animation properties and create a tween for each
		for(var i = 0; i<=totalObjs; i++){
			var obj = objs[i];
			for(var p in properties){
				// check that the property is something that we can animate
				if(isTweenable(p)){
					var easing 	= properties.transition.split(".");
					var time	= properties.time;
					var t 		= startTween(obj, p, easing[0], easing[1], obj[p], properties[p], time);
				}
			}
		}
		
		// assign event functions to last tween created
		if(properties.onMotionStarted)  t.onMotionStarted 	= properties.onMotionStarted;
		if(properties.onMotionStopped)  t.onMotionStopped 	= properties.onMotionStopped;
		if(properties.onMotionResumed)  t.onMotionResumed 	= properties.onMotionResumed;
		if(properties.onMotionFinished) t.onMotionFinished	= properties.onMotionFinished;
		if(properties.onMotionChanged)  t.onMotionChanged 	= properties.onMotionChanged;
		
	}
	
	
	// the flash tween class method calls
	
	private static function startTween(obj:Object, prop, easeClass:String, easeMethod:String, begin, end, d){
		
		var methodType 	= mx.transitions.easing[easeClass][easeMethod];
		var tween 		= new Tween(obj, prop, methodType, begin, end, d , true);
		return tween;
	}
	
	
	// helper determines when looping through properties
	// whether or not property is an “animatable”
	
	private static function isTweenable(prop){

		if(prop == "delay") 			return false;
		if(prop == "time") 				return false;
		if(prop =="onMotionStarted") 	return false;
		if(prop =="onMotionStopped") 	return false;
	    if(prop =="onMotionResumed") 	return false;
        if(prop =="onMotionFinished") 	return false;
        if(prop =="onMotionChanged") 	return false;
		return true;
	}
}