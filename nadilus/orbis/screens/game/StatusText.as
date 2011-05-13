package nadilus.orbis.screens.game
{
		import flash.display.*;
		import flash.events.*;
		import nadilus.orbis.GameConstants;
		import flash.text.TextField;
		
		public class StatusText extends MovieClip {
			
			// Constants:
			
			// Private Properties:
			private var fC:int = 0;
			private var tfC:int = 0;
			private var showing:Boolean = false;
			
			private var textField:TextField;
			
			// Initialization:
			public function statusText(text:String) {
				
				textField = new TextField();
				textField.text = text;
				
				
				this.x = 0;
				this.y = ;
				this.addEventListener(Event.ENTER_FRAME,showHide);
				showing = true;
			}
			
			// Public Methods:
			private function showHide(event:Event):void {
				var frames:int = 8;
				tfC++;
				if(this.visible && fC == frames)
					this.visible = false;
				else if(!this.visible && fC == frames)
					this.visible = true;
				
				if(fC == frames)
					fC = 0;
				
				fC++;
				
				if(tfC == frames*5) {
					parent.removeChild(this);
					this.removeEventListener(Event.ENTER_FRAME,showHide);
					showing = false;
				}
			}
		}
	}