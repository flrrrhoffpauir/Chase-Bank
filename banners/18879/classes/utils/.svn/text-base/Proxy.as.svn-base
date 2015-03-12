/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-04-14
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/



class utils.Proxy {

  public static function create( $target : Object , $function : Function ) : Function {

    var aParameters:Array = new Array();
    for(var i:Number = 2; i < arguments.length; i++) 
	{
      aParameters[i - 2] = arguments[i];
    }

    var fProxy:Function = function():Void 
	{
      var aActualParameters : Array = arguments.concat ( aParameters ) ;
      $function.apply ( $target, aActualParameters ) ;
    };

    return fProxy;

  }

}