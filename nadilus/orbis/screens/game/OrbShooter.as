package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.Utilities;
	import flash.geom.Point;

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
				
				var pt:Point = Utilities.degreesToXY(50, this.rotation+90);
				var orb:Orb =  new Orb(pt.x,pt.y,lvl,this._player);
				
				orb.x = pt.x + lvl.width/2;
				orb.y = pt.y;
				
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