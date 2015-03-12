/*******************************************************************************************************
//
// carouselDoc
//  Created by David Dinh, Sr. Rich Media Designer on 2008-11-20.
//  Copyright (c) 2008 __T3__. All rights reserved.
//
//                                             ffLL                                      LLGG
//                                           LL######EEtt                            ..KK##DD
//                                         ii############KK;;                        GG##LL..
//                                         ..EE##############ff                    iiWW;;
//                                           ....DD############GG                  GGii
//                                         LL#####################KK::            ;;EE
//                    888    888           GGDDLL#######EE##########WWii          EEtt
//                    888    888                    ;;;;  tt############EEttiiiiKKKK
//                    888    888                            ;;KK################KK..
//  88888b.   8888b.  888888 888888 .d88b.  888d888 88888b.     ..ttffLLWW######KK
//  888 "88b     "88b 888    888   d8P  Y8b 888P"   888 "88b            ..KK######;;
//  888  888 .d888888 888    888   88888888 888     888  888              ;;######tt 
//  888 d88P 888  888 Y88b.  Y88b. Y8b.     888     888  888                EE####LL
//  88888P"  "Y888888  "Y888  "Y888 "Y8888  888     888  888                ;;####LL 
//  888                                                                       LL##DD
//  888   88888b.  888  888 88888b.d88b.   8888b.                               LL##LL
//  888   888 "88b 888  888 888 "888 "88b     "88b                                LL##      
//        888  888 888  888 888  888  888 .d888888                                jj##tt
//        888 d88P Y88b 888 888  888  888 888  888                                ii##tt    
//        88888P"   "Y88888 888  888  888 "Y888888                                  tt;;
//        888                                      
//        888                                      
//        888
//  
//	Description:
//
//	Public Methods:
//
******************************************************************************************************/

package application.views {
	// I N C L U D E S
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.*;
	import org.papervision3d.scenes.*;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.cameras.*;
	import org.papervision3d.objects.DisplayObject3D;
	//import org.papervision3d.materials.*;
	import org.papervision3d.materials.BitmapAssetMaterial;
	import caurina.transitions.*;

	public class carouselDoc extends PaperBase{

		// P R O P E R T I E S
		public var numOfItems:int = 5;
		public var radius:Number = 250;
		public var anglePer:Number = (Math.PI*2) / numOfItems;
		public var dsf:DropShadowFilter = new DropShadowFilter(10, 45, 0x000000, 0.3, 6, 6, 1, 3);
		public var setY:Number = 100;
		public var startY:Number = 53;
		//var con:Sprite;
		//var scene:Scene3D;//MovieScene3D;
		//var cam:Camera3D; 
		public var bam:BitmapAssetMaterial;
		public var p:Plane;
		public var angleX:Number = anglePer;
		public var dest:Number  = 1;
		
		public var planeArray:Array = new Array();
		//public var overOut:Boolean = true;

		// C O N S T R U C T O R

		public function carouselDoc(){
			
			init(485,300, false, true);
			
		//	con = new Sprite();
		//	con.x = stage.stageWidth * 0.5;
		//	con.y = stage.stageHeight * 0.5;
		//	addChild(con);
			
			
		//	scene = new Scene3D();//MovieScene3D(con);
		//	cam	= new Camera3D();
			camera.zoom = 2;
			camera.y = startY;
			
			for(var i:Number=1; i<=numOfItems; i++)
			{
				bam = new BitmapAssetMaterial("s" + i);
				bam.oneSide = false;
				bam.smooth = true;
				p = new Plane(bam, 162, 230, 2, 2);
				p.x = Math.cos(i*anglePer) * radius;
				p.z = Math.sin(i*anglePer) * radius;
								
				//p.rotationY = (-i*anglePer) * (180/Math.PI) + 270;
				//.rotationY = (-i*anglePer) * (180/Math.PI);// + 270;
				//p.rotationY = (-i*anglePer) * (180/Math.PI) + 270;
				
				scene.addChild(p);
				planeArray.push(p);
				//p.container.filters = [dsf];
			}

			//this.container.y = -50;
			//angleX = anglePer;
			//dest = 1;

			//this.right.addEventListener(MouseEvent.CLICK, moveRight);
			//this.left.addEventListener(MouseEvent.CLICK, moveLeft);
			//this.addEventListener(Event.ENTER_FRAME, render);
			
			
			//this.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
			//this.detector_mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
		
		}

		// G E T T E R S  &  S E T T E R S
		
		
		// M E T H O D S

		/**
		* Passes 'hello' value into helloWorld
		*
		* @param		msg		String value of the hello message
		* @throws		Error	if msg is an empty String
		*/
	
				
		// L I S T E N E R S
		/*
		private function moveRight(e:Event):void
		{
			dest++;
			Tweener.addTween(this, {angleX:dest*anglePer, time:1});
		}

		private function moveLeft(e:Event):void
		{
			dest--;
			Tweener.addTween(this, {angleX:dest*anglePer, time:1});
		}
		*/
		/*
		private function render(e:Event):void
		{
			cam.x = Math.cos(angleX) * 1000;					 
			cam.z = Math.sin(angleX) * 1000;
			scene.renderCamera(cam);
		}*/
		
		protected override function processFrame():void {
			
			var xChange:Number = this.mouseX - 485/2;//this.stage.stageWidth/2;
			if(xChange < -243)
				xChange = -243;
			else if (xChange > 243)
				xChange = 243;
				
			xChange /= 6000;
			// trace("x: " + xChange)
			//trace(xChange);
			angleX += xChange;
			
			// Process any movement or animation here.
			camera.x = Math.cos(angleX) * (radius+250);					 
			camera.z = Math.sin(angleX) * (radius+250);
			camera.zoom = 4;
			
			var yChange:Number = this.mouseY - this.stage.stageHeight/2;
			//yChange *= 1;
			if(yChange < -47)
				yChange = -47;
			else if (yChange > 95)
				yChange = 95;
			
			if(this.mouseY > (this.stage.stageHeight/2 -50))
				camera.y = yChange + setY;
			
			// trace("y: " + yChange + " " + camera.y);
			
			
			
			/*var _target:DisplayObject3D = new DisplayObject3D();
			_target.x = camera.x;
			_target.y = camera.y;
			_target.z = camera.z;
			trace(_target)
			
			for(var i:Number=0; i<planeArray.length; i++)
			{
				Plane(planeArray[i]).lookAt(_target);
			}
			*/
			enemiesLookAt(this);
			
			//scene.renderCamera(cam);
		}
		
		private function enemiesLookAt(scope:Sprite){
			for(var i:Number=0; i<planeArray.length; i++){
				
				var cam_pt:DisplayObject3D = new DisplayObject3D();
				cam_pt.x = Math.round(Plane(planeArray[i]).x - scope["camera"].x);
				cam_pt.y = Math.round(Plane(planeArray[i]).y - scope["camera"].y);
				cam_pt.z = Math.round(Plane(planeArray[i]).z - scope["camera"].z);
				
				Plane(planeArray[i]).lookAt(cam_pt);
			}
		}
		/*
		private function mouseOverHandler(e:MouseEvent):void{
			if(!overOut){
				trace("STARTING")
				startRendering();
			} else {
				trace("over, but already active")
			}
		}
		
		private function mouseLeaveHandler(e:Event):void{
			trace("LEAVING")
			overOut = false;
			stopRendering();
		}
		*/
	}
}










