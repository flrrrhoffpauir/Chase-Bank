/*
VERSION: 6.04
DATE: 3/11/2008
ACTIONSCRIPT VERSION: 2.0 (AS3 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenLite.com 
DESCRIPTION:
	Tweening. We all do it. Most of us have learned to avoid Adobe's Tween class in favor of a more powerful, 
	less code-heavy engine (Tweener, Fuse, MC Tween, etc.). Each has its own strengths & weaknesses. A few years back, 
	I created TweenLite because I needed a very compact tweening engine that was fast and efficient (I couldn't 
	afford the file size bloat that came with the other tweening engines). It quickly became integral to my work flow.

	Since then, I've added new capabilities while trying to keep file size way down (3K). TweenFilterLite extends 
	TweenLite and adds the ability to tween filters including ColorMatrixFilter effects like saturation, contrast, 
	brightness, hue, and even colorization but it only adds about 3k to the file size. Same syntax as TweenLite. 
	There are AS2 and AS3 versions of both of the classes.

	I know what you're thinking - "if it's so 'lightweight', it's probably missing a lot of features which makes 
	me nervous about using it as my main tweening engine." It is true that it doesn't have the same feature set 
	as the other tweening engines, but I can honestly say that after using it on almost every project I've worked 
	on over the last few years, it has never let me down. I never found myself needing some other functionality. 
	You can tween any property (including a MovieClip's volume and color), use any easing function, build in delays, 
	callback functions, pass arguments to that callback function, and even tween arrays all with one line of code. 
	You very well may require a feature that TweenLite (or TweenFilterLite) doesn't have, but I think most 
	developers will use the built-in features to accomplish whatever they need and appreciate the streamlined 
	nature of the class(es).

	I haven't been able to find a faster tween engine either. The syntax is simple and the class doesn't rely on 
	complicated prototype alterations that can cause problems with certain compilers. TweenLite is simple, very 
	fast, and more lightweight than any other popular tweening engine.

PARAMETERS:
	1) $target: Target MovieClip (or other object) whose properties we're tweening
	2) $duration: Duration (in seconds) of the tween
	3) $vars: An object containing the end values of all the properties you'd like to have tweened (or if you're using the 
	          TweenLite.from() method, these variables would define the BEGINNING values). For example:
					  _alpha: The alpha (opacity level) that the target object should finish at (or begin at if you're 
							  using TweenLite.from()). For example, if the target_obj._alpha is 100 when this script is 
					  		  called, and you specify this argument to be 50, it'll transition from 100 to 50.
					  _x: To change a MovieClip's x position, just set this to the value you'd like the MovieClip to 
					      end up at (or begin at if you're using TweenLite.from()). 
				  SPECIAL PROPERTIES (OPTIONAL):
				  	  delay: Amount of delay before the tween should begin (in seconds).
					  ease: You can specify a function to use for the easing with this variable. For example, 
					        mx.transitions.easing.Elastic.easeOut. The Default is Regular.easeOut.
					  easeParams: An array of extra parameters to feed the easing equation. This can be useful when you 
					  			  use an equation like Elastic and want to control extra parameters like the amplitude and period.
								  Most easing equations, however, don't require extra parameters so you won't need to pass in any easeParams.
					  autoAlpha: Same as changing the _alpha property but with the additional feature of toggling the _visible 
				  			 	 property to false if the _alpha ends at 0. It will also toggle _visible to true before the tween 
								 starts if the value of autoAlpha is greater than zero.
					  volume: To change a MovieClip's volume, just set this to the value you'd like the MovieClip to
					          end up at (or begin at if you're using TweenLite.from()).
					  tint: To change a MovieClip's color, set this to the hex value of the color you'd like the MovieClip
					  		to end up at(or begin at if you're using TweenLite.from()). An example hex value would be 0xFF0000. 
							If you'd like to remove the color from a MovieClip, just pass null as the value of tint. 
							(tint used to be called mcColor prior to version 5.8)
					  frame: Use this to tween a MovieClip to a particular frame.
					  onStart: If you'd like to call a function as soon as the tween begins, pass in a reference to it here.
					  		   This is useful for when there's a delay. 
					  onStartParams: An array of parameters to pass the onStart function. (this is optional)
					  onStartScope: Use this to define the scope of the onStart function.
					  onUpdate: If you'd like to call a function every time the property values are updated (on every frame during
								the time the tween is active), pass a reference to it here.
					  onUpdateParams: An array of parameters to pass the onUpdate function (this is optional)
					  onUpdateScope: Use this to define the scope of the onUpdate function.
					  onComplete: If you'd like to call a function when the tween has finished, use this. 
					  onCompleteParams: An array of parameters to pass the onComplete function (this is optional)
					  onCompleteScope: Use this to define the scope of the onComplete function.
					  renderOnStart: If you're using TweenLite.from() with a delay and want to prevent the tween from rendering until it
					  				 actually begins, set this to true. By default, it's false which causes TweenLite.from() to render
									 its values immediately, even before the delay has expired.
					  overwrite: If you do NOT want the tween to automatically overwrite any other tweens that are 
					             affecting the same target, make sure this value is false.
	

EXAMPLES: 
	As a simple example, you could tween the _alpha to 50% and move the _x position of a MovieClip named "clip_mc" 
	to 120 and fade the volume to 0 over the course of 1.5 seconds like so:
	
		gs.TweenLite.to(clip_mc, 1.5, {_alpha:50, _x:120, volume:0});
		
	To set up a sequence where we fade a MovieClip to 50% opacity over the course of 2 seconds, and then slide it down
	to _y coordinate 300 over the course of 1 second:
	
		import gs.TweenLite;
		TweenLite.to(clip_mc, 2, {_alpha:50});
		TweenLite.to(clip_mc, 1, {_y:300, delay:2, overwrite:false});
	
	If you want to get more advanced and tween the clip_mc MovieClip over 5 seconds, changing the _alpha to 50%, 
	the _x to 120 using the "easeOutBack" easing function, delay starting the whole tween by 2 seconds, and then call
	a function named "onFinishTween" when it has completed and pass in a few parameters to that function (a value of
	5 and a reference to the clip_mc), you'd do so like:
		
		import gs.TweenLite;
		import mx.transitions.easing.Back;
		TweenLite.to(clip_mc, 5, {_alpha:50, _x:120, ease:Back.easeOut, delay:2, onComplete:onFinishTween, onCompleteParams:[5, clip_mc]});
		function onFinishTween(argument1_num:Number, argument2_mc:MovieClip):Void {
			trace("The tween has finished! argument1_num = " + argument1_num + ", and argument2_mc = " + argument2_mc);
		}
	
	If you have a MovieClip on the stage that is already in it's end position and you just want to animate it into 
	place over 5 seconds (drop it into place by changing its _y property to 100 pixels higher on the screen and 
	dropping it from there), you could:
		
		import gs.TweenLite;
		import mx.transitions.easing.Elastic;
		TweenLite.from(clip_mc, 5, {_y:"-100", ease:Elastic.easeOut});		
	

NOTES:
	- This class will add about 3kb to your Flash file.
	- Putting quotes around values will make the tween relative to the current value. For example, if you do
	  TweenLite.to(mc, 2, {x:"-20"}); it'll move the mc.x to the left 20 pixels which is the same as doing
	  TweenLite.to(mc, 2, {x:mc.x - 20});
	- You can tween the volume of any MovieClip using the tween property "volume", like:
	  TweenLite.to(myClip_mc, 1.5, {volume:0});
	- You can tween the color of a MovieClip using the tween property "tint", like:
	  TweenLite.to(myClip_mc, 1.5, {tint:0xFF0000});
	- To tween an array, just pass in an array as a property (it doesn't matter what you name it) like:
	  var myArray:Array = [1,2,3,4];
	  TweenLite.to(myArray, 1.5, {endArray:[10,20,30,40]});
	- You can kill all tweens for a particular object (usually a MovieClip) anytime with the 
	  TweenLite.killTweensOf(myClip_mc); function. If you want to have the tweens forced to completion, 
	  pass true as the second parameter, like TweenLite.killTweensOf(myClip_mc, true);
	- You can kill all delayedCalls to a particular function using TweenLite.killDelayedCallsTo(myFunction_func);
	  This can be helpful if you want to preempt a call.
	- Use the TweenLite.from() method to animate things into place. For example, if you have things set up on 
	  the stage in the spot where they should end up, and you just want to animate them into place, you can 
	  pass in the beginning _x and/or _y and/or _alpha (or whatever properties you want).
	  
CHANGE LOG:
	6.04:
		- Fixed bug that caused calls to complete() to not render if the tween hadn't ever started (like if there was a delay that hadn't expired yet)
	6.03:
		- Added the "renderOnStart" property that can force TweenLite.from() to render only when the tween actually starts (by default, it renders immediately even if the tween has a delay.)
	6.02:
		- Fixed bug that could cause TweenLite.delayedCall() to get called twice.
	6.01:
		- Fixed bug that could cause TweenLite.from() to not render the values immediately.
		- Fixed bug that could prevent tweens with a duration of zero from rendering properly.
	6.0:
		- Added ability to tween a MovieClip's frame
		- Added onCompleteScope, onStartScope, and onUpdateScope
		- Reworked internal class routines for handling SubTweens
	5.9:
		- Added ability to tween sound volumes directly (not just MovieClip volumes).
	5.88:
		- Fixed bug that caused color tweens not to work when the duration was 0.
		- Fixed bug that caused the _alpha to remain 0 when removing a tint in certain circumstances.
	5.84:
		- Fixed an issue that could cause a problem with TextField filters being applied properly with TweenFilterLite.
	5.8:
		- Added the ability to define extra easing parameters using easeParams.
		- Changed "mcColor" to "tint" in order to make it more intuitive. Using mcColor for tweening color values is deprecated and will be removed eventually.
	5.7:	
		- Improved speed (made changes to the render() and initTweenVals() functions)
		- Added a complete() function which allows you to immediately skip to the end of a tween.
	5.61:
		- Removed a line of code that could (very rarely) cause TweenFilterLite tweens to not complete.
		- Fixed an issue with tweening _alpha and tint together.
	5.3:
		- Added onUpdate and onUpdateParams features
		- Finally removed extra/duplicated (deprecated) constructor parameters that had been left in for almost a year simply for backwards compatibility.

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

class gs.TweenLite {
	public static var version:Number = 6.04;
	public static var killDelayedCallsTo:Function = killTweensOf;
	private static var _e:MovieClip; //A reference to the empty MovieClip that we use to drive all our onEnterFrame actions.
	private static var _all:Object = new Object(); //Holds references to all our tweens.
	private static var _cnt:Number = -16000;
	private static var _gc:Number; //Interval id for garbage collection
	private static var _hrp:Boolean = false;
	private var _active:Boolean; //If true, this tween is active. 
	private var _subTweens:Array; //Only used for associated sub-tweens like tint and volume
	private var _hst:Boolean; //Has SubTweens. We track this with a boolean value as opposed to checking _subTweens.length for speed purposes
	private var _initted:Boolean;
	
	var duration:Number; //Duration (in seconds)
	var vars:Object; //Variables (holds things like _alpha or _y or whatever we're tweening)
	var delay:Number; //Delay (in seconds)
	var startTime:Number; //Start time
	var initTime:Number; //Time of initialization. Remember, we can build in delays so this property tells us when the frame action was born, not when it actually started doing anything.
	var tweens:Object; //Contains parsed data for each property that's being tweened (each has to have a target, start, change, and an ease).
	var target:Object; //Target object (usually a MovieClip)
	var tweenID:String; //Tween ID (a way to identify each tween, i.e. "tw1", "tw2", "tw3")
	var endTargetID:String; //Target ID (a way to identify each end target, i.e. "t1", "t2", "t3")
	
	public function TweenLite($target:Object, $duration:Number, $vars:Object) {
		_cnt++;
		tweenID = "tw" + _cnt;
		endTargetID = getID($target, true);
		if ($vars.overwrite != false && $target != undefined) { 
			delete _all[endTargetID];
			_all[endTargetID] = {info:[$target, endTargetID]}
		}
		_all[endTargetID][tweenID] = this;
		this.vars = $vars;
		this.duration = $duration || 0.001;//Easing equations don't work when the duration is zero.
		this.delay = $vars.delay || 0;
		this.target = $target;
		if (typeof(this.vars.ease) != "function") {
			this.vars.ease = easeOut;
		}
		if (this.vars.easeParams != undefined) {
			this.vars.proxiedEase = this.vars.ease;
			this.vars.ease = easeProxy;
		}
		if (this.vars.mcColor != undefined) {
			this.vars.tint = this.vars.mcColor; //For backwards compatibility
		}
		if (typeof(this.vars.autoAlpha) == "number") {
			this.vars._alpha = this.vars.autoAlpha;
		}
		this.tweens = {};
		_subTweens = [];
		_hst = _initted = false;
		_active = ($duration == 0 && this.delay == 0);
		this.initTime = getTimer();
		if (_active || (this.vars.runBackwards == true && this.vars.renderOnStart != true)) {
			initTweenVals();
			this.startTime = getTimer();
			if (_active) { //Means duration is zero and delay is zero, so render it now, but add one to the startTime because this.duration is always forced to be at least 0.001 since easing equations can't handle zero.
				render(this.startTime + 1);
			} else {
				render(this.startTime);
			}
		}
		if (!_active) {
			if (_e._visible != false) { //We were running into strange issues back on Flash player 6 in nested SWFs where _e was defined but wasn't valid. As a workaround, we had to test its _visible property to find out if it's really valid. This empty MovieClip will have the onEnterFrame handler attached to it which will call all our activeions.
				if (!_root.tweenLite_mc) { //If this MovieClip is being loaded inside another, there may already be a tweenLite_mc set up in which case we should use that one. Otherwise, set up a new one.
					var l = _root.getNextHighestDepth() || 9999;
					_e = _root.createEmptyMovieClip("tweenLite_mc", l);
					_e.swapDepths(-1); //We shoot this down to level -1 because sometimes developers assume levels at 0 and above are open and just hard-code new MovieClips into those levels without doing a getNextHighestDepth(). We swapDepths just in case there is already a MovieClip on level -1 - that way we don't kill it (replace it).
				} else {
					_e = _root.tweenLite_mc;
				}
				_e._visible = false;
				clearInterval(_gc);
				_gc = setInterval(killGarbage, 2000);
			}
			_e.onEnterFrame = executeAll;
		}
	}
	
	public function initTweenVals($hrp:Boolean, $reservedProps:String):Void {
		var isMC:Boolean = (typeof(this.target) == "movieclip");
		var p, i;
		if (this.target instanceof Array) {
			var endArray = this.vars.endArray || [];
			for (i = 0; i < endArray.length; i++) {
				if (this.target[i] != endArray[i] && this.target[i] != undefined) {
					this.tweens[i.toString()] = {o:this.target, p:i.toString(), s:this.target[i], c:endArray[i] - this.target[i]}; //o: object, s:starting value, c:change in value, e: easing function
				}
			}
		} else {
			for (p in this.vars) {
				if (p == "ease" || p == "delay" || p == "overwrite" || p == "onComplete" || p == "onCompleteParams" || p == "onCompleteScope" || p == "runBackwards" || p == "onUpdate" || p == "onUpdateParams" || p == "onUpdateScope" || p == "autoAlpha" || p == "onStart" || p == "onStartParams" || p == "onStartScope" || p == "renderOnStart" || p == "easeParams" || p == "mcColor" || p == "type" || ($hrp && $reservedProps.indexOf(" " + p + " ") != -1)) { //"type" is for TweenFilterLite, and it's an issue when trying to tween filters on TextFields which do actually have a "type" property.
								
				} else if (p == "tint" && (isMC || this.target instanceof TextField)) { //If we're trying to change the color of a MovieClip or TextField, then set up a quasai proxy using an instance of a TweenLite to control the color.
					var clr:Color = new Color(this.target);
					var endA:Number;
					if (this.vars[p] == null || this.vars[p] == "") { //In case they're actually trying to remove the colorization, they should pass in null or "" for the tint
						if (this.vars._alpha != undefined) {
							endA = this.vars._alpha;
							delete this.vars._alpha;
							delete this.tweens._alpha;
						} else {
							endA = this.target._alpha;
						}
						addSubTween(tintProxy, clr.getTransform(), {rb:0, gb:0, bb:0, ab:0, ra:endA, ga:endA, ba:endA, aa:endA}, {color:clr});
					} else {
						addSubTween(tintProxy, clr.getTransform(), {rb:(this.vars[p] >> 16), gb:(this.vars[p] >> 8) & 0xff, bb:(this.vars[p] & 0xff), ra:0, ga:0, ba:0}, {color:clr});
					}
				} else if (p == "frame" && isMC) {
					addSubTween(frameProxy, {frame:this.target._currentframe}, {frame:this.vars[p]}, {mc:this.target});
				} else if (p == "volume" && (isMC || this.target instanceof Sound)) { //If we're trying to change the volume of a MovieClip or Sound object, then set up a quasai proxy using an instance of a TweenLite to control the volume.
					var snd:Sound;
					if (isMC) {
						snd = new Sound(this.target);
					} else {
						snd = Sound(this.target);
					}
					addSubTween(volumeProxy, {volume:snd.getVolume()}, {volume:this.vars[p]}, {sound:snd});
				} else {
					if (this.target[p] != undefined) {
						if (typeof(this.vars[p]) == "number") {
							this.tweens[p] = {o:this.target, p:p, s:this.target[p], c:this.vars[p] - this.target[p]}; //o:object, p:property, s:starting value, c:change in value
						} else {
							this.tweens[p] = {o:this.target, p:p, s:this.target[p], c:Number(this.vars[p])}; //o:object, p:property, s:starting value, c:change in value
						}
					}
				}
			}
		}
		if (this.vars.runBackwards == true) {
			var tp;
			for (p in this.tweens) {
				tp = this.tweens[p];
				tp.s += tp.c;
				tp.c *= -1;
			}
		}
		if (typeof(this.vars.autoAlpha) == "number") { 
			this.target._visible = !(this.vars.runBackwards == true && this.target._alpha == 0);
		}
		_initted = true;
	}
	
	private function addSubTween($proxy:Function, $target:Object, $props:Object, $info:Object):Void {
		_subTweens.push({proxy:$proxy, target:$target, info:$info});
		for (var p in $props) {
			if ($target[p] != undefined) {
				if (typeof($props[p]) == "number") {
					this.tweens["st" + _subTweens.length + "_" + p] = {o:$target, p:p, s:$target[p], c:$props[p] - $target[p]}; //o:Object, p:Property, s:Starting value, c:Change in value;
				} else {
					this.tweens["st" + _subTweens.length + "_" + p] = {o:$target, p:p, s:$target[p], c:Number($props[p])};
				}
			}
		}
		_hst = true; //has sub-tweens. We track this with a boolean value as opposed to checking _subTweens.length for speed purposes
	}
	
	public static function to($target:Object, $duration:Number, $vars:Object):TweenLite {
		return new TweenLite($target, $duration, $vars);
	}
	
	public static function from($target:Object, $duration:Number, $vars:Object):TweenLite {
		$vars.runBackwards = true;
		return new TweenLite($target, $duration, $vars);;
	}
	
	public static function delayedCall($delay:Number, $onComplete:Function, $onCompleteParams:Array, $onCompleteScope:Object):TweenLite {
		return new TweenLite($onComplete, 0, {delay:$delay, onComplete:$onComplete, onCompleteParams:$onCompleteParams, onCompleteScope:$onCompleteScope, overwrite:false});
	}
	
	public function render($t:Number):Void {
		var time = ($t - this.startTime) / 1000;
		if (time > this.duration) {
			time = this.duration;
		}
		var tp:Object;
		var factor:Number = this.vars.ease(time, 0, 1, this.duration);
		for (var p in this.tweens) {
			tp = this.tweens[p];
			tp.o[tp.p] = tp.s + (factor * tp.c);
		}
		if (_hst) { //has sub-tweens
			for (var i:Number = 0; i < _subTweens.length; i++) {
				_subTweens[i].proxy(_subTweens[i]);
			}
		}
		if (this.vars.onUpdate != undefined) {
			this.vars.onUpdate.apply(this.vars.onUpdateScope, this.vars.onUpdateParams);
		}
		if (time == this.duration) {
			complete(true);
		}
	}
	
	public static function executeAll():Void {
		var a:Object = _all; //to speed things up
		var t:Number = getTimer();
		var tw;
		for (var p in a) {
			for (var twp in a[p]) {
				tw = a[p][twp];
				if (tw.active) {
					tw.render(t);
				}
			}
		}
	}
	
	public static function removeTween($t:TweenLite):Void {
		_all[$t.endTargetID][$t.tweenID] = {active:false};
		delete _all[$t.endTargetID][$t.tweenID];
	}
	
	public static function killTweensOf($tg:Object, $complete:Boolean):Void {
		var id:String = getID($tg, true);
		if ($complete) {
			var o = _all[id];
			for (var tw in o) {
				o[tw].complete(false);
			}
		}
		delete _all[id];
	}
	
	public function complete($skipRender:Boolean):Void {
		if ($skipRender != true) {
			if (!_initted) {
				initTweenVals();
			}
			this.startTime = 0;
			render(this.duration * 1000); //Just to force the render
			return;
		}
		if (typeof(this.vars.autoAlpha) == "number" && this.target._alpha == 0) {
			this.target._visible = false;
		}
		if (this.vars.onComplete) {
			this.vars.onComplete.apply(this.vars.onCompleteScope, this.vars.onCompleteParams);
		}
		removeTween(this);
	}
	
	public static function getID($tg:Object, $lookup:Boolean):String {
		var id:String;
		if ($lookup) {
			var a = _all;
			if (typeof($tg) == "movieclip") {
				if (a[String($tg)] != undefined) {
					return String($tg);
				} else {
					id = String($tg);
					_all[id] = {info:[$tg, id]};
					return id;
				}
			} else {
				for (var p in a) {
					if (a[p].info[0] == $tg) {
						return p;
					}
				}
			}
		}
		_cnt++;
		id = "t" + _cnt;
		_all[id] = {info:[$tg, id]};
		return id;
	}
	
	public static function killGarbage():Void {
		if (_e.onEnterFrame != null) {
			var a:Object = _all;
			var tw, p, twp;
			var tg_cnt = 0;
			var tw_cnt = 0;
			for (p in a) {
				tw_cnt = 0;
				for (twp in a[p]) {
					tw = a[p][twp];
					if (tw.tweens == undefined) {
						delete tw;
					} else {
						tw_cnt++;
					}
				}
				if (tw_cnt == 0) {
					delete a[p];
				} else {
					tg_cnt++;
				}
			}
			if (tg_cnt == 0) {
				_e.onEnterFrame = null;
			}
		}
	}
	
	//Default ease function for tweens other than _alpha (Regular.easeOut)
	private static function easeOut($t:Number, $b:Number, $c:Number, $d:Number):Number {
		return -$c * ($t /= $d) * ($t - 2) + $b;
	}
	
//---- PROXY FUNCTIONS -----------------------------------------------------------------------------------------------------------

	private function easeProxy($t:Number, $b:Number, $c:Number, $d:Number):Number { //Just for when easeParams are passed in via the vars object.
		var o = this; //The scope will actually be this TweenLite's vars object. This line just allows us to get around compilation errors which will say it's illegal to reference "this.proxiedEase" or "this.easeParams".
		return o.proxiedEase.apply(null, arguments.concat(o.easeParams));
	}
	public static function tintProxy($o:Object):Void {
		$o.info.color.setTransform($o.target);
	}
	public static function frameProxy($o:Object):Void {
		$o.info.mc.gotoAndStop(Math.round($o.target.frame));
	}
	public static function volumeProxy($o:Object):Void {
		$o.info.sound.setVolume($o.target.volume);
	}
	
	
//---- GETTERS / SETTERS ----------------------------------------------------------------------------------------------------------
	
	public function get active():Boolean {
		if (_active) {
			return true;
		} else if ((getTimer() - this.initTime) / 1000 > this.delay) {
			_active = true;
			this.startTime = this.initTime + (this.delay * 1000);
			if (!_initted) {
				initTweenVals();
			} else if (typeof(this.vars.autoAlpha) == "number") {
				this.target._visible = true;
			}
			if (this.duration == 0.001) { //In the constructor, if the duration is zero, we shift it to 0.001 because the easing functions won't work otherwise. We need to offset the startTime to compensate too.
				this.startTime -= 1;
			}
			if (this.vars.onStart != undefined) {
				this.vars.onStart.apply(this.vars.onStartScope, this.vars.onStartParams);
			}
			return true;
		} else {
			return false;
		}
	}
	
}