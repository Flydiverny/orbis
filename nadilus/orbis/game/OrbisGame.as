package nadilus.orbis.game
{
	import flash.display.Sprite;

	import nadilus.orbis.data.GameData;
	
	public class OrbisGame extends Sprite
	{
		private var _activeGameScreen:Sprite;
		private var _gameData:GameData;
		
		public function OrbisGame()
		{
			_gameData = new GameData(this);
			_gameData.loadAndParseXml();
		}
	}
}