/*
VERSION: 5.6
DATE: 8/15/2007
ACTIONSCRIPT VERSION: 2.0
UPDATES AVAILABLE AT: http://blog.greensock.com/transformmanageras2/
AS3 VERSION AVAILABLE AT: http://blog.greensock.com/transformmanageras3/
DESCRIPTION:
	TransformManager gives the user the ability to interactively scale, rotate, and/or move any MovieClip 
	on the stage using an intuitive interface (similar to most modern drawing applications). When the user clicks on the 
	TransformItem's MovieClip, a selection box will be drawn around it along with four handles for scaling. When the user 
	places their mouse just outside of any of the scaling handles, the cursor will change to indicate that they're in 
	rotation mode. Hold down shift to constrain scaling proportions or to limit rotation to 45 degree increments. 
	This TransformManager class will handle multiple TransformItem instances, switching the selection boxes 
	(so that only one is selected at a time) as well as updating the properties with a single call. See the TransformItem
	class for more details about features.
	
	There is also an AS3 version available which was completely rebuilt from the ground up to include extra features like
	multiple selections, 4 extra handles, depth management, and an API that makes it very easy to drive transformations
	directly via code (like scaleSelection(1.5, 1.2), rotateSelection(2.7), moveSelection(30, 80), etc.). Find out more
	at http://blog.greensock.com/transformmanageras3/
	
	The first (and only) parameter in the constructor accepts an object with any number of properties. This makes it easier to
	set only the properties that shouldn't use their default values (you'll probably find that most of the time the default
	values work well for you). It also makes the code easier to read. The properties can be in any order, like so:
	
		var transformManager = new TransformManager({targetObjects:[clip1_mc, clip2_mc], forceSelectionToFront:true, bounds:{xMin:0, xMax:550, yMin:0, yMax:450}, allowDelete:true, scaleFromCenter:true});

EXAMPLE: 
	To make two MovieClips transformable (with default settings):
	
		import gs.TransformManager;
		var transformManager_obj = new TransformManager({targetObjects:[myClip1_mc, myClip2_mc]});
		
	To make two MovieClips transformable, constrain their scaling to be proportional (even if the user is not holding
	down the shift key), call the onTransformEvent function on every event (when one of the MovieClips has been selected, 
	scaled, moved, rotated, deselected, deleted, etc.), lock the rotation value of each MovieClip (preventing rotation), 
	and allow the delete key to actually delete the selected MovieClip, do:
	
		import gs.TransformManager;
		var transformManager_obj = new TransformManager({targetObjects:[myClip1_mc, myClip2_mc], eventHandler:onTransformEvent, constrainScale:true, lockRotation:true, allowDelete:true, autoDeselect:true});
		function onTransformEvent(event_obj:Object):Void {
			trace("Action: "+event_obj.action+", MovieClip: "+event_obj.targetObject+", transformed?: "+event_obj.transformed);
		}
		
KEY PROPERTIES:
	- constrainScale : Boolean [default:false]
	- scaleFromCenter : oolean [default:false]
	- lockScale : Boolean [default:false]
	- lockRotation : Boolean [default:false]
	- lockPosition : Boolean [default:false]
	- autoDeselect : Boolean [default:true]
	- allowDelete : Boolean [default:false]
	- bounds : Object (an object with xMax, xMin, yMax, and yMin properties)
	- eventHandler : Function 
	- lineColor : Number [default:0x3399FF]
	- handleSize : Number [default:8]
	- handleFillColor : Number [default:0xFFFFFF]
	- paddingForRotation : Number [default:10]
	- enabled : Boolean [default:true]
	- forceSelectionToFront : Boolean [default:false]
	- selectedTargetObject : Object (MovieClip or TextField)
	- selectedItem : TransformItem (or TransformItemTF if it's a TextField)
	- items : Array
	- targetObjects : Array
	
KEY METHODS:
	- addItem(targetObject, vars)
	- addItems(targetObjects, vars)
	- select(targetObject) //You can pass a reference to the MovieClip, TextField or its associated TransformItem or TransformItemTF.
	- deselect()
	- getItemFromTargetObject(targetObject)
	- reset()
	- destroy()

KEY EVENTS:
	- select
	- deselect
	- delete
	- clickOff
	- deleteKeyDown (only called when allowDelete is false, otherwise the "delete" event is called)
	- scale
	- rotate
	- move
	
EVENTS RETURN AN OBJECT WITH THE FOLLOWING PROPERTIES:
	- target : TransformManager
	- targetObject : Object (MovieClip or TextField)
	- action : String (one of the following: "select", "deselect", "delete", "clickOff", "deleteKeyDown", "scale", "rotate", "move")
	- manager : TransformManager (if one exists that's associated with this TransformItem)
	- transformed : Boolean (if it was scaled, moved, or rotated, this is true. Otherwise it's false)
	- item : TransformItem (or TransformItemTF if it's a TextField)
		
NOTES:
	- Requires Flash 6 or later
	- Adds about 10kb to file size
	- Requires gs.TransformItem and gs.utils.EventDispatcherAS2 classes

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/


import mx.utils.Delegate;
import gs.TransformItem;
import gs.TransformItemTF;
import gs.utils.EventDispatcherAS2;

class gs.TransformManager {
	var addEventListener:Function;
	var removeEventListener:Function;
	var dispatchEvent:Function;
	var listeners:Array;
	var getItemFromMC:Function = getItemFromTargetObject; //Legacy - just for backwards compatability
	private var _allowDelete:Boolean; //If true, we'll delete a TransformItem's MovieClip when it's selected and the user hits the delete key.
	private var _autoDeselect:Boolean; //If true (and it's true by default), TransformItems will be deselected when the user clicks off of them. Disabling this is sometimes necessary in cases where you want the user to be able to select a MovieClip and then select/edit separate form fields without deselecting the MovieClip. In that case, you'll need to handle things in a custom way through your _eventHandler (look for action_str == "deselect" which will still get fired when the user clicks off of it)
	private var _eventHandler:Function; //Called every time a TransformItem is selected, moved, scaled, rotated, deselected, or when the delete key is pressed.
	private var _constrainScale:Boolean; //If true, only proportional scaling is allowed (even if the SHIFT key isn't held down).
	private var _lockScale:Boolean;
	private var _scaleFromCenter:Boolean;
	private var _lockRotation:Boolean;
	private var _lockPosition:Boolean;
	private var _lineColor:Number;
	private var _handleFillColor:Number;
	private var _handleSize:Number;
	private var _paddingForRotation:Number;
	private var _selectedItem:TransformItem;
	private var _forceSelectionToFront:Boolean;
	private var _items_array:Array; //Holds references to all TransformItems that this TransformManager can control (use addItem() to add MovieClips)
	private var _enabled:Boolean; //Set this value to false if you want to disable all TransformItems. Setting it to true will enable them all.
	private var _bounds:Object; //xMax, xMin, yMax, yMin defining an area that the items are restrained to (according to their _parent coordinate system)
	
	function TransformManager(vars:Object) {
		EventDispatcherAS2.initialize(this);
		eventHandler = vars.eventHandler;
		_allowDelete = defaultBol(vars.allowDelete, false);
		_autoDeselect = defaultBol(vars.autoDeselect, true);
		_constrainScale = defaultBol(vars.constrainScale, false);
		_lockScale = defaultBol(vars.lockScale, false);
		_scaleFromCenter = defaultBol(vars.scaleFromCenter, false);
		_lockRotation = defaultBol(vars.lockRotation, false);
		_lockPosition = defaultBol(vars.lockPosition, false);
		_forceSelectionToFront = defaultBol(vars.forceSelectionToFront, false);
		_lineColor = vars.lineColor || 0x3399FF; //Line color (including handles and selection around MovieClip)
		_handleFillColor = vars.handleFillColor || 0xFFFFFF; //Handle fill color
		_handleSize = vars.handleSize || 8; //Number of pixels the handles should be (square)
		_paddingForRotation = vars.paddingForRotation || 10; //Number of pixels beyond the handles that should be sensitive for rotating.
		if (vars.bounds != undefined) {
			_bounds = vars.bounds;
		} else if (vars.xMax != undefined) {
			_bounds = {xMax:vars.xMax, xMin:vars.xMin, yMax:vars.yMax, yMin:vars.yMin};
		} else {
			_bounds = {};
		}
		_enabled = true;
		_items_array = [];
		if (vars.items.length > 0) {
			_items_array = vars.items;
		} else if (vars.targetObjects.length > 0) {
			addItems(vars.targetObjects);
		}
	}
	
	function addItem(tgo:Object, vars:Object):Object { //Pass in a reference to a MovieClip OR TextField and then optionally a vars object with the properties you want to change from their defaults.
		if (vars.eventHandler != undefined) {eventHandler = vars.eventHandler};
		if (vars.constrainScale != undefined) {constrainScale = vars.constrainScale};
		if (vars.scaleFromCenter != undefined) {scaleFromCenter = vars.scaleFromCenter};
		if (vars.lockScale != undefined) {lockScale = vars.lockScale};
		if (vars.lockRotation != undefined) {lockRotation = vars.lockRotation};
		if (vars.lockPosition != undefined) {lockPosition = vars.lockPosition};
		if (vars.autoDeselect != undefined) {autoDeselect = vars.autoDeselect};
		if (vars.allowDelete != undefined) {allowDelete = vars.allowDelete};
		if (vars.bounds != undefined) {bounds = vars.bounds};
		if (vars.enabled != undefined) {enabled = vars.enabled};
		if (vars.forceSelectionToFront != undefined) {forceSelectionToFront = vars.forceSelectionToFront};
		for (var i = 0; i < _items_array.length; i++) { //Just in case it's already in the array.
			if (_items_array[i].targetObject == tgo) {
				return _items_array[i];
			}
		}
		if (tgo instanceof TextField) {
			var new_obj = new TransformItemTF(tgo, {eventHandler:Delegate.create(this, eventProxy), forceSelectionToFront:_forceSelectionToFront, constrainScale:_constrainScale, scaleFromCenter:_scaleFromCenter, lockScale:_lockScale, lockRotation:_lockRotation, lockPosition:_lockPosition, autoDeselect:_autoDeselect, allowDelete:_allowDelete, bounds:_bounds}, this);
		} else {
			var new_obj = new TransformItem(tgo, {eventHandler:Delegate.create(this, eventProxy), forceSelectionToFront:_forceSelectionToFront, constrainScale:_constrainScale, scaleFromCenter:_scaleFromCenter, lockScale:_lockScale, lockRotation:_lockRotation, lockPosition:_lockPosition, autoDeselect:_autoDeselect, allowDelete:_allowDelete, bounds:_bounds}, this);
		}
		_items_array.push(new_obj);
		return new_obj;
	}
	
	function addItems(tgoa:Array, vars:Object):Array { //Just pass in an array of MovieClips and/or TextFields and then optionally a vars object with the properties you want to change from their defaults.
		var a = [];
		for (var i = 0; i < tgoa.length; i++) {
			a.push(addItem(tgoa[i], vars));
		}
		return a;
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
		_eventHandler = handler;
		for (var i = 0; i < _items_array.length; i++) {
			_items_array[i].addAllEventsListener(Delegate.create(this, eventProxy));
		}
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
		if (listeners.length == 0) {
			_eventHandler = undefined;
			for (var i = 0; i < _items_array.length; i++) {
				_items_array[i].removeAllEventsListener(Delegate.create(this, eventProxy));
			}
		}
	}
	
	function eventProxy(event_obj:Object):Void {
		event_obj.target = this;
		dispatchEvent(event_obj.type, event_obj);
	}
	
	function select(ti:Object):Object { //You can pass in a reference to the MovieClip or its associated TransformItem.
		if (typeof(ti) == "movieclip" || (ti instanceof TextField)) {
			ti = getItemFromTargetObject(ti);
		}
		ti.select();
		return ti;
	}
	
	function deselect():Void {
		_selectedItem.deselect();
	}
	
	function onSelectTransformItem(ti:TransformItem):Void {
		if (ti != undefined) {
			_selectedItem.deselect();
			_selectedItem = ti;
		}
	}
	
	function onDeselect(ti:TransformItem):Void {
		if (ti == _selectedItem) {
			_selectedItem = undefined;
		}
	}
	


//---- GENERAL ------------------------------------------------------------------------
	
	function getItemFromTargetObject(targetObject:Object):TransformItem {
		for (var i = 0; i < _items_array.length; i++) {
			if (_items_array[i].targetObject == targetObject) {
				return _items_array[i];
			}
		}
	}
	
	function reset():Void {
		for (var i = 0; i < _items_array.length; i++) {
			_items_array[i].reset();
		}
	}
	
	function update():Void {
		for (var i = 0; i < _items_array.length; i++) {
			_items_array[i].update();
		}
	}
	
	function removeItem(item_obj:Object):Void {
		if (typeof(item_obj) == "movieclip" || item_obj instanceof TextField) {
			var ti = getItemFromTargetObject(item_obj);
		} else {
			var ti = item_obj;
		}
		if (ti == _selectedItem) {
			_selectedItem.deselect(true);
		}
		for (var i = _items_array.length - 1; i >= 0; i--) {
			if (ti == _items_array[i]) {
				_items_array[i].destroy(true);
				_items_array.splice(i, 1);
			}
		}
	}
	
	private function changePropertyForAllItems(property_str:String, value_obj:Object):Void {
		for (var i = 0; i < _items_array.length; i++) {
			_items_array[i][property_str] = value_obj;
		}
	}
	
	private static function defaultBol(b:Boolean, default_bol:Boolean):Boolean { //Just an easy way for us to set default values for booleans. Reduces the amount of code.
		if (b == undefined) {
			return default_bol;
		} else {
			return b;
		}
	}
	
	function destroy():Void {
		_selectedItem.deselect();
		for (var i = _items_array.length - 1; i >= 0; i--) {
			_items_array[i].destroy();
		}
		destroyInstance(this);
	}
	
	static function destroyInstance(i:TransformManager):Void {
		delete i;
	}
	
//---- GETTERS / SETTERS --------------------------------------------------------------------

	function get enabled():Boolean {
		return _enabled;
	}
	function set enabled(b:Boolean) { //Gives us a way to enable/disable all TransformItems
		_enabled = b;
		changePropertyForAllItems("enabled", b);
	}
	function get items():Array {
		return _items_array;
	}
	function get targetObjects():Array {
		var a = [];
		for (var i = 0; i < _items_array.length; i++) {
			a.push(_items_array[i].targetObject);
		}
		return a;
	}
	function get selectedTargetObject():Object {
		return _selectedItem.targetObject;
	}
	function get selectedItem():TransformItem {
		return _selectedItem;
	}
	function set eventHandler(f:Function):Void {
		if (_eventHandler != f && f != undefined) {
			removeAllEventsListener(_eventHandler);
			addAllEventsListener(f);
		}
	}
	function get eventHandler():Function {
		return _eventHandler;
	}
	function set constrainScale(b:Boolean):Void {
		_constrainScale = b;
		changePropertyForAllItems("constrainScale", b);
	}
	function get constrainScale():Boolean {
		return _constrainScale;
	}
	function set lockScale(b:Boolean):Void {
		_lockScale = b;
		changePropertyForAllItems("lockScale", b);
	}
	function get lockScale():Boolean {
		return _lockScale;
	}
	function set scaleFromCenter(b:Boolean):Void {
		_scaleFromCenter = b;
		changePropertyForAllItems("scaleFromCenter", b);
	}
	function get scaleFromCenter():Boolean {
		return _scaleFromCenter;
	}
	function set lockRotation(b:Boolean):Void {
		_lockRotation = b;
		changePropertyForAllItems("lockRotation", b);
	}
	function get lockRotation():Boolean {
		return _lockRotation;
	}
	function set lockPosition(b:Boolean):Void {
		_lockPosition = b;
		changePropertyForAllItems("lockPosition", b);
	}
	function get lockPosition():Boolean {
		return _lockPosition;
	}
	function set allowDelete(b:Boolean):Void {
		_allowDelete = b;
		changePropertyForAllItems("allowDelete", b);
	}
	function get allowDelete():Boolean {
		return _allowDelete;
	}
	function set autoDeselect(b:Boolean):Void {
		_autoDeselect = b;
		changePropertyForAllItems("autoDeselect", b);
	}
	function get autoDeselect():Boolean {
		return _autoDeselect;
	}
	function set lineColor(n:Number):Void {
		_lineColor = n;
		changePropertyForAllItems("lineColor", n);
	}
	function get lineColor():Number {
		return _lineColor;
	}
	function set handleFillColor(n:Number):Void {
		_handleFillColor = n;
		changePropertyForAllItems("handleFillColor", n);
	}
	function get handleFillColor():Number {
		return _handleFillColor;
	}
	function set handleSize(n:Number):Void {
		_handleSize = n;
		changePropertyForAllItems("handleSize", n);
	}
	function get handleSize():Number {
		return _handleSize;
	}
	function set paddingForRotation(n:Number):Void {
		_paddingForRotation = n;
		changePropertyForAllItems("paddingForRotation", n);
	}
	function get paddingForRotation():Number {
		return _paddingForRotation;
	}
	function set bounds(o:Object):Void {
		if (!isNaN(o.xMax) && !isNaN(o.xMin) && !isNaN(o.yMax) && !isNaN(o.yMin)) {
			_bounds = o;
			changePropertyForAllItems("bounds", o);
		} else {
			trace("ERROR: illegal bounds property for a TransformManager. The bounds property must have valid xMax, xMin, yMax, and yMin properties.");
		}
	}
	function get bounds():Object {
		return _bounds;
	}
	function get forceSelectionToFront():Boolean {
		return _forceSelectionToFront;
	}
	function set forceSelectionToFront(b:Boolean):Void {
		_forceSelectionToFront = b;
		changePropertyForAllItems("forceSelectionToFront", b);
	}
	
}