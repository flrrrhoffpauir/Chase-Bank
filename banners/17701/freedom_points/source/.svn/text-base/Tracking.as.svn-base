/* AS2

	@langversion ActionScript 2.0
	@playerversion Flash 8.0
	
	@author Helmut Granda
	@since  2008-12-01
	
	Copyright 2008 T3.
	
	@description
	Tracking
	
*/

import flash.external.ExternalInterface;

class Tracking {

		private static var _instance : Tracking ;
		
		function Tracking ( ) { } ;
		
		public static function get instance():Tracking {
	  		if (_instance == undefined )
	     		_instance = new Tracking();
	  		return _instance;
	 	}
	
		public static function track ( $stringToTrack : String ) : Void
		{
			ExternalInterface.call('googleTrack', $stringToTrack )
			trace("googleTrack = " + $stringToTrack ) ;
		}

}