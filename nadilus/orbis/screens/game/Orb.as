package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.vector.*;
	
	public class Orb extends MovieClip
	{
		private var _speed:Number = 100;
		private var damage:uint;
		private var bounces:uint;
		private var life:uint;
		
		private var gravity:Number = 0.2;
		private var radius:uint = 5;
		private var precision:uint = 100;
		
		private var _v:Vect;
		
		private var ip:Point;

		private static var staticSetupBool:Boolean;
		
		public function Orb(vect:Vect)
		{
			trace("Orb: Orb(): Called: " + vect);
			
			this.v = vect;
			this.v.vx = v.dx;
			this.v.vy = v.dy;
			
			this.x = v.p1.x;
			this.y = v.p1.y;
		}
		
		public function moveMe() {
			v.p0 = v.p1;
			v = Vect.vFrom1Point(v.p0, v.dx*speed, v.dy*speed);
			placeMe();
		}
		
		internal function placeMe() {
			this.x = v.p0.x;
			this.y = v.p0.y;
		}
		
		public function speedMultiply(multi:Number):void {
			_speed *= multi;
		}
		
		public function get speed():Number {
			trace("Orb: speed(): _speed: " + _speed + " bounces: " + bounces + " calc speed bonus: " + ((_speed/100+1) + (bounces/100)));
			return (_speed/100+1) + (bounces/100);
		}
		
		public function get v():Vect {
			return this._v;
		}
		
		public function get r():Number {
			return this.width/2;
		}
		
		public function set v(value:Vect):void {
			this._v = value;
		}
	}
}
