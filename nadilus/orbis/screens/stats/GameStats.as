package nadilus.orbis.screens.stats
{
	import flash.display.MovieClip;
	import nadilus.orbis.GameConstants;
	
	public class GameStats extends MovieClip
	{
		public function GameStats()
		{
			
			
			this.x = GameConstants.GAMESCREEN_LEFT;
			this.y = GameConstants.ORBSHOOTER_HEIGHT;
			this.width = GameConstants.LEVEL_WIDTH;
			this.height = GameConstants.LEVEL_HEIGHT;
			
			
		}
	}
}