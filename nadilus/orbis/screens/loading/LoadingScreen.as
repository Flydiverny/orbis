package nadilus.orbis.screens.loading
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	
	import nadilus.orbis.screens.OrbisGame;
	
	public class LoadingScreen extends Sprite
	{
		private var _game:OrbisGame;
		
		private var _loadingBar:LoadingBar;
		
		public function LoadingScreen(game:OrbisGame) {
			trace("LoadingScreen: LoadingScreen(): Called");
			this._game = game;

			_loadingBar = new LoadingBar();

			this.addChild(_loadingBar);
			
			this.addEventListener(Event.ENTER_FRAME,loadingBar);
		}
		
		private function loadingBar(event:Event):void {
			trace("LoadingScreen: loadingBar(): Called");
			var total:Number = this.loaderInfo.bytesTotal;
			var loaded:Number = this.loaderInfo.bytesLoaded;
			
			_loadingBar.setPercent(loaded/total);
			_loadingBar.setText("Loaded " + loaded/1000 + " kB of " + total/1000 + " kB, " + Math.floor((loaded/total)*100) + "%");
			
			if(total == loaded) {
				trace("LoadingScreen: loadingBar(): Loading Complete");
				this.removeEventListener(Event.ENTER_FRAME,loadingBar);
				_loadingBar.addEventListener(MouseEvent.CLICK, loadGameData);
				_loadingBar.setText("Start Game");
			}
		}
		
		private function loadGameData(event:Event):void {
			
		}
	}
}