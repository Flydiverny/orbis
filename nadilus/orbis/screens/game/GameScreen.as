package nadilus.orbis.screens.game
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.*;
	
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
		private var _orbShooter:OrbShooter;
		
		// Keys
		private var left:Boolean = false;
		private var right:Boolean = false;
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var space:Boolean = false;
		
		public function GameScreen(game:OrbisGame, gameData:GameData) {
			trace("GameScreen: GameScreen(): Called");
			this._game			= game;
			this._levels 		= gameData.gameLevels;
			this._blockTypes	= gameData.blockTypes;
			
			this._currentLvlNum	= 0;
			
			this._player		= new Player();
			this._orbShooter	= _player.orbShooter;
			
			this.graphics.beginFill( 0x0FF000, 1.0 );
			this.graphics.drawRect( 0, 0, GameConstants.SCREEN_WIDTH, GameConstants.SCREEN_HEIGHT);
			this.graphics.endFill();
			
			this.width				= GameConstants.SCREEN_WIDTH;
			this.height				= GameConstants.SCREEN_HEIGHT;
			
			this._orbShooter.x		= this.width/2;
			this._orbShooter.y		= _orbShooter.height/2-3;
			
			//this._orbShooter.rotation = 75;
			
			startNextLevel();
			
			OrbisGame.gStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			OrbisGame.gStage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function startNextLevel():void {
			trace("GameScreen: startNextLevel(): Called");
			if(_currentLevel != null) {
				_currentLevel.removeChild(_player.platform);
				this.removeChild(_currentLevel);
				this.removeChild(_orbShooter);
			}
			
			// Draw Level
			_currentLevel = _levels[_currentLvlNum];
			_currentLevel.drawLevel(_blockTypes);
			_currentLevel.x = GameConstants.GAMESCREEN_LEFT;
			_currentLevel.y = GameConstants.ORBSHOOTER_HEIGHT;
			_currentLevel.addChild(_player.platform);
			
			// Add Platform to level
			_player.platform.x = _currentLevel.width/2-_player.platform.width/2;
			_player.platform.y = _currentLevel.height-_player.platform.height*1.5;
			
			_orbShooter.orbMagazine = _currentLevel.initialOrbCount;
			
			this.addChild(_currentLevel);
			this.addChild(_orbShooter);
		}
		
		private function enterFrame(event:Event):void {
			_player.platform.movePlatform(left,right,up,down);
			
			if(left) {
				if(_player.orbShooter.rotation < 75)
					_player.orbShooter.rotation += 2;
			}
			if(right) {
				if(_player.orbShooter.rotation > -75)
					_player.orbShooter.rotation -= 2;
			}
				
			if(space)
				_player.orbShooter.fireOrb(_currentLevel);
		}
		
		private function keyPressed(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37: 
					left = true;
					break;
				case 39:
					right = true;
					break;
				case 38:
					up = true;
					break;
				case 40:
					down = true;
					break;
				case Keyboard.SPACE:
					space = true;
					break;
				/*case Keyboard.SHIFT:
				changeWeapon(1);
				break;
				case Keyboard.CONTROL:
				changeWeapon(2);
				break;
				case 49:
				setWeapon(1);
				break;
				case 50:
				setWeapon(2);
				break;
				case 51:
				setWeapon(3);
				break;
				case 52:
				setWeapon(4);
				break;*/
			}
		}
		
		private function keyReleased(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37: 
					left = false;
					break;
				case 39:
					right = false;
					break;
				case 38:
					up = false;
					break;
				case 40:
					down = false;
					break;
				case Keyboard.SPACE:
					space = false;
					break;
			}
		}
	}
}