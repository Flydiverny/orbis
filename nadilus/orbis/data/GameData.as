package nadilus.orbis.data
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	
	import nadilus.orbis.game.OrbisGame;
	
	public class GameData
	{
		private var game:OrbisGame;
		private var blockTypes:Object;
		private var gameLevels:Array;
		private var xmlFileName:String;
		
		private var xml:XML;
		
		public function GameData(game:OrbisGame, xmlFileName:String)
		{
			this.game = game;
			this.gameLevels = new Array();
			this.blockTypes = new Object();
			this.xmlFileName = xmlFileName;
		}
		
		public function loadAndParseXml():void
		{
			readXML();
		}
		
		private function readXML():void {
			var loader:URLLoader = new URLLoader(new URLRequest(xmlFileName));
			loader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		private function xmlLoaded(e:Event):void {
			trace("XML Loaded from: " + xmlFileName);
			xml = new XML(e.target.data);
			trace(xml.toXMLString());
			parse(xml.toXMLString());
		}
		
		private function parse(xmlString:String):void
		{
			trace("Begin parsing XML.");
			var xmlDocument:XMLDocument = new XMLDocument();
			xmlDocument.parseXML(xmlString);
			
			var xmlNode:XMLNode = xmlDocument.firstChild;
			if (xmlNode.nodeName == "Orbis")
			{
				xmlNode = xmlNode.firstChild;
				while (xmlNode != null)
				{
					if (xmlNode.nodeName == "BlockTypes")                    
					{
						var blockTypeNode:XMLNode = xmlNode.firstChild;
						while (blockTypeNode != null)
						{
							if (blockTypeNode.nodeName == "BlockType")
							{
								var symbol:String = blockTypeNode.attributes.Symbol;
//								var blockTypeData:BlockTypeData = blockTypeNode.constructFromXmlNodeAttributes(blockTypeNode.attributes);
								this.blockTypes[symbol] = blockTypeNode;
							}
							blockTypeNode = blockTypeNode.nextSibling;
						}
					}
					if (xmlNode.nodeName == "Levels")
					{
						var levelNode:XMLNode = xmlNode.firstChild;
						while (levelNode != null)
						{
							if (levelNode.nodeName == "Level")
							{
								//var gameLevelData:GameLevelData = GameLevelData.constructFromXmlNode(levelNode);
								//this.gameLevels.push(gameLevelData);
							}
							levelNode = levelNode.nextSibling;
						}
					}
					xmlNode = xmlNode.nextSibling;
				}
			}
			//game.runGameStartScreen();
		}
	}
}