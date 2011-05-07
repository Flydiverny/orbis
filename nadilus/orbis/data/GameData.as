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
		private var game:OrbisGame
		private var blockTypes:Object
		private var gameLevels:Array
		
		public function GameData(game:OrbisGame)
		{
			this.game = game;
			this.gameLevels = new Array();
			this.blockTypes = new Object();
		}
		
		public function loadAndParseXml():void
		{
			var xmlString:String = loadXml();
			parse(xmlString);
		}
		
		private function loadXml():String
		{
			var byteArray:ByteArray = new OrbisXmlData();
			return byteArray.toString(); 
		}
		
		private function parse(xmlString:String):void
		{
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
								var blockTypeData:BlockTypeData = blockTypeNode.constructFromXmlNodeAttributes(blockTypeNode.attributes);
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
								var gameLevelData:GameLevelData = GameLevelData.constructFromXmlNode(levelNode);
								this.gameLevels.push(gameLevelData);
							}
							levelNode = levelNode.nextSibling;
						}
					}
					xmlNode = xmlNode.nextSibling;
				}
			}
			game.runGameStartScreen();
		}
	}
}