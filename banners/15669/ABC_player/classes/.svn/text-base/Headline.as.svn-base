//
//  Headline.as
//
//  Created by Junie Threatt on 2008-03-05.
//  Copyright (c) 2008 T3. All rights reserved.
//

import classes.utils.EventManager

class classes.Headline extends MovieClip {
	
	// private properties
	private var _id:Number;
	
	/**
	 *  CTA Constructor
	 */
	public function Headline() { init(); };
	
	private function init():Void {
		
		EventManager.addEventListener("onNavItemSelected", this, "setSelection");
	};
	
	private function setSelection(o:Object):Void {
		
		// Swaps depths so the correct headline appears
		// Fades the others out
		
		if(o.data.id == _id) {
			this.swapDepths(this._parent.getNextHighestDepth());
			TweenLite.to(this, 2, { _alpha:100 });
		} else {
			TweenLite.to(this, 2, { _alpha:0 });
		}
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