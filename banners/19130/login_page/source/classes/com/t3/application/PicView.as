/*******************************************************************************************************
//
// PicView
//  Created by ,  on 2009-05-11.
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
	import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	import fl.motion.easing.Cubic;
	import gs.TweenFilterLite;

	public class PicView extends AbstractView{

		// P R O P E R T I E S
		private const FINAL_X				:Number = 127;
		private const FINAL_Y				:Number = 6;
		private const NUMBER_VISIBLE		:Number = 4;
		
		private const PIC_W					:Number = 204;//232;
		private const PIC_H					:Number = 204;//232;
		
		private var _setup					:Object;
		private var _stage					:MovieClip;
		private var _content				:Sprite;
		private var _imgArray				:Array;
		private var _timer					:Timer;
		private var _currentSection			:Number;
		


		// C O N S T R U C T O R

		public function PicView(m:AbstractModel, c:AbstractController, setupObj:Object){
			super(m,c);
			_setup = setupObj;	
			_stage = setupObj.scope;
			_content = _stage._content_mc
			_content.mouseEnabled = false;
			_content.buttonMode = false;
			/*with(_content.graphics){
				beginFill(0xff00ff, .5);
				moveTo(0,0);
				lineTo(370,0);
				lineTo(370,240);
				lineTo(0,240);
				lineTo(0,0);
			}*/					
		}

		// G E T T E R S  &  S E T T E R S
		
		
		// M E T H O D S

				
		// L I S T E N E R S
		public override function start(evt:DataEvent):void {
			//simply adding to display list
			_imgArray = new Array();
			for(var i:Number = 0; i < evt.data.imgs.length; i++){
				var temp = new Sprite();
				temp.mouseEnabled = false;
				temp.buttonMode = false;
								
				// add image
				//temp.addChild(evt.data.imgs[i]);
				var bmpDataReg:BitmapData = new BitmapData(evt.data.imgs[i].width, evt.data.imgs[i].height, true, 0x00ffffff);
				bmpDataReg.draw(evt.data.imgs[i]);
				
				var regPic:Bitmap = new Bitmap(bmpDataReg);
				regPic.smoothing = true;
				regPic.width = PIC_W;
				regPic.height = PIC_H;
				temp.addChild(regPic);
				
				
				//add reflection
				var bmpData:BitmapData = new BitmapData(evt.data.imgs[i].width, evt.data.imgs[i].height, true, 0x00ffffff);
								
				var flipMatrix:Matrix = new Matrix();
				flipMatrix.rotate(Math.PI);
				flipMatrix.scale( -1, 1 );
				flipMatrix.translate(0, evt.data.imgs[i].height);
				
				bmpData.draw(evt.data.imgs[i], flipMatrix);
				
				bmpData.lock();
				for (var a:Number = 0; a < evt.data.imgs[i].height; a++) {
					var rowFactor:Number = 1 - (a / evt.data.imgs[i].height);
					//trace(rowFactor)
					for (var b:Number = 0; b < evt.data.imgs[i].width; b++) {
					    var pixelColor:uint = bmpData.getPixel32(b, a);
					    var pixelAlpha:uint = pixelColor >>> 24;
					    var pixelRGB:uint = pixelColor & 0xffffff;
					    var resultAlpha:uint = pixelAlpha * rowFactor;
					    bmpData.setPixel32(b, a, resultAlpha <<24 | pixelRGB);
					}
				}
				bmpData.unlock();
				
				
				
				var reflect:Bitmap = new Bitmap(bmpData);
				reflect.y = evt.data.imgs[i].y + regPic.height;
				reflect.x = evt.data.imgs[i].x;
				reflect.alpha = .2;
				reflect.width = PIC_W;
				reflect.height = PIC_H;
				reflect.smoothing = true;
				
				//bmpData.draw(evt.data.imgs[i]);
				//var reflect:Bitmap = new Bitmap(bmpData);
				//reflect.y = evt.data.imgs[i].height;//*2;
				//reflect.scaleY = -1;
				//reflect.alpha = 0.5;
				
				temp.addChild(reflect);
								
				temp.mouseChildren = false;
				_imgArray.push(temp);
			}
			for(var j:Number = _imgArray.length -1; j >= 0; j--){
				_content.addChild(_imgArray[j]);
			}
			
			//sizing and display			
			for(var k:Number = 0; k < _imgArray.length; k++){
				_imgArray[k].alpha=0;
				_imgArray[k].scaleX=1.5;
				_imgArray[k].scaleY=1.5;
				_imgArray[k].x=FINAL_X+40; 
				_imgArray[k].y=FINAL_Y-30;
			}
			
			_currentSection = 3;
			_timer = new Timer(100, 4);
			
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();	
					
		}
		
		public override function updated(evt:DataEvent):void{
			_timer.stop();
			
			//tween only if focus Pic is diff (saves processing on mouse move by the slider)
			if(_currentSection != evt.data._section)
				tweenPics(evt.data._section);
				//trace("woo")
		}
		
		public function timerHandler(evt:TimerEvent):void{
			tweenPics(_currentSection);
			_currentSection--;
			
			//start timed event
			if(_currentSection == -1)
				HeroModel(this.model).autoPlay(0);
		}
		
		private function tweenPics(_focusPic):void{
			var focusPic:Number = _focusPic;
			var tweenTime:Number = .5;
			var diff:Number;	// diff between the focus Pic and i(current pic in the for loop)
			var maxWDiff:Number = NUMBER_VISIBLE*40;
			var maxHDiff:Number = NUMBER_VISIBLE*30;
			var minScale:Number = Math.pow(.6, NUMBER_VISIBLE);
			
			for(var i:Number = 0; i < _imgArray.length; i++){
				if(i < focusPic){
					diff = focusPic-i;
					TweenFilterLite.to(_imgArray[i], tweenTime, {	
						blurFilter:{blurX:0, blurY:0}, alpha:0,
						scaleX:1.6, scaleY:1.6,
						//scaleX:Math.pow(1.6, diff), scaleY:Math.pow(1.6, diff),
						x:FINAL_X+40,//(40*diff), 
						y:FINAL_Y-30,//(30*diff),
						overwrite: true//, easing:Cubic.easeOut
					});
				} else if (i == focusPic){
					TweenFilterLite.to(_imgArray[i], tweenTime, {	
						blurFilter:{blurX:0, blurY:0}, alpha:1,
						scaleX:1, scaleY:1,
						x:FINAL_X, y:FINAL_Y,
						overwrite: true//,easing:Cubic.easeOut
					});
				} else { //i > focusPic
					diff = i-focusPic;
						
					//var blurAmt:Number = 1.5*i;
					/*var isVisible:Number;
					if(i-focusPic > NUMBER_VISIBLE-1)
						isVisible = 0;
					else
						isVisible = 1;
					*/	
					if(diff < NUMBER_VISIBLE){
						var blurAmt:Number = 1.5*i;
						
						TweenFilterLite.to(_imgArray[i], tweenTime, {	
							blurFilter:{blurX:blurAmt, blurY:blurAmt}, alpha:1,
							scaleX:Math.pow(.6, diff), scaleY:Math.pow(.6, diff),
							x:FINAL_X - (40*diff),
							y:FINAL_Y+(30*diff),
							overwrite: true//, easing:Cubic.easeOut
						});
					} else {
						TweenFilterLite.to(_imgArray[i], tweenTime, {	
							blurFilter:{blurX:6, blurY:6}, alpha:0,
							scaleX:minScale, scaleY:minScale,
							x:FINAL_X - maxWDiff,
							y:FINAL_Y + maxHDiff,
							overwrite: true//, easing:Cubic.easeOut
						});
					}
				}				
			}
			
			_currentSection = focusPic;
		}
		

	}
}