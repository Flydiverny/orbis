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
		private var xPower:Number = 6;
		private var yPower:Number = 6;
		
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
			if(up)
				ySpeed -= f(3);
			if(down)
				ySpeed += f(2);
			
			if(!up && !down && ySpeed != 0)
				ySpeedDec();
			if(!left && !right && xSpeed != 0)
				xSpeedDec();
			
			this.x += xSpeed;
			this.y += ySpeed;
		}
		
		private function movementConstraints():void {
			//Lower Block
			if(this.y > GameConstants.LEVEL_HEIGHT-this.height*1.5)
				this.y = GameConstants.LEVEL_HEIGHT-this.height*1.5;
			
			//Upper Block
			if(this.y < GameConstants.LEVEL_HEIGHT-this.height*1.5)
				this.y = GameConstants.LEVEL_HEIGHT-this.height*1.5;
			
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
			else if(what == 2)
				return yPower-yFriction*ySpeed;
			else if(what == 3)
				return yPower+yFriction*ySpeed;
			else
				return 0;
		}
		
		private function xSpeedDec():void {
			if(xSpeed > 0) {
				xSpeed -= xFriction*xPower*7;
			}
			if(xSpeed < 0) {
				xSpeed += xFriction*xPower*7;
			}
			if(xSpeed < 1 && xSpeed > -1)
				xSpeed = 0;
		}
		
		private function ySpeedDec():void {
			if(ySpeed > 0) {
				ySpeed -= yFriction*yPower*7;
			}
			if(ySpeed < 0) {
				ySpeed += yFriction*yPower*7;
			}
			if(ySpeed < 1 && ySpeed > -1)
				ySpeed = 0;
		}
	}
}