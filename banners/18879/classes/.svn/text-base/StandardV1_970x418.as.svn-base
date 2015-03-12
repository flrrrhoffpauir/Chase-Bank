/*******************************************************************************************************
//
// StandardV1_970x418
//  Created by ,  on 2009-09-16.
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


import gs.TweenLite;
import utils.Proxy;
import gs.easing.Sine;

class StandardV1_970x418 extends Engine {
	
	//var clickTAG:String = "http://www.inkfromchase.com";
	

	private function StandardV1_970x418 ( scope ) {
		super(scope);
		
		scope["closeBtn"].onRelease = Proxy.create  ( this, onCloseHandler ) ;
	}
	
	public static function create(scope:MovieClip) {
		
		instance = new StandardV1_970x418(scope);
		return instance;
	}

	// O V E R W R I T E
	
	private function finalFrame ( ) : Void {
	
		moveOffScreen ( introducingEnd, "top", true );
		//blurItem(introducingCard, 30, 0)
		TweenLite.to ( introducingEnd, 0.3, { 	_y : objectRecorder["introducingEndY"], 
													ease:Sine.easeIn,
													delay: 2.5,
													onComplete: Proxy.create( this, introCardEnd )
													 });
						/*							
								TweenLite.to ( inkLogo, 0.7, { 	_x : -inkLogo._width, 
																			blurFilter:{blurX:30, blurY: 0,remove:true},
																			ease:Sine.easeIn,
																			delay: 1.8
																			 });*/
		
		

	}
	
	private function introCreditLimitsThat ( ) : Void {
		creditLimitsThat._y = creditLimitsThat._y - (creditLimitsThat._height + 10 );
		creditLimitsThat._alpha = 0;
		TweenLite.to ( creditLimitsThat, 0.5, { _alpha : 100, 
												_y : objectRecorder["creditLimitsThatY"], 
												ease:Sine.easeOut,
												delay: 0.2,
												onComplete : Proxy.create ( this, introWriteYourOwn)
												});	
	}
	
	private function introWriteYourOwn ( ) : Void {
		
		writeYourOwn._xscale = 150;
		writeYourOwn._yscale = 150;
		writeYourOwn._alpha = 0;
		TweenLite.to ( writeYourOwn, 0.2, { _alpha : 100, 
													_xscale : 100,
													_yscale : 100,
													ease:Sine.easeOut,
													delay: 0.2,
													onComplete : Proxy.create ( this, introLearnMore)
													 });
	}
	
	private function introLearnMore ( ) : Void {
		learnMore._alpha = 0;
		
		moveOffScreen( learnMore, "bottom", true)
		TweenLite.to ( learnMore, 0.5, { _alpha : 100, 
											_y : objectRecorder["learnMoreY"], 
											ease:Sine.easeOut,
											delay: 0.2,
											onComplete : Proxy.create ( this, activateCTA)
											});
	}
	
	private function onCloseHandler ( ) : Void {
		//getURL(_urlTarget, "_blank");
		trace("close clicked")
	}


}