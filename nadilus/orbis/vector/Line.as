package nadilus.orbis.vector {
	import flash.geom.Point;

	public class Line extends Shapes{
		public var p1:Shapes;
		public var p2:Shapes;
		private var len:Number;
		private var newLen:Number;
		private var addLen:Number;
		private var xd:Number;
		private var yd:Number;

		public function Line (p1a:Point, vx1:Number, vy1:Number, p2a:Point, vx2:Number, vy2:Number, col:uint = 0x000000) {
			super(p1a, 0, 0, col);
			p1 = new Shapes(p1a, vx1, vy1);
			p2 = new Shapes(p2a, vx2, vy2);
			xd = p2.v.p0.x - p1.v.p0.x;
			yd = p2.v.p0.y - p1.v.p0.y;
			len = Math.sqrt(xd * xd + yd * yd);
		}
		public function drawMe (spr) {
			spr.graphics.lineStyle (lineWidth, mycolor);
			spr.graphics.moveTo(p1.v.p0.x, p1.v.p0.y);
			spr.graphics.lineTo(p2.v.p0.x, p2.v.p0.y);
		}
		override public function moveMe () {
			p1.moveMe ();
			p2.moveMe ();
		}
		public function checkMe (stageW:Number, stageH:Number) {
			xd = p2.v.p0.x - p1.v.p0.x;
			yd = p2.v.p0.y - p1.v.p0.y;
			newLen = Math.sqrt(xd * xd + yd * yd);
			//adjust points
			addLen = (len - newLen) / 2;
			adjustEndPoint (p1, -addLen / newLen, stageW, stageH);
			adjustEndPoint (p2, addLen / newLen, stageW, stageH);
		}
		private function adjustEndPoint (ob:Shapes, len:Number, stageW:Number, stageH:Number) {
			ob.changePosition (new Point(ob.v.p0.x + len * xd, ob.v.p0.y + len * yd));
			//edges
			if(ob.v.p1.x < 0){
				ob.v.vx = Math.abs(ob.v.vx);
			}else if(ob.v.p1.x > stageW){
				ob.v.vx = -Math.abs(ob.v.vx);
			}
			if(ob.v.p1.y < 0){
				ob.v.vy = Math.abs(ob.v.vy);
			}else if(ob.v.p1.y > stageH){
				ob.v.vy = -Math.abs(ob.v.vy);
			}
			ob.v = Vect.vFrom1Point (ob.v.p1, ob.v.vx, ob.v.vy);
		}
	}
}