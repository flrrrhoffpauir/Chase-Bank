/**
 * VERSION: 1.03
 * DATE: 10/2/2009
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
package gs.plugins {
	import flash.display.*;
	import flash.geom.ColorTransform;
	import gs.*;
	import gs.plugins.*;
/**
 * Removes the tint of a DisplayObject over time. <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import gs.TweenLite; <br />
 * 		import gs.plugins.TweenPlugin; <br />
 * 		import gs.plugins.RemoveTintPlugin; <br />
 * 		TweenPlugin.activate([RemoveTintPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {removeTint:true}); <br /><br />
 * </code>
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class RemoveTintPlugin extends TintPlugin {
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		public function RemoveTintPlugin() {
			super();
			this.propName = "removeTint";
		}

	}
}