package nadilus.orbis.screens.menu
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	
	import nadilus.orbis.screens.OrbisGame;
	
	public class MenuScreen extends Sprite
	{
		private var _game:OrbisGame;
		
		private var _startBtn:Button;
		
		public function MenuScreen(game:OrbisGame)
		{
			this._game = game;
			this._startBtn = start_btn;
			
			_startBtn.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
			
			//_someBtn.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
			
			//_someBtn.addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
		}
		
		private function startGame(event:MouseEvent) {
			trace("MenuScreen: startGame(): Called");
			_game.runGameScreen();
		}
	}
}