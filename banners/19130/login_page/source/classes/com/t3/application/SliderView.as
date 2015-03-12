/*******************************************************************************************************
//
// SliderView
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
	import com.t3.mvc.events.DataEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import gs.*;

	public class SliderView extends AbstractView{

		// P R O P E R T I E S
		public static const LEFT_BOUND		:Number = 23;
		public static const RIGHT_BOUND		:Number = 671;
		public static const CATEGORY_Y		:Number = 10;
		
		private var _setup					:Object;
		private var _categories				:Array;
		private var _labels					:Array;
		private var _slider					:MovieClip;
		public var _isDragging				:Boolean;
		private var _1stTime				:Boolean;
		

		// C O N S T R U C T O R

		public function SliderView(m:AbstractModel, c:AbstractController, setupObj:Object){
			super(m,c);
			_setup = setupObj;
			_slider = setupObj.scope.slideBar_mc;
			_slider.sliderHandle_mc.tabChildren = false;
			_slider.sliderHandle_mc.tabEnabled = false;
			
			
			_slider.clickDetect_mc.tabChildren = false;
			_slider.clickDetect_mc.tabEnabled = false;
			_isDragging = false;
			_categories = new Array();
			_labels = new Array();
			_1stTime = true;
		}

		// G E T T E R S  &  S E T T E R S
		public override function defaultController (model:AbstractModel):AbstractController {
			return new SliderViewController(this.model);
		}
		
		public function set dragging(b:Boolean):void{
			_isDragging = b;
		}
		
		// M E T H O D S
		private function inArray(str:String, arr:Array):Number{
			var contains:Number = -1;
			
			if(arr == null) // if null array
				return contains;
			else if(arr.length == 0) // if empty array
				return contains;
			else { // everything else
				for(var i:Number = 0; i <= arr.length; i++){
					if(arr[i] == str)
						contains = i;
				}
				return contains;
			}
		}
	
				
		// L I S T E N E R S
		
		public override function start(evt:DataEvent):void {
			var newWidth:Number = Math.round((RIGHT_BOUND - LEFT_BOUND)/evt.data.sections);
						
			// check categories and log em
			var _xml:XML = XML(evt.data.info);
			for each (var property:XML in _xml.item) {
				if(inArray(property.categoryName, _categories) == -1){ // if not found yet
					_categories.push(property.categoryName)
				} 
			}
			/*
			// create labels
			var range:Number = (RIGHT_BOUND - LEFT_BOUND)/_categories.length;
			for(var i:Number = 0; i<_categories.length; i++){
				var newEntry:labelX = new labelX();
				//trace(newEntry.regTxt + " " + newEntry.boldTxt)
				newEntry.regTxt.label_txt.text = _categories[i];
				newEntry.boldTxt.label_txt.text = _categories[i];
				newEntry.boldTxt.alpha = 0;
				newEntry.x = i*range + LEFT_BOUND + range/2;
				newEntry.y = CATEGORY_Y;
				newEntry.mouseChildren = false;
				newEntry.mouseEnabled = false;
				_labels.push(newEntry);
				_slider.addChild(newEntry);
			}
			*/
			_slider.sliderHandle_mc.body_mc.buttonMode = true;
			_slider.sliderHandle_mc.body_mc.width = newWidth;
			_slider.sliderHandle_mc.body_mc.mouseChildren = false;
			_slider.sliderHandle_mc.grip_mc.x = newWidth/2;
			_slider.sliderHandle_mc.grip_mc.mouseEnabled = false;
			_slider.sliderHandle_mc.grip_mc.mouseChildren = false;
			
		}
		
		public override function updated(evt:DataEvent):void{
			if(_1stTime){
				_1stTime = false;
				
				_slider.sliderHandle_mc.body_mc.addEventListener(MouseEvent.MOUSE_DOWN, SliderViewController(this.controller).sliderPressHandler)
				//_slider.sliderHandle_mc.body_mc.addEventListener(MouseEvent.MOUSE_OVER, SliderViewController(this.controller).sliderOverHandler)

				_slider.btn_left.buttonMode = true;
				_slider.btn_left.addEventListener(MouseEvent.CLICK, SliderViewController(this.controller).leftClickHandler);
				_slider.btn_right.buttonMode = true;
				_slider.btn_right.addEventListener(MouseEvent.CLICK, SliderViewController(this.controller).rightClickHandler);
				_slider.clickDetect_mc.buttonMode = true;
				_slider.clickDetect_mc.addEventListener(MouseEvent.MOUSE_UP, SliderViewController(this.controller).barClickHandler);
			}
			
			/*
			// bold the category names
			var xmlItem:XML = XML(evt.data._info);
			
			
			// find location of the category name in the array
			var categoryNum:Number = inArray(xmlItem.categoryName, _categories);
			// bold correct ones
			for(var i:Number = 0; i<_labels.length; i++){
				if(i == categoryNum){
					labelX(_labels[i]).boldTxt.alpha = 1;
					labelX(_labels[i]).regTxt.alpha = 0;
				} else {
					labelX(_labels[i]).boldTxt.alpha = 0;
					labelX(_labels[i]).regTxt.alpha = .75;
				}
			}
			*/
			// move the slider, is and onlyif user released the slider
			if(!_isDragging){
				TweenLite.to(_slider.sliderHandle_mc, .25, {x:evt.data._section*_slider.sliderHandle_mc.body_mc.width + LEFT_BOUND, overwrite:true});
			}
		}

	}
}