/*
*			CardManager Class
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

import mx.utils.Delegate;
import utils.EventManager;
import utils.tweening.TweenLite;
import utils.tweening.Expo;

class utils.CardManager extends MovieClip
{
	// constants

	// private properties
	private var __minScale:Number = 80;
	private var __maxScale:Number = 100;
	private var __pos0:Object = { x:21, y:22, scale:80, depth:30 }; // default front
	private var __pos1:Object = { x:9, y:11, scale:80, depth:20 }; // middle
	private var __pos2:Object = { x:0, y:0, scale:80, depth:10 }; // rear
	
	private var __positions:Array;
	private var __currCardID:Number;
	private var __animatingCards:Boolean = false;
	
	private var __shufflePauseID:Number;
	private var __countPause:Number = 0;
	
	// public properties
	public var mcCard0,mcCard1,mcCard2,mcRollOver:MovieClip;


	/**
	 *  CardManager Constructor
	 */
	function CardManager() { init(); };



	// private methods --------------------------------------------------------------------------------------------------------
	/**
	 *   Initializes
	 */
	private function init():Void
	{
		// register the listeners
		EventManager.addEventListener("onShowCards", this, "showCardsInit");
		EventManager.addEventListener("onCardRollOver", this, "shuffleCards");
		EventManager.addEventListener("onSwitchCards", this, "autoSwitchCards");
		
		// cleanse the Array used to track positions 
		__positions = [];		
		
		// set the depth and scale of the cards
		// but move offstage until CardManager is notified to animate the cards into view
		// store an id number
		// load each card into the __positions Array
		for(var i:Number = 0; i < 3; i++)
		{
			this["mcCard" + i].swapDepths(this["__pos" + i].depth);
			this["mcCard" + i]._x = this["__pos" + i].x;
			this["mcCard" + i]._y = this["__pos" + i].y - 150;
			this["mcCard" + i]._xscale = this["mcCard" + i]._yscale = this["__pos" + i].scale;
			this["mcCard" + i]._alpha = 0;
			this["mcCard" + i].id = i;
			__positions.push(i);
		}
		// reset the frontmost postion's properties
		__pos0 = { x:47, y:18, scale:100 }; // frontmost - in focus
		
		// safety
		clearInterval(__shufflePauseID);
		__countPause = 0;
	};
	
	/**
	 *  xxxxxxxxxxxxxxxxxxxxx
	 * 
	 *  @param xxx xxxxxxxxxx
	 */
	public function startShufflePause():Void
	{
		clearInterval(__shufflePauseID);
		//__shufflePauseID = setInterval(this, "resetShuffleFlag", 1000)
		__animatingCards = false;
		trace("startShufflePause reset flag: __animatingCards = " + __animatingCards);
	};
	
	/**
	 *  xxxxxxxxxxxxxxxxxxxxx
	 * 
	 *  @param xxx xxxxxxxxxx
	 */
	public function resetShuffleFlag():Void
	{
		__countPause++;
		if(__countPause >= 3)
		{
			clearInterval(__shufflePauseID);
			__countPause = 0;
			__animatingCards = false;
			trace("resetShuffleFlag reset flag: __animatingCards = " + __animatingCards);
		}
	};
	
	
	/**
	 *  Used to automatically rearranges depths and positioning of the cards.
	 *  Cycles through the 3 cards
	 * 
	 *  @param _evt The event object
	 */
	public function autoSwitchCards(_evt:Object):Void
	{
		if(__currCardID == undefined || __currCardID > 1)
		{
			shuffleCards({ data:{ id:0 } });
		}
		else
		{
			var newCardID:Number = __currCardID + 1;
			shuffleCards({ data:{ id:newCardID } });
		}
	}


	/**
	 *  Animate the cards onto the Stage
	 * 
	 *  @param _evt The event object
	 */
	public function showCardsInit(_evt:Object):Void
	{
		for(var i:Number = 0; i < 3; i++)
		{
			TweenLite.to(this["mcCard" + i], 0.5, { _alpha:100, _y:this["mcCard" + i]._y + 150, delay:i*.1, ease:Expo.easeOut });
		}
	};

	/**
	 *  Rearranges depths and positioning of the cards
	 * 
	 *  @param _evt The event object
	 */
	public function shuffleCards(_evt:Object):Void
	{
		if(__animatingCards == false)
		{
			__animatingCards = true;
			
			if(__currCardID != _evt.data.id)
			{
				// reset inactivity watch
				EventManager.dispatchEvent("onResetInactivityWatch", this);
				
				// reset nowSelected prop of last card selected
				this["mcCard" + __currCardID].nowSelected = false;
				
				// reset the tracking number to the current clicked/selected card
				__currCardID = _evt.data.id;
				
				// reset nowSelected prop of current card
				this["mcCard" + __currCardID].nowSelected = true;
				//trace("__currCardID: " + __currCardID);
				
				// cleanse 
				__positions = [];
				
				// drive the cards into the position tracking array
				for(var i:Number = 0; i < 3; i++)
				{
					if(i != __currCardID)
					{ 
						__positions.push(i);
						this["mcCard" + i].nowSelected = false;
						//trace(i + "is good to add");
					};
				}
				__positions.unshift(__currCardID); // current card goes in front
				//trace(__positions);
				
				// notify the Left to animate it's text stuffs
				EventManager.dispatchEvent("onNewCardSelected", { cardNum:__currCardID });

				// anim into their positions
				var mc0:MovieClip = this["mcCard" + __positions[0]];
				var mc1:MovieClip = this["mcCard" + __positions[1]];
				var mc2:MovieClip = this["mcCard" + __positions[2]];
				mc0.swapDepths(__pos0.depth);
				mc1.swapDepths(__pos1.depth);
				mc2.swapDepths(__pos2.depth);
				TweenLite.to(mc0, 0.5, { _x:__pos0.x, _y:__pos0.y, _xscale:__pos0.scale, _yscale:__pos0.scale, ease:Expo.easeOut, onComplete:Delegate.create(this, startShufflePause) });
				TweenLite.to(mc1, 0.2, { _x:__pos1.x, _y:__pos1.y, _xscale:__pos1.scale, _yscale:__pos1.scale, ease:Expo.easeOut });
				TweenLite.to(mc2, 0.2, { _x:__pos2.x, _y:__pos2.y, _xscale:__pos2.scale, _yscale:__pos2.scale, ease:Expo.easeOut });
			}
		}
	};
} // end