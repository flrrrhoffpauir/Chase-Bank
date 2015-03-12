//
//  NavButton.as
//
//  Created by Junie Threatt & Tim Harold on 2008-03-05.
//  Copyright (c) 2008 T3. All rights reserved.
//

import classes.utils.EventManager

class classes.NavButton extends MovieClip {

	// private properties
	private var _id:Number;
	private var _speed:Number;
	private var _orig_y:Number;
	private var _scope:Object;
	
	// public properties
	public var background_mc:MovieClip;
	public var hotspot_mc:MovieClip;
	public var content_mc:MovieClip;
	public var screen_mc:MovieClip;

	/**
	 *  NavButton Constructor
	 */
	function NavButton() { init(); };
	
	private function init():Void {
		EventManager.addEventListener("onNavItemSelected", this, "setSelection");
		
		_speed 	= .8;
		_orig_y = content_mc._y;
		_scope 	= this;
		
		setHandlers();
	};
	
	private function setSelection(o:Object):Void {
		
		// Fades and disables active button
		// Enables inactive buttons
		
		if(o.data.id == _id) {
			activateButton();
		} else {
			deactivateButton();
		}
	};
	
	private function setHandlers():Void {
		
		// Actions controlled by the hotspot
		
		hotspot_mc.onRollOver = function():Void {
			
			_parent.moveContentUp();
			EventManager.dispatchEvent("onNavItemRollOver", { id:_parent.id });
		};
		
		hotspot_mc.onRollOut = function():Void {
			
			_parent.moveContentDown();
			EventManager.dispatchEvent("onNavItemRollOut", { id:_parent.id });
		};
		
		hotspot_mc.onRelease = function():Void {
			EventManager.dispatchEvent("onNavItemSelected", { id:_parent.id });
		};
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
		TweenLite.to(content_mc, .5, { _alpha:50, overwrite:false });
		TweenLite.to(background_mc, .5, { _alpha:50, overwrite:false });
		TweenLite.to(content_mc.screen_mc, .5, { _alpha:100, overwrite:false });
		hotspot_mc.enabled = false;
	};
	
	private function deactivateButton():Void {
		
		// A different nav item has been clicked
		
		moveContentDown();
		TweenLite.to(content_mc, .5, { _alpha:100, overwrite:false });
		TweenLite.to(background_mc, .5, { _alpha:100, overwrite:false });
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