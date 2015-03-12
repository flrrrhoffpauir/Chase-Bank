package {

	// I N C L U D E S
	
	import flash.display.*;
	import flash.events.*;	
	import flash.system.*;  
	import flash.external.*  
	import flash.utils.*;	                 
	
	
	/**                              
	 * The CalculatorDocument.
	 *	
	 * @author David Vo
	 * 
	 * @langversion Actionscript 3.0
	 * @since Created on 09-February-2010
	 * @description Copyright (c) 2008 T3 | The Think Tank. All rights reserved.
	 */	                   
	
	
	public class CalculatorDocument extends MovieClip{
		
		// P R O P E R T I E S   
		                  
		private var _debug					:Boolean = true;		
		private var _arr   		 			:Array; 
		private var _rootRef				:String;  
		private var _ctaURL					:Object;		    		
		private var _firstVisit				:Boolean;	
		private var _tweenArr				:Array;  
		private var _tweenCounter			:Number;	
		private var _initFocus				:Boolean;		   		
				
		
		// C O N S T R U C T O R
				
		public function CalculatorDocument(){	   
			 	
			Security.allowDomain("*");   

			clearBtn.mouseChildren = false;
			clearBtn.buttonMode = true;  
			clearBtn.addEventListener(MouseEvent.CLICK, buttonHandler);
			clearBtn.addEventListener(MouseEvent.MOUSE_OVER, buttonOverHandler);  
		    clearBtn.addEventListener(MouseEvent.MOUSE_OUT, buttonOutHandler);	
		
			inputPoints.addEventListener ( Event.CHANGE, inputChangeEventHandler, false ) ;
			inputPoints.addEventListener ( FocusEvent.FOCUS_IN, inputFocusInHandler );
			inputPoints.addEventListener ( MouseEvent.CLICK, inputClickHandler );			
			inputPoints.addEventListener ( FocusEvent.FOCUS_OUT, inputFocusOutHandler );
			inputDollars.addEventListener ( Event.CHANGE, inputChangeEventHandler, false ) ;
			inputDollars.addEventListener ( FocusEvent.FOCUS_IN, inputFocusInHandler );		
			inputDollars.addEventListener ( MouseEvent.CLICK, inputClickHandler );							
			inputDollars.addEventListener ( FocusEvent.FOCUS_OUT, inputFocusOutHandler );			
			
			stage.focus 					= inputPoints.input;
			inputPoints.input.tabIndex 	 	= 0;
			inputDollars.input.tabIndex 	= 1;		
			clearBtn.tabIndex				= 2;
			               
			inputPoints.input.selectable = true;
			inputDollars.input.selectable = true;
			inputPoints.input.restrict = "0-9 \\.\\,"
			inputDollars.input.restrict = "0-9 \\.\\,"			
				
		}
		
		
		// G E T T E R S  &  S E T T E R S		      	
		
		
		// M E T H O D S				       
		
		private function addCommas(num:*, killDec:Boolean=false):String{   
			
			var count				:Number = 0;
			var tempString			:String = "";  
			var finalString			:String = "";                                               
			var centString			:String = "";
			var dollarString		:String = "";			
			var decimalIndex		:Number = String(num).indexOf('.');                             
			
			if (decimalIndex != -1){
				centString  = String(num).substring(decimalIndex, decimalIndex+3);	
				dollarString = String(num).substring(0, decimalIndex);		
			} else {
				centString = "";
				dollarString = String(num);
			}			                                         
			
			for (var i:Number = dollarString.length-1; i>=0; i--) {
				count++;
				tempString += dollarString.charAt(i);
				if ((count%3 == 0) && (i - 1 >= 0)) {
					tempString += ",";
				}
			}
			for (var k:Number = tempString.length; k>=0; k--) {
				finalString += tempString.charAt(k);
			}
			
			if (killDec) return finalString;
			else return finalString + centString;
			
		}
		
		private function removeCommas(val:String):String{
			
			var tempArr:Array = String(val).split(",");
			var finalString:String = "";
			                          
			for (var i:Number=0; i<tempArr.length; i++){
				finalString += tempArr[i];
			}                             
			
			return finalString;
			
		}
		        
        		
		// L I S T E N E R S	 
		
		private function buttonHandler(e:MouseEvent):void{ 			
			inputPoints.input.text = "0";     
			inputDollars.input.text = "0.00"						
		}   
		
		private function buttonOverHandler(e:MouseEvent):void{		
		}		
		
		private function buttonOutHandler(e:MouseEvent):void{ 		
		}	
		
		private function inputChangeEventHandler(e:Event):void{
			var val		:String;
			var newVal	:Number;   
			var tmp		:Number;   
			var tmpPts	:Number;   
			var tmpDol	:String;
			
			switch(e.currentTarget.name){           
				
				case "inputPoints":
					val = e.currentTarget.input.text;
					newVal = Number(removeCommas(val))/100;
					                                         
					// output to dollars
					if (String(newVal).indexOf(".", 0) == -1) {
						inputDollars.input.text = addCommas(newVal) + ".00";
					}
					else {
						tmp = Number(newVal + "0");
						inputDollars.input.text = addCommas(tmp.toFixed(2));
					} 
					
					// reformat points                                     
				  	tmpPts = Number(removeCommas(val));
					inputPoints.input.text = addCommas(tmpPts);            
					
					setTimeout(inputPoints.input.setSelection, 0, inputPoints.input.length, inputPoints.input.length);

					break;
					
				case "inputDollars":
					val = e.currentTarget.input.text;
					newVal = Math.floor(Number(removeCommas(val))*100);

					// output to points
					inputPoints.input.text = addCommas(newVal, true);                  
					
					// reformat dollars
					tmpDol = removeCommas(val);										
					inputDollars.input.text = addCommas(tmpDol)					
							                                  
					setTimeout(inputDollars.input.setSelection, 0, inputDollars.input.length, inputDollars.input.length);							
							
					break;
			}
		}	             
		
		private function inputFocusInHandler(e:Event):void{       
			e.currentTarget["bg"].hilite.alpha = 1;           
			/*if (_initFocus) setTimeout(e.currentTarget.input.setSelection,10, 0, e.currentTarget.input.length);			
			else _initFocus = true;                               */
		}                              
		
		private function inputClickHandler(e:MouseEvent):void{
			e.currentTarget.input.setSelection(0, e.currentTarget.input.length);   	
		}
		
		private function inputFocusOutHandler(e:Event):void{
			e.currentTarget["bg"].hilite.alpha = 0;       
			
			switch (e.currentTarget.name){
				case "inputDollars":
					// reformat dollars                        
					var input:String = e.currentTarget.input.text;        
					
					if (input.indexOf(".", 0) == -1) {
						inputDollars.input.text += ".00";
					} 
					else if (input.indexOf(".", 0) == 2){                                                                   						
						var tmpDollars:String = addCommas(Number(input));						
						var tmp:Number = Number(tmpDollars);
						inputDollars.input.text = tmp.toFixed(2);						
					}          
					
					break;
				
			}			
		}		
		
	}
	
	
}
