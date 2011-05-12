package nadilus.orbis.screens.game
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.geom.Point;
	
	public class Stats extends Sprite {
		
		// Constants:
		// Public Properties:
		private var score:int;
		private var fC:int = 0;
		private var out:TextField = new TextField();
		private var format:TextFormat = new TextFormat();
		private var spawner:MovieClip;
		
		// Private Properties:
		private var color:uint;
		
		// Initialization:
		public function Stats(spawner:MovieClip, point:Point, text:String, color:uint = 0x66CD00) {
			this.spawner = spawner;
			
			this.x = point.x;
			this.y = point.y;
			
			this.color = color;
			
			setText(text);
			
			spawner.addChild(this);
			
			this.addEventListener(Event.ENTER_FRAME,eventHandler);
		}
		
		// Public Methods:
		private function eventHandler(event:Event):void {
			this.alpha -= 0.03;
			
			if(fC < 10)
				format.size = 12+fC;
			else
				format.size = 32-fC;
			
			out.defaultTextFormat = format;
			out.text = out.text;
			
			fC++;
			
			if(fC == 23)
				spawner.removeChild(this);
		}
		
		// Protected Methods:
		private function setText(txtIn:String):void {
			out.autoSize = TextFieldAutoSize.CENTER;
			
			format.font = "Verdana";
			format.color = this.color;
			format.size = 10;
			out.defaultTextFormat = format;
			
			out.text = txtIn;
			out.textColor = this.color;

			out.visible = true;
			this.addChild(out);
		}
	} //End Class
}