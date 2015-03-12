//-------------------------------------
// VARIABLES
//-------------------------------------
	var onLoadArr:Array=[];
	var extra_mcl:MovieClipLoader = new MovieClipLoader();
	var extra_list:Object = new Object();
	extra_list.onLoadInit = function(target_mc){
		execAutoFunc(target_mc);
		Unicast.dispatchEvent({type:"ExternalContentEvent",subtype:"Init",target:this});
	}
	extra_mcl.addListener(extra_list);

//-------------------------------------
// PUBLIC FUNCTIONS
//-------------------------------------
	function loadContent(file:String, target_mc:MovieClip, onLoadFunc:Function){
		// If no target is specified, use 'extra_mc'.
		if(!target_mc){
			// If 'extra_mc' doesn't exist, create it first
			if(!_root.extra_mc){
				_root.createEmptyMovieClip("extra_mc",_root.getNextHighestDepth());
			}
			target_mc = _root.extra_mc;
		}
		(onLoadFunc) ? addAutoFunc(target_mc,onLoadFunc) : clearAutoFunc(target_mc);
		extra_mcl.loadClip(Unicast.baseURL+file, target_mc);
		Unicast.dispatchEvent({type:"ExternalContentEvent",subtype:"Request",target:this,holder:target_mc});
	}
	function unloadContent(target_mc:MovieClip){
		Unicast.dispatchEvent({type:"ExternalContentEvent",subtype:"Unload",target:this});
		if(!target_mc) target_mc = _root.extra_mc;
		extra_mcl.unloadClip(target_mc);
	}
//-------------------------------------
// PRIVATE FUNCTIONS
//-------------------------------------
	function clearAutoFunc(target){
		for(var i=0;i<onLoadArr.length;i++){
			if(onLoadArr[i].targ == target){
				onLoadArr.splice(i,1);
				break;
			}
		}
	}
	function addAutoFunc(target,onLoadFunc){
		clearAutoFunc(target);
		onLoadArr.push({targ:target,func:onLoadFunc});
	}
	function execAutoFunc(target){
		for(var i=0;i<onLoadArr.length;i++){
			if(onLoadArr[i].targ == target){
				onLoadArr[i].func();
				onLoadArr.splice(i,1);
				break;
			}
		}
	}
