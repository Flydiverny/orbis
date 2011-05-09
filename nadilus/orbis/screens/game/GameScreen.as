package nadilus.orbis.screens.game
{
	import flash.display.Sprite;
	
	import nadilus.orbis.GameConstants;
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
		
		private var _player:Player;
		
		public function GameScreen(game:OrbisGame, gameData:GameData)
		{
			trace("GameScreen: GameScreen(): Called");
			this._game			= game;
			this._levels 		= gameData.gameLevels;
			this._blockTypes	= gameData.blockTypes;
			
			this._currentLvlNum	= 0;
			
			this._player		= new Player();
			
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
				_currentLevel.removeChild(_player.platform);
				this.removeChild(_currentLevel);
			}
			
			_currentLevel = _levels[_currentLvlNum];
			_currentLevel.drawLevel(_blockTypes);
			_currentLevel.x = GameConstants.GAMESCREEN_LEFT;
			_currentLevel.y = GameConstants.ORBSHOOTER_HEIGHT;

			_currentLevel.addChild(_player.platform);
			_player.platform.x = _currentLevel.width/2-_player.platform.width/2;
			_player.platform.y = _currentLevel.height-_player.platform.height*1.5;
			
			this.addChild(_currentLevel);
		}
	}
}