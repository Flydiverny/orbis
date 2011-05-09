package nadilus.orbis.screens
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.GameData;
	import nadilus.orbis.screens.game.GameScreen;
	import nadilus.orbis.screens.game.Platform;
	import nadilus.orbis.screens.loading.LoadingScreen;
	import nadilus.orbis.screens.menu.MenuScreen;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class OrbisGame extends Sprite
	{
		private var _activeGameScreen:Sprite;
		private var _gameData:GameData;
		private var _player:Platform;
		
		public static var gStage:Stage;
		
		public function OrbisGame() {
			trace("OrbisGame: OrbisGame(): Called");
			//runLoadingScreen()
			this.addEventListener(Event.ADDED_TO_STAGE, ini);
		}
		
		function ini(e:Event):void {
			trace("Stage found");
			removeEventListener(Event.ADDED_TO_STAGE, ini);
			gStage = stage;
			loadGameData();
		}
		
		public function runLoadingScreen():void {
			trace("OrbisGame: runLoadingScreen(): Called");
			changeActiveGameScreen(new LoadingScreen(this));
		}
		
		public function loadGameData():void {
			trace("OrbisGame: loadGameData(): Called");
			_gameData = new GameData(this);
			_gameData.loadAndParseXml();
		}
		
		public function runMenuScreen():void {
			trace("OrbisGame: runMenuScreen(): Called");
			changeActiveGameScreen(new MenuScreen(this));
		}
		
		public function runGameScreen():void {
			trace("OrbisGame: runGameScreen(): Called");
			changeActiveGameScreen(new GameScreen(this,_gameData));
		}
		
		private function changeActiveGameScreen(obj:Sprite):void {
			trace("OrbisGame: changeActiveGameScreen(): Called");
			if (_activeGameScreen != null) {
				this.removeChild(_activeGameScreen);
			}
			
			_activeGameScreen = obj;
			this.addChild(_activeGameScreen);
		}
	}
}