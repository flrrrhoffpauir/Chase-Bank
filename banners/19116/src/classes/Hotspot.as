/**
*	Hotspot Class
*	Created on 2009-11-10
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2009-11-10                      
*	@author 
*	@version 1.0.0
*
*	all code copyright (c) 2009 T3 The Think Tank. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import mx.utils.Delegate;

class Hotspot extends MovieClip
{
	public function Hotspot() { this.onRelease = Delegate.create(this, release); };
	private function release():Void { _root.conduit.exit(1); };
}; // end





