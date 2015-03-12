
// MatchPoints.as
// Created by Junie Threatt
// on 08-19-2008

import classes.utils.EventManager;
import classes.controllers.MatchPointsController;

class classes.views.MatchPoints extends MovieClip {
	
	// private properties
	private var _scope:MovieClip;
	//*
	private var _prodArray:Array = [{ id:0, 	prod:"DESIGNER DOG COLLAR", 		points:"3,200", 	py:14, imgx:30, imgy:-277, tSize:13 },
					{ id:1, 	prod:"CASHMERE\nSWEATER", 		points:"9,500", 	py:14, imgx:15, imgy:-258, tSize:13 },
					{ id:2, 	prod:"VINTAGE\nMARY JANES", 		points:"5,800", 	py:14, imgx:22, imgy:-256, tSize:13 },
					{ id:3, 	prod:"CHEETAH PRINT PUMPS", 		points:"11,500", 	py:14, imgx:18, imgy:-247, tSize:13 },
					{ id:4, 	prod:"1982 MERLOT", 			points:"19,500", 	py:20, imgx:68, imgy:-281, tSize:13 },
					{ id:5, 	prod:"GOLD BRACELET", 			points:"15,900", 	py:20, imgx:10, imgy:-222, tSize:13 },
					{ id:6, 	prod:"LUXURIOUS\nSPA DAY", 		points:"65,000", 	py:14, imgx:38, imgy:-263, tSize:13 },
					{ id:7, 	prod:"1 WEEK WITH\nPERSONAL TRAINER", 	points:"42,000", 	py:14, imgx:2, imgy:-279, tSize:12 },
					{ id:8, 	prod:"CROCODILE\nHANDBAG", 		points:"32,000", 	py:14, imgx:33, imgy:-278, tSize:13 },
					{ id:9, 	prod:"7-NIGHT CRUISE\nTO CARIBBEAN", 	points:"169,900", 	py:14, imgx:4, imgy:-236, tSize:13 },
					{ id:10, 	prod:"14K SOLID\nGOLD WATCH", 		points:"250,000", 	py:14, imgx:12, imgy:-227, tSize:13 },
					{ id:11, 	prod:"FAINTING COUCH", 			points:"199,500", 	py:20, imgx:-15, imgy:-239, tSize:13 },
					{ id:12, 	prod:"PRIVATE JET NY\nTO MIAMI", 	points:"890,000", 	py:14, imgx:-12, imgy:-237, tSize:13 },
					{ id:13, 	prod:"5-CARAT BLUE SAPPHIRE RING", 	points:"949,000", 	py:14, imgx:33, imgy:-223, tSize:13 },
					{ id:14, 	prod:"CLASSIC 1960s SCOOTER", 		points:"620,000", 	py:14, imgx:20, imgy:-277, tSize:13 }];
	//*/
	/*				
	private var _prodArray:Array = [{ id:0, 	prod:"DESIGNER DOG COLLAR", 		points:"3,200", 	py:14, imgx:30, imgy:-277 },
					{ id:1, 	prod:"CASHMERE SWEATER", 		points:"9,500", 	py:14, imgx:15, imgy:-258 },
					{ id:2, 	prod:"VINTAGE MARY JANES", 		points:"5,800", 	py:14, imgx:22, imgy:-256 },
					{ id:3, 	prod:"CHEETAH PRINT PUMPS", 		points:"11,500", 	py:14, imgx:18, imgy:-247 },
					{ id:4, 	prod:"1982 MERLOT", 			points:"19,500", 	py:20, imgx:68, imgy:-281 },
					{ id:5, 	prod:"GOLD BRACELET", 			points:"15,900", 	py:20, imgx:10, imgy:-222 },
					{ id:6, 	prod:"LUXURIOUS SPA DAY", 		points:"65,000", 	py:14, imgx:38, imgy:-263 },
					{ id:7, 	prod:"1 WEEK WITH PERSONAL TRAINER", 	points:"42,000", 	py:14, imgx:2, imgy:-279 },
					{ id:8, 	prod:"CROCODILE HANDBAG", 		points:"32,000", 	py:14, imgx:33, imgy:-278 },
					{ id:9, 	prod:"7-NIGHT CRUISE TO CARIBBEAN", 	points:"169,900", 	py:14, imgx:4, imgy:-236 },
					{ id:10, 	prod:"14K SOLID GOLD WATCH", 		points:"250,000", 	py:14, imgx:12, imgy:-227 },
					{ id:11, 	prod:"FAINTING COUCH", 			points:"199,500", 	py:20, imgx:-15, imgy:-239 },
					{ id:12, 	prod:"PRIVATE JET NY TO MIAMI", 	points:"890,000", 	py:14, imgx:-12, imgy:-237 },
					{ id:13, 	prod:"5-CARAT BLUE SAPPHIRE RING", 	points:"949,000", 	py:14, imgx:33, imgy:-223 },
					{ id:14, 	prod:"CLASSIC 1960s SCOOTER", 		points:"620,000", 	py:14, imgx:20, imgy:-277 }];
	//*/				
	private var _prodSectArray:Array = [];		// holds an array of 3 products based on the current section
	private var _nextProdSectArray:Array = [];	// holds an array of the next 3 products based on the current section
	private var _controller:MatchPointsController;	// reference to controller
	
	// static properties
	
	// constructor
	public function MatchPoints(scope:MovieClip, controller) {
				
		_scope = scope;
		_controller = controller;
			
		// initTags();
		// initProducts();
		
		set0();
		set1();
	}
	
	public function set0():Void { initTags(); initProducts(); };
	
	public function set1():Void { initNextProducts(_controller.getSectionId()); };
	
	// gives tags id, handlers, and other information
	private function initTags():Void {
		
		var mc:MovieClip;
		
		for(var i:Number = 0; i < 3; i++) {
			
			mc = _scope["tag"+i];
			
			// give each one an id
			mc.id = i;
			
			// and original placements
			mc.ox = mc._x;
			mc.oy = mc._y;
			
			// add property to track if tag is being dragged left or right
			mc.xdir = 0;
			
			// set handlers
			setHandlers(mc);
			
		}
		
		// set tag text
		// pass in section id
		setText(_controller.getSectionId());
	}
	
	// sets the text of the tags only
	private function setText(sectionId:Number):Void {
		
		var mc:MovieClip;
				
		// get 3 indexes based on sectionId
		_prodSectArray = _prodArray.slice(sectionId, sectionId+3);
		
		// copy that array for splicing
		var dupeArray:Array = _prodSectArray.slice();
		var tempArray:Array = [];
				
		for(var i:Number = 0; i < 3; i++) {
			
			mc = _scope["tag"+i];
			
			// splice random index from array and set tag text
			tempArray = dupeArray.splice(randomRange(0, dupeArray.length), 1);
	 		mc.t.text = tempArray[0].points;
	        	
			// also give it the id from tempArray
			mc.prodid = tempArray[0].id;
		}
	}
	
	// sets text of product display panels (prodDisplay)
	private function initProducts():Void {
		
		var dmc:MovieClip;		// display mc
		var pmc:MovieClip;		// pillar mc
		
		var dupeArray:Array = _prodSectArray.slice();
		var tempArray:Array = [];
				
		for(var i:Number = 0; i < 3; i++) {
			
			dmc = _scope["prodDisplay"+i].screen;
			pmc = _scope["pillar"+i];
			
			// splice random index from array and set display product id
			tempArray = dupeArray.splice(randomRange(0, dupeArray.length), 1);
			dmc.prodid = tempArray[0].id;
			
			// assign products text appropriately
			dmc.t.text = tempArray[0].prod;
			dmc.t.embedFonts = true;
			dmc.t.setTextFormat(createTextFormat(tempArray[0].tSize));
			
			// adjust placement of textfield
			dmc.t._y = tempArray[0].py;
			
			// assign image to pillar
			pmc.attachMovie("prod"+tempArray[0].id, "prod", pmc.getNextHighestDepth(), { _x:tempArray[0].imgx, _y:tempArray[0].imgy });
		}
		
	}
	
	
	// pretty much same function as above, but reassigns _prodSectArray and has a different loop
	// might change in the future, but quick fix for now
	private function initNextProducts(sectionId:Number):Void {

		// increment to next section
		sectionId += 3;
		
		var dmc:MovieClip	// display mc;
		var pmc:MovieClip	// pillar mc;
		
		// get 3 indexes based on sectionId
		_prodSectArray = _prodArray.slice(sectionId, sectionId+3);
		
		// copy that array for splicing
		var dupeArray:Array = _prodSectArray.slice();
		var tempArray:Array = [];
				
		_nextProdSectArray = [];
		
		for(var i:Number = 3; i < 6; i++) {
			
			dmc = _scope["prodDisplay"+i].screen;
			pmc = _scope["pillar"+i];
			
			// splice random index from array and set display product id
			tempArray = dupeArray.splice(randomRange(0, dupeArray.length), 1);
			dmc.prodid = tempArray[0].id;
			
			// assign products text appropriately
			dmc.t.text = tempArray[0].prod;
			dmc.t.embedFonts = true;
			dmc.t.setTextFormat(createTextFormat(tempArray[0].tSize));
			
			// adjust placement of textfield
			dmc.t._y = tempArray[0].py;
			
			// assign image to pillar
			pmc.attachMovie("prod"+tempArray[0].id, "prod", pmc.getNextHighestDepth(), { _x:tempArray[0].imgx, _y:tempArray[0].imgy });
			
			// push into array so we can keep track of the next section
			// used for switching product pillars
			_nextProdSectArray.push(tempArray[0]);
		}
	}
	
	// ... formats prodDisplay text
	public function createTextFormat(tSize:Number):TextFormat {
		
		var ls:Number = (tSize == 13) ? 2 : 1.5;
		
		var tFormat = new TextFormat();
		tFormat.font = "digital";
		tFormat.size = tSize;
		tFormat.bold = true;
		tFormat.leading = -2;
		tFormat.letterSpacing = ls;
		
		return tFormat;
	}
	
	public function setHandlers(mc:MovieClip):Void {
		mc.onRollOver = function():Void { EventManager.dispatchEvent("onTagRollOver", { id:this.id }); };
		mc.onRollOut = function():Void { EventManager.dispatchEvent("onTagRollOut", { id:this.id }); };
		mc.onPress = function():Void { EventManager.dispatchEvent("onTagPress", { id:this.id }); };
		mc.onRelease = function():Void { EventManager.dispatchEvent("onTagRelease", { id:this.id }); };
		mc.onReleaseOutside = function():Void { EventManager.dispatchEvent("onTagRelease", { id:this.id }); };
	}
	
	private function randomRange(min:Number, max:Number):Number { return Math.floor(Math.random() * (max - min)) + min; };
}