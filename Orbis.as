package
{
	import flash.display.Sprite;
	
	import nadilus.orbis.game.OrbisGame;
	
	public class Orbis extends Sprite
	{
		public function Orbis()
		{
			var game:OrbisGame = new OrbisGame();
			addChild(game);
		}
	}
}