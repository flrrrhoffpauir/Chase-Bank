/**
*	App2 Class
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

class application.App2 extends MovieClip
{
	private var _scope:MovieClip;
	
	//private var _dotCoords:Array = [{ _x:0,_y:0}, {_x:22,_y:120}, {_x:147,_y:82}, {_x:240,_y:82}, {_x:295,_y:82}, {_x:393,_y:111}, {_x:463,_y:111}, {_x:144,_y:356}, {_x:282,_y:356}];
//	private var _bubbleCoords:Array = [{ _x:0,_y:0}, {_x:26,_y:125}, {_x:154,_y:87}, {_x:249,_y:87}, {_x:305,_y:87}, {_x:125,_y:115}, {_x:201,_y:116}, {_x:149,_y:361}, {_x:289,_y:361}];
	
	private var _dotCoords:Array = [{ _x:0,_y:0}, {_x:22,_y:120}, {_x:147,_y:82}, {_x:240,_y:82}, {_x:295,_y:82}, {_x:463,_y:111}, {_x:393,_y:111}, {_x:144,_y:356}, {_x:282,_y:356}];
	private var _bubbleCoords:Array = [{ _x:0,_y:0}, {_x:26,_y:125}, {_x:154,_y:87}, {_x:249,_y:87}, {_x:305,_y:87}, {_x:201,_y:116}, {_x:125,_y:115}, {_x:149,_y:361}, {_x:289,_y:361}];

	/**
	 *  App Constructor
	 */
	public function App2(scope:MovieClip)
	{
		trace("App");
		_scope = scope;
	};
	

	public function init():Void
	{
		makeDotsAndBubbles();
	};


	private function makeDotsAndBubbles():Void
	{
		var depth:Number = 10;
		for(var i:Number = 8; i > 0; i--)
		{
			_scope.attachMovie("bubble"+i, "bubble"+i, depth, { _x:_bubbleCoords[i]._x, _y:_bubbleCoords[i]._y });
			depth += 1;
			_scope.attachMovie("dot", "dot"+i, depth, { _x:_dotCoords[i]._x, _y:_dotCoords[i]._y });
			_scope["dot"+i].targetBubble = _scope["bubble"+i];
			depth += 1;
		}
	};
	
} // end





