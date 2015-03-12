/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org � blog.papervision3d.org � osflash.org/papervision3d
 */

/*
Copyright (c) 2007 Carlos Ulloa

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import org.papervision3d.cameras.FreeCamera3D;
import org.papervision3d.materials.BitmapAssetMaterial;
import org.papervision3d.objects.Plane;
import org.papervision3d.scenes.Scene3D;
import classes.tweening.TweenFilterLite;


class bannerPlane640x480 extends MovieClip 
{
	// _______________________________________________________________________
	//                                                                  vars3D
	var _container 		:MovieClip;
	var scene     		:Scene3D;
	var camera    		:FreeCamera3D;

	var planeCard 		:Plane;
	var materialCard 	:BitmapAssetMaterial;

	var planePhone 		:Plane;
	var materialPhone 	:BitmapAssetMaterial;

	var _stageWidth 	:Number;
	var _stageHieght 	:Number;
	var playFrame		:Number = 0;
	var flipTime		:Number = 0.5;
	
	
	// _______________________________________________________________________
	//                                                                    Main
	function bannerPlane640x480()
	{	
		
		_stageWidth = 320;
		_stageHieght = 240;
		
		//trace(_stageWidth+" : "+_stageHieght);
		
		init3D();
		this.onEnterFrame = loop3D;
	}
	
	
	// _______________________________________________________________________
	//                                                                  Init3D
	function init3D()
	{
		// -- Create _container movieclip and center it
		var tempMC = this.createEmptyMovieClip( "temp", this.getNextHighestDepth() );
		_container = tempMC._parent.container;
		_container._x = _stageWidth;
		_container._y = _stageHieght;
		
		
				
		// -- Create scene
		scene = new Scene3D( _container );
		
		// -- Create camera
		camera = new FreeCamera3D();
		camera.z = -200;
		camera.y = 45;
		camera.zoom = 1.4;
		camera.focus = 500;
		
		
		// -- Create material
		materialCard = new BitmapAssetMaterial( "card_bmp" );
		materialCard.oneSide = false; // Make it double sided
		materialCard.smooth = true;
		
		materialPhone = new BitmapAssetMaterial( "phone_bmp" );
		materialPhone.oneSide = false; // Make it double sided
		materialPhone.smooth = true;
		
		
		planeCard = new Plane( materialCard, null, null, 8, 8 );
		planePhone = new Plane( materialPhone, null, null, 8, 8 );
        
		
		// -- position
		planeCard.x = -10;
		planeCard.y = 105;
		planeCard.z = 0;
        
		planePhone.x = 0;
		planePhone.y = 100;
		planePhone.z = 0;
		planePhone.rotationY = -90;
        
		// -- Include in scene
		scene.push( planeCard );
		scene.push( planePhone );
		
		TweenFilterLite.from(planeCard, flipTime, {x:-(_stageWidth*3), z:500, rotationY:-120, delay:0.2});
		TweenFilterLite.from(_container, flipTime, {blurFilter:{blurX:20}, overwrite:false});
		
		
		TweenFilterLite.delayedCall(.75, wiggle, [planeCard], this);
		TweenFilterLite.delayedCall(2, playMain0, [], this);
		TweenFilterLite.delayedCall(3.5, playMain1, [], this);
		
		TweenFilterLite.delayedCall(4, flipPhoneIn, [], this);
		TweenFilterLite.delayedCall(6, playMain2, [], this);
		
		TweenFilterLite.delayedCall(8.5, slidePhoneOver, [], this);
		TweenFilterLite.delayedCall(8.5, playMain3, [], this);

		
	}
	
	// _______________________________________________________________________
	//                                                         Animation Setup
	
	function flipPhoneIn()
	{
				
		TweenFilterLite.to(_container, flipTime, {blurFilter:{blurX:20}, overwrite:false});
		TweenFilterLite.to(_container, flipTime, {blurFilter:{blurX:0}, delay:flipTime/2, overwrite:false});
		
		TweenFilterLite.to(camera, flipTime/2, {z:-400, overwrite:false});
		TweenFilterLite.to(camera, flipTime/2, {z:-200, delay:flipTime/2, overwrite:false});
		
		TweenFilterLite.to(planeCard, flipTime, {rotationY:90, x:25, z:-300, overwrite:false, onComplete:removePlane, onCompleteParams:[planeCard]});
		TweenFilterLite.to(planePhone, flipTime, {rotationY:-1, x:-10, delay:flipTime/2, overwrite:false});
		
		TweenFilterLite.delayedCall((flipTime+(flipTime*0.5)), wiggle, [planePhone], this);
	}
	
	function removePlane(myPlane:Plane)
	{
		
		myPlane.z = -2000;
		
	}
	
	function slidePhoneOver()
	{
		
		TweenFilterLite.to(planePhone, .5, {x:220, onComplete:wiggle, onCompleteParams:[planePhone]});
		
		
	}
	
	function wiggle(myObj:Plane)
	{
		
		TweenFilterLite.to(_container, 0.20, {blurFilter:{blurX:5}, delay:0.5, overwrite:false});
		TweenFilterLite.to(_container, 0.20, {blurFilter:{blurX:0}, delay:.75, overwrite:false});
		
		TweenFilterLite.to(_container, 0.20, {blurFilter:{blurX:5}, delay:1.5, overwrite:false});
		TweenFilterLite.to(_container, 0.20, {blurFilter:{blurX:0}, delay:1.75, overwrite:false});
		
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:0.5, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:0.55, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:0.6, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:0.65, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:0.70, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:0.75, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:0.80, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:0.85, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:0.9, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:0.95, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:1, overwrite:false});
				
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:1.5, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:1.55, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:1.60, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:1.65, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:1.70, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:1.75, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:1.8, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:1.85, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:1.9, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x-1, delay:1.95, overwrite:false});
		TweenFilterLite.to(myObj, 0.05, {x:myObj.x+1, delay:2, overwrite:false});
		
	}
	
	function playMain0()
	{
		_container._parent.gotoAndPlay(4);
	}
	function playMain1()
	{
		_container._parent.gotoAndPlay(5);
	}
	function playMain2()
	{
		_container._parent.gotoAndPlay(10);
	}
	function playMain3()
	{
		_container._parent.gotoAndPlay(18);
	}
	
	
	// _______________________________________________________________________
	//                                                                    Loop
	function loop3D()
	{
		//camera.x = -(_container._xmouse/2);
		//camera.y = -(_container._ymouse/2);

		// Render
		scene.renderCamera( camera );
	}
}

