/**
Clouds

@author David Ford
@version 1.0

@description Generates clouds on home screen

*/

import flash.display.BitmapData;
import flash.geom.Transform;
import flash.geom.ColorTransform;
import classes.tweening.TweenFilterLite;
import classes.tweening.Expo;

class classes.views.Clouds{
	
	private var cloudMc 		: MovieClip;
	private var cloudColorOffest	: Number;
	private var cloudIntensity 	: Number;
	private var speed 		: Number;
	private var yOffset		: Number;
	private var offset0		: Object;
	private var offset1		: Object;
	private var offset2		: Object;
	private var offset3		: Object;
	private var bitmapData		: BitmapData;
	
	public function Clouds(_cloudMc){
		
		cloudMc 		= _cloudMc;
		bitmapData 		= new BitmapData(971, 100, false, 0xFFFFFFFF);
		var trans:Transform 	= new Transform(cloudMc);
		speed 			= 2.5
		yOffset			= 0;
		cloudColorOffest 	= -220;
		cloudIntensity 	 	= 2;
		
		var cloudColorTransform	= new ColorTransform(cloudIntensity, cloudIntensity, cloudIntensity, 1, cloudColorOffest, cloudColorOffest, cloudColorOffest, 0);
		trans.colorTransform 	= cloudColorTransform;

		cloudMc.attachBitmap(bitmapData, cloudMc.getNextHighestDepth());

		cloudMc._width 		= 971;
		cloudMc._height 	= 100;
		cloudMc.blendMode	= "screen";
		cloudMc._alpha 		= 100;
		speed 			= 1.25;
		yOffset 		= 0;

		offset0 		= {x:speed, y:yOffset};
		offset1 		= {x:speed, y:yOffset};
		offset2 		= {x:speed, y:yOffset};
		offset3 		= {x:speed, y:yOffset};

		cloudMc.onEnterFrame = local(this,aniPerlin);

	}
	
	
	private function aniPerlin(){

		var oct = 5;
		offset0.x += speed;
		offset1.x += speed;
		offset2.x += speed;
		offset3.x += speed;

		bitmapData.perlinNoise(250, 100, oct, 50, false, true, 15, true, [offset0, offset1, offset2, offset3]);
	}
	

	public function toggleVisibility(dir){
		
		var endA = (dir == "hide") ? 0 : 100;
		TweenFilterLite.to(cloudMc, 2, { _alpha:endA, ease:Expo.easeOut });
		
	}
	
	
	public function toggleClouds(dir){

		if(dir == "off"){
			delete cloudMc.onEnterFrame;
		}else{
			cloudMc.onEnterFrame = local(this,aniPerlin);
		}
		
	}
	
	public static function local(scope, myCallback){
		var s = scope;
		arguments.splice(0, 2);
		var args = arguments;
		var locFunc = function() {
			return myCallback.apply(s, args.concat());
		};
		return locFunc;         
	}
}