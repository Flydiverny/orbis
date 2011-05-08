package nadilus.orbis.screens.game
{
	import flash.display.Sprite;
	
	import nadilus.orbis.data.GameData;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.screens.OrbisGame;
	
	public class GameScreen extends Sprite
	{
		private var _game:OrbisGame;
		private var _levels:Array;
		private var _blockTypes:Object;
		
		private var _currentLvlNum:uint;
		private var _currentLevel:Level;
		
		public function GameScreen(game:OrbisGame, gameData:GameData)
		{
			trace("GameScreen: GameScreen(): Called");
			this._game			= game;
			this._levels 		= gameData.gameLevels;
			this._blockTypes	= gameData.blockTypes;
			
			this._currentLvlNum	= 0;
			
			startNextLevel();
		}
		
		private function startNextLevel():void {
			trace("GameScreen: startNextLevel(): Called");
			if(_currentLevel != null) {
				this.removeChild(_currentLevel);
			}
			
			_currentLevel = _levels[_currentLvlNum];
			_currentLevel.drawLevel(_blockTypes);
			
			this.addChild(_currentLevel);
		}
	}
}