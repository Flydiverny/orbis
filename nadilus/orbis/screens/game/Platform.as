package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;

	import flash.display.Stage;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.screens.OrbisGame;
	import nadilus.orbis.GameConstants;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.*;
	
	public class Platform extends MovieClip
	{
		// Keys
		private static var left:Boolean = false;
		private static var right:Boolean = false;
		private static var up:Boolean = false;
		private static var down:Boolean = false;
		private static var space:Boolean = false;
		
		// Movement
		private var ySpeed:Number = 0;
		private var xSpeed:Number = 0;
		private var xFriction:Number = 0.09;
		private var yFriction:Number = 0.09;
		private var xPower:Number = 1.5;
		private var yPower:Number = 1.5;
		
		public function Platform() {
			trace("Platform: Platform(): Called");
			Utilities.setHue(this, 500);
			
			OrbisGame.gStage.addEventListener(Event.ENTER_FRAME, movePlatform);
			OrbisGame.gStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			OrbisGame.gStage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		private function movePlatform(event:Event):void {
			//Lower Block "Invis Wall"
			if(this.y > GameConstants.LEVEL_HEIGHT-this.height*1.5)
				this.y = GameConstants.LEVEL_HEIGHT-this.height*1.5;
			//Upper Block "Invis Wall"
			if(this.y < GameConstants.LEVEL_HEIGHT-this.height*1.5)
				this.y = GameConstants.LEVEL_HEIGHT-this.height*1.5;
			
			if(this.x+xSpeed < 5) {
				this.xSpeed = 0;
				this.x = 5;
			}
			
			if(this.x+xSpeed+this.width > GameConstants.LEVEL_WIDTH-5) {
				this.xSpeed = 0;
				this.x = GameConstants.LEVEL_WIDTH-5-this.width;
			}
			
			updateSpeed();
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
		
		private function updateSpeed():void {
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
		
		private function keyPressed(event:KeyboardEvent):void {
			trace("Keypressed!!!");
			switch(event.keyCode) {
				case 37: 
					left = true;
					break;
				case 39:
					right = true;
					break;
				case 38:
					up = true;
					break;
				case 40:
					down = true;
					break;
				case Keyboard.SPACE:
					space = true;
					break;
				/*case Keyboard.SHIFT:
					changeWeapon(1);
					break;
				case Keyboard.CONTROL:
					changeWeapon(2);
					break;
				case 49:
					setWeapon(1);
					break;
				case 50:
					setWeapon(2);
					break;
				case 51:
					setWeapon(3);
					break;
				case 52:
				setWeapon(4);
				break;*/
			}
		}
		
		private function keyReleased(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37: 
					left = false;
					break;
				case 39:
					right = false;
					break;
				case 38:
					up = false;
					break;
				case 40:
					down = false;
					break;
				case Keyboard.SPACE:
					space = false;
					break;
			}
		}
	}
}