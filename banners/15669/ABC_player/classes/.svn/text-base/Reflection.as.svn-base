//
//  Reflection.as
//
//  Created by Junie Threatt & Tim Harold on 2008-03-05.
//  Copyright (c) 2008 T3. All rights reserved.
//

import classes.utils.EventManager

class classes.Reflection extends MovieClip {

	// private properties
	private var _id:Number;
	private var _orig_y:Number;

	// public properties
	public var background_mc:MovieClip;
	public var hotspot_mc:MovieClip;
	public var content_mc:MovieClip;
	public var screen_mc:MovieClip;
	
	/**
	 *  Reflection Constructor
	 */
	function Reflection() { init(); };
	
	private function init():Void {
		
		EventManager.addEventListener("onNavItemSelected", this, "setSelection");
		EventManager.addEventListener("onNavItemRollOver", this, "setRollOver");
		EventManager.addEventListener("onNavItemRollOut", this, "setRollOut");
		
		_orig_y = content_mc._y;	// original _y value
	};
	
	private function setSelection(o:Object):Void {
		
		// Fades active reflection
		
		if(o.data.id == _id) {
			activateButton();
		} else {
			deactivateButton();
		}
	};
	
	private function setRollOver(o:Object):Void {
		
		// Move the content for the corresponding id
		
		if(o.data.id == _id) {
			moveContentUp();
		}
	};
	
	private function setRollOut(o:Object):Void {
		
		// Move the content for the corresponding id
		
		if(o.data.id == _id) {
			moveContentDown();
		}
	};
	
	private function moveContentUp():Void {
		
		// For rollover and activation
		
	       	TweenLite.to(content_mc, .5, { _y:_orig_y-10 });
	       	TweenLite.to(content_mc.screen_mc, .5, { _alpha:100 });
	       	TweenLite.to(background_mc, .5, { _yscale:115 });
	};
	
	private function moveContentDown():Void {
		
		// For rollout and deactivation
		
		TweenLite.to(content_mc, .5, { _y:_orig_y });
		TweenLite.to(content_mc.screen_mc, .5, { _alpha:0 });
		TweenLite.to(background_mc, .5, { _yscale:100 });
	};
	
	private function activateButton():Void {
		
		// Nav item has been clicked
		
		moveContentUp();
		TweenLite.to(this, .5, { _alpha:25, overwrite:false });
		TweenLite.to(content_mc.screen_mc, .5, { _alpha:100, overwrite:false});
		hotspot_mc.enabled = false;
	};
	
	private function deactivateButton():Void {
		
		// A different nav item has been clicked
		
		moveContentDown();
		TweenLite.to(this, .5, { _alpha:50, overwrite:false });
		TweenLite.to(content_mc.screen_mc, .5, { _alpha:0, overwrite:false });
		hotspot_mc.enabled = true;
	};

	/**
	 *  Getter/setter methods - much slower than accessor methods... but who really cares, right?
	 */
	public function get id():Number {
		return _id;
	};
	
	public function set id(id:Number):Void {
		_id = id;
	};
};