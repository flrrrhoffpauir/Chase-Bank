﻿import mx.transitions.Tween;import mx.transitions.easing.*;class classes.transitions.Tweens {		public function Tweens() {			}		public function xTween(mc:MovieClip, x1:Number, x2:Number, time:Number):Void {		new Tween(mc, "_x", Strong.easeOut, x1, x2, time, true);	}		public function yTween(mc:MovieClip, y1:Number, y2:Number, time:Number):Void {		new Tween(mc, "_y", Strong.easeOut, y1, y2, time, true);	}		public function ctaShimTween(mc:MovieClip, prop:String, y1:Number, y2:Number, time:Number, _pathToShimmer:MovieClip):Void {		var _ctaXYTween = new Tween(mc, prop, Strong.easeOut, y1, y2, time, true);		_ctaXYTween.onMotionFinished = function():Void		{			_pathToShimmer.gotoAndPlay("shimmer");		}	}		public function xBackTween(mc:MovieClip, x1:Number, x2:Number, time:Number):Void {		new Tween(mc, "_x", Elastic.easeOut, x1, x2, time, true);	}		public function yBackTween(mc:MovieClip, x1:Number, x2:Number, time:Number):Void {		new Tween(mc, "_y", Elastic.easeOut, x1, x2, time, true);	}		public function fadeTween(mc:MovieClip, a1:Number, a2:Number, time:Number):Void {		new Tween(mc, "_alpha", Strong.easeOut, a1, a2, time, true);	}		public function scaleTween(mc:MovieClip, s1:Number, s2:Number, time:Number):Void {		new Tween(mc, "_xscale", Strong.easeOut, s1, s2, time, true);		new Tween(mc, "_yscale", Strong.easeOut, s1, s2, time, true);	}		public function backScaleTween(mc:MovieClip, s1:Number, s2:Number, time:Number):Void {		new Tween(mc, "_xscale", Back.easeOut, s1, s2, time, true);		new Tween(mc, "_yscale", Back.easeOut, s1, s2, time, true);	}		public function xScaleTween(mc:MovieClip, s1:Number, s2:Number, time:Number):Tween {		return new Tween(mc, "_xscale", Strong.easeOut, s1, s2, time, true);	}		public function yScaleTween(mc:MovieClip, s1:Number, s2:Number, time:Number):Tween {		return new Tween(mc, "_yscale", Strong.easeOut, s1, s2, time, true);	}				public function xBounceTween(mc:MovieClip, s1:Number, s2:Number, time:Number):Tween {		return new Tween(mc, "_xscale", Elastic.easeOut, s1, s2, time, true);	}		public function xBounceTween2(mc:MovieClip, s1:Number, s2:Number, time:Number, _pathToShimmer:MovieClip):Void {		var _ccTween = new Tween(mc, "_x", Bounce.easeOut, s1, s2, time, true);		_ccTween.onMotionFinished = function():Void		{			_pathToShimmer.gotoAndPlay("shimmer");		}	}		public function yBounceTween(mc:MovieClip, s1:Number, s2:Number, time:Number):Tween {		return new Tween(mc, "_yscale", Elastic.easeOut, s1, s2, time, true);	}			}