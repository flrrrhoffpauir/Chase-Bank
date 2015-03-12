/**
*                          Tracking Class
*                          Created on 2008-06-13
*
*                            .ed"""" """$$$$be.                     
*                          -"           ^""**$$$e.                  
*                        ."                   '$$$c                 
*                       /                      "4$$b                
*                      d  3          ?          $$$$                
*                      $  *                   .$$$$$$               
*                     .$  ^c           $$$$$e$$$$$$$$.              
*                     d$L  4.         4$$$$$$$$$$$$$$b              
*                     $$$$b ^ceeeee.  4$$ECL.F*$$$$$$$              
*         e$""=.      $$$$P d$$$$F $ $$$$$$$$$- $$$$$$              
*        z$$b. ^c     3$$$F "$$$$b   $"$$$$$$$  $$$$*"      .=""$c  
*       4$$$$L   \     $$P"  "$$b   .$ $$$$$...e$$        .=  e$$$. 
*       ^*$$$$$c  %..   *c    ..    $$ 3$$$$$$$$$$eF     zP  d$$$$$ 
*         "**$$$ec   "\   %ce""    $$$  $$$$$$$$$$*    .r" =$$$$P"" 
*               "*$b.  "c  *$e.    *** d$$$$$"L$$    .d"  e$$***"   
*                 ^*$$c ^$c $$$      4J$$$$$% $$$ .e*".eeP"         
*                    "$$$$$$"'$=e....$*$$**$cz$$" "..d$*"           
*                      "*$$$  *=%4.$ L L$ P3$$$F $$$P"              
*                         "$   "%*ebJLzb$e$$$$$b $P"                
*                           %..      4$$$$$$$$$$ "                  
*                            $$$e   z$$$$$$$$$$%                    
*                             "*$c  "$$$$$$$P"
*                              ."""*$$$$$$$$bc                      
*                           .-"    .$***$$$"""*e.                   
*                        .-"    .e$"     "*$c  ^*b.                 
*                 .=*""""    .e$*"          "*bc  "*$e..            
*               .$"        .z*"               ^*$e.   "*****e.      
*               $$ee$c   .d"    @author timmy   "*$.        3.     
*               ^*$E")$..$"     @version 1.0.0     *   .ee==d%     
*                  $.d$$$*                           *  J$$$e*      
*                   """""                             "$$$"Gilo95'
*                        @langversion ActionScript 2.0
*                            @playerversion 8.0
*                             @since 2008-06-13
*
*      all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      Re-use of this code without express written permission is prohibited.
*
*     A very simple execution of ExternalInterface. A wrapper that allows
*     us to change constants in the invocation in one central location. It
*     also provides simple trace output for local testing.
*/

import flash.external.*;

class tracking.Tracking
{
	private static var TRACKING_FUNCTION_1:String = "track";
	private static var TRACKING_FUNCTION_2:String = "setCookie";
	
	public static var showTrace:Boolean = true;
	
	/**
	 *   Tracking Constructor
	 */
	function Tracking() { };

	/**
	 *   calls the external js function which performs the tracking blibble blabble,
	 *   in the javascript:
	 *          var googleTag = pageLocation + '/' + tag;
	 *          a googleTrack(googleTag) & hbxTrack(tag, pageLocation) to b exact
	 *
	 *
	 *   !!!  NEED TO PULL THE "pageId" & "subPageId" PASSED WHEN EMBEDDED AT THE _root  !!!
	 *
	 * 
	 *   @param     _trackingString     the string to be tracked
	 */
	public static function track(_pageLocation:String, _tag:String):Void
	{
		// track(pageLocation, tag)
		ExternalInterface.call(TRACKING_FUNCTION_1, _pageLocation, _tag);
		debug("[\"" + TRACKING_FUNCTION_1 + "\", \"" + _pageLocation + "\", \"" + _tag + "\"]");
	};
	
	/**
	 *   calls the external js function which performs the tracking blibble blabble,
	 *   a googleTrack(googleTag) & _hbLink(hbx_pageLink) to be exact
	 * 
	 *   @param     _trackingString     the string to be tracked
	 */
	public static function trackFlash(_hbx_pageLink:String, _googleTag:String):Void
	{
		// trackFlash(hbx_pageLink, googleTag)
		ExternalInterface.call(TRACKING_FUNCTION_2, _hbx_pageLink, _googleTag);
		debug("[\"" + TRACKING_FUNCTION_2 + "\", \"" + _hbx_pageLink + "\", \"" + _googleTag + "\"]");
	};
	
	/**
	 *   simple trace output for local testing toggled via "showTrace" static var
	 * 
	 *   @param     _message     the string to be traced
	 */
	private static function debug(_message:String):Void 
	{
		if(showTrace)
		{
			trace("\n****************************************\nTracking Event:");
			trace(_message);
			trace("****************************************\n");
		};
	};
	
} // end



