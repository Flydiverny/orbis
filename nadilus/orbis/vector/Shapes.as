package nadilus.orbis.vector {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.MovieClip;

	public class Shapes extends MovieClip {

		public var v:Vect;
		private var _spr:Sprite;
		internal var _mycolor:uint;
		internal var _lineWidth:Number;

		public function Shapes (p:Point, vx:Number, vy:Number, col:uint = 0x000000) {
			_spr = new Sprite();
			v = Vect.vFrom1Point (p, vx, vy);
			_mycolor = col;
			_lineWidth = 2;
			spr.graphics.lineStyle (_lineWidth, _mycolor);
			placeMe ();
		}
		public function moveMe () {
			v.p0 = v.p1;
			v = Vect.vFrom1Point (v.p0, v.vx, v.vy);
			placeMe ();
		}
		internal function placeMe () {
			_spr.x = v.p0.x;
			_spr.y = v.p0.y;
		}
		public function changeMovement (xd:Number, yd:Number) {
			v.vx += xd;
			v.vy += yd;
		}
		public function changePosition (p:Point) {
			v.p1 = p;
		}
		public function get spr() {
			return _spr;
		}
		public function get lineWidth() {
			return _lineWidth;
		}
		public function get mycolor() {
			return _mycolor;
		}
	}
}