package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.BlockType;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.screens.game.Stats;
	import nadilus.orbis.vector.Vect;
	
	public class Block extends MovieClip
	{
		private var _blockType:BlockType;
		private var _blockNum:uint;
		private var _blockRow:uint;
		
		private var hitsTaken:uint = 0;
		
		public var vectors:Array;
		
		public function Block(blockType:BlockType, blockRow:uint, blockNum:uint)
		{
			trace("Block: Block(): Called: " + blockType + " " + blockRow + " " + blockNum);	
			this._blockType	= blockType;
			this._blockNum	= blockNum;
			this._blockRow	= blockRow;
			
			this.width = GameConstants.BLOCK_WIDTH;
			this.height = GameConstants.BLOCK_HEIGHT;
			
			Utilities.setHue(this, _blockType.hueShiftAngle);
		}
		
		override public function set x(value:Number):void {
			super.x = value;
			
			remakeVectors();
		}
		
		override public function set y(value:Number):void {
			super.y = value;
			
			remakeVectors();
		}
		
		private function remakeVectors():void {
			var leftWall:Vect = new Vect(new Point(this.x,this.y), new Point(this.x,this.y+this.height));
			var topWall:Vect = new Vect(new Point(this.x+this.width,this.y), new Point(this.x,this.y));
			
			var rightWall:Vect = new Vect(new Point(this.x+this.width,this.y+this.height), new Point(this.x+this.width,this.y));
			var botWall:Vect = new Vect(new Point(this.x,this.y+this.height), new Point(this.x+this.width,this.y+this.height));
			
			vectors = new Array();
			vectors.push(leftWall);
			vectors.push(topWall);
			
			vectors.push(rightWall);
			vectors.push(botWall);
		}
		
		public function get blockType():BlockType {
			return this._blockType;
		}
		
		public function hitBlock():Boolean {
			this.hitsTaken++;
			
			if(this.blockType.destroyable) {
				if(this.hitsTaken  >= _blockType.hitsToBreak) {
					if(parent != null)
						parent.removeChild(this);
					return true;
				}

				var stats = new Stats(Level(this.parent), new Point(this.x,this.y-10), String(_blockType.hitsToBreak - hitsTaken),0xFF0000);
			}
			
			return false;
		}
	}
}