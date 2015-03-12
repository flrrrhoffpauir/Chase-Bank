/**
*      ThumbContainer Class
*      Created on 2008-09-12
*
*      @langversion ActionScript 2.0
*      @playerversion 8.0
*      @since 2008-09-12
*
*      all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*      Re-use of this code without express written permission is prohibited.
*
*      The container for the ThumbHolders
*
*/

import events.Events;
import events.EventManager;

class views.ThumbContainer extends MovieClip {
	
	private var _totalThumbs:Number = 5;
	
	public function ThumbContainer() {EventManager.addEventListener(Events.SCROLLER_LOAD_THUMBS, this, "addThumbs"); };
	
	private function addThumbs(o:Object):Void {
		
		// attaches initial thumbs to thumb container

		removeThumbs();
		
		var xpos:Number = 0;
		var spacer:Number = 68;
		var currThumb:Number = o.data.id;
		var prevThumb:Number = (currThumb == 0) ? _totalThumbs - 1 : currThumb - 1;
		var nextThumb:Number = (currThumb == _totalThumbs - 1) ? 0 : currThumb + 1;
		
		EventManager.dispatchEvent(Events.SCROLLER_STORE_THUMBS, { id:0, ct:currThumb, pt:prevThumb, nt:nextThumb });
		
		this.attachMovie("mcThumb"+prevThumb, "mcThumb"+prevThumb, this.getNextHighestDepth(), { _x:0, _y:0, id:prevThumb });
		this.attachMovie("mcThumb"+currThumb, "mcThumb"+currThumb, this.getNextHighestDepth(), { _x:0+spacer, _y:0, id:currThumb });
		this.attachMovie("mcThumb"+nextThumb, "mcThumb"+nextThumb, this.getNextHighestDepth(), { _x:0+spacer*2, _y:0, id:nextThumb });
		
		// select the current thumb
		this["mcThumb"+currThumb].selector._alpha = 100;
		// this["mcThumb"+currThumb].enabled = false;
	}
	
	
	private function removeThumbs():Void {
		for(var i:Number = 0; i < _totalThumbs; i++) {
			this["mcThumb"+i].removeMovieClip();
		}
	}
}
