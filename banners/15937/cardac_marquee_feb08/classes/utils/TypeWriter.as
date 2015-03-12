/*
*                          TypeWriter Class AS2.0
*                          Created on 2008-02-18
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
*               $$ee$c   .d"                     *$.        3.     
*               ^*$E")$..$"                         *   .ee==d%     
*                  $.d$$$*                           *  J$$$e*      
*                   """""                             "$$$"Gilo95'
*
*                    @author Junie Threatt and Tim Harold
*                               @version 1.0.0
*
*            all code copyright (c) 2008 T3. All rights reserved.
*
*            Invoke the TypeWriter.startTyping() method to initiate the typing effect. A
*            delay value may be passed using the optional property named "delay".
*            
*            If the .controlPlayhead property is set to true, upon completion this Class
*            will resume Timeline playback if the _parent Timeline of the target TextField
*            has previously been halted.
*
*            Example:
*
*            import TypeWriter;
*            var txtField1:TextField;
*            TypeWriter.startTyping(txtField1, "Tim is lame-O", { speed:250,
*                                                                 delay:2,
*                                                                 toUppercase:true,
*                                                                 controlPlayhead:true });
*
*/

class utils.TypeWriter
{
	private static var __CLASS_INSTANCE:TypeWriter = undefined;
	private static var __showTraceOutput:Boolean = false;
	private static var __allObjects:Object = {}; // hold references of the objects to receive Junie's Typing Effect
	

	/**
	 *  TypeWriter Constructor
	 */
	public function TypeWriter() { };
	
	/**
	 *  Function that invokes the typing effect.
	 * 
	 *  @param _targetField The target TextField receiving the typing effect.
	 *  @param _textToType A String containing the text value use for the typing effect.
	 *  @param _dataObj [OPTIONAL] An Object comprised of properties that will override the defaults. the properties are: 
						[_speed:Number, [_delay:Number, [_toUppercase:Boolean, [_controlPlayhead:Boolean]]]].
						The default values are:  speed:500, delay:0, toUppercase:false, controlPlayhead:false.
	 */
	public static function startTyping(_targetField:TextField, _textToType:String, _dataObj:Object):Void
	{
		// instantiate if necessary
		getInstance();
		
		// create id for static tracking array
		var id:String = _targetField._name;
		
		// store the length of the text content to be typed into the field
		var textToTypeLength:Number = _textToType.length;
		
		// if the toUppercase flag is set to true then convert the text to uppercase
		var tempTextToType:String = (_dataObj.toUppercase) ? _textToType.toUpperCase() : _textToType;
		
		// create the new target object and set the defaults
		var newTextTarget:Object = { targetField:_targetField,
									textToType:tempTextToType,
									textToTypeLength:textToTypeLength,
									speed:500,
									delay:0,
									toUppercase:false,
									controlPlayhead:false,
									typeInterval:0,
									delayInterval:0,
									typeStep:0,
									delayStep:0 };
									
		// parse the new params object and replace the defaults
		for(var prop in _dataObj)
		{
			newTextTarget[prop] = _dataObj[prop];			
			if(__showTraceOutput) { trace("newTextTarget[" + prop + "] = " + _dataObj[prop]); };
		}
		
			
		// store the new target object in the static tracking array
		__allObjects[id] = newTextTarget;
		
		// apply the typing interval
		clearInterval(__allObjects[id].typeInterval);
		
		// if there is a delay declared then... delay the mofo
		if(_dataObj.delay == undefined)
		{
			// halt _parent Timeline playback
			if(__allObjects[id].controlPlayhead) { __allObjects[id].targetField._parent.stop(); };
			
			// no delay has been declared so let's get to it
			__allObjects[id].typeInterval = setInterval(__CLASS_INSTANCE, "typeChar", __allObjects[id].speed, id);
		}
		else
		{
			// delay has been declared so... delay the typing effect
			var formattedDelayTime:Number = __allObjects[id].delay * 1000;
			
			//!!!!!!!!!!!!!!!!!!!!!!!!  USE _global IN AS2.0 CLASSES FOR setTimeout TO WORK  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			_global.setTimeout(__CLASS_INSTANCE, "delayInterval", formattedDelayTime, id);
		}
		
		// TESTING  /////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if(__showTraceOutput)
		{
			// trace the default object
			trace("default:");
			for(var prop in newTextTarget) { trace("newTextTarget[" + prop + "] = " + newTextTarget[prop]); };
			trace(" ");
			// trace the tracked object
			trace("tracked:");
			for(var prop in __allObjects[id]) { trace("__allObjects[" + id + "][" + prop + "] = " + __allObjects[id][prop]); };
			trace(" ");
			// trace the interval info
			trace(__CLASS_INSTANCE + " " + __allObjects[id].typeInterval);
		};
		// TESTING  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
	};
	
	/**
	 *  Performs the typing effect. Executed by setInterval() within the startTyping() method.
	 *
	 *  @param _id String that represents the current target.
	 */
	private function typeChar(_id:String):Void
	{
		// time to shut down and clean up
		if(__allObjects[_id].typeStep == __allObjects[_id].textToTypeLength) 
		{
			// type the value into the target TextField
			__allObjects[_id].targetField.text = __allObjects[_id].textToType;
			
			// clear the typing interval
			clearInterval(__allObjects[_id].typeInterval);
			if(__showTraceOutput) { trace(__allObjects[_id].targetField + " interval cleared: #" + __allObjects[_id].typeInterval); };
			
			// resume _parent Timeline playback
			if(__allObjects[_id].controlPlayhead) { __allObjects[_id].targetField._parent.play(); };
			
			// when finished, remove from the static tracking array
			__allObjects[_id] = null;
		}
		else
		{			
			// type the value into the target TextField
			__allObjects[_id].targetField.text = __allObjects[_id].textToType.substr(0, __allObjects[_id].typeStep);
			
			// increment our step
			__allObjects[_id].typeStep++;
			if(__showTraceOutput) { trace(__allObjects[_id].targetField + " typeStep: " + __allObjects[_id].typeStep); };
		}
	};
	
	/**
	 *  Invokes the typing effect after a specified pause. Executed by setTimeout() within the startTyping() method.
	 *
	 *  @param _id String that represents the current target.
	 */
	private function delayInterval(_id:String):Void
	{
		// halt _parent Timeline playback
		if(__allObjects[_id].controlPlayhead) { __allObjects[_id].targetField._parent.stop(); };
		__allObjects[_id].typeInterval = setInterval(__CLASS_INSTANCE, "typeChar", __allObjects[_id].speed, _id);
	};
		
	/**
	 *  Insure that we only have one instance in use for typing all the text effects!
 	 */
	public static function getInstance():TypeWriter
	{
		// ignore that pesky warning 1012 if you see it
		if(__CLASS_INSTANCE == undefined) { __CLASS_INSTANCE = new TypeWriter(); } else { if(__showTraceOutput) { trace("TypeWriter instance already exists"); }; };
		return __CLASS_INSTANCE;
	};
		
	// end
}