/**
 *	all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
 *	Re-use of this code without express written permission is prohibited.
 */

package application.events
{
	import flash.events.Event;

	public class PanelEvent extends Event
	{
		public static const PAUSE_SHOW:String = "onItemRollOver";
		public static const RESUME_SHOW:String = "onItemRollOut";
		
		public var _data:*;

		public function PanelEvent(type:String, data:*=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		};

		public function get data():* { return _data; };

		override public function clone():Event { return new PanelEvent(type, _data, bubbles, cancelable); };
		
		override public function toString():String { return formatToString("PanelEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); };
		
	};
	
};


