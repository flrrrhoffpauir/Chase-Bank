/*******************************************************************************************************
//
// SliderViewController
//  Created by ,  on 2009-05-07.
//  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
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

package com.t3.application{
	// I N C L U D E S
	import com.t3.mvc.abstract.*;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	public class SliderViewController extends AbstractController{

		// P R O P E R T I E S
		private var _bounds		:Rectangle;
		private var _slider		:MovieClip;


		// C O N S T R U C T O R

		public function SliderViewController(m:AbstractModel){
			super(m);
			_bounds = new Rectangle(SliderView.LEFT_BOUND,0,SliderView.RIGHT_BOUND-SliderView.LEFT_BOUND,0);
			//trace("####### BOUNDS " + SliderView.LEFT_BOUND + " " + (SliderView.RIGHT_BOUND-SliderView.LEFT_BOUND))
		}

		// G E T T E R S  &  S E T T E R S
		
		
		// M E T H O D S
		/*public function sliderOverHandler(evt:MouseEvent):void{
			trace("sliderOver")
		}*/
		
		public function sliderPressHandler(evt:MouseEvent):void{
			HeroModel(this.model).interacted = true;
			
			//trace("press down")
			// set to true since you can move now
			SliderView(this.view).dragging = true;
				
			_slider = evt.target.parent as MovieClip;
			_bounds.y = _slider.y;
			_bounds.width = SliderView.RIGHT_BOUND-SliderView.LEFT_BOUND - _slider.width;
			_slider.stage.addEventListener(MouseEvent.MOUSE_UP, sliderUpHandler);
			_slider.stage.addEventListener(MouseEvent.MOUSE_MOVE, sliderMoveHandler);
			//_slider.addEventListener(MouseEvent.MOUSE_UP, sliderUpHandler);
			_slider.startDrag(false, _bounds);
		}
		
		private function sliderMoveHandler(evt:MouseEvent):void{
			calculateSliderPos();
		}
		private function sliderUpHandler(evt:MouseEvent):void{
			// set draggng property to false since you released
			SliderView(this.view).dragging = false;
			
			//trace("press up " + evt.target + " " + evt.currentTarget + " "  +_slider.x + " " + (_slider.x+_slider.width))
			_slider.stage.removeEventListener(MouseEvent.MOUSE_UP, sliderUpHandler);
			_slider.stage.removeEventListener(MouseEvent.MOUSE_MOVE, sliderMoveHandler);
			_slider.stopDrag();
			calculateSliderPos();
		}
		
		private function calculateSliderPos():void{	
			//evt.stopPropagation();
			var gotoPiece:Number = Math.round((_slider.x - SliderView.LEFT_BOUND)/_slider.width);
			HeroModel(this.model).slideTo(gotoPiece);
		}
		
		public function leftClickHandler(evt:MouseEvent):void{
			// set to false since you shouldnt be dragging anyways
			SliderView(this.view).dragging = false;
			
			HeroModel(this.model).interacted = true;
			HeroModel(this.model).previous();
		}
		
		public function rightClickHandler(evt:MouseEvent):void{
			// set to false since you shouldnt be dragging anyways
			SliderView(this.view).dragging = false;
			
			HeroModel(this.model).interacted = true;
			HeroModel(this.model).next();
		}

		public function barClickHandler(evt:MouseEvent):void{
			// set to false since you shouldnt be dragging anyways
			SliderView(this.view).dragging = false;
			
			HeroModel(this.model).interacted = true;
			
			var gotoPiece:Number = Math.floor(evt.target.mouseX/(evt.target.width/HeroModel(this.model).totalSections));
			if(gotoPiece >= HeroModel(this.model).totalSections )
				gotoPiece = HeroModel(this.model).totalSections - 1;
				
			HeroModel(this.model).slideTo(gotoPiece);
		}
				
		// L I S T E N E R S
	}
}