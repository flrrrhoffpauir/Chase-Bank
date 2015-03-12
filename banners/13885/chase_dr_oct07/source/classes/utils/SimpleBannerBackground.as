﻿/** *	SimpleBannerBackground Class, Created 2007-10-01 *	Copyright (c) 2007 T3. All rights reserved. * *	Used to set the background for a banner. A MovieClip *  instance containing a vector rectangle should be passed *  to the Class constructor. Invoke the makeBackground() *  method to size and set the color of the background. If *  no background color is passed, the dafault is #FFFFFF. * *	@author Timothy Harold *	@version 1.0 *	*/class classes.utils.SimpleBannerBackground{	// static properties			// private properties	private var __backgroundClip:MovieClip;	private var __colorObj:Color;		// public properties				// Class constructor	/**	 * Invoke the makeBackground() method to set the dimensions of the banner's	 * background. Requires a MovieClip instance that contains a vector rectangle	 * embedded. The makeBackground() method will set the color via a passed	 * parameter, the dimensions are based on the banner's Stage.width and	 * Stage.height.	 * <p>	 * The Color Object has been implemented using the setRGB() method for	 * backwards compatibility with FP6.	 *	 * @params _targetClip The MovieClip that contains the vector background.	 */	function SimpleBannerBackground(_backgroundClip:MovieClip)	{				// reference for the target background MovieClip		__backgroundClip = _backgroundClip;				// create a Color object (FP6 friendly)		__colorObj = new Color(__backgroundClip);	}				// private methods  ------------------------------------------------------------------------------			// public methods  -------------------------------------------------------------------------------	/**	 * Requires a MovieClip instance that contains a vector rectangle embedded.	 * The makeBackground() method will set the color via a passed parameter,	 * the dimensions are based on the banner's Stage.width and Stage.height.	 *	 * @param _rgb A hex value specifying the fill color. Default is #FFFFFF.	 */	public function makeBackground(_rgb:Number):Void	{				// grab the Stage width and height		var backWidth:Number = Stage.width;		var backHeight:Number = Stage.height;				// set the dimensions		__backgroundClip._width = backWidth;		__backgroundClip._height = backHeight;				// default to black if hex is not passed		var color:Number = (_rgb == undefined || _rgb == null) ? 0xFFFFFF : _rgb;				// set the color of the background		__colorObj.setRGB(color);				// set to 0, 0		__backgroundClip._x = __backgroundClip._y = 0;	}		// handlers/listeners  ---------------------------------------------------------------------------					// end}