package nadilus.orbis.screens.game
{
	import flash.display.Sprite;
	
	import nadilus.orbis.data.GameData;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.screens.OrbisGame;
	import nadilus.orbis.GameConstants;
	
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
			
			this.graphics.beginFill( 0x0FF000, 1.0 );
			this.graphics.drawRect( 0, 0, GameConstants.SCREEN_WIDTH, GameConstants.SCREEN_HEIGHT);
			this.graphics.endFill();
			
			this.width				= GameConstants.SCREEN_WIDTH;
			this.height				= GameConstants.SCREEN_HEIGHT;
			
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
			
			trace("GameScreen: this.x " + this.x + " this.y " + this.y + " this.height " + this.height + " this.width " + this.width);
		}
	}
}