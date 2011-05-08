package nadilus.orbis.game
{
	import flash.display.MovieClip;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.BlockType;
	
	public class Block extends MovieClip
	{
		public function Block(gamePlayScreen:GamePlayScreen, symbol:String, unitNumber:uint)
		{
			var filters:Array = new Array();
			filters.push(Utilities.createHueShiftColorMatrixFilter(blockType.hueShiftAngle));
			this.filters = filters;

		}
		
		public function get blockType():BlockType
		{
			return gameData.getEnemyUnitBySymbol(_symbol);
		}
	}
}