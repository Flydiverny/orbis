package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.data.Level;
	
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
		
		private var _vector:Object = new Object();
		
		//private var radius:Number;

		public function Orb(xPt:Number, yPt:Number, lvl:Level, player:Player)
		{
			trace("Orb: Orb(): Called: " + xPt + " " + yPt + " " + lvl + " " + player);
			_v.vx = xPt;
			_v.vy = yPt;
			
			_v.len=Math.sqrt(_v.vx*_v.vx+_v.vy*_v.vy);
			
			_v.dx=_v.vx/_v.len;
			_v.dy=_v.vy/_v.len;
			
			_v.vx=_v.dx;
			_v.vy=_v.dy;
			
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
		
			_v.nextPoint = {};
			_v.nextPoint.x = _v.currentPoint.x + _v.vx * speed;
			_v.nextPoint.y = _v.currentPoint.y + _v.vy * speed;
			
			if(_player.platform.hitTestPoint(_v.nextPoint.x, _v.nextPoint.y, true))
			{
				trace("platform hit!");
			}
			
			this.x = _v.nextPoint.x;
			this.y = _v.nextPoint.y;
		}
		
		private function get _v():Object {
			_vector.currentPoint = new Point(this.x, this.y);
			
			return _vector;
		}
		
		public function speedMultiply(multi:Number):void {
			_speed *= multi;
		}
		
		public function get speed():Number {
			return _speed * bounces;
		}
	}
}