/**
*      	FoodItems Class
*      	Created on 2008-10-03
*
*      	@langversion ActionScript 2.0
*      	@playerversion 8.0
*      	@since 2008-10-03
*	@author Junie Threatt
*
*      	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      	Re-use of this code without express written permission is prohibited.
*
*      	Sets alpha to food items
*
*/

import events.Events;
import events.EventManager;

class views.FoodItems extends MovieClip {
	
	private var _scope:MovieClip;
	private var _foodArray:Array;
	private var _numOfItems:Number;
	private var _percent:Number;
	
	public function FoodItems(num:Number, scope:MovieClip) {
		
		_scope = scope;
		trace(_scope);
		
		// 3 items
		_foodArray = [{ mc:_scope["item0"], minNum:1, midNum:35, maxNum:68 },
				{ mc:_scope["item1"], minNum:36, midNum:68, maxNum:100 },
				{ mc:_scope["item2"], minNum:69, midNum:100, maxNum:101 }];
				
		// used to calculate evenly, but these aren't even, so I set values
		// _foodArray = calcFoodArray(num);
		
		_percent = Math.round(100 / num);
		_numOfItems = _foodArray.length;
		
		EventManager.addEventListener(Events.KNOB_DRAG, this, "updateFood");
	}
	
	private function calcFoodArray(num:Number):Array {
		var tempArray:Array = [];
		for(var i:Number = 0; i < num; i++) {
			var o:Object = { mc:_scope["item"+i], minNum:Math.floor(1+_percent*i), midNum:Math.floor(_percent*(i+1)), maxNum:Math.floor(_percent*(i+1)+_percent) };
			tempArray.push(o);
		}
		return tempArray;
	}
	
	
	public function updateFood(o:Object):Void {
		var num:Number = o.data.num/100;
		var o:Object;
		for(var i:Number = 0; i < _numOfItems; i++) {
			o = _foodArray[i];
			
			if(num < o.midNum) {
				o.mc._alpha = Math.round(((num - o.minNum) / (o.midNum - o.minNum)) *100);
			} else {
				o.mc._alpha = Math.round(100 - (((num - o.midNum) / (o.maxNum - o.midNum)) *100));
			}
			
			o.mc._alpha = (o.mc._alpha < 0) ? 0 : (o.mc._alpha > 100) ? 100 : Math.round(o.mc._alpha);
			_scope["t"].text = o.mc + " : " + num + " (" + this + ")";
		}
	}
	
}