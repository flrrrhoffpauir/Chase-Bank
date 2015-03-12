
// PageCounter.as
// Created by Junie Threatt
// on 2008-08-26

import classes.utils.EventManager;

class classes.views.PageCounter extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	
	// constructor
	public function PageCounter() { _scope = this; EventManager.addEventListener("onSectionChange", this, "changeCount"); };
	
	private function changeCount(o:Object) { _scope.gotoAndStop("f" + o.data.id.toString()); };
}