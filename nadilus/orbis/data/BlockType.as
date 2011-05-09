package nadilus.orbis.data
{
	import flash.geom.ColorTransform;
	
	import nadilus.orbis.Utilities;

	public class BlockType
	{
		private var _symbol:String;
		private var _hueShiftAngle:Number;
		private var _speedMultiplier:Number;
		private var _score:uint;
		private var _specialChance:uint;
		private var _destroyable:Boolean;
		private var _hitsToBreak:uint;
		
		
		public function BlockType()
		{
			this._symbol			=	"1"
			this._hueShiftAngle		=	1;
			this._speedMultiplier	=	1.02;
			this._score				=	1;
			this._specialChance		=	0;
			this._destroyable		=	true;
			this._hitsToBreak		=	1;
		}
		
		public function get score():uint
		{
			return _score;
		}

		public function get specialChance():uint
		{
			return _specialChance;
		}

		public function get destroyable():Boolean
		{
			return _destroyable;
		}

		public function get hitsToBreak():uint
		{
			return _hitsToBreak;
		}

		public function get speedMultiplier():Number
		{
			return _speedMultiplier;
		}

		public function get hueShiftAngle():Number
		{
			return _hueShiftAngle;
		}

		public function get symbol():String
		{
			return _symbol;
		}

		public static function constructFromXmlNode(attributes:Object):BlockType
		{
			trace("BlockType: constructFromXmlNode(): Called");
			var blockType:BlockType = new BlockType();
			
			if(attributes.Symbol != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: Symbol");
				blockType._symbol = attributes.Symbol;
			}
			
			if(attributes.HueShiftAngle != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: HueShiftAngle");
				blockType._hueShiftAngle = parseInt(attributes.HueShiftAngle);
			}
			
			if(attributes.SpeedMultiplier != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: SpeedMultiplier");
				blockType._speedMultiplier = parseFloat(attributes.SpeedMultiplier);
			}
			
			if(attributes.Score != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: Score");
				blockType._score = parseFloat(attributes.Score);
			}
			
			if(attributes.SpecialChance != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: SpecialChance");
				blockType._specialChance = parseInt(attributes.SpecialChance);
			}
			
			if(attributes.Destroyable != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: Destroyable");
				blockType._destroyable = Utilities.parseBoolean(attributes.Destroyable);
			}
			
			if(attributes.HitsToBreak != null) {
				trace("BlockType: constructFromXmlNode(): Attribute Found: HitsToBreak");
				blockType._hitsToBreak = parseInt(attributes.HitsToBreak);
			}

			trace("BlockType: constructFromXmlNode(): BlockType Created: Symbol: " + blockType.symbol + " HueShiftAngle: " + blockType.hueShiftAngle + " SpeedMultiplier: " + blockType._speedMultiplier + " Score: " + blockType._score + " SpecialChance: " + blockType._specialChance + " Destroyable: " + blockType._destroyable + " HitsToBreak: " + blockType._hitsToBreak);
			return blockType;
		}
	}
}