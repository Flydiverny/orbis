package nadilus.orbis.screens.game
{
	public class Player
	{
		private var _platform:Platform;
		
		private var _orbShooter:OrbShooter;
		
		private var _currentScore:uint;
		
		public function Player() {
			trace("Player: Player(): Called");
			this._platform = new Platform();
			this._orbShooter = new OrbShooter();
		}

		public function get platform():Platform {
			return _platform;
		}
		
		public function get orbShooter():OrbShooter {
			return _orbShooter;
		}
		
		public function get currentScore():uint {
			return this._currentScore;
		}
		
		public function set currentScore(value:uint):void {
			this._currentScore = value;	
		}
	}
}