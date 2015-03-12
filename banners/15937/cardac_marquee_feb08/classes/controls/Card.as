/*
*			Card Class
*			Created on 2008-02-20
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

class controls.Card extends MovieClip
{
	private var __id:Number;
	private var __nowSelected:Boolean = false;

	/**
	 *  Card Constructor
	 */
	function Card() { };

	/**
	 *   onRollOver handler dispatches event string to the 
	 *   CardManager Class to shufle the credit card instances.
	 */
	public function onRollOver():Void
	{
		if(__nowSelected == false)
		{
			EventManager.dispatchEvent("onCardRollOver", this);
		}
	};
	
	/**
	 *   onRelease handler for the card instances. Request URL string on click.
	 */
	public function onRelease():Void
	{
		getURL("http://resources.chase.com/ViewAd.aspx?AD=|||33468|||", "_blank");
	};
	
	public function set id(_val:Number):Void { __id = _val; };
	public function get id():Number { return __id; };
	
	public function set nowSelected(_val:Boolean):Void { __nowSelected = _val; };
	public function get nowSelected():Boolean { return __nowSelected; };
	
	
} // end

