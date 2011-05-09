package nadilus.orbis.vector {
	import flash.geom.Point;

	public class Circle extends Shapes{
		public var r:Number;

		public function Circle (p:Point, vx:Number, vy:Number, radius:Number, col:uint = 0x000000) {
			super(p, vx, vy, col);
			r = radius;
			drawMe ();
		}
		public function drawMe () {
			spr.graphics.drawCircle (0, 0, r);
		}
	}
}