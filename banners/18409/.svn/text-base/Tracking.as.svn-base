/*
*                          Tracking Class
*                          Created on 2008-05-13
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
*                             @langversion AS 2.0
*                             @playerversion 8.0
*                             @since 2008-05-13
*
*     all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*     Re-use of this code without permission is prohibited.
*
*     A very simple execution of ExternalInterface. It also provides simple
*     trace output for local testing.
*
*/

import flash.external.*;

class application.utils.Tracking
{
	private static var CLASS_INSTANCE:EventManager = undefined;
	private static var TRACKING_FUNCTION:String = "js_function_name_here";
	public static var showTrace:Boolean = true;
	
	/**
	 *  Tracking Constructor
	 */
	function Tracking() { };
	
	
	/**
	 *  Highlander:  There can only be one
	 */
	public static function getInstance():Tracking
	{
		if(CLASS_INSTANCE == undefined) { CLASS_INSTANCE = new Tracking(); } else { trace("Tracking instance already exists"); };
		return CLASS_INSTANCE;
	};
	

	/**
	 *   calls the external js function which performs the tracking blibble blabble
	 * 
	 *   @param     _trackingString     the string to be tracked
	 */
	public static function track(_trackingString:String):Void
	{		
		ExternalInterface.call(TRACKING_FUNCTION, _trackingString);
		debug(_trackingString);
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

