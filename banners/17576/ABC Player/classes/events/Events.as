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
	public static var ICON_ROLLOVER:String			= "onIconRollOver";
	public static var ICON_ROLLOUT:String			= "onIconRollOut";
	public static var ICON_RELEASED:String			= "onIconReleased";
	
	public static var ICON_TEXT_RELEASED:String		= "onIconTextRelease";
	
	public static var KNOB_PRESS:String			= "onKnobPress";
	public static var KNOB_RELEASE:String			= "onKnobRelease";
	public static var KNOB_DRAG:String			= "onKnobDrag";
	
	public static var CLOSE_RELEASED:String			= "onCloseRelease";
	public static var OPEN_RELEASED:String			= "onOpenReleased";
	
	// public static var SHOW_POPUP:String			= "onShowPopup";
	// public static var HIDE_POPUP:String			= "onHidePopup";
	public static var STOP_POPUP:String			= "onStopPopup";
	public static var START_POPUP:String			= "onStartPopup";
	
	public static var PLAY_VIDEO:String			= "playVideo";
		
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



