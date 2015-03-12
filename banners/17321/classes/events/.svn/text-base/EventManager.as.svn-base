/**
*                          EventManager Class
*                          Created on 2008-06-01
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
*                             @since 2008-05-28
*
*      all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      Re-use of this code without express written permission is prohibited.
*
*      Description pending ---
*
*/

class events.EventManager
{
	private static var CLASS_INSTANCE:EventManager = undefined;
	private static var _arr_listeners:Array = [];
	
	/**
	 *  EventManager Class
	 */
	function EventManager() { };

	/**
	 *  Adds an Object, an event, and a handler to the watch list.
	 *
	 *  @param     _event        The event to register for the Object.
	 *  @param     _listener     The Object to register for the event.
	 *  @param     _mappedTo     The Function that will be called upon notification of the event.
	 */
	public static function addEventListener(_event:String, _listener:Object, _mappedTo:String):Boolean
	{
		var _ev:String;
		var _li_obj:Object;
		
		// check to see if the Object has already been registered
		for(var i in _arr_listeners)
		{
			_ev = _arr_listeners[i].event;
			_li_obj = _arr_listeners[i].listener;
			// if it has, exit
			if(_ev == _event && _li_obj == _listener) { return false; };
		}
		
		// ... if it hasn't, then register it now
		_arr_listeners.push({ event:_event, listener:_listener, mappedTo:_mappedTo });
		return true;
	};
	
	/**
	 *  Removes an Object, it's event, and it's handler from the watch list.
	 *
	 *  @param     _event        The event previously registered to the Object.
	 *  @param     _listener     The Object previously added to the watch list.
	 */
	public static function removeEventListener(_event:String, _listener:Object):Boolean
	{
		var _ev:String;
		var _li_obj:Object;
		
		var _len:Number = _arr_listeners.length;
		for(var i:Number = 0; i < _len; i++)
		{
			_ev = _arr_listeners[i].event;
			_li_obj = _arr_listeners[i].listener;
			// if the Object is in the list, remove it
			if(_ev == _event && _li_obj == _listener) { _arr_listeners.splice(i, 1); return true; };
		}
		
		// otherwise, just shut down now
		return false;
	};
	
	/**
	 *  Used to inform listeners when an event has occurred.
	 *
	 *  @param     _event     The name of the event.
	 *  @param     _data      The additional parameters to be sent to the registered Function. 
	 */
	public static function dispatchEvent(_event:String, _data:Object):Void
	{
		// place information into an object
		var evtObj:Object = { type:_event, data:_data };
		
		// find Objects registered to hear this event
		for(var i:String in _arr_listeners)
		{
			if(_arr_listeners[i].event == _event)
			{
				_arr_listeners[i].listener[_arr_listeners[i].mappedTo](evtObj);
			}
		}
	};
	
	/**
	 *  Displays the Array of Listeners, their event, and the function to which they are mapped
	 */
	public static function showListeners():Void
	{
		var _len:Number = _arr_listeners.length;
		for(var i:Number = 0; i < _len; i++)
		{
			trace(i + " - event: " + _arr_listeners[i].event + "  listener: " + _arr_listeners[i].listener + "  mappedTo: " + _arr_listeners[i].mappedTo);
		}
	};
	
	/**
	 *  Ensure that we only have one instance in use for managing all events!
	 */
	public static function getInstance():EventManager
	{
		if(CLASS_INSTANCE == undefined) { CLASS_INSTANCE = new EventManager(); } else { trace("EventManager instance already exists"); };
		return CLASS_INSTANCE;
	};
	
} //end


