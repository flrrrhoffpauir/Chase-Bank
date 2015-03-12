/*
VERSION: 1.6
DATE: 9/12/2007
ACTIONSCRIPT VERSION: 2.0
AS3 VERSION AVAILABLE AT: http://blog.greensock.com/transformmanageras3/
DESCRIPTION:
	Same as TransformItem but instead of working for MovieClips, this works for TextFields. The big benefit is that it doesn't distort
	the text - instead, it simply transforms the TextField that contains the text. Note that due to the way TextFields work, you cannot
	click and drag a TextField to move it. You must select it first, then grab the edges (or just outside the edges) to move it. 
	
	IMPORTANT: If you set the allowDelete property to true, when the user hits the delete key, the entire TextField will be deleted! This may not
			   be desirable because they may just be trying to delete something they typed. To get around this, make sure the allowDelete property
			   is false and if you need to sense when the user hits the delete key, just listen for the "deleteKeyDown" event.
	
NOTES:
	- Requires Flash 6 or later
	- In order for TextFields to be rotated, you MUST use embedded fonts!!! (otherwise the TextField will simply disappear)
	- Requires gs.TransformManager and gs.TransformItem and gs.utils.EventDispatcherAS2 classes

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2007, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

import gs.TransformManager;
import gs.TransformItem;
import mx.utils.Delegate;
import gs.utils.EventDispatcherAS2;

class gs.TransformItemTF extends gs.TransformItem {
	private var _mimic:MovieClip; //We create this MovieClip and set its _visible property to false and make it always follow the TextField so that we can use the localToGlobal() and globalToLocal() functions (not available to TextFields)
	private var _focusListener:Object;
	private static var _dummyTF:TextField;
	
	function TransformItemTF(tf:Object, vars:Object, manager:TransformManager) {
		super(tf, vars, manager);
		var l = findNextHighestDepth(tf._parent);
		if (_dummyTF == undefined) {
			_targetObject._parent.createTextField("dummyTransformItemTF"+l, l, 10000, 0, 100, 15); //We had to use this in order to fix focus issues (onKillFocus wouldn't permanently kill the focus!)
			_dummyTF = _targetObject._parent["dummyTransformItemTF"+l];
			TextField.prototype.swapDepths = MovieClip.prototype.swapDepths; //By default, you cannot change the depths of TextFields! This is the only workaround in AS2
			TextField.prototype.getBounds = MovieClip.prototype.getBounds;
			TextField.prototype.localToGlobal = MovieClip.prototype.localToGlobal;
			TextField.prototype.globalToLocal = MovieClip.prototype.globalToLocal;
			l++;
		}
		_oldOnPress = tf.onSetFocus;
		_oldOnRelease = tf.onKillFocus;
		_mimic = tf._parent.createEmptyMovieClip("TransformItemTFMimic"+l, l);
		box(_mimic, 0, 0, _baseWidth, _baseHeight, 0xFFFFFF);
		_mimic._visible = false;
		resetStartProps();
		_focusListener = {onSetFocus:Delegate.create(this, onSetFocus)};
		_enabled = !_enabled;
		this.enabled = !_enabled;
	}
	
	function resetStartProps():Void {
		super.resetStartProps();
		var r = _targetObject._rotation;
		_targetObject._rotation = 0;
		_startProps._width = _targetObject._width;
		_startProps._height = _targetObject._height;
		_targetObject._rotation = r;
	}	
	
	private function resetCenterPoint():Void {
		var r = _targetObject._rotation;
		_targetObject._rotation = 0;
		var w = _targetObject._width;
		var h = _targetObject._height;
		_targetObject._rotation = r;
		_localCenterX = w / 2;
		_localCenterY = h / 2;
	}
	
	public function update():Void {
		super.update();
		updateMimic(true);
	}
	
	private function updateMimic(full:Boolean):Void {
		_mimic._x = _targetObject._x;
		_mimic._y = _targetObject._y;
		_mimic._rotation = _targetObject._rotation;
		if (full) {
			var r = _targetObject._rotation;
			_targetObject._rotation = 0;
			_mimic._xscale = _targetObject._width / _baseWidth * 100;
			_mimic._yscale = _targetObject._height / _baseHeight * 100;
			_targetObject._rotation = r;
		}
	}
	
	private function setAxis(x:Number, y:Number):Void { //x and y according the the _targetObject._parent's coordinate space!
		var p = {x:x, y:y}; //Make a point so that we can do localToGlobal()
		updateMimic(false);
		_mimic._parent.localToGlobal(p); //Translates the coordinates to global ones (based on _root)
		_mimic.globalToLocal(p); //Translates the coordinates to local ones (based on _targetObject)
		_localAxisX = p.x;
		_localAxisY = p.y;
	}
	
	function select():Void {
		if (!_selected) {
			showHandles();
			resetStartProps();
			_selected = true;
			onKeyDown = Delegate.create(this, onKeyDownCheck);
			onKeyUp = Delegate.create(this, onKeyUpCheck);
			if (forceSelectionToFront) {
				bringToFront();
			}
			dispatchEvent("select", {target:this, type:"select", action:"select", transformed:false, targetObject:_targetObject, manager:_manager, item:this}); 
			_manager.onSelectTransformItem(this);
		}
	}
	
	function deselect(skipEvent:Boolean):Void {
		if (_selected) {
			_selection_mc._visible = false;
			_selected = false;
			Selection.setFocus(_dummyTF);
			onKeyDown = undefined;
			onKeyUp = undefined;
			_manager.onDeselect(this);
			if (skipEvent != true) {
				dispatchEvent("deselect", {target:this, type:"deselect", action:"deselect", transformed:false, targetObject:_targetObject, manager:_manager, item:this});
			}
		}
	}
	
	function checkForDeselect():Void {
		if (_selected) {
			if (Selection.getFocus() == _targetObject || _selection_mc.hitTest(_root._xmouse, _root._ymouse, true)) {
				return;
			} else if (autoDeselect) {
				deselect();
			} else if (_manager.selectedItem != undefined || _manager == undefined) {
				dispatchEvent("clickOff", {target:this, type:"clickOff", action:"clickOff", transformed:false, targetObject:_targetObject, manager:_manager, item:this}); 
			}
		}
	}
	
	function onSetFocus(old_obj, new_obj):Void {
		if (new_obj == _targetObject) {
			select();
		} else if (old_obj == _targetObject) {
			checkForDeselect();
		}
	}
	
	function deleteItem():Void {
		_targetObject.swapDepths(findNextHighestDepth(_targetObject._parent)); //Otherwise we can't delete MovieClips that were created/placed in the IDE (authoring environment) because they're on negative depths.
		_targetObject.removeTextField();
		_scaleCursor._visible = _rotationCursor._visible = false;
		Mouse.show();
		if (_manager == undefined) {
			destroy();
		} else {
			_manager.removeItem(this);
		}
		dispatchEvent("delete", {target:this, type:"delete", action:"delete", transformed:false, targetObject:_targetObject, manager:_manager, item:this}); 
	}
	
	
//---- MOVE -------------------------------------------------------------------------

	function onPressMove():Void {
		if (!lockPosition) {
			resetStartProps();
			_selection_mc.onMouseMove = Delegate.create(this, onMouseMoveMove);
			onMouseMoveMove();
		}
	}
	
	function onMouseMoveMove():Void {
		var sp = _startProps;
		var xChange = _targetObject._parent._xmouse - sp._xmouse;
		var yChange = _targetObject._parent._ymouse - sp._ymouse;
		if (!Key.isDown(Key.SHIFT)) {
			_targetObject._x = sp._x + xChange;
			_targetObject._y = sp._y + yChange;
		} else if (Math.abs(xChange) > Math.abs(yChange)) {
			_targetObject._x = sp._x + xChange;
			_targetObject._y = sp._y;
		} else {
			_targetObject._y = sp._y + yChange;
			_targetObject._x = sp._x;
		}
		if (_bounds.xMax != undefined) { //If we must constrain dragging to a particular area.
			_targetObject._x = Math.max(sp.xMin, Math.min(_targetObject._x, sp.xMax));
			_targetObject._y = Math.max(sp.yMin, Math.min(_targetObject._y, sp.yMax));
		}
		_selection_mc._x = _targetObject._x - sp.distRegToCenterX;
		_selection_mc._y = _targetObject._y - sp.distRegToCenterY;
		updateAfterEvent();
	}
	
	function onReleaseMove():Void {
		if (!lockPosition) {
			_selection_mc.onMouseMove = undefined;
			if (_startProps._x != _targetObject._x || _startProps._y != _targetObject._y) {
				resetStartProps(); //Otherwise the centerX isn't set properly which makes the scale rollover point in the wrong direction.
				dispatchEvent("move", {target:this, type:"move", action:"move", transformed:true, targetObject:_targetObject, manager:_manager, item:this}); 
			}
		}
		if (_oldOnRelease != undefined) {
			_oldOnRelease();
		}
	}
	
//---- SCALE ------------------------------------------------------------------------
	
	private function setScaleAxis():Void {
		if (scaleFromCenter) {
			setAxis(this.centerX, this.centerY);
		} else {
			for (var i = 0; i < 4; i++) {
				var hmc = _handles_array[i].mc;
				if (hmc.hitTest(_root._xmouse, _root._ymouse, true)) {
					var oppositeIndex = (i + 2) % 4;
					hmc = _handles_array[oppositeIndex].mc;
					var p = {x:hmc._x, y:hmc._y};
					hmc._parent.localToGlobal(p);
					updateMimic(false);
					_mimic._parent.globalToLocal(p);
					setAxis(p.x, p.y);
					break;
				}
			}
		}
	}
	
	function onMouseMoveScale():Void {
		var sp = _startProps;
		var dx = _targetObject._parent._xmouse - sp.axisX; //Distance from mouse to axis (x)
		var dy = sp.axisY - _targetObject._parent._ymouse; //Distance from mouse to axis (y)
		var d = Math.sqrt(dx * dx + dy * dy); //Distance from mouse to axis (total).
		if (Key.isDown(Key.SHIFT) || constrainScale) {
			_targetObject._width = (sp._width / sp.distAxisToMouse) * d;
			_targetObject._height = (sp._height / sp.distAxisToMouse) * d;
		} else {
			var angle = Math.atan2(dy, dx) + sp.angle; //Total angle which combines the current angle from the center to the mouse plus the angle of the _targetObject.
			_targetObject._width = Math.max(2, (sp._width / sp.distAxisToMouseX) * Math.cos(angle) * d);
			_targetObject._height = Math.max(2, (sp._height / sp.distAxisToMouseY) * Math.sin(angle) * d);
			resetHandleAngles();
		}
		updateMimic(true);
		var p2 = {x:_localAxisX, y:_localAxisY};
		_mimic.localToGlobal(p2);
		_mimic._parent.globalToLocal(p2);
		_targetObject._x -= p2.x - sp.axisX;
		_targetObject._y -= p2.y - sp.axisY;
		if (_bounds.xMax != undefined) { //If we must constrain scaling to a particular area.
			var bnds = _targetObject.getBounds(_targetObject._parent);
			if (bnds.xMax > _bounds.xMax || bnds.xMin < _bounds.xMin || bnds.yMax > _bounds.yMax || bnds.yMin < _bounds.yMin) {
				updateMimic(true);
				renderHandles();
				var angleAxisToH:Number;
				var newLength:Number; //Maximum extended length of diagonal to edge (there must be at least one that's shorter than the oldLength since the bounds have been violated.)
				var oldLength:Number; //The currently rendered length of the diagonal to the handle (not extended to the edge)
				var minScaleFactor:Number = 1; //It should always be decreasing the scale, so it should never go over 1.
				var axis = this.axisPoint;
				var roundedAxis = {x:Math.round(axis.x), y:Math.round(axis.y)};
				var h:Object; //Handle
				var hp:Object; //Handle coordinates point (x, y)
				for (var i = 0; i < _handles_array.length; i++) { //Loop through all 4 corner handles, see their maximum extent (if we drew a line from the axis through the handle until it hit the boundry) and compare it to the lenght of the current diagonal. Since the boundries are being violated, there must be at least one that's longer than it should be, so we'll find that, determine the scaling factor to get it back to where it hits the boundry, and apply that scale.
					h = _handles_array[i];
					hp = {x:h.mc._x, y:h.mc._y};
					h.mc._parent.localToGlobal(hp);
					_targetObject._parent.globalToLocal(hp);
					hp.x = Math.round(hp.x);
					hp.y = Math.round(hp.y);
					if (!(Math.abs(hp.x - axis.x) < 1 && Math.abs(hp.y - axis.y) < 1)) { //If the axis is on top of the handle (same coordinates), no need to factor it in.
						angleAxisToH = (Math.atan2(hp.y - roundedAxis.y, hp.x - roundedAxis.x) + (Math.PI * 4)) % (Math.PI * 2); //positive angle (in radians) from axis to handle
						dx = axis.x - hp.x;
						dy = axis.y - hp.y;
						oldLength = Math.sqrt(dx * dx + dy * dy);
						if (angleAxisToH <= sp.angleAxisToBR || (sp.angleAxisToTR >= Math.PI * 1.5 && angleAxisToH >= sp.angleAxisToTR)) { //Extends RIGHT
							dx = _bounds.xMax - axis.x;
							newLength = dx / Math.cos(angleAxisToH);
						} else if (angleAxisToH <= sp.angleAxisToBL) { //Extends DOWN
							dy = _bounds.yMax - axis.y;
							newLength = dy / Math.sin(angleAxisToH);
						} else if (angleAxisToH <= sp.angleAxisToTL) { //Extends LEFT
							dx = axis.x - _bounds.xMin;
							newLength = dx / Math.cos(angleAxisToH);
						} else { //Extends UP
							dy = axis.y - _bounds.yMin;
							newLength = dy / Math.sin(angleAxisToH);
						}
						if (newLength != 0) {
							minScaleFactor = Math.min(minScaleFactor, Math.abs(newLength) / oldLength);
						}
					}
				}
				_targetObject._width = (_mimic._xscale * minScaleFactor / 100) * _baseWidth;
				_targetObject._height = (_mimic._yscale * minScaleFactor / 100) * _baseHeight;
				updateMimic(true);
				p2 = {x:_localAxisX, y:_localAxisY};
				_mimic.localToGlobal(p2);
				_mimic._parent.globalToLocal(p2);
				_targetObject._x -= p2.x - sp.axisX;
				_targetObject._y -= p2.y - sp.axisY;
			}
		}		
		renderHandles();
		updateAfterEvent();
	}


//---- ROTATION -----------------------------------------------------------------------

	
	
	
//---- GENERAL ------------------------------------------------------------------------
	
	private function resetHandleAngles():Void {
		var r = _targetObject._rotation;
		_targetObject._rotation = 0;
		var x = _targetObject._width / 2; //Half of the width
		var y = _targetObject._height / 2; //Half of the height
		_targetObject._rotation = r;
		var a = Math.atan2(y, x); //Base angle offset
		_handles_array[0].angleOffset = Math.PI + a; //Top left
		_handles_array[1].angleOffset = 0 - a; //Top right
		_handles_array[2].angleOffset = a; //Bottom right
		_handles_array[3].angleOffset = Math.PI - a; //Bottom left
	}
	
	private function getDistanceToHandles():Number {
		var r = _targetObject._rotation;
		_targetObject._rotation = 0;
		var w = _targetObject._width / 2; //Half of the width
		var h = _targetObject._height / 2; //Half of the height
		_targetObject._rotation = r;
		return Math.sqrt((w * w) + (h * h));
	}
	
	static function getItemFromTargetObject(tgo:TextField):TransformItemTF {
		for (var i = 0; i < _items_array.length; i++) {
			if (_items_array[i].targetObject == tgo) {
				return _items_array[i];
			}
		}
	}
	
	
	static function selectTargetObject(tgo:TextField):TransformItemTF {
		var ti = getItemFromTargetObject(tgo);
		if (ti == undefined) {
			ti = new TransformItemTF(tgo); //If it wasn't found, then make it a TransformItem!
		}
		ti.select();
		return ti;
	}
	
	
//---- GETTERS / SETTERS ------------------------------------------------------------------
	
	function get targetObject():Object {
		return _targetObject;
	}
	function get enabled():Boolean {
		return _enabled;
	}
	function set enabled(b:Boolean) {
		if (_enabled != b) {
			_enabled = b;
			if (b) {
				Selection.addListener(_focusListener);
			} else {
				if (_selected) {
					deselect();
				}
				Selection.removeListener(_focusListener);
			}
		}
	}
	function get width():Number {
		var r = _targetObject._rotation;
		_targetObject._rotation = 0;
		var w = _targetObject._width;
		_targetObject._rotation = r;
		return w;
	}
	function get height():Number {
		var r = _targetObject._rotation;
		_targetObject._rotation = 0;
		var h = _targetObject._height;
		_targetObject._rotation = r;
		return h;
	}
	function get centerPoint():Object {
		updateMimic(false);
		var p = {x:_localCenterX, y:_localCenterY};
		_mimic.localToGlobal(p);
		_mimic._parent.globalToLocal(p);
		return p;
	}
	function get axisPoint():Object {
		updateMimic(false);
		var p = {x:_localAxisX, y:_localAxisY};
		_mimic.localToGlobal(p);
		_mimic._parent.globalToLocal(p);
		return p;
	}
	
}