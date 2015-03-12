/**
*	Globe Code
*	Created on 2009-11-12
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2009-11-12                      
*	@author timothypatrickharold
*	@version 1.0.0
*
*	all code copyright (c) 2009 timothyharold.com. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import org.papervision3d_18K.scenes.*;
import org.papervision3d_18K.cameras.*;
import org.papervision3d_18K.materials.*;
import org.papervision3d_18K.objects.*;
import org.papervision3d_18K.proto.*;
import org.papervision3d_18K.core.*;
import flash.geom.*;
import flash.display.*;
import gs.TweenLite;
import gs.easing.*;

class globe.Globe extends MovieClip
{
	public var _scope, container:MovieClip;
	public var scene:Scene3D;
	public var camera:Camera3D;
	public var bitmapMaterial:BitmapMaterial;
	public var sphere:Sphere;
	public var _debug:Boolean = true;
	public var _sphere_radius:Number = 80;
	public var _sphere_faces:Number = 16;
	public var isPressed:Boolean = false;
	public var startX:Number = 0;
	public var startY:Number = 0;
	public var vx:Number = 0;
	public var vy:Number = 0;
	
	public var bd:BitmapData;

	
	public function Globe()
	{
		_scope = this;
		
		bd = new BitmapData(562, 323, false);
		bd.draw(_scope._parent.map_mc);
		
		switch(_scope._parent.bannerID) // 0:160x600, 1:300x250, 2:336x280, 3:300x600, 4:728x90
		{
			case 0 :
				_sphere_radius = 120;
				break;
			case 1 :
			case 2 :
				_sphere_radius = 80;
				break;
			case 3 :
				_sphere_radius = 115;
				break;
			case 4 :
				_sphere_radius = 90;
				break;
		}
		
		container = _scope.createEmptyMovieClip("container_mc", _scope.getNextHighestDepth());
		scene = new Scene3D(container);// Create scene
		camera = new Camera3D(); // Camera
		var bitmapMaterial:BitmapMaterial = new BitmapMaterial(bd);// Create material
		bitmapMaterial.oneSide = true;
		sphere = new Sphere(bitmapMaterial, _sphere_radius, _sphere_faces, _sphere_faces); // the globe
		sphere.rotationX = 15;
		scene.push(sphere); // add to scene		
		_scope.onEnterFrame = render; // continuous render
		_scope.onPress = pressHandler;
		_scope.onRelease = _scope.onReleaseOutside = releaseHandler;
	};
	
	public function destroy():Void
	{
		TweenLite.killTweensOf(this);
		_scope.onEnterFrame = _scope.onPress =_scope.onRelease = _scope.onReleaseOutside = null;
		sphere = null;
		bitmapMaterial = null;
		camera = null;
		scene = null;
		this.removeMovieClip(container);
	};
	
	public function spinGlobe():Void { vx = -70; };

	private function pressHandler():Void
	{
		isPressed = true;
		startX = _scope._xmouse;
	    startY = _scope._ymouse;
	};
	
	private function releaseHandler():Void { isPressed = false; };

	private function render():Void
	{
		if(isPressed == false)
		{
		     if(vx != 0)
		     {
		        vx *= .9;
		         sphere.rotationY += vx;
		     }
		} 
		else
		{
		     vx = (_scope._xmouse - startX) * .4;
		     startX = _scope._xmouse;
		     sphere.rotationY += vx;
		}
		scene.renderCamera(camera);
	};

};

