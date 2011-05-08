package nadilus.orbis.data
{
	import flash.xml.XMLNode;
	
	import nadilus.orbis.Utilities;

	public class Level
	{
		private var scoreToWin:uint;
		private var initialOrbCount:uint;
		private var maximumOrbsToLose:uint;
		private var specialsCount:uint;

		private var blocks:Array;
		
		private var special_SpeedUp:Boolean;
		private var special_SpeedDown:Boolean;
		private var special_OrbSplit:Boolean;
		
		public function Level()
		{
			this.scoreToWin			= 1;
			this.initialOrbCount	= 1;
			this.maximumOrbsToLose	= 1;
			this.specialsCount		= 1;
			
			this.blocks				= new Array();
			
			this.special_SpeedUp	= true;
			this.special_SpeedDown	= true;
			this.special_OrbSplit	= true;
		}
		
		public static function constructFromXmlNode(node:XMLNode):Level {
			trace("Level: constructFromXmlNode(): Called");
			var level:Level = new Level();
			
			if(node.attributes.ScoreToWin != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: ScoreToWin");
				level.scoreToWin = node.attributes.ScoreToWin;
			}
			
			if(node.attributes.InitialOrbCount != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: InitialOrbCount");
				level.initialOrbCount = node.attributes.InitialOrbCount;
			}
			
			if(node.attributes.MaximumOrbsToLose != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: MaximumOrbsToLose");
				level.maximumOrbsToLose = node.attributes.MaximumOrbsToLose;
			}
			
			if(node.attributes.SpecialsCount != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: SpecialsCount");
				level.specialsCount = node.attributes.SpecialsCount;
			}
			
			// Loop thru all ChildNodes and look for BlockLines and/or SpecialsPool
			for each(var childNode:XMLNode in node.childNodes) {
				if(childNode.localName == "BlockLines") {
					trace("Level: constructFromXmlNode(): BlockLines found");
					for each(var blockLine:XMLNode in childNode.childNodes) {
						if(blockLine.localName == "BlockLine") {
							var blockSymbols:String = blockLine.attributes.Blocks;
							
							var blocksArray:Array = new Array();
							
							for(var i:uint = 0; i < blockSymbols.length; i++) {
								blocksArray.push(blockSymbols.charAt(i));
							}
							
							level.blocks.push(blocksArray);
							trace("Level: constructFromXmlNode(): BlockLine added: " + blockSymbols);
						}
					}
				}
				
				if(childNode.localName == "SpecialsPool") {
					trace("Level: constructFromXmlNode(): SpecialsPool found");
					
					if(childNode.attributes.SpeedUp != null) {
						trace("Level: constructFromXmlNode(): SpecialsPool: Attribute Found: SpeedUp");
						level.special_SpeedUp = Utilities.parseBoolean(childNode.attributes.SpeedUp);
					}
					
					if(childNode.attributes.SpeedDown != null) {
						trace("Level: constructFromXmlNode(): SpecialsPool: Attribute Found: SpeedDown");
						level.special_SpeedDown = Utilities.parseBoolean(childNode.attributes.SpeedDown);
					}
					
					if(childNode.attributes.OrbSplit != null) {
						trace("Level: constructFromXmlNode(): SpecialsPool: Attribute Found: OrbSplit");
						level.special_OrbSplit = Utilities.parseBoolean(childNode.attributes.OrbSplit);
					}
				}
			}
	
			return level;
		}
	}
}