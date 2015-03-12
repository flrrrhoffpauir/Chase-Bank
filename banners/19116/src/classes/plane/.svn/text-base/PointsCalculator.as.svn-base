/**
*	PointsCalculator Class
*	Created on 2009-11-10
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2009-11-10                      
*	@author 
*	@version 1.0.0
*
*	all code copyright (c) 2009 T3 The Think Tank. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import mx.utils.Delegate;

class plane.PointsCalculator extends MovieClip
{
	private var _minimumPointsToShowInActualPointsField:Number = 9500;
	public var increment,decrement:Button;
	public var txtActualPoints,txtPossiblePoints:TextField;
	
	private var _incrementIsPressed:Boolean;
	private var _decrementIsPressed:Boolean;



	/**
	 *  PointsCalculator Constructor
	 */
	public function PointsCalculator()
	{
		increment.onPress = Delegate.create(this, incrementPointsPress);
		increment.onRelease = Delegate.create(this, incrementPointsRelease);
		increment.onReleaseOutside = Delegate.create(this, incrementPointsRelease);
		decrement.onPress = Delegate.create(this, decrementPointsPress);
		decrement.onRelease = Delegate.create(this, decrementPointsRelease);
		decrement.onReleaseOutside = Delegate.create(this, decrementPointsRelease);
	};
	

	/**
	 *   Inits
	 */
	
	private function incrementPointsPress():Void
	{
		_incrementIsPressed = true;
		this.onEnterFrame = Delegate.create(this, changePoints);
	}; 
	
	private function incrementPointsRelease():Void
	{
		_incrementIsPressed = false;
		this.onEnterFrame = null;
	}; 
	
	private function decrementPointsPress():Void
	{
		_decrementIsPressed = true;
		this.onEnterFrame = Delegate.create(this, changePoints);
	}; 
	
	private function decrementPointsRelease():Void
	{
		_decrementIsPressed = false;
		this.onEnterFrame = null;
	};
	
	
	private function changePoints():Void
	{
		var varNum:Number;
		if(_incrementIsPressed) { varNum = 100; };
		if(_decrementIsPressed) { varNum = -100; };
		var val:Number = stripCommaConvertToNumber(txtActualPoints.text) + varNum;
		if(val > _minimumPointsToShowInActualPointsField)
		{
			txtActualPoints.text = formatWithCommas(val);
			txtPossiblePoints.text = calculatePoints(val);
		}
	};
	
	
	private function calculatePoints(val:Number):String
	{
		var bonusPercentage:Number = .25;
        var bonusPoints:Number = Math.round(val + (val * bonusPercentage));
		return formatWithCommas(bonusPoints);
	};
	
	
	private function stripCommaConvertToNumber(val:String):Number
	{
		var output:Array = val.split(",");
    	var combo:String = output[0] + output[1];
		var num:Number = Number(combo);
        return num;
	};
	
	
	private function formatWithCommas(val:Number):String
	{
		
		var output:Array = val.toString().split();
        var tmp:Array = new Array(); 
        var startNum:Number; 
        var endNum:Number = output[0].length;
        while(endNum > 0)
        { 
            startNum = Math.max(endNum - 3, 0); 
            tmp.unshift(output[0].slice(startNum, endNum)); 
            endNum = startNum; 
        } 
        output[0] = tmp.join(",");
        return String(output[0]);
	};
	
} // end





