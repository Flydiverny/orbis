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
		private var Speed:Number = 0;
		private var Friction:Number = GameConstants.FRICTION;
		private var Power:Number = GameConstants.POWER;

		public function OrbShooter() {
			trace("OrbShooter: OrbShooter(): Called");
		}
		
		public function fireOrb():Vect {
			trace("OrbShooter: fireOrb(): Called");
			// DO NOT CHANGE THIS IS FINAL
			var pt:Point = Utilities.degreesToXY(25, this.rotation+90);
			var pt1:Point = new Point(pt.x+GameConstants.LEVEL_WIDTH/2,pt.y);
			
			var vect:Vect = new Vect(new Point(GameConstants.LEVEL_WIDTH/2,0), pt1);
			
			return vect;
		}
		
		public function rotateOrbshooter(left:Boolean, right:Boolean):void {
			movementConstraints();
			
			if(right)
				Speed -= f(1);
			if(left)
				Speed += f(0);
			
			if(!left && !right && Speed != 0)
				xSpeedDec();
			
			this.rotation += Speed/GameConstants.LEVEL_WIDTH*160;
		}
		
		private function movementConstraints():void {
			//Left Block
			if(this.rotation+Speed > 75) {
				this.Speed = 0;
				this.rotation = 75;
			}
			
			//Right Block
			if(this.rotation+Speed < -75) {
				this.Speed = 0;
				this.rotation = -75;
			}
		}
		
		private function f(what:int):Number {
			if(what == 0)
				return Power-Friction*Speed;
			else if(what == 1)
				return Power+Friction*Speed;
			else
				return 0;
		}
		
		private function xSpeedDec():void {
			if(Speed > 0) {
				Speed -= Friction*Power*7;
			}
			if(Speed < 0) {
				Speed += Friction*Power*7;
			}
			if(Speed < 1 && Speed > -1)
				Speed = 0;
		}
	}
}