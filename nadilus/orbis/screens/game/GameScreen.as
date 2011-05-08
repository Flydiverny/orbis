package nadilus.orbis.screens.game
{
	import flash.display.Sprite;
	
	import nadilus.orbis.data.GameData;
	import nadilus.orbis.screens.OrbisGame;
	
	public class GameScreen extends Sprite
	{
		private var _game:OrbisGame;
		private var _levels:Array;
		private var _blockTypes:Object;
		
		public function GameScreen(game:OrbisGame, gameData:GameData)
		{
			this._game			= game;
			this._levels 		= gameData.gameLevels;
			this._blockTypes	= gameData.blockTypes;
		}
	}
}