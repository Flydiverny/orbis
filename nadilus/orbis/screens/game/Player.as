package nadilus.orbis.screens.game
{
	public class Player
	{
		private var _platform:Platform;
		
		private var _orbShooter:OrbShooter;
		
		private var _currentScore:uint;
		
		private var _totalBounces:uint;
		private var _totalBlocksDestroyed:uint;
		
		private var _totalScore:uint;
		
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
		
		public function addBlocksDestroyed(value:uint):void {
			this._totalBlocksDestroyed += value;
		}
		
		public function addBounces(value:uint):void {
			this._totalBounces += value;
		}
		
		public function get totalBounces():uint {
			return _totalBounces;
		}
		
		public function get totalBlocksDestroyed():uint {
			return _totalBlocksDestroyed;
		}
		
		
		public function addTotalScore(value:uint):void {
			this._totalScore += value;
		}
		
		public function get totalScore():uint {
			return _totalScore;
		}
		
	}
}