//
//  TypeWriter.as
//
//  Created by Junie Threatt on 2008-02-18.
//  Copyright (c) 2008 T3. All rights reserved.
//

class TypeWriter {
	
	private var _typeInterval:Number;
	private var _inc:Number;
	
	private var _typeText:String;
	private var _typeField:TextField;
	private var _typeTextLength:Number;
	
	private var _typeSpeed:Number;
	
	private var _isUpperCase:Boolean
	
	public function TypeWriter(txt:String, field:TextField, speed:Number, uppercase:Boolean) {
		_typeText		= txt;			// text to type
		_typeField		= field;		// text field to type in
		_typeSpeed		= speed;		// interval speed
		_typeTextLength		= _typeText.length;	// length of text to type
		
		_inc			= 0;			// incrementor
		
		_isUpperCase 		= uppercase;		// toUpperCase() flag
		
		initTyping();
	}
	
	private function initTyping():Void {
		stop();
		_typeText = (_isUpperCase == true) ? _typeText.toUpperCase() : _typeText;
		clearInterval(_typeInterval);
		_typeInterval = setInterval(this, "typeChar", _typeSpeed);
	}
	
	private function typeChar():Void {
		if(_inc == _typeTextLength) {
			_typeField.text = _typeText;
			clearInterval(_typeInterval);
			play();
		} else {
			_typeField.text = _typeText.substr(0, _inc);
			_inc++;
		}
	}
}