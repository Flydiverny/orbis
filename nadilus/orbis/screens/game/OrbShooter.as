package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.vector.Vect;

	public class OrbShooter extends MovieClip
	{
		private var _orbMagazine:uint;
		
		private var _player:Player;
		
		public function OrbShooter(player:Player) {
			trace("OrbShooter: OrbShooter(): Called");
			this._player = player;
		}
		
		public function fireOrb(lvl:Level):void {
			trace("OrbShooter: fireOrb(): Called: " + lvl);
			if(this._orbMagazine > 0) {
				// DO NOT CHANGE THIS IS FINAL
				var pt:Point = Utilities.degreesToXY(50, this.rotation+90);
				var pt1:Point = new Point(pt.x+lvl.width/2,pt.y);
				
				var vect:Vect = new Vect(new Point(lvl.width/2,0), pt1);
				var orb:Orb =  new Orb(vect,lvl,this._player);
				
				lvl.addChild(orb);
				_orbMagazine--;
			}
		}
		
		public function get orbMagazine():uint
		{
			trace("OrbShooter: orbMagazine(): Called");
			return _orbMagazine;
		}

		public function set orbMagazine(value:uint):void
		{
			trace("OrbShooter: orbMagazine(): Called: " + value);
			_orbMagazine = value;
		}
	}
}