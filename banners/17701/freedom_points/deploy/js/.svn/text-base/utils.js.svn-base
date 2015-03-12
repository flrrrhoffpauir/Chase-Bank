var URL = unescape(window.document.location);
var list1 = "";
if (URL.indexOf("?") > -1) {
	list1 = URL.split("?");
};

var flashvars = {
  	cardtype: list1[1],
	logo: escape("http://chase.com"),
	applyNowLink: escape("https://applynow.chase.com/FlexAppWeb/renderApp.do?PID=CHFD4&SPID=C5V9&CAT=0&CELL=6NQR&MSC=T3013829")
};
swfobject.embedSWF("freedompoints_landing.swf", "chaseContent", "780", "655", "8.0.0", "expressInstall.swf", flashvars ) ;

function googleTrack ( $string ) 
{
	WriteLayer ('debug', null, $string ) ;
}

function WriteLayer(ID,parentID,sText) {
 if (document.layers) {
   var oLayer;
   if(parentID){
     oLayer = eval('document.' + parentID + '.document.' + ID + '.document');
   }else{
     oLayer = document.layers[ID].document;
   }
   oLayer.open();
   oLayer.write(sText);
   oLayer.close();
 }
 else if (parseInt(navigator.appVersion)>=5&&navigator.appName=="Netscape") {
   document.getElementById(ID).innerHTML = sText;
 }
 else if (document.all) document.all[ID].innerHTML = sText
}

