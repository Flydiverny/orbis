package nadilus.orbis.screens.menu
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import nadilus.orbis.screens.OrbisGame;
	import nadilus.orbis.GameConstants;
	
	public class MenuScreen extends Sprite
	{
		private var _game:OrbisGame;
		
		private var _startBtn:MovieClip;
		private var _credBtn:MovieClip;
		
		public function MenuScreen(game:OrbisGame)
		{
			this._game			= game;
			this._startBtn		= this.newGameBtn;
			this._credBtn		= this.creditsBtn;
			
			this.x += GameConstants.GAMESCREEN_LEFT;
			this.y += GameConstants.ORBSHOOTER_HEIGHT/2;
			
			//this.width			= GameConstants.SCREEN_WIDTH;
			//this.height			= GameConstants.SCREEN_HEIGHT;
			
			_startBtn.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
			
			_credBtn.addEventListener(MouseEvent.CLICK, showCredits, false, 0, true);
			
			//_someBtn.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
		}
		
		private function startGame(event:MouseEvent) {
			trace("MenuScreen: startGame(): Called");
			_startBtn.removeEventListener(MouseEvent.CLICK, startGame);
			_game.runGameScreen();
		}
		
		private function showCredits(event:MouseEvent) {
			
		}
	}
}