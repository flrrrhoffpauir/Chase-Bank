/*******************************************************************************************************
//
// PaperBase
//  Created by David Dinh, Sr. Rich Media Designer on 2008-08-26.
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
//		PaperBase class taken from the PaperBase class and editted from http://papervision2.com;
//
//	Public Methods:
//
******************************************************************************************************/

package application.views {
	
	// I N C L U D E S
	import flash.display.Sprite; // To extend this class
	import flash.events.Event; // To work out when a frame is entered.
	import org.papervision3d.view.Viewport3D; // We need a viewport
	import org.papervision3d.cameras.*; // Import all types of camera
	import org.papervision3d.scenes.Scene3D; // We'll need at least one scene
	import org.papervision3d.render.BasicRenderEngine; // And we need a renderer

	public class PaperBase extends Sprite {

		// P R O P E R T I E S
		public var container			:Sprite;
		public var viewport				:Viewport3D; // The Viewport
		public var renderer				:BasicRenderEngine; // Rendering engine
			// -- Scenes -- //
		public var scene				:Scene3D; // A Scene
			// -- Cameras --//
		public var camera				:Camera3D; // A Camera

		// C O N S T R U C T O R

		public function PaperBase(){
			container = new Sprite();
			addChild(container);
		}

		// G E T T E R S  &  S E T T E R S
		
		
		// M E T H O D S

		public function init(vpWidth:Number = 800, vpHeight:Number = 600, scaleToStage:Boolean = false, interactive:Boolean = true):void {
			initPapervision(vpWidth, vpHeight, scaleToStage, interactive); // Initialise papervision
			init3d(); // Initialise the 3d stuff..
			init2d(); // Initialise the interface..
			//initEvents(); // Set up any event listeners..
			startRendering();
		}
		
		protected function initPapervision(vpWidth:Number, vpHeight:Number, scaleToStage:Boolean = false, interactive:Boolean = true):void {
			// Here is where we initialise everything we need to
			// render a papervision scene.
			viewport = new Viewport3D(vpWidth, vpHeight, scaleToStage, interactive);
			// The viewport is the object added to the flash scene.
			// You 'look at' the papervision scene through the viewport
			// window, which is placed on the flash stage.
			container.addChild(viewport); // Add the viewport to the stage.
			// Initialise the rendering engine.
			renderer = new BasicRenderEngine();
			// -- Initialise the Scenes -- //
			scene = new Scene3D();
			// -- Initialise the Cameras -- //
			camera = new Camera3D(); // The argument passed to the camera
			// is the object that it should look at. I've passed the scene object
			// so that the camera is always pointing at the centre of the scene.
		}
		
		protected function init3d():void {
			// This function should hold all of the stages needed
			// to initialise everything used for papervision.
			// Models, materials, cameras etc.
		}
		
		protected function init2d():void {
			// This function should create all of the 2d items
			// that will be overlayed on your papervision project.
			// User interfaces, Heads up displays etc.
		}
			
		public function singleRender():void{
			onEnterFrameHandler(new Event(Event.COMPLETE));			
		}	
				
		public function startRendering():void {
			// This function makes the onFrame function get called for
			// every frame.
			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			// This line of code makes the onEnterFrame function get
			// called when every frame is entered.
		}
		
		protected function processFrame():void {
			// Process any movement or animation here.
		}
		
		public function stopRendering(reRender:Boolean = false, cacheAsBitmap:Boolean = false):void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
	
				
		// L I S T E N E R S
		
		protected function onEnterFrameHandler( e:Event ):void {
			//We need to render the scene and update anything here.
			processFrame();
			renderer.renderScene(scene, camera, viewport);
		}

	}
}