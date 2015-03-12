/**
*	ThumbScroller class
*	Created on 2008-09-15
*
*	@langversion Actionscript 2.0
*	@playerversion 8.0
*	@ since 2008-09-15
*
*      all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      Re-use of this code without express written permission is prohibited.
*
*      The scroller
*
*/

import events.Events;
import events.EventManager;
import tweening.TweenLite;
import tweening.Expo;
import mx.utils.Delegate;

class views.ThumbScroller extends MovieClip {
	
	private var _scope:MovieClip;
	private var _currThumb:Number;
	private var _thumbArray:Array;
	private var _totalThumbs:Number		= 5;
	
	private static var SPEED:Number 	= .55;
	private static var DIST:Number 		= 68;
	private static var EASE:Function 	= Expo.easeOut;
	private static var DIR:String		= "";
	
	public function ThumbScroller() {
		
		_scope = this;
		
		EventManager.addEventListener(Events.SCROLLER_BUTTON_CLICK, this, "scrollContainer");
		EventManager.addEventListener(Events.SCROLLER_STORE_THUMBS, this, "storeThumbs");
		EventManager.addEventListener(Events.SCROLLER_THUMB_RELEASE, this, "setCurrThumb");
		EventManager.addEventListener(Events.LOCATION_HAS_LOADED, this, "showScroller");
		
		initButtons();
	}
	
	
	private function scrollContainer(o:Object):Void {
		
		disableButtons();
		
		// attach next visible thumb
		addNextThumb(o.data.id);
		
		// get distance: positive for left, negative for right
		var dist:Number = (o.data.id == 0) ? DIST : -DIST;
		
		// tween each thumb
		var mc:MovieClip;
		for(var i:Number = 0; i < _totalThumbs; i++) {
			mc = _scope["mcThumbContainer"]["mcThumb"+i];
			
			// so it will animate fully but doesn't remove a thumb each time
			if(i < _totalThumbs-1) {
				TweenLite.to(mc, SPEED, { _x:mc._x+dist, ease:EASE });
			} else {
				TweenLite.to(mc, SPEED, { _x:mc._x+dist, ease:EASE, onComplete:Delegate.create(this, removeThumb) });
			}
		}
	}
	
	
	private function disableButtons():Void {
		_scope["mcLeft"].enabled = false;
		_scope["mcRight"].enabled = false;
	}
	
	
	private function enableButtons():Void {
		_scope["mcLeft"].enabled = true;
		_scope["mcRight"].enabled = true;
	}
	
	
	private function addNextThumb(arrowNum:Number):Void {
		
		// arrowNum will be 0 for left or right
		if(arrowNum == 0) {
			
			// left arrow makes clips go right
			
			// attach clip on left	
			var id:Number = (_thumbArray[0] == 0) ? _totalThumbs-1 : _thumbArray[0]-1;
			var dist:Number = 0-DIST;
			
			// add id to the beginning of the array
			_thumbArray.unshift(id);
			DIR = "right";
			
		} else {
			
			// right arrow makes clips go left
			
			// attach clip on right
			var id:Number = (_thumbArray[2] == _totalThumbs-1) ? 0 : _thumbArray[2]+1;
			var dist:Number = DIST*3;
			
			// add id to the end of the array
			_thumbArray.push(id);
			DIR = "left";
		}
		
		// attach the next thumb
		_scope["mcThumbContainer"].attachMovie("mcThumb"+id, "mcThumb"+id, _scope["mcThumbContainer"].getNextHighestDepth(), { _x:dist, id:id });
		
		// see if it's the currThumb
		checkSelected(_scope["mcThumbContainer"]["mcThumb"+id], id);
		
	}
	
	
	private function removeThumb():Void {
		
		enableButtons();
		
		if(DIR == "right") {
			var oldEnd:Object = _thumbArray.pop();
			
		} else {
			var oldEnd:Object = _thumbArray.shift();
		}
		
		_scope["mcThumbContainer"]["mcThumb"+oldEnd].removeMovieClip();
	}
	
	
	private function checkSelected(mc, id):Void {
		if(_currThumb == id) {
			mc["selector"]._alpha = 100;
			// mc.enabled = false;
		};
	};
	
	
	private function setCurrThumb(o:Object) {
		
		hideScroller();
		
		// oh look, another hack
		TweenLite.to(this._parent._parent["headline"], SPEED, { _x:596, ease:EASE });
		
		if(_currThumb == o.data.id) { return; };
		
		_currThumb = o.data.id;
		
		// hack
		findThumbLocation();
	};
	
	
	/**
	 *   since I made this based on which arrow you click on
	 *   I added this function to fake that. it finds out
	 *   where the clicked thumb is in the array and sends out
	 *   the id of the arrow for that side so it will scroll
	 */
	private function findThumbLocation():Void {
		for(var i:Number = 0; i < _thumbArray.length; i++) {
			if(_thumbArray[i] == _currThumb) {
				if(i == 0) {
					scrollContainer({data:{id:0}});
				} else if(i == 1) {
					// _scope["mcThumbContainer"]["mcThumb1"].gotoAndPlay("firstFrame");
				} else if(i == 2) {
					scrollContainer({data:{id:1}});
				}
			}
		}
	}
	

	private function disableThumb(id:Number):Void {
		// _scope["mcThumbContainer"]["mcThumb"+id].enabled = false;
	}
	
	private function enabledThumb(id:Number):Void { _scope["mcThumbContainer"]["mcThumb"+id].enabled = true; };
	
	
	private function storeThumbs(o:Object):Void {
		
		// to keep track of selected thumb
		_currThumb = o.data.ct;
		
		// to keep track of visible thumbs
		_thumbArray = [o.data.pt, _currThumb, o.data.nt];
	
	}
	
	
	private function initButtons():Void {
		_scope.attachMovie("scrollerLeftButton", "mcLeft", 10, { _x:9, _y:11, id:0 });
		_scope.attachMovie("scrollerRightButton", "mcRight", 11, {_x:233, _y:11, id:1 });
	}
	
	
	private function hideScroller():Void { TweenLite.to(this, SPEED, { _x:Stage.width+5, ease:EASE }); };
	private function showScroller():Void { TweenLite.to(this, SPEED, { _x:269, ease:EASE }); };
}