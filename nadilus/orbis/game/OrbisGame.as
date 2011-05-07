package nadilus.orbis.game
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import nadilus.orbis.Utilities;
	
	import nadilus.orbis.data.GameData;
	
	public class OrbisGame extends Sprite
	{
		private var _activeGameScreen:Sprite;
		private var _gameData:GameData;
		private var platform:Platform;
		
		public function OrbisGame()
		{
			_gameData = new GameData(this,"Orbis.xml");
			_gameData.loadAndParseXml();
			platform = new Platform();
			addChild(platform);
			Utilities.setRGB(platform, 0xFF0000);
		}
	}
}