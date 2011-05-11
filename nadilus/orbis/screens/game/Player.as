package nadilus.orbis.screens.game
{
	public class Player
	{
		private var _platform:Platform;
		
		private var _orbShooter:OrbShooter;
		
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
	}
}