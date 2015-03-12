import AdTimeout;
//=========================================================
// UNICAST PUSHDOWN SHARED CODE
//---------------------------------------------------------
	if (VwTimeoutAuto)		TIMEOUT_AUTO 		= Number(VwTimeoutAuto);
	if (VwTimeoutAutoVid)	TIMEOUT_AUTO_VID 	= Number(VwTimeoutAutoVid);
	if (VwTimeoutAutoLock)	TIMEOUT_AUTO_LOCK 	= (VwTimeoutAutoLock.toLowerCase() == "true");
	if (VwTimeoutUser)		TIMEOUT_USER 		= Number(VwTimeoutUser);
	if (VwTimeoutUserVid)	TIMEOUT_USER_VID 	= Number(VwTimeoutUserVid);
	if (VwTimeoutUserLock)	TIMEOUT_USER_LOCK 	= (VwTimeoutUserLock.toLowerCase() == "true");
	
	var ROLL_EXPAND = (VwExpandTrigger=="roll");
	var ROLL_CLOSE =  (VwCloseTrigger == "roll");
	
	//var ENABLE_ROLLOFF:Boolean = (VwEnableRolloff.toLowerCase()=="true");
	var isAutoExpand:Boolean = (VwIsAutoExpand.toLowerCase()=="true");
	var isExpanded:Boolean = false;
	var isTweening:Boolean=false;
	var bResizeEnableRolloff=false;
	var isAdLoaded = false;
	
	var pushdownTimeout:AdTimeout = new AdTimeout();
	pushdownTimeout.addEventListener(AdTimeout.TRIGGER, onAdTimeout);
	function onAdTimeout(e:Object) {
		doRetract(true);
	}
	
	function _unicastEventListener(e:Object):Void {
		if(e.subtype!="Load" || isAdLoaded) return;
		isAdLoaded = true;
		Unicast.removeEventListener("UnicastEvent", _unicastEventListener);
		
		if(_url.substr(0,5)=="file:"){
			_root.createEmptyMovieClip("localhint_mc",_root.getNextHighestDepth());
			localhint_mc.loadMovie("localhints.swf");
		}
		
		// If stage is already the maximum dimensions, assume this is a variant of auto-expand
		if (Stage.width == MAXWIDTH && Stage.height == MAXHEIGHT) {
			trace("Stage is already at max dimensions. Assuming auto-expand.");
			isAutoExpand = isExpanded = true;
			Unicast.dispatchEvent({type:"FormatEvent",subtype:"ExpandComplete",target:this,auto:true});
		}else {
			if(Stage.width!=MINWIDTH || Stage.height!=MINHEIGHT){
				trace("*** WARNING: Stage dimensions(" + Stage.width + "x" + Stage.height + ") do not match minimum dimensions(" + MINWIDTH + "x" + MINHEIGHT + ")");
			}
			Unicast.dispatchEvent( { type:"FormatEvent", subtype:"Init", target:this, auto:isAutoExpand } );
		}
	}
	Unicast.addEventListener("UnicastEvent", _unicastEventListener);


//---------------------------------------------------------
// TIMEOUT HANDLING
//---------------------------------------------------------
	function timeoutEventListener(e){
		switch(e.subtype) {
			case "ExpandComplete":
				if(isAutoExpand){
					pushdownTimeout.start(TIMEOUT_AUTO, TIMEOUT_AUTO_VID, TIMEOUT_AUTO_LOCK);
				}else {
					pushdownTimeout.start(TIMEOUT_USER, TIMEOUT_USER_VID, TIMEOUT_USER_LOCK);
				}
				break;
			case "Retract":
				pushdownTimeout.cancel(true);
				break;
		}
	}
	Unicast.addEventListener("FormatEvent", timeoutEventListener);
	
//---------------------------------------------------------
// EXPAND/ RETRACT
//---------------------------------------------------------
	function doExpand(bAuto:Boolean) {
		if(isExpanded) return;
		isTweening=true;
		isExpanded = true;
		isAutoExpand = bAuto;
		if(!bAuto) Unicast.track("User_Expand",1);
		if(ROLL_CLOSE && !bAuto) bResizeEnableRolloff=true;
		Unicast.dispatchEvent({type:"FormatEvent",subtype:"Expand",target:this,auto:(bAuto==true)});
		
		// Expand Width & Height Together
			Unicast.animatePanel(Unicast.panelID, MAXX, 0, MAXWIDTH, MAXHEIGHT, 1);
		// Expand Width...Then Height
			//Unicast.animatePanel(1, null, null, MAXWIDTH, null, 1);
			//Unicast.animatePanel(1, null, null, null, MAXHEIGHT, 1, true);
	}

	function doRetract(bAuto:Boolean) {
		if(!isExpanded) return;
		isExpanded=false;
		isTweening=true;
		if(bAuto) Unicast.log("AUTO-RETRACT");
		if(!bAuto)Unicast.track("User_Close",-1);
		isAutoExpand=false;
		if(ENABLE_ROLLOFF && !bAuto) Unicast.callJS("VwCancelMouseListener"+Unicast.adID+"();");
		Unicast.dispatchEvent({type:"FormatEvent",subtype:"Retract",target:this,auto:(bAuto==true)});
		
		// Collapse Width & Height Together
			Unicast.animatePanel(Unicast.panelID, 0, 0, MINWIDTH, MINHEIGHT, 1);
		// Collapse Height...Then Width
			//Unicast.animatePanel(Unicast.panelID, null, null, null, MINHEIGHT, 1);
			//Unicast.animatePanel(Unicast.panelID, null, null, MINWIDTH, null, 1,true);
	}
	Unicast.addCommand("retract",this,doRetract);
	
//---------------------------------------------------------
// STAGE SIZE LISTENER
//---------------------------------------------------------
	var stageList:Object = new Object();
	stageList.onResize = function() {
		var w:Number = Stage.width;
		var h:Number = Stage.height;
		if(!isTweening)return;
		if(bResizeEnableRolloff){
			bResizeEnableRolloff=false;
			Unicast.callJS("VwSetRolloffPanel"+Unicast.adID+"("+Unicast.panelID+");");
		}
		// Don't respond to initial size
		if(getTimer()<1000) return;
		// Stage has fully expanded, start the animation
		if (Math.abs(h - MAXHEIGHT) <= 1 && Math.abs(w - MAXWIDTH) <= 1 && isExpanded == true) {
			isTweening = false;
			Unicast.dispatchEvent({type:"FormatEvent",subtype:"ExpandComplete",target:this,auto:isAutoExpand});
		}
		// Stage has fully collapsed, return to prompt
		if (Math.abs(h-MINHEIGHT)<2 && Math.abs(w-MINWIDTH)<=1 && isExpanded==false){
			isTweening = false;
			Unicast.dispatchEvent({type:"FormatEvent",subtype:"RetractComplete",target:this,auto:isAutoExpand});
		}
		if(userNewSize) userNewSize(w,h);
	};
	Stage.addListener(stageList);

//---------------------------------------------------------
	stop();