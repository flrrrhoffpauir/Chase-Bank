﻿// sharedCode.asimport Tweener;// variables  -------------------------------------------------------------------------------------var __debugging:Boolean = true;_quality = "BEST";var typeInterval:Number;var i:Number = 0;var portalInterval:Number;var count:Number = 0;var portalArray:Array = [];var bottomPortalInterval:Number;var bcount:Number = 0;var bottomPortalArray:Array = [];var bulletInterval:Number;var b:Number = 0;var numOfBullets = 3;var swipeBottomInterval:Number;var p:Number = 0;// functions  -------------------------------------------------------------------------------------// Sets an interval to type out the textfunction typeWrite(txt:String, t:TextField):Void {	stop();	i = 0;	txt = txt.toUpperCase();	clearInterval(typeInterval);	typeInterval = setInterval(this, "typeChar", 40, txt, t);}// Types text like a type writerfunction typeChar(txt:String, t:TextField):Void {	if(i == txt.length) {		t.text = txt;		clearInterval(typeInterval);		play();	} else {		t.text = txt.substr(0, i);		i++;	}}// create an array for the top portalsfunction generatePortalArray():Void {	if(__debugging) { trace("::: generatePortalArray() :::"); };	for(var i:Number = 0; i < 16; i++) {		var mc:MovieClip = eval("bp" + i);		portalArray.push(mc);	}}// sets interval for portals to appearfunction setPortalInterval():Void {	if(__debugging) { trace("::: setPortalInterval() :::"); };	generatePortalArray();	clearInterval(portalInterval);	portalInterval = setInterval(this, "movePortalDown", 20);}// brings portals in from offstagefunction movePortalDown():Void {	if(__debugging) { trace("::: movePortalDown() :::"); };	var mc:MovieClip = portalArray[count];	mc.nscale = Math.random() * 100;	mc.nx = Stage.width - Math.ceil(Math.random() * 260 - 200);	mc.ny = Stage.height - Math.ceil(Math.random() * 150 - 160);		Tweener.addTween(mc, {_x: mc._nx, _y: mc.ny, _xscale: mc.nscale, _yscale: mc.nscale, time: .7, transition: "Strong.easeOut"});			count++;		if(count >= portalArray.length) {		clearInterval(portalInterval);	}}// bring in stationary portalsfunction addStationaryPortals():Void {	if(__debugging) { trace("::: addStationaryPortals() :::"); };	for(var i:Number = 0; i < 3; i++) {		var mc:MovieClip = eval("p" + i);		mc.dlay = random(9) / 10;		Tweener.addTween(mc, {_y: mc._y + 230, time: .5, delay: mc.dlay, transition: "Strong.easeOut"});	}}// bring in small stationary portalsfunction addSmallStationaryPortals():Void {	if(__debugging) { trace("::: addSmallStationaryPortals() :::"); };	for(var i:Number = 0; i < 5; i++) {		var mc:MovieClip = eval("s" + i);		mc.dlay = random(9) / 10;		Tweener.addTween(mc, {_y: mc._y - 230, time: .5, delay: mc.dlay, transition: "Strong.easeOut"});	}}// Sets interval to show "FREE" bulletsfunction showFreeBullets(xDist:Number, speed:Number):Void {	if(__debugging) { trace("::: showFreeBullets() :::"); };	stop();	clearInterval(bulletInterval);	bulletInterval = setInterval(this, "showBullet", speed, xDist);}// Shows "FREE" bullet points// Then tweens in the body (sub) copyfunction showBullet(xDist):Void {	var mc:MovieClip = this["free" + b + "_mc"];	Tweener.addTween(mc, {_x: mc._x + xDist, time: .5, transition: "Strong.easeOut", onMotionStopped: subTween});			function subTween():Void {		// hack - positioning of the three subs needs to be unique (#3 needs it's own value anyway!)		//var addXOffset:Number = (mc == free3_mc) ? 200 : 170;		switch(mc)		{			case free0_mc:				var addXOffset:Number = 170;				break;			case free1_mc:				var addXOffset:Number = 170;				break;			case free2_mc:				var addXOffset:Number = 245;				break;		}		Tweener.addTween(mc.sub, {_x: mc.sub._x + addXOffset, time: .5, transition: "Strong.easeOut"});	}		b++;		if(b >= numOfBullets) {		clearInterval(bulletInterval);		play();	}}function setHotSpot():Void {	if(__debugging) { trace("::: setHotSpot() :::"); };	this.cta_mc.onRollOver = function():Void {		cta_mc.bg.gotoAndPlay("shimmer");		Tweener.addTween(cta_mc.arrow_mc, {_x: 56, time: .3, transition: "Strong.easeOut"});	}	this.cta_mc.onRollOut = function():Void {		Tweener.addTween(cta_mc.arrow_mc, {_x: 53, time: .3, transition: "Strong.easeOut"});	}	this.cta_mc.onRelease = defaultClick;}function defaultClick():Void {	getURL("http://resources.chase.com/ViewAd.aspx?AD=|||32508|||", "_blank");}// hack  ------------------------------------------------------------------------------------------// create an array for the top portalsfunction generateBottomPortalArray():Void {	if(__debugging) { trace("::: generateBottomPortalArray() :::"); };	for(var i:Number = 0; i < 16; i++) {		var mc:MovieClip = eval("tp" + i);		bottomPortalArray.push(mc);	}}// sets interval for portals to appearfunction setBottomPortalInterval():Void {	if(__debugging) { trace("::: setBottomPortalInterval() :::"); }; 	generateBottomPortalArray();	clearInterval(bottomPortalInterval);	bottomPortalInterval = setInterval(this, "movePortalUp", 20);}// Set interval to move bottom portalsfunction swipeBottomPortals():Void {	if(__debugging) { trace("::: swipeBottomPortals() :::"); };	clearInterval(swipeBottomInterval);	swipeBottomInterval = setInterval(this, "swipeBottom", 5);}// brings portals in from offstagefunction movePortalUp():Void {	if(__debugging) { trace("::: movePortalUp() :::"); };	var mc:MovieClip = bottomPortalArray[bcount];	mc.nscale = Math.random() * 100;	mc.nx = -(Stage.width - Math.ceil(Math.random() * 260));	mc.ny = -(Stage.height - Math.ceil(Math.random() * 150 - 30));		Tweener.addTween(mc, {_x: mc._nx, _y: mc.ny, _xscale: mc.nscale, _yscale: mc.nscale, time: .7, transition: "Strong.easeOut"});			bcount++;		if(bcount >= bottomPortalArray.length) {		clearInterval(bottomPortalInterval);	}}// run at once  -----------------------------------------------------------------------------------