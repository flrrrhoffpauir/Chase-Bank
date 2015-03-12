package com.modernista.swffocus {
	
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
    import flash.events.FocusEvent;
	import flash.events.EventDispatcher;
    import flash.external.ExternalInterface;
    import flash.system.Capabilities;

    public class SWFFocus extends EventDispatcher {
    
        private static var _availability:Boolean = ExternalInterface.available;
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		private static var _instance:SWFFocus = new SWFFocus( SingletonLock );
		private static var _initialized:Boolean = false;
		private var _stage:Stage;
		
		public function SWFFocus( lock:Class )
		{
			if ( lock != SingletonLock )   
			{   
				throw new Error( "Invalid Singleton access.  Use SWFFocus.init." );   
			}
		}
		
		public static function init(stageRef:Stage):void {
			trace("init swffocus");
			var swffocus:SWFFocus = _instance;
			if (stageRef && swffocus._stage != stageRef && !_initialized)
			{
				 swffocus._stage = stageRef;
				 _initialized =  swffocus._initialize();
			}
		};
		
        private function _initialize():Boolean {
			if (_availability && Capabilities.playerType.toLowerCase() == "plugin" && !SWFFocus._initialized) {
				
				/*
				The ExternalInterface call executes the following anonymous javascript function
				to create links and script functions to handle focus into and out of swf.

				function(){
					var i,j,oE,o,pE,p,st,ti,a,d,s,t;
					oE=document.getElementsByTagName('object');
					if(oE.length == 0){
						oE=document.getElementsByTagName('embed');
					};
					for(i=0; i<oE.length; i++){
						o=oE[i];
						if( (o.data || o.src) && o.type=='application/x-shockwave-flash'){
							st=true;
							pE=o.getElementsByTagName('param');
							for(j=0; j<pE.length; j++){
								p=pE[j];
								if(p.name.toLowerCase()=='seamlesstabbing'){
									if(p.value.toLowerCase()=='false'){
										st=false;
									};
									break;
								};
							};
							if(o.tagName.toLowerCase() == 'embed'){
								if(o.attributes['seamlesstabbing'] 
									&& o.attributes['seamlesstabbing'].value.toLowerCase()=='false'){
										st=false;
								} else {
									o.setAttribute('seamlesstabbing','true');
								};
							};
							if(st){
								ti = (o.attributes.tabindex) ? parseInt(o.attributes.tabindex.value)+1 : 2;
								o.setAttribute('tabindex',ti);
								a=document.createElement('a');
								a.id='beforeswfanchor'+i;
								a.setAttribute('tabindex',(ti-1));
								o.parentNode.insertBefore(a,o);
								a=document.createElement('a');
								a.id='afterswfanchor'+i;
								a.setAttribute('tabindex',(ti+1));
								o.parentNode.appendChild(a);
								s=document.createElement('script');
								s.type='text/javascript';
								t=document.createTextNode("if(!com) var com={}; if(!com.modernista) com.modernista={}; if(!com.modernista.swffocus) com.modernista.swffocus={}; com.modernista.swffocus.SWFFocus={}; var SWFFocus=com.modernista.swffocus.SWFFocus; SWFFocus.focusPrevious=function(){document.getElementById('beforeswfanchor\"+i+\"').focus();}; SWFFocus.focusNext=function(){document.getElementById('afterswfanchor\"+i+\"').focus();};");
								s.appendChild(t);
								document.getElementsByTagName('head')[0].appendChild(s);
								document.getElementById('beforeswfanchor'+i).focus();
								o.focus();
							};
						};
					};
				}	

				*/
					
				ExternalInterface.call("function(){var i,j,oE,o,pE,p,st,ti,a,d,s,t;oE=document.getElementsByTagName('object');if(oE.length==0){oE=document.getElementsByTagName('embed');};for(i=0;i<oE.length;i++){o=oE[i];if((o.data||o.src)&&o.type=='application/x-shockwave-flash'){st=true;pE=o.getElementsByTagName('param');for(j=0;j<pE.length;j++){p=pE[j];if(p.name.toLowerCase()=='seamlesstabbing'){if(p.value.toLowerCase()=='false'){st=false;};break;};};if(o.tagName.toLowerCase()=='embed'){if(o.attributes['seamlesstabbing']&&o.attributes['seamlesstabbing'].value.toLowerCase()=='false'){st=false;}else{o.setAttribute('seamlesstabbing','true');};};if(st){ti=(o.attributes.tabindex)?parseInt(o.attributes.tabindex.value)+1:2;o.setAttribute('tabindex',ti);a=document.createElement('a');a.id='beforeswfanchor'+i;a.setAttribute('tabindex',(ti-1));o.parentNode.insertBefore(a,o);a=document.createElement('a');a.id='afterswfanchor'+i;a.setAttribute('tabindex',(ti+1));o.parentNode.appendChild(a);s=document.createElement('script');s.type='text/javascript';t=document.createTextNode(\"if (!com) var com = { }; if (!com.modernista) com.modernista = { }; if (!com.modernista.swffocus) com.modernista.swffocus = { }; com.modernista.swffocus.SWFFocus = { }; var SWFFocus = com.modernista.swffocus.SWFFocus; SWFFocus.focusPrevious = function(){document.getElementById('beforeswfanchor\"+i+\"').focus(); }; SWFFocus.focusNext = function(){document.getElementById('afterswfanchor\"+i+\"').focus(); };\");s.appendChild(t);document.getElementsByTagName('head')[0].appendChild(s);document.getElementById('beforeswfanchor'+i).focus();o.focus();};};};}");
				
				_stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, handleFocusChange, false, 0, true);
			}
			return true;
        }
		
        private function handleFocusChange(e:FocusEvent):void {
			if (!e.shiftKey && e.target.tabIndex >= e.relatedObject.tabIndex)
			{
				ExternalInterface.call("SWFFocus.focusNext");
			} else if (e.shiftKey && e.target.tabIndex <= e.relatedObject.tabIndex)
			{
				ExternalInterface.call("SWFFocus.focusPrevious");
			}
		}
	}
 }
 
/**  
 * This is a private class declared outside of the package  
 * that is only accessible to classes inside of the SWFFocus.as  
 * file.  Because of that, no outside code is able to get a  
 * reference to this class to pass to the constructor, which  
 * enables us to prevent outside instantiation.  
 */  
class SingletonLock
{   
} // end class  