/**
*	Ripples Class
*	Created on 2008-09-23
*
*	@langversion ActionScript 2.0
*	@playerversion 8.0
*	@since 2008-09-23                      
*	@author timmy
*	@version 1.0.0
*
*	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*	Re-use of this code without express written permission is prohibited.
*	
*/

import flash.display.BitmapData;
import flash.geom.*;
import flash.filters.*;
import mx.utils.Delegate;

class effects.Ripples extends MovieClip
{
	private var _r0,_r1,_r2,_r3,_gradient:BitmapData;
	private var _w:Number; // area 
	private var _h:Number; // area
	
	private var _offset1,_offset2,_offset3,_pt,_pt2,_r1pt,_r2pt,_r3pt:Point;
	private var _s1,_s2,_s3:Number;
	private var _rect,_r1Rect,_r2Rect,_r3Rect:Rectangle;
	private var _dMap:DisplacementMapFilter;
	public var gradient_mc:MovieClip;

	/**
	 *  Ripplea Constructor
	 */
	public function Ripples() { init(); };

	/**
	 *   Inits
	 */
	private function init():Void
	{
		_w = this._width;
		_h = this._height + 60;
		
		// bitmap containing ripples
		_r0 = new BitmapData(_w, _h);
		
		_r3 = new BitmapData(_w, _h/2); // wave
		_r2 = new BitmapData(_w, _h/4); // wave
		_r1 = new BitmapData(_w, _h/4); // wave
		
		// bitmap to draw gradient
		_gradient = new BitmapData(_r0.width, _r0.height);
		_gradient.draw(this._parent.gradient_mc);
		this._parent.gradient_mc._visible = false;
		
		_offset3 = new Point(0, 0);
		_offset2 = new Point(0, 0);
		_offset1 = new Point(0, 0);
		
		// define speed and octave of each ripple
		_s1 = -0.1; // -0.3;
		_s2 = -0.2; // -0.6;
		_s3 = -0.4; // -1.2;
		_pt = new Point(0, 0);
		_rect = new Rectangle(0, 0, _r0.width, _r0.height);
		_r1Rect = new Rectangle(0, 0, _r1.width, _r1.height);
		_r2Rect = new Rectangle(0, 0, _r2.width, _r2.height);
		_r3Rect = new Rectangle(0, 0, _r3.width, _r3.height);
		
		// positioning
		_r1pt = new Point(0, 0);
		_r2pt = new Point(0, _r1.height);
		_r3pt = new Point(0, _r1.height + _r2.height);
		
		// displacement map filter using ripples as source
		_dMap = new DisplacementMapFilter(_r0, _pt, null, 1, 100, 100, "WRAP");
		
		this.onEnterFrame = Delegate.create(this, update);
	
	};

	private function update():Void
	{
		// update offsets
		var s:Number = 2100;//Math.floor(Math.random() * 100);
		
		_offset1.y += _s1;
		_offset2.y += _s2;
		_offset3.y += _s3;
		
		// generate the three smooth wave gradients
		_r3.perlinNoise(0, 15, 1, s, true, true, 1, true, [_offset3]);
		_r2.perlinNoise(0, 10, 1, s, true, true, 1, true, [_offset2]);
		_r1.perlinNoise(0, 5, 1, s, true, true, 1, true, [_offset1]);
		
		// copy the gradients and draw in the final bitmap
		_r0.copyPixels(_r1, _r1Rect, _r1pt);
		_r0.copyPixels(_r2, _r2Rect, _r2pt);
		_r0.copyPixels(_r3, _r3Rect, _r3pt);
		
		// merge the final bitmap and gradient bitmap to smooth
		_r0.merge(_gradient, _rect, _pt2, 127, 127, 127);
		
		// apply the filter
		this.filters = [_dMap];
		
	};
	
} // end
	
