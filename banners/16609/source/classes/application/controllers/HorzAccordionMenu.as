
// HorzAccordionMenu.as
//
// Created by Junie Threatt
// on 2008-06-04
//

import gs.TweenLite;
import gs.Expo;
import mx.utils.Delegate;
import application.events.EventManager;
import application.events.Events;

class application.controllers.HorzAccordionMenu extends MovieClip {
	
	// private properties
	private var _id:Number;
	private var _initialPos:Number;
	private var _collapseHeight:Number;
	private var _expandHeight:Number;
	
	// public properties
	
	// static properties
	private static var SPEED:Number;
	private static var PADDING:Number;
	
	public function HorzAccordionMenu() { init(); };
	
	private function init():Void {
		
		_initialPos = this._y;
		_collapseHeight = 20;
		_expandHeight = 50;
		SPEED = .5;
		PADDING = 1;
		
		setHandlers();
		
		EventManager.addEventListener(Events.ROLLOVER, this, "repositionMenu");
		EventManager.addEventListener(Events.ROLLOUT, this, "resetMenu");
		
		EventManager.addEventListener(Events.EXPAND, this, "expandTile");
		EventManager.addEventListener(Events.COLLAPSE, this, "collapseTile");
	};
	
	private function setHandlers():Void {
		
		this.onRollOver = function():Void {
			EventManager.dispatchEvent(Events.ROLLOVER, { id:_id, y:_y });
		};
		
		this.onRollOut = function():Void {
			EventManager.dispatchEvent(Events.ROLLOUT, { id:_id });
		};
	};
	
	private function repositionMenu(o:Object):Void {
		if(_id == o.data.id) {
			EventManager.dispatchEvent(Events.EXPAND, { id:_id });
		} else {
			EventManager.dispatchEvent(Events.COLLAPSE, { id:_id });
		};
		
		/*
		if(_id == o.data.id) {
			trace(o.data.id);
			TweenLite.to(this, SPEED, { _height:_expandHeight, _y:_initialPos, ease:Expo.easeOut });
		} else if (_id < o.data.id) {
			TweenLite.to(this, SPEED, { _height:_collapseHeight, _y:_initialPos, ease:Expo.easeOut });
		} else {
			 TweenLite.to(this, SPEED, { _height:_collapseHeight, _y:this._y + _expandHeight - _collapseHeight, ease:Expo.easeOut });
			// TweenLite.to(this, SPEED, { _height:_collapseHeight, _y:this._y + _expandHeight + (_collapseHeight) - _collapseHeight * 2, ease:Expo.easeOut });
		};
		//*/
	};
	
	private function resetMenu(o:Object):Void {
		TweenLite.to(this, SPEED, { _height:_collapseHeight, _y:_initialPos, ease:Expo.easeOut });
	};
	
	private function expandTile(o:Object):Void {
		if(_id == o.data.id) {
			TweenLite.to(this, SPEED, { _height:_expandHeight, _y:_initialPos, ease:Expo.easeOut });
		};
	};
	
	private function collapseTile(o:Object):Void {
		if (_id < o.data.id) {
			TweenLite.to(this, SPEED, { _height:_collapseHeight, _y:_initialPos, ease:Expo.easeOut });
		} else if(_id > o.data.id) {
			// trace(_id);
			 TweenLite.to(this, SPEED, { _height:_collapseHeight, _y:this._y + _expandHeight - _collapseHeight, ease:Expo.easeOut });
		};		
	};
	
	public function get id():Number {
		return _id;
	};
	
	public function set id(id:Number):Void {
		_id = id;
	};
}