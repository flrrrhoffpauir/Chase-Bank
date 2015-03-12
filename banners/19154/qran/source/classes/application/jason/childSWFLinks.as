﻿package application.jason{	// import flash	import flash.display.*;	import flash.events.*;	import flash.external.*;    import flash.utils.*;	import flash.net.URLRequest;	import flash.net.navigateToURL;		public class childSWFLinks {		public var _linkarray:Array;		public function childSWFLinks(){			}				public static function tokenArrayReplace(rPath:String, rAI:String, childXML:XML, childArray:Array){			var la:Array = new Array();			var region:String;						// Set path to region			switch(rPath){				case "https://chaseonlineq3.chase.com/":					region = "QA_Domain";					break;								case "https://chaseonlineq5.chase.com/":					region = "Breakfix_Domain";					break;								case "https://chaseonline.chase.com/":					region = "PROD_Domain";					break;									default:					region = "QA_Domain";					break;			}						//switch set la with token			switch(region){				case "QA_Domain":					la[0] = childXML.vender_links.QA_Domain.LoyaltySecureRoot.text();					la[1] = childXML.vender_links.QA_Domain.LoyaltyReardenRoot.text();					la[2] = childXML.vender_links.QA_Domain.LoyaltyCLSRoot.text();					la[3] = childXML.vender_links.QA_Domain.LoyaltyMallNetworksRoot.text();					la[4] = childXML.vender_links.QA_Domain.LoyaltyB2SRoot.text();					la[5] = childXML.vender_links.QA_Domain.LoyaltyTruitionRoot.text();					break;								case "Breakfix_Domain":					la[0] = childXML.vender_links.Breakfix_Domain.LoyaltySecureRoot.text();					la[1] = childXML.vender_links.Breakfix_Domain.LoyaltyReardenRoot.text();					la[2] = childXML.vender_links.Breakfix_Domain.LoyaltyCLSRoot.text();					la[3] = childXML.vender_links.Breakfix_Domain.LoyaltyMallNetworksRoot.text();					la[4] = childXML.vender_links.Breakfix_Domain.LoyaltyB2SRoot.text();					la[5] = childXML.vender_links.Breakfix_Domain.LoyaltyTruitionRoot.text();					break;								case "PROD_Domain":					la[0] = childXML.vender_links.PROD_Domain.LoyaltySecureRoot.text();					la[1] = childXML.vender_links.PROD_Domain.LoyaltyReardenRoot.text();					la[2] = childXML.vender_links.PROD_Domain.LoyaltyCLSRoot.text();					la[3] = childXML.vender_links.PROD_Domain.LoyaltyMallNetworksRoot.text();					la[4] = childXML.vender_links.PROD_Domain.LoyaltyB2SRoot.text();					la[5] = childXML.vender_links.PROD_Domain.LoyaltyTruitionRoot.text();					break;							}						/**********************************************				set up patterns for token replace			**********************************************/			var LoyaltySecureRoot:String = "%LoyaltySecureRoot%";			var LoyaltyReardenRoot:String = "%LoyaltyReardenRoot%";			var LoyaltyCLSRoot:String = "%LoyaltyCLSRoot%";			var LoyaltyMallNetworksRoot:String = "%LoyaltyMallNetworksRoot%";			var LoyaltyB2SRoot:String = "%LoyaltyB2SRoot%";			var LoyaltyTruitionRoot:String = "%LoyaltyTruitionRoot%";						var LoyaltySecureRootPattern:RegExp = new RegExp(LoyaltySecureRoot);			var LoyaltyReardenRootPattern:RegExp = new RegExp(LoyaltyReardenRoot);			var LoyaltyCLSRootPattern:RegExp = new RegExp(LoyaltyCLSRoot);			var LoyaltyMallNetworksRootPattern:RegExp = new RegExp(LoyaltyMallNetworksRoot);			var LoyaltyB2SRootPattern:RegExp = new RegExp(LoyaltyB2SRoot);			var LoyaltyTruitionRootPattern:RegExp = new RegExp(LoyaltyTruitionRoot);						var childSplit:Array;			for(var e:int = 0; e < childArray.length; e++){												if(childArray[e].length == 1)					childSplit = childArray[e][0].split(/Root/);				else					childSplit = childArray[e].split(/Root/);								switch(childSplit[0]){					case "%LoyaltySecure":						childArray[e] = paramTest(childArray[e].replace(LoyaltySecureRootPattern, la[0]), rAI);						break;										case "%LoyaltyRearden":						childArray[e] = paramTest(childArray[e].replace(LoyaltyReardenRootPattern, la[1]), rAI);						break;										case "%LoyaltyCLS":						childArray[e] = paramTest(childArray[e].replace(LoyaltyCLSRootPattern, la[2]), rAI);						break;										case "%LoyaltyMallNetworks":						childArray[e] = paramTest(childArray[e].replace(LoyaltyMallNetworksRootPattern, la[3]), rAI);						break;										case "%LoyaltyB2S":						childArray[e] = paramTest(childArray[e].replace(LoyaltyB2SRootPattern, la[4]), rAI);						break;										case "%LoyaltyTruition":						childArray[e] = paramTest(childArray[e].replace(LoyaltyTruitionRootPattern, la[5]), rAI);						break;											default:												break;									}						}						return childArray;		}		public static function paramTest(e:String, rAI:String):String {		var aiUrl:String;		if(e.indexOf('?',0) != -1)			aiUrl = e + "&AI=" + rAI;		else if(e.charAt(e.length-1) == '/')			aiUrl = e;		else			aiUrl = e + "?AI=" + rAI;				return aiUrl;		}			}//class	}///package		