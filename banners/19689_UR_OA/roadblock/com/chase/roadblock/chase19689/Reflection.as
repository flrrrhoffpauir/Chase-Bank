/**
*	Reflection Class
*	Created on 2010-06-07
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2010-06-07                      
*	@author timothypatrickharold
*	@version 1.0.0
*
*	all code copyright (c) 2010 timothyharold.com. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

class com.chase.roadblock.chase19689.Reflection extends MovieClip
{
	public var mc,gradientMask:MovieClip;

	public function Reflection() { init(); };


	private function init():Void
	{
		this.mc.cacheAsBitmap = gradientMask.cacheAsBitmap = true;
		this.mc.setMask(gradientMask);
	};


} // end





