package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.BlockType;
	
	public class Block extends MovieClip
	{
		private var _blockType:BlockType;
		private var _blockNum:uint;
		private var _blockRow:uint;
		
		private var hitsTaken:uint = 0;
		
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