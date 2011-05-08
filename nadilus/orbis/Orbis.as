package nadilus.orbis
{
	import flash.display.Sprite;
	
	import nadilus.orbis.screens.OrbisGame;
	
	public class Orbis extends Sprite
	{
		public function Orbis()
		{
			trace("Orbis: Orbis(): Called");
			var game:OrbisGame = new OrbisGame();
			addChild(game);
		}
	}
}