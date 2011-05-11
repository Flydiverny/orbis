package nadilus.orbis.data
{
	import flash.display.Sprite;
	import flash.xml.XMLNode;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.screens.game.Block;
	import flash.geom.Point;

	public class Level extends Sprite
	{
		private var _scoreToWin:uint;
		private var _initialOrbCount:uint;
		private var _maximumOrbsToLose:uint;
		private var _specialsCount:uint;

		private var blockSymbols:Array;
		private var _blocks:Array;
		
		private var special_SpeedUp:Boolean;
		private var special_SpeedDown:Boolean;
		private var special_OrbSplit:Boolean;
		
		private var _levelDrawn:Boolean;
		
		public var topLeftBlocks:Array;
		public var bottomLeftBlocks:Array;
		public var topRightBlocks:Array;
		public var bottomRightBlocks:Array;
		
		public var centerPoint:Point;
		
		public function Level() {
			trace("Level: Level(): Called");
			this._scoreToWin		= 1;
			this._initialOrbCount	= 1;
			this._maximumOrbsToLose	= 1;
			this._specialsCount		= 1;
			
			this.blockSymbols		= new Array();
			this._blocks				= new Array();
			
			this.special_SpeedUp	= true;
			this.special_SpeedDown	= true;
			this.special_OrbSplit	= true;
			
			
			this.graphics.beginFill( 0x000000, 1.0 );
			this.graphics.drawRect( 0, 0, GameConstants.LEVEL_WIDTH, GameConstants.LEVEL_HEIGHT);
			this.graphics.endFill();
			
			this.width				= GameConstants.LEVEL_WIDTH;
			this.height				= GameConstants.LEVEL_HEIGHT;
		}
		
		public function get blocks():Array
		{
			return _blocks;
		}

		public function get initialOrbCount():uint
		{
			return _initialOrbCount;
		}

		public function drawLevel(blockTypes:Object):void {
			trace("this.x " + this.x + " this.y " + this.y + " this.height " + this.height + " this.width " + this.width);
			
			trace("Level: drawLevel(): Called");
			if(_levelDrawn == false) {
				var blockRow:uint = 0;
				
				var yincrement = this.height/2/2/blockSymbols.length;
				var xincrement = GameConstants.BLOCK_WIDTH; //+yincrement-GameConstants.BLOCK_HEIGHT;
				var nexty:Number = yincrement+50;
				
				trace("Level: drawLevel(): Start looping thru BlockSymbols.");
				for each(var line:Array in blockSymbols) {
					trace("Level: drawLevel(): Looping thru line: " + line);
					var blockNum:uint = 0;
					var row:Array = new Array();
					
					var nextx:Number = this.width/2-line.length*xincrement/2;
					
					for each(var symbol:String in line) {
						trace("Level: drawLevel(): Creating block for Symbol: " + symbol);
						if(symbol == GameConstants.EMPTY_BLOCK) {
							trace("Level: drawLevel(): Skipping, matches constant for Empty Block");
							nextx += xincrement;
							continue;
						}
						
						var blockType:BlockType = blockTypes[symbol];
						
						if(blockType == null) {
							throw new Error("Level: drawLevel(): BlockType was null.");
						}
						
						var block:Block = new Block(blockType, blockRow, blockNum);
						
						block.x = nextx;
						block.y = nexty;
						
						this.addChild(block);
						row.push(block);
						blockNum++;
						nextx += xincrement;
					}
					
					blocks.push(row);
					blockRow++;
					nexty += yincrement;
				}
				
				centerPoint = new Point(this.width/2,this.height/2/2);
				
				topLeftBlocks = new Array();
				topRightBlocks = new Array();
				bottomLeftBlocks = new Array();
				bottomRightBlocks = new Array();
				
				for(var i:uint = 0; i < blocks.length; i++) {
					for(var x:uint = 0; x < blocks[i].length; x++) {
						if(blocks[i][x].y <= centerPoint.y) {
							if(blocks[i][x].x <= centerPoint.x) {
								topLeftBlocks.push(blocks[i][x]);
								//Utilities.setHue(blocks[i][x], 50);
							}
							if(blocks[i][x].x + blocks[i][x].width >= centerPoint.x) {
								topRightBlocks.push(blocks[i][x]);
								//Utilities.setHue(blocks[i][x], 100);
							}
						}
						
						if(blocks[i][x].y+blocks[i][x].height >= centerPoint.y) {
							if(blocks[i][x].x <= centerPoint.x) {
								bottomLeftBlocks.push(blocks[i][x]);
								//Utilities.setHue(blocks[i][x], 150);
							}
							if(blocks[i][x].x + blocks[i][x].width >= centerPoint.x) {
								bottomRightBlocks.push(blocks[i][x]);
								//Utilities.setHue(blocks[i][x], 200);
							}
						}
					}
				}
			}
		}
		
		public static function constructFromXmlNode(node:XMLNode):Level {
			trace("Level: constructFromXmlNode(): Called");
			var level:Level = new Level();
			
			if(node.attributes.ScoreToWin != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: ScoreToWin");
				level._scoreToWin = node.attributes.ScoreToWin;
			}
			
			if(node.attributes.InitialOrbCount != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: InitialOrbCount");
				level._initialOrbCount = node.attributes.InitialOrbCount;
			}
			
			if(node.attributes.MaximumOrbsToLose != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: MaximumOrbsToLose");
				level._maximumOrbsToLose = node.attributes.MaximumOrbsToLose;
			}
			
			if(node.attributes.SpecialsCount != null) {
				trace("Level: constructFromXmlNode(): Attribute Found: SpecialsCount");
				level._specialsCount = node.attributes.SpecialsCount;
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
							
							level.blockSymbols.push(blocksArray);
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