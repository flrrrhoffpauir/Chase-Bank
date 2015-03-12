package com.modernista.controls
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;
	import com.modernista.accessibility.MLinkButtonAccImpl;

	public class  AccLinkButton extends Sprite
	{
		private var _label_txt:TextField;
		private var _label:String;
		private var _bg_mc:Sprite;
		private var _relatedObject:*;
		private var _styleSheet:StyleSheet;
		
		public function AccLinkButton():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_styleSheet = new StyleSheet();
			_styleSheet.setStyle("a:link", { color:"#0489B7", textDecoration:"none" } );
			_styleSheet.setStyle("a:visited", { color:"#0489B7", textDecoration:"none" } );
			_styleSheet.setStyle("a:active", { color:"#0489B7", textDecoration:"underline" } );
			_styleSheet.setStyle("a:hover", { color:"#0489B7", textDecoration:"underline" } );
			
			focusRect = false	;
			tabChildren = false;
			tabEnabled = true;
			mouseChildren = true;
			buttonMode = false;
			
			_bg_mc = DisplayObjectContainer(this).getChildByName("bg_mc") as Sprite;
			_label_txt = DisplayObjectContainer(this).getChildByName("label_txt") as TextField;
			_label_txt.autoSize = TextFieldAutoSize.NONE;
			_label_txt.width = 2;
			_label_txt.multiline = false; 
			_label_txt.wordWrap = false;
			_label_txt.autoSize = TextFieldAutoSize.LEFT;
			_label_txt.styleSheet = _styleSheet;
			
			if (_label && _label_txt.htmlText != _label) {
				_label_txt.htmlText = _label;
			}
			
			accessibilityProperties = new AccessibilityProperties();
			accessibilityProperties.name = _label_txt.text;
			
			_bg_mc.width = _label_txt.x + _label_txt.width;
			
			width = _label_txt.width;
			height = _label_txt.height;
			
			addEventListeners();
			
			MLinkButtonAccImpl.createAccessibilityImplementation(this);
		}
		
		public function addEventListeners():void {
			addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler, false, 0, true);
			addEventListener(FocusEvent.FOCUS_IN, focusInHandler, false, 0, true);
			addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, false, 0, true);
			addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			addEventListener(KeyboardEvent.KEY_DOWN, clickHandler, false, 0, true);
			
			stage.addEventListener(Event.ACTIVATE, stage_onActivateEvent, false, 1, true);
			stage.addEventListener(Event.DEACTIVATE, stage_onActivateEvent, false, 1, true);
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			_styleSheet.setStyle("a:link", _styleSheet.getStyle("a:hover") );
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			_styleSheet.setStyle("a:link", _styleSheet.getStyle("a:visited") );
		}
		
		private function focusInHandler(e:FocusEvent = null):void
		{
			_styleSheet.setStyle("a:link", _styleSheet.getStyle("a:hover") );
		}
		
		private function focusOutHandler(e:FocusEvent = null):void
		{
			_styleSheet.setStyle("a:link", _styleSheet.getStyle("a:visited") );
		}
		
		private function clickHandler(e:*):void
		{
			if (e is MouseEvent ||
				(e is KeyboardEvent && ( e.keyCode == Keyboard.ENTER || e.keyCode == Keyboard.SPACE ) ) )
			{
				XML.ignoreWhitespace = true;
				var xml:XML = new XML( _label_txt.htmlText );
				
				var urlrequest:URLRequest = new URLRequest();
				var href:String = (xml..@href.toString()!="") ? xml..@href.toString() : xml..@HREF.toString();
				var targ:String = (xml..@target.toString()!="") ? xml..@target.toString() : xml..@TARGET.toString();

				urlrequest.url = href;
				
				targ = (targ != "") ? targ : "_self";
				
				flash.net.navigateToURL(urlrequest, targ);
				
				e.stopPropagation();
			}
		}
		
		private function stage_onActivateEvent(e:Event):void
		{
			switch(e.type){
				case Event.ACTIVATE :
					if(stage.focus == this){
						focusInHandler();
					}
					break;
				case Event.DEACTIVATE :
					addEventListener(Event.ENTER_FRAME, 
										 function(evt:Event){
											 evt.target.removeEventListener(evt.type, arguments.callee);
											 evt.target.focusOutHandler();
										 }
									 );
					
					break;
			}
		}
		
		public function get label():String {
			return _label;
		}
		
		public function set label(p_label:String):void {
			_label = p_label;
			if(_label_txt){
				_label_txt.htmlText = p_label;
				accessibilityProperties.name = _label_txt.text;
				_bg_mc.width = _label_txt.width;
				_bg_mc.height = _label_txt.height;
				width = _label_txt.width;
				height = _label_txt.height;
			}
		}
		
		public function get relatedObject():* {
			return _relatedObject;
		}
		
		public function set relatedObject(p_relatedObject:*):void {
			_relatedObject = p_relatedObject;
		}
		
	}
	
}