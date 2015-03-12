/*******************************************************************************************************
//
// AccessibilityView
//  Created by ,  on 2009-05-19.
//  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
//
//                                             ffLL                                      LLGG
//                                           LL######EEtt                            ..KK##DD
//                                         ii############KK;;                        GG##LL..
//                                         ..EE##############ff                    iiWW;;
//                                           ....DD############GG                  GGii
//                                         LL#####################KK::            ;;EE
//                    888    888           GGDDLL#######EE##########WWii          EEtt
//                    888    888                    ;;;;  tt############EEttiiiiKKKK
//                    888    888                            ;;KK################KK..
//  88888b.   8888b.  888888 888888 .d88b.  888d888 88888b.     ..ttffLLWW######KK
//  888 "88b     "88b 888    888   d8P  Y8b 888P"   888 "88b            ..KK######;;
//  888  888 .d888888 888    888   88888888 888     888  888              ;;######tt 
//  888 d88P 888  888 Y88b.  Y88b. Y8b.     888     888  888                EE####LL
//  88888P"  "Y888888  "Y888  "Y888 "Y8888  888     888  888                ;;####LL 
//  888                                                                       LL##DD
//  888   88888b.  888  888 88888b.d88b.   8888b.                               LL##LL
//  888   888 "88b 888  888 888 "888 "88b     "88b                                LL##      
//        888  888 888  888 888  888  888 .d888888                                jj##tt
//        888 d88P Y88b 888 888  888  888 888  888                                ii##tt    
//        88888P"   "Y88888 888  888  888 "Y888888                                  tt;;
//        888                                      
//        888                                      
//        888
//  
//	Description:
//
//	Public Methods:
//
******************************************************************************************************/

package com.t3.application{
	// I N C L U D E S
	import com.t3.mvc.abstract.*;
	import com.t3.mvc.events.DataEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import gs.TweenFilterLite;

	public class AccessibilityView extends AbstractView{

		// P R O P E R T I E S
		private var _setup					:Object;
		private var _stage					:MovieClip;
		private var _content				:Sprite;		


		// C O N S T R U C T O R

		public function AccessibilityView(m:AbstractModel, c:AbstractController, setupObj:Object){
			super(m,c);
			_setup = setupObj;	
			_stage = setupObj.scope;
			_content = _stage._content_mc
			_content.mouseEnabled = false;
			_content.buttonMode = false;
			with(_content.graphics){
				beginFill(0xff00ff, .5);
				moveTo(0,0);
				lineTo(370,0);
				lineTo(370,240);
				lineTo(0,240);
				lineTo(0,0);
			}				
		}

		// G E T T E R S  &  S E T T E R S
		
		
		// M E T H O D S

				
		// L I S T E N E R S
		public override function start(evt:DataEvent):void {
			
					
		}
		
		public override function updated(evt:DataEvent):void{
			
		}
		

	}
}