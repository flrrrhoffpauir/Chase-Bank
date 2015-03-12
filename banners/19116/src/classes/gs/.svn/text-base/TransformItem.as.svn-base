/*
VERSION: 5.72
DATE: 4/19/2008
ACTIONSCRIPT VERSION: 2.0
UPDATES AVAILABLE AT: http://blog.greensock.com/transformmanageras2/
AS3 VERSION AVAILABLE AT: http://blog.greensock.com/transformmanageras3/
DESCRIPTION:
	This class gives the user the ability to scale, rotate, and/or move any MovieClip on the stage using an intuitive
	interface (similar to most modern drawing applications). When the user clicks on the TransformItem's MovieClip, a 
	selection box will be drawn around it along with four handles for scaling. When the user places their mouse just 
	outside of any of the scaling handles, the cursor will change to indicate that they're in rotation mode. Hold down shift to
	constrain scaling proportions or to limit rotation to 45 degree increments. To manage multiple TransformItem instances,
	use the TransformManager class which will handle switching the selection boxes (so that only one is selected at a time), 
	as well as updating the properties with a single call. 
	
	There is also an AS3 version available which was completely rebuilt from the ground up to include extra features like
	multiple selections, 4 extra handles, depth management, and an API that makes it very easy to drive transformations
	directly via code (like scaleSelection(1.5, 1.2), rotateSelection(2.7), moveSelection(30, 80), etc.). Find out more
	at http://blog.greensock.com/transformmanageras3/
	
	The second parameter in the constructor accepts an object with any number of properties. This makes it easier to
	set only the properties that shouldn't use their default values (you'll probably find that most of the time the default
	values work well for you). It also makes the code easier to read. The properties can be in any order, like so:
	
		var transformItem = new TransformItem(my_mc, {forceSelectionToFront:true, bounds:{xMin:0, xMax:550, yMin:0, yMax:450}, allowDelete:true, scaleFromCenter:true});
	
PRIMARY FEATURES:
	- Scale, rotate, or move any MovieClip
	- The cursor will automatically change to indicate scaling or rotation mode (roll your mouse close to the handles to see)
	- You do NOT need to make sure that each MovieClip's registration point is centered! 
	- You can lock the scale, rotation, or position of any MovieClip
	- Constrain items to coordinates you define (using the "bounds" property - an object with xMax, xMin, yMax, and yMin properties)
	- Force the selection to come to the front (in the stacking order) by setting the forceSelectionToFront property to true
	- Constrain scaling to be proportional by either holding down the shift key when scaling or set the constrainScale
	  property
	- Constrain rotation to go in increments of 45 degrees by holding down the shift key when rotating.
	- As of version 5.0, it uses the same method of event handling as the new AS3 model (addEventListener("select", myFunction), etc.).
	- You can allow the class to delete MovieClips when the user hits the delete key and a TransformItem is selected by
	  setting the allowDelete argument to true.
	- You can control the size and color of the handles and selection box and even the padding area that triggers
	  the rotation tool. Simply change the lineColor, handleSize, handleFillColor, or paddingForRotation properties.
	- You can enable or disable the entire TransformManager or an individual TransformItem by setting the "enabled" 
	  property to true or false.
	- Manually select a MovieClip using the static TransformItem.selectTargetObject(myClip_mc) method.
	- You can deselect everything by calling the static TransformItem.deselectAll() method.

EXAMPLE: 
	To make a MovieClip instance named "myClip_mc" transformable (with default settings):
	
		import gs.TransformItem;
		var transformItem = new TransformItem(myClip_mc);
		
	To make a MovieClip transformable, constrain its scaling to be proportional (even if the user is not holding
	down the shift key), call a function on every event (when the MovieClip has been selected, scaled, moved,
	rotated, deselected, deleted, etc.), lock the rotation value of the MovieClip (preventing rotation), and allow 
	the delete key to actually delete the selected MovieClip, do:
	
		import gs.TransformItem;
		var transformItem = new TransformItem(myClip_mc, {eventHandler:onAnyEvent, constrainScale:true, lockRotation:true, allowDelete:true});
		function onAnyEvent(event_obj:Object):Void {
			trace("Action: "+event_obj.action+", MovieClip or TextField: "+event_obj.targetObject+", transformed?: "+event_obj.transformed);
		}
		
KEY PROPERTIES:
	- constrainScale : Boolean [default:false]
	- scaleFromCenter : oolean [default:false]
	- lockScale : Boolean [default:false]
	- lockRotation : Boolean [default:false]
	- lockPosition : Boolean [default:false]
	- autoDeselect : Boolean [default:true]
	- allowDelete : Boolean [default:false]
	- eventHandler : Function 
	- lineColor : Number [default:0x3399FF]
	- handleSize : Number [default:8]
	- handleFillColor : Number [default:0xFFFFFF]
	- paddingForRotation : Number [default:10]
	- enabled : Boolean [default:true]
	- forceSelectionToFront : Boolean [default:false]
	- bounds : Object (an object with xMax, xMin, yMax, and yMin properties)
	- targetObject : Object (MovieClip that the TransformItem controls) (read-only)
	- selected : Boolean (read-only)
	- manager : TransformManager 
	- width : Number (the regular _width property of a MovieClip changes when you change the _rotation of the MovieClip, but this width property gives you an easy way to get the true width without considering the _rotation)
	- height : Number (the regular _height property of a MovieClip changes when you change the _rotation of the MovieClip, but this height property gives you an easy way to get the true height without considering the _rotation)
	- centerX : Number (read-only)
	- centerY : Number (read-only)
	- axisX : Number(read-only)
	- axisY : Number (read-only)
	
KEY METHODS:
	- select()
	- deselect()
	- deleteItem()
	- update()
	- bringToFront()
	- reset()
	- selectTargetObject(targetObject) (static)
	- deselectAll() (static)
	- destroy()
	
KEY EVENTS:
	- select
	- deselect
	- delete
	- clickOff (only called when the autoDeselect is false, otherwise the "deselect" event is called)
	- deleteKeyDown (only called when allowDelete is false, otherwise the "delete" event is called)
	- scale
	- rotate
	- move

EVENTS RETURN AN OBJECT WITH THE FOLLOWING PROPERTIES:
	- target : TransformItem 
	- targetObject : Object (MovieClip for TransformItems, TextField for TransformItemTFs) 
	- action : String (one of the following: "select", "deselect", "delete", "clickOff", "deleteKeyDown", "scale", "rotate", "move")
	- manager : TransformManager (if one exists that's associated with this TransformItem)
	- transformed : Boolean (if it was scaled, moved, or rotated, this is true. Otherwise it's false)
	- item : TransformItem 
	
NOTES:
	- Requires Flash 6 or later
	- Adds about 7kb to file size
	- Requires gs.TransformManager and gs.utils.EventDispatcherAS2 classes

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2007, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

import gs.TransformManager;
import mx.utils.Delegate;
import gs.utils.EventDispatcherAS2;

class gs.TransformItem {
	var onKeyUp:Function; 
	var onKeyDown:Function; 
	var constrainScale:Boolean; //If true, only proportional scaling is allowed (even if the SHIFT key isn't held down).
	var lockScale:Boolean;
	var scaleFromCenter:Boolean;
	var lockRotation:Boolean;
	var lockPosition:Boolean;
	var allowDelete:Boolean; //If true, we'll delete a TransformItem's MovieClip when it's selected and the user hits the delete key.
	var autoDeselect:Boolean; //If true (and it's true by default), TransformItems will be deselected when the user clicks off of them. Disabling this is sometimes necessary in cases where you want the user to be able to select a MovieClip and then select/edit separate form fields without deselecting the MovieClip. In that case, you'll need to handle things in a custom way through your eventHandler (look for action == "deselect" which will still get fired when the user clicks off of it)
	var forceSelectionToFront:Boolean; 
	var addEventListener:Function;
	var removeEventListener:Function;
	var dispatchEvent:Function;
	var listeners:Array;
	private var _eventHandler:Function; //Called every time a TransformItem is selected, moved, scaled, rotated, deselected, or when the delete key is pressed
	private var _targetObject:Object; //MovieClip (or TextField for TransformItemTF instances)
	private var _handleSize:Number; //Number of pixels the handles should be (square)
	private var _paddingForRotation:Number; //Number of pixels beyond the handles that should be sensitive for rotating.
	private var _handleFillColor:Number; //Handle fill color
	private var _lineColor:Number; //Line color (including handles and selection around MovieClip)
	private var _baseWidth:Number; //The width of the _targetObject when its _xscale and _yscale are 100% and it's NOT rotated.
	private var _baseHeight:Number; //The height of the _targetObject when its _xscale and _yscale are 100% and it's NOT rotated.
	private var _startProps:Object;
	private var _localAxisX:Number;
	private var _localAxisY:Number;
	private var _localCenterX:Number;
	private var _localCenterY:Number;
	private var _manager:Object; //Optional - an instance of the TransformManager class. I didn't type it as such so that you could use this TransformItem class on its own (otherwise the Compiler would throw an error when the TransformManager class file is missing)
	private var _enabled:Boolean; //If true, this item can be selected/deselected/transformed. 
	private var _selected:Boolean;
	private var _oldOnPress:Function; //Since we set a new onPress value to sense when the user clicks on this item, we need to remember what it was originally (if anything) so we can return it when this TransformItem is disabled (set enabled = false)
	private var _oldOnRelease:Function; 
	private var _oldOnReleaseOutside:Function; 
	private var _mode:Number; //1 = scale, 2 = rotation, 0 = everything else.
	private var _selection_mc:MovieClip;
	private var _handles_array:Array; //4-element array starting with the top left, going clockwise.
	private var _bounds:Object; //xMax, xMin, yMax, yMin defining an area that the _targetObject is restrained to (according to the _targetObject._parent coordinate system)
	private var _originalState:Object;
	private static var _rotationCursor:MovieClip; //The cursor we use when the user gets close to a rotation handle.
	private static var _scaleCursor:MovieClip; //The cursor we use when the user gets close to a scale handle.
	private static var _items_array:Array; //Holds references to all TransformItems
	
	function TransformItem(mc:Object, vars:Object, manager:TransformManager) {
		EventDispatcherAS2.initialize(this);
		_targetObject = mc;
		constrainScale = defaultBol(vars.constrainScale, false);
		lockScale = defaultBol(vars.lockScale, false);
		lockRotation = defaultBol(vars.lockRotation, false);
		lockPosition = defaultBol(vars.lockPosition, false);
		autoDeselect = defaultBol(vars.autoDeselect, true);
		constrainScale = defaultBol(vars.constrainScale, false);
		scaleFromCenter = defaultBol(vars.scaleFromCenter, false);
		lockScale = defaultBol(vars.lockScale, false);
		lockRotation = defaultBol(vars.lockRotation, false);
		lockPosition = defaultBol(vars.lockPosition, false);
		allowDelete = defaultBol(vars.allowDelete, false);
		forceSelectionToFront = vars.forceSelectionToFront;
		if (vars.bounds != undefined) {
			_bounds = vars.bounds;
		} else if (vars.xMax != undefined) {
			_bounds = {xMax:vars.xMax, xMin:vars.xMin, yMax:vars.yMax, yMin:vars.yMin};
		} else {
			_bounds = {};
		}
		eventHandler = vars.eventHandler;
		_oldOnPress = _targetObject.onPress;
		_oldOnRelease = _targetObject.onRelease;
		_oldOnReleaseOutside = _targetObject.onReleaseOutside;
		_targetObject.useHandCursor = false;
		buildRotationCursor();
		buildScaleCursor();
		_handles_array = [];
		_originalState = {};
		_mode = 0;
		_selected = false;
		resetCenterPoint();
		resetStartProps();
		resetBaseProps();
		setAxis(this.centerX, this.centerY);
		Key.addListener(this);
		if (manager != undefined) {
			_manager = manager;
			_lineColor = _manager.lineColor; 
			_handleFillColor = _manager.handleFillColor; 
			_handleSize = _manager.handleSize; 
			_paddingForRotation = _manager.paddingForRotation; 
			this.enabled = _manager.enabled;
		} else {
			_lineColor = vars.lineColor || 0x3399FF; //Line color (including handles and selection around MovieClip)
			_handleFillColor = vars.handleFillColor || 0xFFFFFF; //Handle fill color
			_handleSize = vars.handleSize || 8; //Number of pixels the handles should be (square)
			_paddingForRotation = vars.paddingForRotation || 10; //Number of pixels beyond the handles that should be sensitive for rotating.
			this.enabled = defaultBol(vars.enabled, true);
		}
		if (_items_array == undefined) {
			_items_array = [];
		}
		_items_array.push(this);
	}
	
	function resetBaseProps():Void {
		_originalState._rotation = _targetObject._rotation;
		_originalState._xscale = _targetObject._xscale;
		_originalState._yscale = _targetObject._yscale;
		_originalState._x = _targetObject._x;
		_originalState._y = _targetObject._y;
		//Temporarily straighten the MovieClip and make its scale 100% so we can accurately measure its _width and _height at that point. We'll set the values back when we're done measuring....
		_targetObject._rotation = 0; 
		_targetObject._xscale = 100;
		_targetObject._yscale = 100;
		_baseWidth = _targetObject._width;
		_baseHeight = _targetObject._height;
		_targetObject._rotation = _originalState._rotation;
		_targetObject._xscale = _originalState._xscale;
		_targetObject._yscale = _originalState._yscale;
	}
	
	function reset():Void {
		_targetObject._rotation = _originalState._rotation;
		_targetObject._xscale = _originalState._xscale;
		_targetObject._yscale = _originalState._yscale;
		_targetObject._x = _originalState._x;
		_targetObject._y = _originalState._y;
		update();
	}
	
	function resetStartProps():Void {
		delete _startProps; //Aids in memory management
		_startProps = {};
		var sp = _startProps;
		var axisPoint_obj = this.axisPoint;
		var mdx = _targetObject._parent._xmouse - axisPoint_obj.x; //Distance to mouse along the x-axis
		var mdy = axisPoint_obj.y - _targetObject._parent._ymouse; //Distance to mouse along the y-axis
		var md = Math.sqrt(mdx * mdx + mdy * mdy); //Total distance to mouse
		var angleAxisToMouse = Math.atan2(mdy, mdx);
		
		var rdx = _targetObject._x - axisPoint_obj.x; //Distance between axis point and registration along the x-axis
		var rdy = axisPoint_obj.y - _targetObject._y; //Distance between axis point and registration along the y-axis
		
		var angle = _targetObject._rotation * (Math.PI / 180); //rotation translated to radians
		var rAngleAxisToMouse = angleAxisToMouse + angle; //Rotated (corrected) angle to mouse (as though we tilted everything including the mouse position so that the _targetObject is at a 0 degree angle)
		
				sp.centerX = this.centerX;
				sp.centerY = this.centerY;
				sp.axisX = axisPoint_obj.x;
				sp.axisY = axisPoint_obj.y;
				sp._x = _targetObject._x;
				sp._y = _targetObject._y;
				sp._xscale = _targetObject._xscale; 
				sp._yscale = _targetObject._yscale; 
				sp._rotation = _targetObject._rotation; 
				sp.angle = angle;
				sp._xmouse = _targetObject._parent._xmouse;
				sp._ymouse = _targetObject._parent._ymouse;
				sp.angleAxisToMouse = (angleAxisToMouse + Math.PI * 2) % (Math.PI * 2);
				sp.distAxisToMouseX = Math.cos(rAngleAxisToMouse) * md;
				sp.distAxisToMouseY = Math.sin(rAngleAxisToMouse) * md;
				sp.distAxisToMouse = md;
				sp.distRegToCenterX = _targetObject._x - sp.centerX;
				sp.distRegToCenterY = _targetObject._y - sp.centerY;
				sp.distAxisToReg = Math.sqrt(rdx * rdx + rdy * rdy);
				sp.angleAxisToReg = Math.atan2(rdy, rdx);
				if (_bounds.xMax != undefined) { //If we need to constrain dragging to stay within a rectangle...
					var bnds = _targetObject.getBounds(_targetObject._parent);
					sp.xMin = _bounds.xMin + (_targetObject._x - bnds.xMin);
					sp.xMax = _bounds.xMax - (bnds.xMax - _targetObject._x);
					sp.yMin = _bounds.yMin + (_targetObject._y - bnds.yMin);
					sp.yMax = _bounds.yMax - (bnds.yMax - _targetObject._y);
					
					sp.angleAxisToTL = (Math.atan2(_bounds.yMin - axisPoint_obj.y, _bounds.xMin - axisPoint_obj.x) + (Math.PI * 4)) % (Math.PI * 2);
					sp.angleAxisToTR = (Math.atan2(_bounds.yMin - axisPoint_obj.y, _bounds.xMax - axisPoint_obj.x) + (Math.PI * 4)) % (Math.PI * 2);
					sp.angleAxisToBR = (Math.atan2(_bounds.yMax - axisPoint_obj.y, _bounds.xMax - axisPoint_obj.x) + (Math.PI * 4)) % (Math.PI * 2);
					sp.angleAxisToBL = (Math.atan2(_bounds.yMax - axisPoint_obj.y, _bounds.xMin - axisPoint_obj.x) + (Math.PI * 4)) % (Math.PI * 2);
				}
	}	
	
	private function resetCenterPoint():Void {
		var rotation_num = _targetObject._rotation;
		_targetObject._rotation = 0; //We need to straighten it temporarily to measure accurately...
		var bounds_obj = _targetObject.getBounds(_targetObject._parent);
		var x1 = (bounds_obj.xMax + bounds_obj.xMin) / 2; //Find the center x-coordinate when the rotation is 0
		var y1 = (bounds_obj.yMax + bounds_obj.yMin) / 2; //Find the center y-coordinate when the rotation is 0
		var dx = x1 - _targetObject._x; //distance between the _targetObject's registration point and center point along the x-axis
		var dy = _targetObject._y - y1; //distance between the _targetObject's registration point and center point along the y-axis
		var radius = Math.sqrt((dx * dx) + (dy * dy)); //Find the distance between the _targetObject's registration point and the center point.
		var angle1_num = Math.atan2(dy, dx);
		var angle = (rotation_num * (Math.PI / 180)) - angle1_num; //Total angle that we're adding/moving (we have to subtract the original angle to just get the difference)
		var x = _targetObject._x + (Math.cos(angle) * radius);
		var y = _targetObject._y + (Math.sin(angle) * radius);
		_targetObject._rotation = rotation_num; //Re-apply the rotation since we removed it temporarily.
		var p = {x:x, y:y};
		_targetObject._parent.localToGlobal(p);
		_targetObject.globalToLocal(p);
		_localCenterX = p.x;
		_localCenterY = p.y;
	}
	
	private function setAxis(x:Number, y:Number):Void { //x and y according the the _targetObject._parent's coordinate space!
		var p = {x:x, y:y}; //Make a point so that we can do localToGlobal()
		_targetObject._parent.localToGlobal(p); //Translates the coordinates to global ones (based on _root)
		_targetObject.globalToLocal(p); //Translates the coordinates to local ones (based on _targetObject)
		_localAxisX = p.x;
		_localAxisY = p.y;
	}
	
	private function renderHandles():Void {
		var radius = getDistanceToHandles();
		var angle = _targetObject._rotation * (Math.PI / 180);
		var s = _selection_mc;
		var c = this.centerPoint;
		s._x = c.x;
		s._y = c.y;
		s.center_mc.clear();
		s.center_mc.lineStyle(1, _lineColor);
		//First get the bottom left corner position so that we can do the moveTo() at the right spot. Then we'll loop through and do lineTo() for all of the handles.
		var x = Math.cos(_handles_array[3].angleOffset) * radius;
		var y = Math.sin(_handles_array[3].angleOffset) * radius;
		s.center_mc.moveTo(x, y);
		for (var i = 0; i < 4; i++) {
			var h = _handles_array[i];
			h.mc._x = Math.cos(h.angleOffset) * radius;
			h.mc._y = Math.sin(h.angleOffset) * radius;
			h.mc._rotation = Math.floor(h.angleOffset / (Math.PI / 2)) * 90; //If the _xscale or _yscale goes negative, we need to rotate the handles!
			s.center_mc.lineTo(h.mc._x, h.mc._y);
		}
		s.tl_mc.edge_mc._height = s.bl_mc._y - s.tl_mc._y;
		s.tr_mc.edge_mc._height = s.tr_mc._x - s.tl_mc._x;
		s.br_mc.edge_mc._height = s.br_mc._y - s.tr_mc._y;
		s.bl_mc.edge_mc._height = s.br_mc._x - s.bl_mc._x;
		s._rotation = _targetObject._rotation;
	}
	
	function onPressSelect():Void {
		if (_oldOnPress != undefined) {
			_oldOnPress();
		}
		select();
		onPressMove();
	}
	
	function update():Void {
		resetBaseProps();
		resetCenterPoint();
		resetStartProps();
		resetHandleAngles();
		renderHandles();
		if (_selected) {
			_selection_mc.swapDepths(findNextHighestDepth(_selection_mc._parent));
		}
	}
	
	function bringToFront():Void {
		_targetObject.swapDepths(findNextHighestDepth(_targetObject._parent));
		if (_selected) {
			_selection_mc.swapDepths(findNextHighestDepth(_selection_mc._parent));
		}
	}
	
	function select():Void {
		if (!_selected) {
			showHandles();
			onKeyDown = Delegate.create(this, onKeyDownCheck);
			onKeyUp = Delegate.create(this, onKeyUpCheck);
			if (_targetObject.hitTest(_root._xmouse, _root._ymouse, true)) { //If the user clicked on it, allow them to start moving it right away (instead of clicking again after selecting)
				// onPressMove();
			} else {
				resetStartProps();
			}
			_selected = true;
			if (forceSelectionToFront) {
				bringToFront();
			}
			dispatchEvent("select", {target:this, type:"select", action:"select", transformed:false, targetObject:_targetObject, manager:_manager, item:this}); 
			_manager.onSelectTransformItem(this);
		}
	}
	
	static function checkAllForDeselect():Void {
		var l = _items_array.length;
		for (var i = 0; i < l; i++) {
			_items_array[i].checkForDeselect();
		}
	}
	
	function checkForDeselect():Void {
		if (_selected) {
			if (_selection_mc.hitTest(_root._xmouse, _root._ymouse, true) || _targetObject.hitTest(_root._xmouse, _root._ymouse, true)) {
				return;
			} else if (autoDeselect) {
				deselect();
			} else if (_manager.selectedItem != undefined || _manager == undefined) {
				dispatchEvent("clickOff", {target:this, type:"clickOff", action:"clickOff", transformed:false, targetObject:_targetObject, manager:_manager, item:this}); 
			}
		}
	}
	
	function deselect(skipEvent:Boolean):Void {
		if (_selected) {
			_selection_mc._visible = false;
			_selected = false;
			onKeyDown = undefined;
			onKeyUp = undefined;
			_manager.onDeselect(this);
			if (skipEvent != true) {
				dispatchEvent("deselect", {target:this, type:"deselect", action:"deselect", transformed:false, targetObject:_targetObject, manager:_manager, item:this});
			}
		}
	}
	
	function onKeyUpCheck():Void {
		if (Key.getCode() == 16) {
			if (_mode == 1) { //We're in "scaling" mode.
				onMouseMoveScale();
				resetHandleAngles();
			} else if (_mode == 2) { //We're in "rotation" mode.
				onMouseMoveRotate();
			}
			this.onKeyDown = Delegate.create(this, onKeyDownCheck);
		}
	}
	
	function onKeyDownCheck():Void { //When the shift key is released, we need to force some function calls otherwise handles get stuck at the wrong proportions or the rotating item doesn't snap until the user starts moving their mouse.
		if (Key.getCode() == 16) {
			if (_mode == 1) { //We're in "scaling" mode.
				onMouseMoveScale();
				resetHandleAngles();
				renderHandles();
			} else if (_mode == 2) { //We're in "rotation" mode.
				onMouseMoveRotate();
			}
			this.onKeyDown = undefined; //Otherwise it'll keep calling this function over and over while the user is holding down the key!
		} else if (((Key.getCode() == 46) || (Key.getCode() == 8)) && _selected) { // OLD: ((Key.isDown(Key.DELETEKEY) || Key.isDown(Key.BACKSPACE)) && _selected) but changed because Key.isDown always return false in Firefox
			if (allowDelete) {
				deleteItem();
			} else {
				dispatchEvent("deleteKeyDown", {target:this, type:"deleteKeyDown", action:"deleteKeyDown", transformed:false, targetObject:_targetObject, manager:_manager, item:this}); 
			}
		}
	}
	
	function deleteItem():Void {
		_targetObject.swapDepths(findNextHighestDepth(_targetObject._parent)); //Otherwise we can't delete MovieClips that were created/placed in the IDE (authoring environment) because they're on negative depths.
		_targetObject.removeMovieClip();
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
	
	function onRollOverScale():Void {
		if (!lockScale) {
			Mouse.hide();
			_scaleCursor.onMouseMove = Delegate.create(this, snapCursorScale);
			var xm = _targetObject._parent._xmouse - this.centerX;
			var ym = this.centerY - _targetObject._parent._ymouse;
			var cursorAngle = 0 - (Math.atan2(ym, xm) - (Math.PI * 0.25));
			_scaleCursor._rotation = cursorAngle * (180 / Math.PI);
			_scaleCursor._visible = true;
			_scaleCursor.swapDepths(findNextHighestDepth(_root)); //Just make sure it's on top of everything.
			snapCursorScale();
		}
	}
	
	function onRollOutScale():Void {
		if (!lockScale) {
			_scaleCursor.onMouseMove = undefined;
			_scaleCursor._visible = false;
			Mouse.show();
		}
	}
	
	function onPressScale():Void {
		if (!lockScale) {
			_mode = 1;
			setScaleAxis();
			resetStartProps();
			_selection_mc.onMouseMove = Delegate.create(this, onMouseMoveScale);
			onMouseMoveScale();
		}
	}
	
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
					_targetObject._parent.globalToLocal(p);
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
		var angle = Math.atan2(dy, dx);
		if (Key.isDown(Key.SHIFT) || constrainScale) {
			var dif = (angle - sp.angleAxisToMouse + Math.PI * 3.5) % (Math.PI * 2);
			if (dif < Math.PI) {
				d *= -1; //Flip it when necessary to make the _xscale & _yscale negative.
			}
			_targetObject._xscale = (sp._xscale / sp.distAxisToMouse) * d;
			_targetObject._yscale = (sp._yscale / sp.distAxisToMouse) * d;
		} else {
			angle += sp.angle; //Total angle which combines the current angle from the center to the mouse plus the angle of the _targetObject.
			_targetObject._xscale = (sp._xscale / sp.distAxisToMouseX) * Math.cos(angle) * d; //FORCE POSITIVE (NO FLIPPING): Math.max(0, (sp._xscale / sp.distAxisToMouseX) * Math.cos(angle) * d);
			_targetObject._yscale = (sp._yscale / sp.distAxisToMouseY) * Math.sin(angle) * d; //FORCE POSITIVE (NO FLIPPING): Math.max(0, (sp._yscale / sp.distAxisToMouseY) * Math.sin(angle) * d);
			resetHandleAngles();
		}
		var p2 = {x:_localAxisX, y:_localAxisY};
		_targetObject.localToGlobal(p2);
		_targetObject._parent.globalToLocal(p2);
		_targetObject._x -= p2.x - sp.axisX;
		_targetObject._y -= p2.y - sp.axisY;
		if (_bounds.xMax != undefined) { //If we must constrain scaling to a particular area.
			var bnds = _targetObject.getBounds(_targetObject._parent);
			if (bnds.xMax > _bounds.xMax || bnds.xMin < _bounds.xMin || bnds.yMax > _bounds.yMax || bnds.yMin < _bounds.yMin) {
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
				_targetObject._xscale *= minScaleFactor;
				_targetObject._yscale *= minScaleFactor;
				p2 = {x:_localAxisX, y:_localAxisY};
				_targetObject.localToGlobal(p2);
				_targetObject._parent.globalToLocal(p2);
				_targetObject._x -= p2.x - sp.axisX;
				_targetObject._y -= p2.y - sp.axisY;
			}
		}
		renderHandles();
		updateAfterEvent();
	}
	
	function onReleaseScale():Void {
		if (!lockScale) {
			_mode = 0;
			_selection_mc.onMouseMove = undefined;
			resetStartProps();
			dispatchEvent("scale", {target:this, type:"scale", action:"scale", transformed:true, targetObject:_targetObject, manager:_manager, item:this});
		}
	}
	
	function onReleaseOutsideScale():Void {
		onRollOutScale();
		onReleaseScale();
	}
	
	function snapCursorScale():Void {
		_scaleCursor._x = _root._xmouse;
		_scaleCursor._y = _root._ymouse;
		updateAfterEvent();
	}
	

//---- ROTATION -----------------------------------------------------------------------

	function onRollOverRotate():Void {
		if (!lockRotation) {
			Mouse.hide();
			_rotationCursor.onMouseMove = Delegate.create(this, snapCursorRotate);
			_rotationCursor._visible = true;
			_rotationCursor.swapDepths(findNextHighestDepth(_root)); //Just make sure it's on top of everything.
			snapCursorRotate();
		}
	}
	
	function onRollOutRotate():Void {
		if (!lockRotation) {
			_rotationCursor.onMouseMove = undefined;
			_rotationCursor._visible = false;
			Mouse.show();
		}
	}
	
	function onPressRotate():Void {
		if (!lockRotation) {
			_mode = 2;
			setAxis(this.centerX, this.centerY);
			resetStartProps();
			_selection_mc.onMouseMove = Delegate.create(this, onMouseMoveRotate);
			onMouseMoveRotate();
		}
	}
	
	function onMouseMoveRotate():Void {
		var sp = _startProps;
		var old = {_x:_targetObject._x, _y:_targetObject._y, _rotation:_targetObject._rotation}; //In case we need to revert it (if there are bounds that get violated which we'll check for later)
		var dx = _targetObject._parent._xmouse - sp.centerX;
		var dy = sp.centerY - _targetObject._parent._ymouse;
		var angleDifference_num = sp.angleAxisToMouse - Math.atan2(dy, dx);
		var angle = sp.angle + angleDifference_num;
		_targetObject._rotation = angle * (180 / Math.PI);
		if (Key.isDown(Key.SHIFT)) {
			_targetObject._rotation = Math.round(_targetObject._rotation / 45) * 45;
			angleDifference_num = (_targetObject._rotation * (Math.PI / 180)) - sp.angle;
		}
		_targetObject._x = sp.centerX + (Math.cos(angleDifference_num - sp.angleAxisToReg) * sp.distAxisToReg);
		_targetObject._y = sp.centerY + (Math.sin(angleDifference_num - sp.angleAxisToReg) * sp.distAxisToReg);
		if (_bounds.xMax != undefined) { //If we must constrain scaling to a particular area.
			var bnds = _targetObject.getBounds(_targetObject._parent);
			if (bnds.xMax > _bounds.xMax || bnds.xMin < _bounds.xMin || bnds.yMax > _bounds.yMax || bnds.yMin < _bounds.yMin) {
				_targetObject._rotation = old._rotation;
				_targetObject._x = old._x;
				_targetObject._y = old._y;
			}
		}
		_selection_mc._rotation = _targetObject._rotation;
		updateAfterEvent();
	}
	
	function onReleaseRotate():Void {
		if (!lockRotation) {
			_mode = 0;
			_selection_mc.onMouseMove = undefined;
			resetStartProps();
			dispatchEvent("rotate", {target:this, type:"rotate", action:"rotate", transformed:true, targetObject:_targetObject, manager:_manager, item:this});
		}
	}
	
	function onReleaseOutsideRotate():Void {
		onRollOutRotate();
		onReleaseRotate();
	}
	
	function snapCursorRotate():Void {
		_rotationCursor._x = _root._xmouse;
		_rotationCursor._y = _root._ymouse;
		updateAfterEvent();
	}
	
	
	
//---- GENERAL ------------------------------------------------------------------------

	private function showHandles():Void {
		if (_selection_mc == undefined) {
			initHandles(_lineColor, _handleFillColor, _handleSize, _paddingForRotation);
		} else {
			_selection_mc.swapDepths(findNextHighestDepth(_selection_mc._parent));
			resetHandleAngles();
			renderHandles();
		}
		_targetObject.useHandCursor = false;
		_selection_mc._visible = true;
	}
	
	function initHandles():Void {
		var isVisible = false;
		if (_selection_mc != undefined) {
			isVisible = _selection_mc._visible;
			_selection_mc.removeMovieClip();
		}
		var l = findNextHighestDepth(_targetObject._parent);
		_selection_mc = _targetObject._parent.createEmptyMovieClip("selection"+l+"_mc", l);
		_selection_mc.createEmptyMovieClip("edges_mc", 0); //Holds the invisible edge handles for dragging.
		_selection_mc.createEmptyMovieClip("center_mc", 1); //Holds the center area that will be a hotspot (and the outline)
		var m_mc = _selection_mc.createEmptyMovieClip("m_mc", 2); //Center handle
		//box(m_mc, 0 - _handleSize / 2, 0 - _handleSize / 2, _handleSize, _handleSize, _handleFillColor, 100, 1, _lineColor, 100);
		prefabRotateHandle(m_mc);
		var tl = buildHandle(_selection_mc, "tl_mc", 180, 3); //Top left handle
		var tr = buildHandle(_selection_mc, "tr_mc", -90, 4); //Top right handle
		var br = buildHandle(_selection_mc, "br_mc", 0, 5); //Bottom right handle
		var bl = buildHandle(_selection_mc, "bl_mc", 90, 6); //Bottom left handle
		_handles_array = [{mc:tl, dir:"_y", prtnr:3},
						  {mc:tr, dir:"_x", prtnr:0},
						  {mc:br, dir:"_y", prtnr:1},
						  {mc:bl, dir:"_x", prtnr:2}];
		_selection_mc._visible = isVisible;
		resetHandleAngles();
		renderHandles();
	}
	
	private function buildHandle(parent_mc:MovieClip, name_str:String, rotation_num:Number, level_num:Number):MovieClip {
		var mc = parent_mc.createEmptyMovieClip(name_str, level_num);
		var e = mc.createEmptyMovieClip("edge_mc", 0);
		box(e, -7, -100, 14, 100, 0x000000, 0);
		var r = mc.createEmptyMovieClip("rotate_mc", 1);
		var rotateSize = _handleSize + _paddingForRotation;
		box(r, 0, 0, rotateSize, rotateSize, 0x000000, 0);
		var s = mc.createEmptyMovieClip("scale_mc", 2);
		// box(s, 0, 0, _handleSize, _handleSize, _handleFillColor, 100, 1, _lineColor, 100);
		prefabScaleHandle(s);
		mc._rotation = rotation_num;
		//Set up Mouse events...
		e.onPress = Delegate.create(this, onPressSelect);
		e.onRelease = e.onReleaseOutside = Delegate.create(this, onReleaseMove);
		r.onRollOver = Delegate.create(this, onRollOverRotate);
		r.onRollOut = Delegate.create(this, onRollOutRotate);
		r.onPress = Delegate.create(this, onPressRotate);
		r.onRelease = Delegate.create(this, onReleaseRotate);
		r.onReleaseOutside = Delegate.create(this, onReleaseOutsideRotate);
		s.onRollOver = Delegate.create(this, onRollOverScale);
		s.onRollOut = Delegate.create(this, onRollOutScale);
		s.onPress = Delegate.create(this, onPressScale);
		s.onRelease = Delegate.create(this, onReleaseScale);
		s.onReleaseOutside = Delegate.create(this, onReleaseOutsideScale);
		r.useHandCursor = s.useHandCursor = e.useHandCursor = false;
		return mc;
	}
	
	private function resetHandleAngles():Void {
		var x = (_baseWidth * (_targetObject._xscale / 100)) / 2; //Half of the width
		var y = (_baseHeight * (_targetObject._yscale / 100)) / 2; //Half of the height
		var a = Math.atan2(y, x); //Base angle offset
		_handles_array[0].angleOffset = Math.PI + a; //Top left
		_handles_array[1].angleOffset = 0 - a; //Top right
		_handles_array[2].angleOffset = a; //Bottom right
		_handles_array[3].angleOffset = Math.PI - a; //Bottom left
	}
	
	private function getDistanceToHandles():Number {
		var w = (_baseWidth * (_targetObject._xscale / 100)) / 2;
		var h = (_baseHeight * (_targetObject._yscale / 100)) / 2;
		return Math.sqrt((w * w) + (h * h));
	}
	
	private function deleteHandles():Void {
		for (var i = 0; i < _handles_array.length; i++) {
			_handles_array[i].mc.removeMovieClip();
			delete _handles_array[i];
		}
		_handles_array = [];
		_selection_mc.onMouseMove = undefined;
		_selection_mc.removeMovieClip();
	}
	
	private static function defaultBol(b:Boolean, default_bol:Boolean):Boolean { //Just an easy way for us to set default values for booleans. Reduces the amount of code.
		if (b == undefined) {
			return default_bol;
		} else {
			return b;
		}
	}
	
	function addAllEventsListener(handler:Function):Void {
		addEventListener("select", handler);
		addEventListener("deselect", handler);
		addEventListener("delete", handler);
		addEventListener("clickOff", handler);
		addEventListener("deleteKeyDown", handler);
		addEventListener("scale", handler);
		addEventListener("rotate", handler);
		addEventListener("move", handler);
	}
	
	function removeAllEventsListener(handler:Function):Void {
		removeEventListener("select", handler);
		removeEventListener("deselect", handler);
		removeEventListener("delete", handler);
		removeEventListener("clickOff", handler);
		removeEventListener("deleteKeyDown", handler);
		removeEventListener("scale", handler);
		removeEventListener("rotate", handler);
		removeEventListener("move", handler);
	}
	
	static function getItemFromTargetObject(tgo:Object):TransformItem {
		for (var i = 0; i < _items_array.length; i++) {
			if (_items_array[i].targetObject == tgo) {
				return _items_array[i];
			}
		}
	}
	
	private static function buildRotationCursor():Void {
		if (_root.rotationCursor_mc == undefined) {
			var radius = 6.5;
			_rotationCursor = _root.createEmptyMovieClip("rotationCursor_mc", findNextHighestDepth(_root));
			var r = _rotationCursor;
			r.lineStyle(4, 0x000000);
			//Draw outline...
			circle(r, 0, 0, radius);
			r.moveTo(0 - radius - 2.5, -3);
			r.lineTo(0 - radius, 0);
			r.lineTo(0 - radius + 4, -1.5);
			//Draw white circle...
			r.lineStyle(2, 0xFFFFFF);
			circle(r, 0, 0, radius);
			//Draw dark line just below arrow tip to help define it (must be over the light circle)
			r.lineStyle(2, 0x000000);
			r.moveTo(0 - radius - 1, 1);
			r.lineTo(0 - radius + 1, 1);
			//Draw the arrow tip.
			r.lineStyle(2, 0xFFFFFF);
			r.moveTo(0 - radius - 2.5, -3);
			r.lineTo(0 - radius, 0);
			r.lineTo(0 - radius + 4, -1.5);
			r.cacheAsBitmap = true;
			r._visible = false;
		} else {
			_rotationCursor = _root.rotationCursor_mc;
		}
		_rotationCursor.onMouseDown = checkAllForDeselect;
	}
	
	private static function buildScaleCursor():Void {
		if (_root.scaleCursor_mc == undefined) {
			var length_num = 10;
			_scaleCursor = _root.createEmptyMovieClip("scaleCursor_mc", findNextHighestDepth(_root));
			var s = _scaleCursor;
			s.lineStyle(4, 0x000000);
			//Draw outline...
			s.moveTo(0 - length_num / 2, length_num / 2);
			s.lineTo(length_num / 2, 0 - length_num / 2);
			s.moveTo(length_num / 2 - 3, 0 - length_num / 2);
			s.lineTo(length_num / 2, 0 - length_num / 2);
			s.lineTo(length_num / 2, 0 - length_num / 2 + 3);
			s.moveTo(0 - length_num / 2, length_num / 2 - 3);
			s.lineTo(0 - length_num / 2, length_num / 2);
			s.lineTo(0 - length_num / 2 + 3, length_num / 2);
			//draw white lines...
			s.lineStyle(2, 0xFFFFFF);
			s.moveTo(0 - length_num / 2, length_num / 2);
			s.lineTo(length_num / 2, 0 - length_num / 2);
			s.moveTo(length_num / 2 - 3, 0 - length_num / 2);
			s.lineTo(length_num / 2, 0 - length_num / 2);
			s.lineTo(length_num / 2, 0 - length_num / 2 + 3);
			s.moveTo(0 - length_num / 2, length_num / 2 - 3);
			s.lineTo(0 - length_num / 2, length_num / 2);
			s.lineTo(0 - length_num / 2 + 3, length_num / 2);
			s.cacheAsBitmap = true;
			s._visible = false;
		} else {
			_scaleCursor = _root.scaleCursor_mc;
		}
	}
	
	private static function box(mc:MovieClip, x:Number, y:Number, w:Number, h:Number, fc:Number, fa:Number, t:Number, lc:Number, la:Number):Void {
		if (lc != undefined) {
			mc.lineStyle(t, lc, la);
		}
		if (fc != undefined) {
			mc.beginFill(fc, fa);
		}
		mc.moveTo(x, y);
		mc.lineTo(x + w, y);
		mc.lineTo(x + w, y + h);
		mc.lineTo(x, y + h);
		mc.lineTo(x, y);
		if (fc != undefined) {
			mc.endFill();
		}
	}
	
	
	private static function prefabScaleHandle(mc:MovieClip):Void {
		mc.attachMovie("ScaleHandle", "scaleHandle", mc.getNextHighestDepth());
	};
	
	private static function prefabRotateHandle(mc:MovieClip):Void {
		mc.attachMovie("RotateHandle", "rotHandle", mc.getNextHighestDepth());
	};
	
	
	private static function circle (mc:MovieClip, x:Number, y:Number, r:Number, f:Number):Void {
		if (f != undefined) {
			mc.beginFill(f);
		}
		mc.moveTo (x+r, y);
		mc.curveTo (r+x, Math.tan(Math.PI/8)*r+y, Math.sin(Math.PI/4)*r+x, Math.sin(Math.PI/4)*r+y);
		mc.curveTo (Math.tan(Math.PI/8)*r+x, r+y, x, r+y);
		mc.curveTo (-Math.tan(Math.PI/8)*r+x, r+y, -Math.sin(Math.PI/4)*r+x, Math.sin(Math.PI/4)*r+y);
		mc.curveTo (-r+x, Math.tan(Math.PI/8)*r+y, -r+x, y);
		mc.curveTo (-r+x, -Math.tan(Math.PI/8)*r+y, -Math.sin(Math.PI/4)*r+x, -Math.sin(Math.PI/4)*r+y);
		mc.curveTo (-Math.tan(Math.PI/8)*r+x, -r+y, x, -r+y);
		mc.curveTo (Math.tan(Math.PI/8)*r+x, -r+y, Math.sin(Math.PI/4)*r+x, -Math.sin(Math.PI/4)*r+y);
		mc.curveTo (r+x, -Math.tan(Math.PI/8)*r+y, r+x, y);
		if (f != undefined) {
			mc.endFill();
		}
	}
	
	static function findNextHighestDepth(mc:Object):Number { //Helps us avoid problems when v2 components are used (which screw up the levels and prevented the _selection_mc from being removed properly). It also allows us to publish to Flash Player 6 (findNextHighestDepth() isn't available in v6)
		var maxDepth:Number = mc.getNextHighestDepth();
		if (maxDepth != undefined && maxDepth < 16000) {
			return maxDepth;
		} else {
			maxDepth = -1;
			var depth:Number;
			var obj:Object; 
			var tf = TextField.prototype;
			for (var p in mc) {
				obj = mc[p];
				if ((typeof(obj) == "movieclip" || obj.__proto__ == tf) && obj._parent == mc) {
					depth = obj.getDepth();
					if (depth > maxDepth && depth < 16000) { //When v2 Components are used, they use extremely high depths which we should ignore.
						maxDepth = depth;
					}
				}
			}
			return maxDepth + 1;
		}
	}
	
	static function selectTargetObject(tgo:Object):TransformItem {
		var ti = getItemFromTargetObject(tgo);
		if (ti == undefined) {
			ti = new TransformItem(tgo); //If it wasn't found, then make it a TransformItem!
		}
		ti.select();
		return ti;
	}
	
	static function deselectAll():Void {
		for (var i = 0; i < _items_array.length; i++) {
			_items_array[i].deselect();
		}
	}
	
	function destroy(calledFromManager_bol:Boolean):Void {
		if (calledFromManager_bol != true) {
			_manager.removeItem(this);
		}
		enabled = false;
		deselect(true);
		Key.removeListener(this);
		_selection_mc.removeMovieClip();
		destroyInstance(this);
	}
	
	static function destroyInstance(i:TransformItem):Void {
		delete i;
	}
	
	
//---- GETTERS / SETTERS ------------------------------------------------------------------
	
	function get selected():Boolean {
		return _selected;
	}
	function set selected(b:Boolean) {
		if (b != _selected) {
			if (b) {
				select();
			} else {
				deselect();
			}
		}
	}
	function get targetObject():Object {
		return _targetObject;
	}
	function get mc():Object {
		return this.targetObject;
	}
	function get manager():Object {
		return _manager;
	}
	function get enabled():Boolean {
		return _enabled;
	}
	function set enabled(b:Boolean) {
		if (_enabled != b) {
			_enabled = b;
			if (b) {
				_targetObject.onPress = Delegate.create(this, onPressSelect);
				_targetObject.onRelease = _targetObject.onReleaseOutside = Delegate.create(this, onReleaseMove);
			} else {
				if (_selected) {
					deselect();
				}
				if (_oldOnPress == undefined) {
					delete _targetObject.onPress;
				} else {
					_targetObject.onPress = _oldOnPress;
				}
				if (_oldOnReleaseOutside == undefined) {
					delete _targetObject.onReleaseOutside;
				} else {
					_targetObject.onReleaseOutside = _oldOnReleaseOutside;
				}
				if (_oldOnRelease == undefined) {
					delete _targetObject.onRelease;
				} else {
					_targetObject.onRelease = _oldOnRelease;
				}
			}
		}
	}
	function set lineColor(n:Number):Void {
		_lineColor = n;
		if (_selection_mc != undefined) {
			initHandles();
		}
	}
	function get lineColor():Number {
		return _lineColor;
	}
	function set handleFillColor(n:Number):Void {
		_handleFillColor = n;
		if (_selection_mc != undefined) {
			initHandles();
		}
	}
	function get handleFillColor():Number {
		return _handleFillColor;
	}
	function set handleSize(n:Number):Void {
		_handleSize = n;
		if (_selection_mc != undefined) {
			initHandles();
		}
	}
	function get handleSize():Number {
		return _handleSize;
	}
	function set paddingForRotation(n:Number):Void {
		_paddingForRotation = n;
		if (_selection_mc != undefined) {
			initHandles();
		}
	}
	function get paddingForRotation():Number {
		return _paddingForRotation;
	}
	function get width():Number {
		return _baseWidth * (_targetObject._xscale / 100);
	}
	function get height():Number {
		return _baseHeight * (_targetObject._yscale / 100);
	}
	function set bounds(o:Object):Void {
		if (o.xMax != undefined && o.xMin != undefined && o.yMax != undefined && o.yMin != undefined) {
			_bounds = o;
		} else {
			trace("ERROR: illegal bounds property for the TransformItem of "+_targetObject+". The bounds property must have valid xMax, xMin, yMax, and yMin properties.");
		}
	}
	function get bounds():Object {
		return _bounds;
	}
	function get centerX():Number {
		return this.centerPoint.x;
	}
	function get centerY():Number {
		return this.centerPoint.y;
	}
	function get centerPoint():Object {
		var p = {x:_localCenterX, y:_localCenterY};
		_targetObject.localToGlobal(p);
		_targetObject._parent.globalToLocal(p);
		return p;
	}
	function get axisX():Number {
		return this.axisPoint.x;
	}
	function get axisY():Number {
		return this.axisPoint.y;
	}
	function get axisPoint():Object {
		var p = {x:_localAxisX, y:_localAxisY};
		_targetObject.localToGlobal(p);
		_targetObject._parent.globalToLocal(p);
		return p;
	}
	function get eventHandler():Function {
		return _eventHandler;
	}
	function set eventHandler(f:Function):Void {
		if (f != _eventHandler && f != undefined) {
			removeAllEventsListener(_eventHandler);
			addAllEventsListener(f);
			_eventHandler = f;
		}
	}
	
}