/**
*	InteractiveDot Class
*	Created on 2009-04-16
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2009-04-16                      
*	@author 
*	@version 1.0.0
*
*	all code copyright (c) 2009 T3 The Think Tank. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import mx.utils.Delegate;

class application.InteractiveDot extends MovieClip
{
	public var _targBubble:MovieClip;

	/**
	 *  InteractiveDot Constructor
	 */
	public function InteractiveDot()
	{		
		this.useHandCursor = true;
		this.onRollOver = Delegate.create(this, rollOver);
		this.onRollOut = Delegate.create(this, rollOut);
	};


	public function get targetBubble():MovieClip { return _targBubble; };
	public function set targetBubble(_val:MovieClip):Void { _targBubble = _val; trace(this._name + " assigned: "+ _targBubble); };

	private function rollOver():Void
	{
		trace(this._name + " : dot expand");
		this.gotoAndPlay("expand");
		_targBubble.gotoAndPlay("expand");
		trace(_targBubble);
	};
	
	private function rollOut():Void
	{
		trace(this._name + " : dot collapse");
		this.gotoAndPlay("collapse");
		_targBubble.gotoAndPlay("collapse");
		trace(_targBubble);	
	};
	

} // end





