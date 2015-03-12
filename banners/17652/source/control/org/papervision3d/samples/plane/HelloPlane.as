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

class org.papervision3d.samples.plane.HelloPlane extends MovieClip 
{
	// _______________________________________________________________________
	//                                                                  vars3D
	var container 	:MovieClip;
	var scene     	:Scene3D;
	var camera    	:FreeCamera3D;

	// _______________________________________________________________________
	//                                                                    Main
	function HelloPlane()
	{	
				
		init3D();
		this.onEnterFrame = loop3D;
	}


	// _______________________________________________________________________
	//                                                                  Init3D
	function init3D()
	{
		// Create container movieclip and center it
		container = this.createEmptyMovieClip( "container", this.getNextHighestDepth() );
		container._x = this._width/2;
		container._y = this._height/2;
		//container.attachMovie("card_mc", "card", container.getNextHighestDepth())
		
		// Create scene
		scene = new Scene3D( container );
		
		// Create camera
		camera = new FreeCamera3D();
		camera.z = -100;
		camera.zoom = 1;
		camera.focus = 500;

		// Create material
		var material :BitmapAssetMaterial = new BitmapAssetMaterial( "card_bmp" );
		material.oneSide = false; // Make it double sided
		material.smooth = true;
		material.lineAlpha = 25;
		
		var plane :Plane = new Plane( material );
        
		// position
		plane.x = -200;
		plane.y = 0;
		plane.z = 0;
        
		// rotation
		plane.rotationX = 0;
		plane.rotationY = 0;
		plane.rotationZ = 0;
        
		// Include in scene
		scene.push( plane );
		
		
	}

	// _______________________________________________________________________
	//                                                                    Loop
	function loop3D()
	{
		//camera.x = -(container._xmouse/2);
		//camera.y = -(container._ymouse/2);

		// Render
		scene.renderCamera( camera );
	}
}

