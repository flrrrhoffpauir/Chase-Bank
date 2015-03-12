import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.filters.ColorMatrixFilter;

class Chasilism extends MovieClip {
	
	private static var _logo 			: MovieClip;
	private static var _logoId			: String;
	private static var _width			: Number;
	private static var _height			: Number;
	private static var _maskWidth		: Number;
	private static var _maskHeight		: Number;
	private static var _scope			: MovieClip;
	private static var _transitionX		: Number;
	private static var _transitionY		: Number;
	private static var _logoWidth 		: Number;
	private static var _logoHeight		: Number;
	private static var _bmpData			: BitmapData;
	private static var _colorTransform	: ColorTransform;
	private static var _logos			: Array;
	private static var _padding			= 1;
	private static var _matrix			: Matrix;
	private static var _int				: Number;
	private static var _time : Number	= 1.5;
	private static var _start			: Number;
	private static var _currRow : Number= 0;
	private static var _mask			: MovieClip;
	private static var _splash			: MovieClip;
	private static var _played			: Boolean;
	private static var _minY			: Number;
    private static var _maxY            : Number;
	/*private static var
	private static var*/
	
	
	public function Chasilism ()
	{
		_scope 			= this._parent;
		//trace("scope: "+_scope)
		_logoId			= "portalSpinning";
		_logo			= _scope.attachMovie(_logoId,"___logo", _scope.getNextHighestDepth(), {_x:-999, _y:-999, _alpha:0}) ;
		_logoWidth		= 20;
		_logoHeight		= 20;
		_width			= 300;
		_height			= 250;
		_transitionX	= 0;
		_transitionY	= 0;
		_minY			= -20
		_maxY			= 20;
		_colorTransform = new ColorTransform(0, 1, 1, 1, 0, 0, 0, 0);
		_logos			= new Array();
		_matrix			= new Matrix();
		_mask			= _scope.m;
		_splash			= _scope.img2;
		_played			= false;
		_splash.setMask(_mask);
		
		//makeGrid();
	}
	
	
	public static function init(obj) : Void
	{
		if(!obj) return;
		if(obj.logo) _logoId = obj.logo;		
		if(obj.logoWidth) _logoWidth	= obj.logoWidth;
		if(obj.logoHeight) _logoHeight = obj.logoHeight;	
		if(obj.width) _width = obj.width		
		if(obj.height) _height = obj.height;		
		if(obj.transitionX) _transitionX = obj.transitionX; 
		if(obj.transitionY) _transitionY = obj.transitionY;
		if(obj.minY) _minY	= obj.minY;
		if(obj.maxY) _maxY	= obj.maxY;
	}
	
	
	private static function reset()
	{
		clearInterval(_int);
		_bmpData.fillRect(new Rectangle(0, 0, _width, _height), 0x00FF0000);
		_logos			= new Array();
		makeGrid();	
	}
	
	
	private static function makeGrid() : Void
	{
		var rows 		= Math.ceil(_height/_logoHeight);
		var columns		= Math.ceil(_width/_logoWidth);
		var minTime		= .9;
		var minY		= -25;
		var maxY		= 25;
		var maxS		= 4;
		var minS		= 1;
		var maxSp		= 10;
		var minSp		= 1;
		var timeStep	= minTime/_time;
		var speedStep	= (_time-minTime)/columns
		_bmpData 		= new BitmapData(_width, _height, true, 0xFFFFFF);

		_scope.attachBitmap(_bmpData, _scope.getNextHighestDepth());
		
		
		for (var h = 0; h <= rows; h++) {
			for (var w = 0; w <= columns; w++) {
				var colStep		= (w+1)/columns;
				var num 		= _logos.push({});
				var l 			= _logos[(num-1)];
				l.x 			= w*_logoWidth+w*_padding;
				l.startX		= l.x;
				l.y 			= h*_logoHeight+h*_padding;	
				l.rotation 		= 0;
				l.scale 		= randRange(1,1.5);
				l.alpha 		= 0;
				l.destScale		= ((h/rows) <= .5) ? ((h*2/rows)*(maxS-minS)+minS) : (1-(h/rows))*(maxS-minS)+minS;
				l.scaleSpeed	= ((h/rows) <= .5) ?  ((h/(rows/2))*(maxSp-minSp)+minS)/100 : ((1-(h/rows))*(maxSp-minSp)+minSp)/100;
				l.speedX		= w/columns*(_time-minTime)+minTime
				var destWidth	= (_logoWidth*l.destScale)+_logoWidth;
				l.speedY		= (h/rows*(_maxY-_minY)+_minY)
				l.speedR		= randRange(-.1, .1);
				l.speedA		= randRange(.1,.3);
				l.currFrame		= randRange(1, 19);
				l.row 			= w;
				l.dest 			= _width + (w*destWidth)+(destWidth*2);//_width+(w*(_logoWidth*1.5))//(_width*2) - (w*_logoWidth);//
				_colorTransform.alphaMultiplier = l.alpha;
				
				_matrix.createBox(l.scale, l.scale, 0, l.x, l.y);
				_bmpData.draw(_logo, _matrix, _colorTransform);
			}
		}
	}
	
	
	public static function startTransition(_w, _h, time, callBack)
	{
		if(!_played){
			_width = _w;
			_height = _h;
			reset();
			_scope.transitionMc._width = _width;
			_scope.transitionMc._height = _height;
			_time = time;
			_start = getTimer();
			_int = setInterval(renderTransition, 10, callBack);
			_played = true;
		}else{
			_mask._x	= -974;
			_played = false	;
		}

	}
	
	
	private static function renderTransition(c)
	{
		var logos = _logos;
		var t = (getTimer() - _start) / 1000;
		var m = _scope.m;
		if (t > _time) {
			t = _time;
			c.apply();
			clearInterval(_int);
			return;
		}
		
		// animate current row
		_currRow = linear(t, 0, Math.ceil(_width/_logoWidth), _time);
		
		// refresh bitmap
		_bmpData.fillRect(new Rectangle(0, 0, _width, _height), 0x00FF0000);
		
		// moveMask
		var mStart = _width+250//774
		_mask._x	= linear(t, -974, mStart, _time);
		
		for(var i in logos)
		{
			var l = _logos[i];
			if(l.row <=_currRow){
				l.scale		+= l.scaleSpeed
				l.x 		= linear (t, l.startX, l.dest, _time)//linear(t, l.startX, l.dest, _time);
				l.y 		+= l.speedY
				l.rotation	+= l.speedR
				l.alpha 	+= l.speedA
				l.currFrame = (l.currFrame + 1 <= _logo._totalframes) ? l.currFrame + 1 : 1;
				//if(i == 0) trace("l.currFrame: "+l.currFrame)
				_logo.gotoAndStop(l.currFrame);
				_colorTransform.alphaMultiplier = l.alpha;
				
				_matrix.createBox(l.scale, l.scale, l.rotation, l.x, l.y);
				_bmpData.draw(_logo, _matrix, _colorTransform);
			}
		}
		
	}
	
	/* ============== TWEENS ======================= */
	private static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
		return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
	}
	
	
	private static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
		return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
	}
	
	private static function linear (t, b, c, d) {
		return c*t/d + b;
	}
	
	
	private static function cubicBez (t, b, c, d, p1, p2) {
		return ((t/=d)*t*c + 3*(1-t)*(t*(p2-b) + (1-t)*(p1-b)))*t + b;
	};
	
	private static function easeInBack (t, b, c, d, s) {
		if (s == undefined) s = 1.70158;
		return c*(t/=d)*t*((s+1)*t - s) + b;
	};
	
	private static function easeInExpo (t, b, c, d) {
		return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
	};
	
	
	static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
		if (t==0) return b;
		if (t==d) return b+c;
		if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
		return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
	}
	
	private static function handleError(s:String) : Void
	{
		trace("\r***\rChasilism Component: "+s+"\r***\r")
	}
	
	
	/* ============== Helpers ======================= */
	
	private static function randRange(min:Number, max:Number):Number {
	    var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
	    return randomNum;
	}
	
	/* ============== End Helpers ======================= */
	
}