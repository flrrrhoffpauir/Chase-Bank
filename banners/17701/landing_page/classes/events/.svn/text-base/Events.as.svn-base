/**
*      Events Class
*      Created on 2008-09-23
*
*      @langversion ActionScript 2.0
*      @playerversion 8.0
*      @since 2008-06-03
*
*      all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      Re-use of this code without express written permission is prohibited.
*
*      Description pending ---
*
*/

class events.Events
{
	/*   list all event strings  ---------------------------------------------*/
	public static var OFFER_ROLLOVER:String			= "onOfferRollOver";
	public static var OFFER_ROLLOUT:String			= "onOfferRollOut";
		
	/*------------------------------------------------------------------------*/
	public static var CLASS_INSTANCE:Events = undefined;
	
	/**  Events Constructor  */
	private function Events() { };

	/**  Ensure that only one instance exists!  */
	private function getInstance():Events
	{
		if(CLASS_INSTANCE == undefined) { CLASS_INSTANCE = new Events(); } else { trace("Events instance already exists"); };
		return CLASS_INSTANCE;		
	};
	
} // end



