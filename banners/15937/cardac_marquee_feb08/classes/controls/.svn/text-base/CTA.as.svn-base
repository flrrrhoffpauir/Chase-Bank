/*
*			CTA Class
*			Created on 2008-02-21
*			copyright (c) 2008 T3. All rights reserved.
*
*			@author timmy
*			@version 1.0.0
*
*                            .ed"""" """$$$$be.                     
*                          -"           ^""**$$$e.                  
*                        ."                   '$$$c                 
*                       /                      "4$$b                
*                      d  3           ?         $$$$                
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
*               $$ee$c   .d"                     "*$.        3.     
*               ^*$E")$..$"                         *   .ee==d%     
*                  $.d$$$*                           *  J$$$e*      
*                   """""                             "$$$"Gilo95'
*/

import utils.EventManager;
import utils.tweening.TweenLite;
import utils.tweening.Expo;

class controls.CTA extends MovieClip
{
	public var mcArrow:MovieClip;

	/**
	 *  CTA Constructor
	 */
	function CTA() { };

	public function onRollOver():Void
	{
		// show the shimmer effect
		this.gotoAndPlay("shimmer");
		TweenLite.to(mcArrow, 0.3, { _x:62, ease:Expo.easeOut });
	};
	
	public function onRollOut():Void
	{
		// show the shimmer effect
		TweenLite.to(mcArrow, 0.3, { _x:59, ease:Expo.easeOut });
	};
	
	/**
	 *  notify the rightCode.as that the cta was clicked and depending
	 * 
	 */
	public function onRelease():Void
	{
		EventManager.dispatchEvent("onCTARelease", this);
	};

} // end

