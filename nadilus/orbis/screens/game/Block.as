package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.BlockType;
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
			var topWall2:Vect = new Vect(new Point(this.x,this.y), new Point(this.x+this.width,this.y));
			var rightWall:Vect = new Vect(new Point(this.x+this.width,this.y+this.height), new Point(this.x+this.width,this.y));
			var botWall:Vect = new Vect(new Point(this.x,this.y+this.height), new Point(this.x+this.width,this.y+this.height));
			
			vectors = new Array();
			vectors.push(leftWall);
			vectors.push(topWall);
			vectors.push(topWall2);
			vectors.push(rightWall);
			vectors.push(botWall);
		}
		
		public function orbHit(orb:Orb):void {
			if(_blockType.destroyable) {
				if(hitsTaken < _blockType.hitsToBreak) {
					hitsTaken++;
					orb.bounceBack();
				}
				else {
					parent.removeChild(this); //reward player some socre
				}
			} else {
				orb.bounceBack();
			}
			orb.speedMultiply(_blockType.speedMultiplier);
		}
	}
}