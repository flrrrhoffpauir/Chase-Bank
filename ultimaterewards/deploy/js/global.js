// general
function addEvent(obj,evType,fn){ 
	if (obj.addEventListener){obj.addEventListener(evType,fn,false);return true;}
 	else if(obj.attachEvent){var r=obj.attachEvent("on"+evType,fn);return r;}
 	else return false; 
}
function externalLinks() { 
	if (!document.getElementsByTagName)return;var anchors=document.getElementsByTagName("a"); 
	for (var i=0;i<anchors.length;i++)if(anchors[i].getAttribute("href")&&anchors[i].getAttribute("rel")=="external")anchors[i].target="_blank";
}
function getQueryVar(obj){
	var vars=window.location.search.substring(1).split("&");
	for(var i=0;i<vars.length;i++){var pair=vars[i].split("=");if(pair[0]==obj)return pair[1];}
	return null;
}
function stripHTML(obj){return obj.replace(/(<([^>]+)>)/gi, "");}
function isEmpty(obj){if(obj.replace(/ /g,"").replace(/\r/g,"").replace(/\n/g,"")=="")return true;return false;}
function genEmail(user,domain,suffix,text){mailto=user+'@'+domain+'.'+suffix;text=(text)?text:mailto;document.write('<a href="mailto:'+mailto+'">'+text+'</a>');}
function getPos(el){for(var lx=0,ly=0;el!=null;lx+=el.offsetLeft,ly+=el.offsetTop,el=el.offsetParent);return{x:lx,y:ly};}
function copyVal(to,from){document.getElementById(to).value=document.getElementById(from).value;}
function innerHTML(obj,val){obj=(document.getElementById(obj))?document.getElementById(obj):obj;obj.innerHTML=val;}
function txtCt(obj,maxlimit){if(obj.value.length>maxlimit)obj.value=obj.value.substring(0,maxlimit);}
function showObj(obj){obj=(document.getElementById(obj))?document.getElementById(obj):obj;obj.style.display="block";}
function hideObj(obj){obj=(document.getElementById(obj))?document.getElementById(obj):obj;obj.style.display="none";}
function visibleObj(obj){obj=(document.getElementById(obj))?document.getElementById(obj):obj;obj.style.visibility="visible";}
function hiddenObj(obj){obj=(document.getElementById(obj))?document.getElementById(obj):obj;obj.style.visibility="hidden";}
function newWin(url,id,w,h,tb,st,sb,re){var x=screen.availWidth/2-w/2;var y=screen.availHeight/2-h/2;
	var newWin = window.open(url,id,"width="+w+",height="+h+",left="+((x>0)?x:0)+",top="+((y>0)?y:0)+",toolbar="+(tb?tb:"no")+",status="+(st?st:"no")+",scrollbars="+(sb?sb:"no")+",resizable="+(re?re:"no")+"");
	newWin.focus();
}

// cookies
function createCookie(name,value,days) {
	if (days){var date=new Date();date.setTime(date.getTime()+(days*24*60*60*1000));var expires="; expires="+date.toGMTString();}
	else var expires="";document.cookie=name+"="+value+expires+"; path=/";
}
function readCookie(name) {
	var nameEQ=name+"=";var ca=document.cookie.split(';');
	for(var i=0;i<ca.length;i++){var c=ca[i];while(c.charAt(0)==' ')c=c.substring(1,c.length);if(c.indexOf(nameEQ)==0)return c.substring(nameEQ.length,c.length);}
	return null;
}
function eraseCookie(name){createCookie(name,"",-1);}

// onload events
addEvent(window, "load", externalLinks);