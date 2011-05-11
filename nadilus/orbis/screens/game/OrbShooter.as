package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.vector.Vect;
	
	import nadilus.orbis.GameConstants;

	public class OrbShooter extends MovieClip
	{
		public function OrbShooter() {
			trace("OrbShooter: OrbShooter(): Called");
		}
		
		public function fireOrb():Vect {
			trace("OrbShooter: fireOrb(): Called");
			// DO NOT CHANGE THIS IS FINAL
			var pt:Point = Utilities.degreesToXY(50, this.rotation+90);
			var pt1:Point = new Point(pt.x+GameConstants.LEVEL_WIDTH/2,pt.y);
			
			var vect:Vect = new Vect(new Point(GameConstants.LEVEL_WIDTH/2,0), pt1);
			
			return vect;
		}
	}
}