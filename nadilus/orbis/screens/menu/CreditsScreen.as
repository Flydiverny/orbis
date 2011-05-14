package nadilus.orbis.screens.menu
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import nadilus.orbis.screens.OrbisGame;
	import nadilus.orbis.GameConstants;
	import flash.display.SimpleButton;
	
	public class CreditsScreen extends Sprite
	{
		private var _game:OrbisGame;
		
		private var _startBtn:SimpleButton;
		private var _bkToMenuBtn:SimpleButton;
		
		public function CreditsScreen(game:OrbisGame)
		{
			this._game			= game;
			this._startBtn		= this.newGameBtn;
			this._bkToMenuBtn		= this.bkToMenuBtn;
			
			this.x += GameConstants.GAMESCREEN_LEFT;
			this.y += GameConstants.ORBSHOOTER_HEIGHT/2;
			
			//this.width			= GameConstants.SCREEN_WIDTH;
			//this.height			= GameConstants.SCREEN_HEIGHT;
			
			_startBtn.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
			
			_bkToMenuBtn.addEventListener(MouseEvent.CLICK, showMenu, false, 0, true);
			
			//_someBtn.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
		}
	
		private function startGame(event:MouseEvent) {
			trace("MenuScreen: startGame(): Called");
			_bkToMenuBtn.removeEventListener(MouseEvent.CLICK, startGame);
			_game.runGameScreen();
		}
		
		private function showMenu(event:MouseEvent) {
			_game.runMenuScreen();
		}
	}
}