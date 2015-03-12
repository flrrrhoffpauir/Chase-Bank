package application.utils{

	// I N C L U D E S
	
	import flash.display.*;
	import flash.events.*;	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	                              	
	import gs.*;   
	import gs.easing.*;   
	import gs.plugins.*; 	                                      
	
	
	/**                              
	 * The Bubbles.
	 *	
	 * @author David Vo
	 * 
	 * @langversion Actionscript 3.0
	 * @since Created on 27-October-2009
	 * @description resize the mc to the desired width and height on stage. DO NOT edit the shape within the mc; keep it at 25x25. Copyright (c) 2008 T3 | The Think Tank. All rights reserved.
	 */	                   
	
	
	public class Bubbles extends MovieClip {
		
		// P R O P E R T I E S   
		
		private static var _BUBBLE_COUNT	:Number = 50;
		private static var _BUBBLE_COLOR	:Number = 0xFDFFD0;
		                  
		private var _targ					:MovieClip;   
		private var _loader					:Loader;
		private var _bounds					:Object;
		private var _bubblesArr				:Array;
				
		
		// C O N S T R U C T O R
				
		public function Bubbles() {
			super();			                         
			init();
		}
		
		
		// G E T T E R S  &  S E T T E R S 	
		
		
		// M E T H O D S
		
		private function init():void {
			_targ = this;			
			             
			// record the bounds
			_bounds = new Object();
			_bounds.w = _targ.width;
			_bounds.h = _targ.height; 
			                    
			// resize back to the default
			_targ.width = 25;
			_targ.height = 25;
			
			generateBubbles();			
		}
		
		private function generateBubbles():void {
			_bubblesArr = new Array();
			                       
			for (var i:Number=0; i<_BUBBLE_COUNT; i++){
				var bubble:MovieClip = new MovieClip();
				bubble.graphics.beginFill(_BUBBLE_COLOR);
				bubble.graphics.drawCircle(0, 0, randRange(0.1,1));
				bubble.graphics.endFill();			
				bubble.name = "bubble"+i;
				bubble.x = randRange(0,_bounds.w);
				bubble.y = randRange(_bounds.h-15,_bounds.h)
				bubble.alpha = 0;
				_targ.addChild(bubble);  		
				        
				_bubblesArr.push(bubble);            
				TweenLite.to(bubble, randRange(4,7), {alpha:0.8, y:0, delay:randRange(0, 100)*.1, onComplete:bubbleRisen, onCompleteParams:[bubble]}); 
			}
			
		}            
		
		private function bubbleRisen(bubble):void {
			bubble.alpha = 0;
			bubble.y = randRange(_bounds.h-15,_bounds.h)
			TweenLite.to(bubble, randRange(4,7), {alpha:1, y:0, delay:randRange(0, 100)*.1, onComplete:bubbleRisen, onCompleteParams:[bubble]}); 			
		}
		
		private function randRange(minNum:Number, maxNum:Number):Number {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }

		public function kill():void {				
			for (var i:Number=0; i<_bubblesArr.length; i++){
				TweenLite.killTweensOf(_bubblesArr[i]);
			}
		}
		
				
		// L I S T E N E R S		  	        	
		
	}
	
}
