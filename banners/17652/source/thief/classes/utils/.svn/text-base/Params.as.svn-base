/**
*     Params Class
*     Created on 2008-06-20
*
*     @langversion ActionScript 2.0
*     @playerversion 8.0
*     @since 2008-06-20                      
*     @author timmy
*     @version 1.0.0
*
*     all code copyright (c) 2008 T3 The Think Tank. All rights reserved.
*     Re-use of this code without express written permission is prohibited.
*
*     Listing of all parameters for each set of banners. 
*
*/

class classes.utils.Params
{
	// DAISY - offer 1
	public static var ID_DAISY_1:Object = { b:"daisy",o:1,utm_source:"someSite",utm_medium:"banner",utm_campaign:"utmCampaign",utm_content:"v1" };  
	
	// DAISY - offer 2
	public static var ID_DAISY_2:Object = { b:"daisy",o:2,utm_source:"someSite",utm_medium:"banner",utm_campaign:"utmCampaign",utm_content:"v1" };
	
	// DAISY - offer 3
	public static var ID_DAISY_3:Object = { b:"daisy",o:3,utm_source:"someSite",utm_medium:"banner",utm_campaign:"utmCampaign",utm_content:"v1" };
	
	
	
	// DR CASH - offer 1						
	public static var ID_DR_CASH_1:Object = { b:"dr_cash",o:1,utm_source:"someSite",utm_medium:"banner",utm_campaign:"utmCampaign",utm_content:"v1" };
	
	// DR CREDIT - offer 1
	public static var ID_DR_CREDIT_1:Object = { b:"dr_credit",o:1,utm_source:"someSite",utm_medium:"banner",utm_campaign:"utmCampaign",utm_content:"v1" };
	
	// SAND - offer 1
	public static var ID_SAND_1:Object = { b:"sand",o:1,utm_source:"someSite",utm_medium:"banner",utm_campaign:"utmCampaign",utm_content:"v1" };
									
	// SPIN CHANGE - offer 1
	public static var ID_SPIN_CHANGE_1:Object = { b:"spin_change",o:1,utm_source:"someSite",utm_medium:"banner",utm_campaign:"utmCampaign",utm_content:"v1" };


	  
	
	
	
	private static var CLASS_INSTANCE:Params = undefined;

	/**
	 *  Params Constructor
	 */
	public function Params() { };

	/**
	 *  Ensure that we only have one instance in use
	 */
	public static function getInstance():Params
	{
		// ignore warning 1012 if you see it... what is that anyway?
		if(CLASS_INSTANCE == undefined) { CLASS_INSTANCE = new Params(); } else { trace("Params instance already exists"); };
		return CLASS_INSTANCE;
	};

} // end