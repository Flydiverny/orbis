package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.vector.*;
	import nadilus.orbis.Utilities;
	
	public class Orb extends MovieClip
	{
		private var _speed:Number = 400;
		private var damage:uint;
		private var bounces:uint;
		private var life:uint;
		private var radius:uint = 5;
		private var precision:uint = 100;
		
		private var thisV:Vect;
		private var lastV:Vect;
		
		private var thisIp:Point;
		private var lastIp:Point;

		private static var staticSetupBool:Boolean;
		
		public var vectors:Array;
		
		public function Orb(vect:Vect)
		{
			trace("Orb: Orb(): Called: " + vect);
			
			vectors = new Array();
			this.bounces = 0;
			
			this.v = vect;
			this.v.vx = v.dx;
			this.v.vy = v.dy;
			
			this.x = v.p1.x;
			this.y = v.p1.y;
		}
		
		public function moveMe() {
			//trace("Orb: moveMe(): v.p0: " + v.p0 + " v.p1: " + v.p1 + " new: v.p0: " + Vect.vFrom1Point(v.p0, v.dx*speed, v.dy*speed).p0 + " v.p1 " + Vect.vFrom1Point(v.p0, v.dx*speed, v.dy*speed).p1);
			v.p0 = v.p1;
			v = Vect.vFrom1Point(v.p0, v.dx*speed, v.dy*speed);
			
			if(vectors.length >= 5) {
				if(v.p0.x == vectors[vectors.length-2].p0.x && vectors[vectors.length-2].p0.x == vectors[vectors.length-3].p0.x && vectors[vectors.length-2].p0.y == vectors[vectors.length-3].p0.y && v.p0.y == vectors[vectors.length-2].p0.y) {
					//Utilities.setHue(this,-200);
					v = vectors[0];
					v.dx *= -1;
					v.dy *= -1;
					v = Vect.vFrom1Point(v.p0, v.dx*speed, v.dy*speed);
					trace("Orb: moveMe(): MAGICS MAGICS MAGICS MAGICS MAGICS MAGICS ");
				}
				
				vectors.shift();
			}
			
			vectors.push(v);
			
			placeMe();
		}
		
		internal function placeMe() {
			trace("Orb: placeMe(): current: (" + this.x + ", " + this.y + ") new: (" + v.p0.x + ", " + v.p0.y + ")");
			this.x = v.p0.x;
			this.y = v.p0.y;
		}
		
		public function speedMultiply(multi:Number):void {
			_speed *= multi;
		}
		
		public function get speed():Number {
			trace("Orb: speed(): _speed: " + _speed + " bounces: " + bounces + " calc speed bonus: " + ((_speed/100+1) + ((bounces/100)*2)));
			return (_speed/100+1) + ((bounces/100)*2);
		}
		
		public function get v():Vect {
			return this.thisV;
		}
		
		public function get r():Number {
			return this.width/2;
		}
		
		public function set v(value:Vect):void {
			this.thisV = value;
		}
		
		public function bounce():void {
			this.bounces++;
		}
		
		public function remove():void {
			parent.removeChild(this);
		}
	}
}
