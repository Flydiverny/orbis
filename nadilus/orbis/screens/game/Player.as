package nadilus.orbis.screens.game
{
	public class Player
	{
		private var _platform:Platform;
		
		public function Player()
		{
			this._platform = new Platform();
		}

		public function get platform():Platform
		{
			return _platform;
		}
	}
}