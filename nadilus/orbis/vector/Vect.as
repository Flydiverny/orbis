package nadilus.orbis.vector {
	import flash.geom.Point;

	public class Vect {
		//static functions belonging to Vector class

		//finds dot product of 2 vectors
		public static function dotProduct (v1:Vect, v2:Vect):Number {
			var dp:Number = v1.vx * v2.dx + v1.vy * v2.dy;
			return dp;
		}

		//creates new vector from point and 2 components
		public static function vFrom1Point (p0:Point, vx:Number, vy:Number):Vect {
			var p1:Point = new Point(p0.x + vx,p0.y + vy);
			var v:Vect = new Vect(p0, p1);
			return v;
		}
		//projects vector v1 on the vector v2 and returns projection vector
		public static function projectVector (v1:Vect, v2:Vect):Vect {
			var dp:Number = dotProduct(v1, v2);
			var pvx:Number = dp * v2.dx;
			var pvy:Number = dp * v2.dy;
			var v:Vect = Vect.vFrom1Point(v1.p0, pvx, pvy);
			return v;
		}
		//find if 2 vectors are parallel
		public static  function parVectors (v1:Vect, v2:Vect):Boolean {
			var par:Boolean = false;
			if ((v1.dx == v2.dx && v1.dy == v2.dy) || (v1.dx == - v2.dx && v1.dy == - v2.dy)) {
				par = true;
			}
			return par;
		}
		//calculate perp product of 2 vectors
		public static function perP (v1:Vect, v2:Vect):Number {
			var pp:Number = v1.vx * v2.vy - v1.vy * v2.vx;
			return pp;
		}
		//find intersection point of 2 vectors
		public static function findIntersection (v1:Vect, v2:Vect):Array {
			var t1:Number = 1000000;
			var t2:Number = 1000000;
			var ip:Point = new Point();
			//they can only intersect if v1.p0 is on 1 side of v2 
			//and v1.p1 is on other side
			var v2n = Vect.vFrom1Point(v2.p0, v2.rx, v2.ry);
			if (dotProduct(v1, v2n) < 0){
				var v3:Vect = new Vect (v1.p0, v2.p0);
				if (dotProduct(v3, v2n) < 0){
					t1 = perP(v3, v2) / perP(v1, v2);
					v3 = new Vect (v2.p0, v1.p0);
					t2 = perP(v3, v1) / perP(v2, v1);
					if(t1 < 0 || t2 < 0 || t1 > 1 || t2 > 1){
						t1 = 1000000;
					}
				}
			}
			ip.x = v1.p0.x + v1.vx * t1;
			ip.y = v1.p0.y + v1.vy * t1;
			var iArr:Array = new Array(ip, t1, t2);
			return iArr;
		}
		//find new vector for v1 bouncing from v2
		public static function bounce (v1:Vect, v2:Vect, ip:Point):Vect {
			//projection of v1 on v2
			var proj1:Vect = projectVector(v1, v2);
			var v2n:Vect = Vect.vFrom1Point(v2.p0, v2.lx, v2.ly);
			//projection of v1 on v2 normal
			var proj2:Vect = projectVector(v1, v2n);
			if(dotProduct(proj2, v2n) < 0){
				proj2 = new Vect(proj2.p1, proj2.p0);
			}
			//add up the projections to create new vector
			var bv:Vect = Vect.vFrom1Point(ip, proj1.vx - proj2.vx, proj1.vy - proj2.vy);
			return bv;
		}
		//find collision of ball with line
		//return array [0]=point [1]=bounce vector
		public static function b2Line (ob:Circle, v:Vect):Array {
			var returnArray:Array = new Array();
			returnArray[0] = ob.v.p1;
			//vector from ball center to start of line
			var v1:Vect = new Vect (ob.v.p0, v.p0);
			
			//project on line normal
			var vn:Vect = Vect.vFrom1Point(v.p0, v.rx, v.ry);
			var v1Proj:Vect = Vect.projectVector(v1, vn);
			//if ball starts too close to line
			if(v1Proj.len < ob.r){
				vn = Vect.vFrom1Point(new Point(ob.v.p0.x + vn.dx * ob.r, ob.v.p0.y + vn.dy * ob.r), -vn.dx * ob.r * 2, -vn.dy * ob.r * 2);
				if(Vect.findIntersection(new Vect (v.p1, v.p0), vn)[1] != 1000000){
					var fixPos:Number = ob.r - v1Proj.len;
					returnArray[0] = new Point(v1Proj.p1.x - vn.dx * ob.r, v1Proj.p1.y - vn.dy * ob.r);
					returnArray[2] = v;
					returnArray[1] = 0;
					return returnArray;
				}
			}
			
			var p:Point = new Point(v.p0.x + v.rx / v.len * ob.r, v.p0.y + v.ry / v.len * ob.r);
			v1 = Vect.vFrom1Point (p, v.vx, v.vy);
			var arr:Array = Vect.findIntersection(ob.v, v1);
			if(arr[1] != 1000000){
				//bounce from line
				returnArray[0] = arr[0];
				returnArray[2] = v1;
				returnArray[1] = arr[1];
			}else{
				//find collision with endpoints of the line
				var a1:Array = Vect.b2Ball (ob, new Circle(v.p0, 0, 0, 0));
				var a2:Array = Vect.b2Ball (ob, new Circle(v.p1, 0, 0, 0));
				if(a1[1] < a2[1]){
					arr = a1;
				}else{
					arr = a2;
				}
				if(arr[1] < 1){
					//vector from point to ball center
					v1 = new Vect(arr[2], arr[0]);
					//use normal for bounce
					v1 = Vect.vFrom1Point (v1.p0, v1.lx, v1.ly);
					trace(v1.vx+" "+v1.vy+" "+v1.p0.x+" "+v1.p0.y);
					returnArray[0] = arr[0];
					returnArray[2] = v1;
					returnArray[1] = arr[1];
				}
			}
			return returnArray;
		}
		//find collision of ball with point
		public static function b2Ball (ob1:Circle, ob2:Circle):Array {
			var totalR:Number = ob1.r + ob2.r;
			var arr:Array =  new Array();
			var v = Vect.vFrom1Point (ob1.v.p0, ob1.v.vx - ob2.v.vx, ob1.v.vy - ob2.v.vy);
			//vector between centers of balls
			var v1:Vect = new Vect(v.p0, ob2.v.p0);
			//if they start too close
			if(v1.len < totalR){
				var fixPos:Number = totalR - v1.len;
				arr[0] = new Point(ob1.v.p0.x - v1.dx * fixPos, ob1.v.p0.y - v1.dy * fixPos);
				arr[2] = ob2.v.p0;
				arr[1] = 0;
				return arr;
			}
			//project on v
			v1 = Vect.projectVector (v1, v);
			//must be same direction with v
			if(dotProduct(v1, v) < 0){
				arr[1] = 1000000;
				return arr;
			}
			//vector in direction of v normal to point
			v1 = new Vect(v1.p1, ob2.v.p0);
			if(v1.len / totalR < 1){
				var len:Number = Math.sqrt(totalR * totalR - v1.len * v1.len);
				//vector to move ball back until it exactly hits the point
				v1 = Vect.vFrom1Point (v1.p0, -v.dx * len, -v.dy * len);
				arr[0] = v1.p1;
				arr[2] = ob2.v.p0;
				//time to move the ball
				v1 = new Vect(v.p0, v1.p1);
				arr[1] = v1.len / v.len;
				if(dotProduct(v1, v) < 0){
					arr[1] = 1000000;
				}
			}else{
				arr[1] = 1000000;
			}
			return arr;
		}

		public var p0:Point;
		public var p1:Point;
		public var vx:Number;
		public var vy:Number;
		public var len:Number;
		public var dx:Number;
		public var dy:Number;
		public var rx:Number;
		public var ry:Number;
		public var lx:Number;
		public var ly:Number;

		public function Vect (newp0:Point, newp1:Point) {
			p0 = newp0;
			p1 = newp1;
			vx = p1.x - p0.x;
			vy = p1.y - p0.y;
			len = Math.sqrt(vx * vx + vy * vy);
			if(len == 0){
				dx = 0;
				dy = 0;
			}else{
				dx = vx / len;
				dy = vy / len;
			}
			rx = -vy;
			ry = vx;
			lx = vy;
			ly = -vx;
		}
	}
}