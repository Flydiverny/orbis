package nadilus.orbis.data
{
	import flash.geom.ColorTransform;
	
	import nadilus.orbis.Utilities;

	public class BlockType
	{
		private var symbol:String;
		private var hueShiftAngle:Number;
		private var speedMultiplier:Number;
		private var score:uint;
		private var specialChance:uint;
		private var destroyable:Boolean;
		private var hitsToBreak:uint;
		
		
		public function BlockType()
		{
			this.symbol				=	"1"
			this.hueShiftAngle		=	1;
			this.speedMultiplier	=	1.02;
			this.score				=	1;
			this.specialChance		=	0;
			this.destroyable		=	true;
			this.hitsToBreak		=	1;
		}
		
		public static function constructFromXmlNode(attributes:Object):BlockType
		{
			trace("BlockType: constructFromXmlNode(): Called");
			var blockType:BlockType = new BlockType();
			
			if(attributes.Symbol != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: Symbol");
				blockType.symbol = attributes.Symbol;
			}
			
			if(attributes.HueShiftAngle != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: HueShiftAngle");
				blockType.hueShiftAngle = parseInt(attributes.HueShiftAngle);
			}
			
			if(attributes.SpeedMultiplier != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: SpeedMultiplier");
				blockType.speedMultiplier = parseFloat(attributes.SpeedMultiplier);
			}
			
			if(attributes.Score != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: Score");
				blockType.score = parseFloat(attributes.Score);
			}
			
			if(attributes.SpecialChance != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: SpecialChance");
				blockType.specialChance = parseInt(attributes.SpecialChance);
			}
			
			if(attributes.Destroyable != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: Destroyable");
				blockType.destroyable = Utilities.parseBoolean(attributes.Destroyable);
			}
			
			if(attributes.HitsToBreak != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: HitsToBreak");
				blockType.hitsToBreak = parseInt(attributes.HitsToBreak);
			}

			trace("BlockType: constructFromXmlNode(): BlockType Created: Symbol: " + blockType.symbol + " HueShiftAngle: " + blockType.hueShiftAngle + " SpeedMultiplier: " + blockType.speedMultiplier + " Score: " + blockType.score + " SpecialChance: " + blockType.specialChance + " Destroyable: " + blockType.destroyable + " HitsToBreak: " + blockType.hitsToBreak);
			return blockType;
		}
	}
}