/*
	@author Helmut Granda / AS2 / F.8.0
	@since  2009-09-10
	all code copyright (c) 2009 T3. All rights reserved.
	Re-use of this code without express written permission is prohibited.
*/

import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV1_728x90 extends Engine {
	
	private function StandardV1_728x90 ( scope )
	{
		super(scope);
	}
	
	public static function create(scope:MovieClip) {
		
		instance = new StandardV1_728x90(scope);
		return instance;
	}
	
	private function finalFrame ( ) : Void
	{
	
		moveOffScreen ( introducingEnd, "top", true );
		TweenLite.to ( introducingEnd, 0.3, { 	_y : objectRecorder["introducingEndY"], 
													ease:Sine.easeIn,
													delay: 2.5,
													onComplete: Proxy.create( this, introCardEnd )
													 });

	}
	
	

}