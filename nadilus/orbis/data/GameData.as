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
	import nadilus.orbis.data.BlockType;
	
	public class GameData
	{
		private var game:OrbisGame;
		private var blockTypes:Object;
		private var gameLevels:Array;
		
		[Embed(source="Orbis.xml", mimeType="application/octet-stream")]
		protected const OrbisXMLData:Class;
		
		private var xml:XML;
		
		public function GameData(game:OrbisGame) {
			this.game = game;
			this.gameLevels = new Array();
			this.blockTypes = new Object();
		}
		
		public function loadAndParseXml():void {
			trace("GameData: loadAndParseXml(): Called");
			var byteArray:ByteArray = new OrbisXMLData();
			xml = new XML(byteArray.toString());
			trace("GameData: loadAndParseXml(): XML Loaded.");
			//trace(xml.toXMLString());
			parse(xml.toXMLString());
		}
		
		private function parse(xmlString:String):void {
			trace("GameData: parse(): Begin parsing XML.");
			var xmlDocument:XMLDocument = new XMLDocument();
			xmlDocument.parseXML(xmlString);
			
			var xmlNode:XMLNode = xmlDocument.firstChild;
			trace("GameData: parse(): First Node: " + xmlNode.nodeName);
			if (xmlNode.nodeName == "Orbis") {
				
				trace("GameData: parse(): Orbis node found");
				xmlNode = xmlNode.firstChild;
				
				while (xmlNode != null) {
					if (xmlNode.nodeName == "BlockTypes") {
						trace("GameData: parse(): Block types found");
						readBlockTypes(xmlNode);
					}
					
					if (xmlNode.nodeName == "Levels") {
						trace("GameData: parse(): Levels found");
						readLevelNodes(xmlNode);
					}
					xmlNode = xmlNode.nextSibling;
				}
			}
			//game.runGameStartScreen();
		}
		
		private function readBlockTypes(xmlNode:XMLNode):void
		{
			trace("GameData: readBlockTypes(): Called");
			var blockTypeNode:XMLNode = xmlNode.firstChild;
			while (blockTypeNode != null)
			{
				if (blockTypeNode.nodeName == "BlockType") {
					trace("GameData: readBlockTypes(): Reading BlockType: " + blockTypeNode.attributes.Symbol);
					var symbol:String = blockTypeNode.attributes.Symbol;
					var blockType:BlockType = BlockType.constructFromXmlNode(blockTypeNode.attributes);
					this.blockTypes[symbol] = blockTypeNode;
				}
				
				blockTypeNode = blockTypeNode.nextSibling;
			}
		}
		
		private function readLevelNodes(xmlNode:XMLNode):void
		{
			trace("GameData: readLevelNodes(): Called");
			var levelNode:XMLNode = xmlNode.firstChild;
			while (levelNode != null)
			{
				if (levelNode.nodeName == "Level")
				{
					trace("GameData: readLevelNodes(): Reading Level");
					//var gameLevelData:GameLevelData = GameLevelData.constructFromXmlNode(levelNode);
					//this.gameLevels.push(gameLevelData);
				}
				levelNode = levelNode.nextSibling;
			}
		}
	}
}