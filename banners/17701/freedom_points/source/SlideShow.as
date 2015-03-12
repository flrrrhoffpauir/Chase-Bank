/* AS2

	
	@langversion ActionScript 2.0
	@playerversion Flash 8.0
	
	@author Helmut Granda
	@since  2008-11-26
	
	Copyright 2008 T3.
	
	@description
	untitled
	
*/

import gs.TweenMax;
import gs.TweenLite;
import mx.utils.Delegate;
import gs.easing.Bounce;

class SlideShow extends MovieClip {

	private var picture1 		: MovieClip;
	private var picture2 		: MovieClip;
	private var picture3 		: MovieClip;
	private var pictureHeader 	: MovieClip;
	private var picture1Body 	: MovieClip;
	private var picture2Body 	: MovieClip;
	private var picture3Body 	: MovieClip;
	private var currentPicture 	: MovieClip;
	private var currentBody 	: MovieClip;
	
	private var currentContentNumber 		: Number ;
	
		function SlideShow()
		{
			init();
		}
		
		private function init( ): Void
		{
			currentContentNumber = 0;
				
			for ( var i in this ) 
			{
				this[ i ]._alpha = 0;
			}
			
			doSlideShow();
		}
		
		private function doSlideShow ( ) : Void
		{
			currentContentNumber++;
			
			if (currentContentNumber > 3 ) currentContentNumber = 1;
			
			currentPicture 	= this[ "picture" + currentContentNumber ];
			currentBody 	= this[ "picture" + currentContentNumber + "Body" ];
			
			TweenMax.to ( currentPicture, 	1, 		{_alpha : 100 } ) ;
			TweenMax.to ( currentBody, 		0.5, 	{_alpha : 100, delay: 1.5 } ) ;
			
			TweenMax.delayedCall ( 1,	Delegate.create ( this , blurTitleIn ) ) ;
			TweenMax.delayedCall ( 5.5,	Delegate.create ( this , doSlideShow ) ) ;
			TweenMax.delayedCall ( 5, 	Delegate.create ( this , hideCurrent ) ) ;
		}
		
		private function blurTitleIn( ) : Void
		{
			pictureHeader._alpha = 100;
			TweenMax.from ( pictureHeader, 0.5, { blurFilter : { blurX : 25, quality : 3 } , ease : Bounce.easeOut } );
		}
		
		private function hideCurrent ( ) : Void
		{
			TweenMax.to ( currentPicture, 	0.5, 	{ _alpha : 0 } );
			TweenMax.to ( pictureHeader, 	0.5, 	{ _alpha : 0 } );
			TweenMax.to ( currentBody, 		0.5, 	{ _alpha : 0 } );
		}
		
}