/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-17
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;

class utils.TweenTracker {
	
		private static var _set : Boolean ;
		private static var _instance : TweenTracker ;
		private static var _appName : String ;
		
		private static var _tracker : Array;
		
		function TweenTracker(){
			if (!_set) throw Error ("Need Instance of TweenTracker");
		}
		
		public static function getInstance( appName : String ) : TweenTracker
		{
			if (_instance == null ) {
				_set = true;
				_instance = new TweenTracker();
				_appName = appName;
				_tracker = new Array;
			}
			
			return _instance ;
		}
		
		public function addTarget ( target:Object) 
		{
			_tracker.push(target) ;
		}
		
		public function killAll ( ) : Void
		{
			
			for (var i = 0 ; i < _tracker.length ; i ++ )
			{
				killItem(_tracker[i]);
			}
			
		}
		
		private function killItem ( item : Object) : Void
		{
			var item : Object = typeof(item);
			if (item == "movieclip")
			{
				TweenLite.killTweensOf(item);
			} 
		}
		

}
