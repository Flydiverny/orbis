package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.*;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.screens.OrbisGame;
	
	public class Platform extends MovieClip
	{
		// Movement
		private var ySpeed:Number = 0;
		private var xSpeed:Number = 0;
		private var xFriction:Number = 0.09;
		private var yFriction:Number = 0.09;
		private var xPower:Number = 5;
		private var yPower:Number = 0;
		
		public function Platform() {
			trace("Platform: Platform(): Called");
			Utilities.setHue(this, 500);
		}
		
		public function movePlatform(left:Boolean, right:Boolean, up:Boolean, down:Boolean):void {
			movementConstraints();
			
			if(left)
				xSpeed -= f(1);
			if(right)
				xSpeed += f(0);

			if(!left && !right && xSpeed != 0)
				xSpeedDec();
			
			this.x += xSpeed;
			this.y += ySpeed;
		}
		
		private function movementConstraints():void {
			//Left Block
			if(this.x+xSpeed < 5) {
				this.xSpeed = 0;
				this.x = 5;
			}
			
			//Right Block
			if(this.x+xSpeed+this.width > GameConstants.LEVEL_WIDTH-5) {
				this.xSpeed = 0;
				this.x = GameConstants.LEVEL_WIDTH-5-this.width;
			}
		}
		
		private function f(what:int):Number {
			if(what == 0)
				return xPower-xFriction*xSpeed;
			else if(what == 1)
				return xPower+xFriction*xSpeed;
			else
				return 0;
		}
		
		private function xSpeedDec():void {
			if(xSpeed > 0) {
				xSpeed -= xFriction*xFriction*xPower;
			}
			if(xSpeed < 0) {
				xSpeed += xFriction*xPower;
			}
			if(xSpeed < 1 && xSpeed > -1)
				xSpeed = 0;
		}
	}
}