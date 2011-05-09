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
		private var _speed:Number = 1;
		private var damage:uint;
		private var bounces:uint = 1;
		private var life:uint;
		
		private var gravity:Number = 0.2;
		private var radius:uint = 5;
		private var precision:uint = 100;

		
		private var friction:Number = 0.90;
		
		private var _player:Player;
		private var _blocks:Array;
		
		private var _vector:Vect;
		
		private var ip:Point;
		
		//private var radius:Number;

		public function Orb(vect:Vect, lvl:Level, player:Player)
		{
			trace("Orb: Orb(): Called: " + vect + " " + lvl + " " + player);
			
			this._vector = vect;
			this._vector.vx = _vector.dx;
			this._vector.vy = _vector.dy;
			
			this.x = _vector.p1.x;
			this.y = _vector.p1.y;
			
			this._blocks = lvl.blocks;
			this._player = player,

			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(event:Event):void {
			/*if(this.x < 0) {
				this.x = 0;
				bounceBack();
			}
			
			if(this.x > GameConstants.LEVEL_WIDTH) {
				this.x = GameConstants.LEVEL_WIDTH;
				bounceBack();
			}
			
			if(this.y < 0) {
				this.y = 0;
				bounceBack();
			}
			
			if(this.y > GameConstants.LEVEL_HEIGHT) {
				//killball - score player etc.
			}*/
			
			checkCollission();
		}
		
		private function checkBlocks():void {
			var lvl:Level = Level ( this.parent );
			for each (var line:Array in lvl.blocks) {
				for each (var block:Block in line) {
					if(this.hitTestObject(block)){
						block.orbHit(this);
					}
				}
			}
		}
		
		public function bounceBack():void {
			this.bounces++;
		}
		
		private function checkCollission():void {
			var p1:Point = new Point(_player.platform.x, _player.platform.y);
			var p2:Point = new Point(_player.platform.x+_player.platform.width, _player.platform.y);

			var platform:Vect = new Vect(p1,p2);
			var leftWall:Vect = new Vect(new Point(0,0),new Point(0,GameConstants.LEVEL_HEIGHT));
			var topWall:Vect = new Vect(new Point(0,0),new Point(GameConstants.LEVEL_WIDTH,GameConstants.LEVEL_HEIGHT));
			var rightWall:Vect = new Vect(new Point(GameConstants.LEVEL_WIDTH,0),new Point(GameConstants.LEVEL_WIDTH,GameConstants.LEVEL_HEIGHT));
			
			var vectors:Array = new Array();
			vectors.push(platform);
			vectors.push(leftWall);
			vectors.push(topWall);
			vectors.push(rightWall);
			
			
			//intersection with walls
			var t:Number = 1000000;
			var v:Vect = platform;

			for each(var vect:Vect in vectors) {
				trace("Checking vect: " + vect + " p0: " + vect.p0 + " p1: " + vect.p1);
				var v1:Vect = vect;
				var p:Point = new Point(v1.p0.x + v1.rx / v1.len * (this.width/2), v1.p0.y + v1.ry / v1.len * (this.width/2));
				var v2:Vect = Vect.vFrom1Point (p, v1.vx, v1.vy);
				var p3:Point = new Point(v1.p0.x + v1.lx / v1.len * (this.width/2), v1.p0.y + v1.ly / v1.len * (this.width/2));
				var v3:Vect = Vect.vFrom1Point (p3, v1.vx, v1.vy);
				var arr = Vect.findIntersection(this._vector, v2);
				var arr2 = Vect.findIntersection(this._vector, v3);
				if(arr[1] < t){
					ip = arr[0];
					t = arr[1];
					v = vect;
				}
				if(arr2[1] < t){
					ip = arr2[0];
					t = arr2[1];
					v = vect;
				}
			}
			
			/*for each(var vect:Vect in vectors) {
				var arr = Vect.findIntersection(this._vector, vect);
				if(arr[1] < t){
					ip = arr[0];
					t = arr[1];
					v = vect;
				}
			}*/
			
			if(t != 1000000){
				//draw bounce vector
				this._vector = Vect.bounce(this._vector, v, ip);
				this._vector.p1 = ip;
			}
			
			this.moveMe();
			
			/*_v.p1.x = _v.p0.x + _v.vx;
			_v.p1.y = _v.p0.y + _v.vy;
			
			trace(_v.p1.x)
			trace(_v.p1.y)
			
			this.x = _v.p1.x;
			this.y = _v.p1.y;*/
		}
		
		private function get _v():Vect {
			_vector.p0 = new Point(this.x, this.y);
			
			return _vector;
		}
		
		public function moveMe() {
			_vector.p0 = _vector.p1;
			_vector = Vect.vFrom1Point (_vector.p0, _vector.vx, _vector.vy);
			placeMe();
		}
		
		internal function placeMe() {
			this.x = _vector.p0.x;
			this.y = _vector.p0.y;
		}
		
		public function speedMultiply(multi:Number):void {
			_speed *= multi;
		}
		
		public function get speed():Number {
			return _speed * bounces;
		}
	}
}
