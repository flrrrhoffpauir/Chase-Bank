/******************************************************************************************************

AbstractController

//  Created by David Dinh                   ffLL                                      LLGG
//  Sr. Rich Media Designer               LL######EEtt                            ..KK##DD
//  on 2007-05-16.                      ii############KK;;                        GG##LL..
//  Copyright (c) 2007 __T3__.          ..EE##############ff                    iiWW;;
//  All rights reserved.                  ....DD############GG                  GGii
                                       LL#####################KK::            ;;EE
                  888    888           GGDDLL#######EE##########WWii          EEtt
                  888    888                    ;;;;  tt############EEttiiiiKKKK
                  888    888                            ;;KK################KK..
88888b.   8888b.  888888 888888 .d88b.  888d888 88888b.     ..ttffLLWW######KK
888 "88b     "88b 888    888   d8P  Y8b 888P"   888 "88b            ..KK######;;
888  888 .d888888 888    888   88888888 888     888  888              ;;######tt 
888 d88P 888  888 Y88b.  Y88b. Y8b.     888     888  888                EE####LL
88888P"  "Y888888  "Y888  "Y888 "Y8888  888     888  888                ;;####LL 
888                                                                       LL##DD
888   88888b.  888  888 88888b.d88b.   8888b.                               LL##LL
888   888 "88b 888  888 888 "888 "88b     "88b                                LL##      
      888  888 888  888 888  888  888 .d888888                                jj##tt
      888 d88P Y88b 888 888  888  888 888  888                                ii##tt    
      88888P"   "Y88888 888  888  888 "Y888888                                  tt;;
      888                                      
      888                                      
      888

******************************************************************************************************/

package com.t3.mvc.abstract{

	// I N C L U D E S
	import com.t3.mvc.interfaces.*;
	//import application.mvc.*;

	/**
	* AbstractController is the abstract class instantiation of th Controller interface.
	* 
	*/
	public class AbstractController implements Controller {

		// P R O P E R T I E S

		private var _model	:AbstractModel; // A reference to the model.
		private var _view	:AbstractView; // A reference to the view.
		

		// C O N S T R U C T O R

		public function AbstractController (m:AbstractModel) {
			// Set the model.
			_model = m;
		}

		// G E T T E R S  &  S E T T E R S

		public function set model (m:AbstractModel):void {
			_model = m;
		}

		public function get model ():AbstractModel {
			return _model;
		}

		public function set view (v:AbstractView):void {
			_view = v;
		}

		public function get view ():AbstractView {
			return _view;
		}
				
		
		// M E T H O D S

				
		// L I S T E N E R S


	}
}
