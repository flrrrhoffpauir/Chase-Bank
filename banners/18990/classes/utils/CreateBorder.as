/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-13
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/



class utils.CreateBorder {
	
		private var _scope : MovieClip;
		
		private var _stageHeight : Number ;
		private var _stageWidth : Number ;
		
		private var _borderTop : MovieClip;
		private var _borderBottom : MovieClip ;
		private var _borderRight : MovieClip ;
		private var _borderLeft : MovieClip ;
		
		function CreateBorder(scope){
			
			_scope = scope;
			setUp();
			init();
		}
		
		private function setUp ( ) : Void
		{
			
			_stageHeight = _scope.STAGE_HEIGHT;
			_stageWidth = _scope.STAGE_WIDTH;
			_borderTop = _scope.borderTop;
			_borderBottom = _scope.borderBottom;
			_borderRight = _scope.borderRight;
			_borderLeft = _scope.borderLeft;
		}
		
		private function init() : Void
		{
			
			setBorderTop();
			setBorderBottom();
			setBorderLeft();
			setBorderRight();
		}
		
		private function setBorderTop ( ) : Void
		{
			_borderTop._width = _stageWidth;
		}
		
		private function setBorderBottom ( ) : Void
		{
			_borderBottom._width = _stageWidth;
			_borderBottom._y = _stageHeight - _borderBottom._height;
		}
		
		private function setBorderRight ( ) : Void
		{
			_borderRight._height = _stageHeight;
		}
		
		private function setBorderLeft ( ) : Void
		{
			_borderLeft._height = _stageHeight;
			_borderLeft._x = _stageWidth - _borderLeft._width;
		}
		
		

}