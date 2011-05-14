package nadilus.orbis.screens.game
{
		import flash.display.*;
		import flash.events.*;
		import flash.text.TextField;
		import flash.text.TextFormat;
		
		import nadilus.orbis.GameConstants;
		
		public class StatusText extends MovieClip {
			
			// Constants:
			
			// Private Properties:
			private var fC:int = 0;
			private var tfC:int = 0;
			private var showing:Boolean = false;
			
			private var textField:TextField;
			private var subField:TextField;
			
			// Initialization:
			public function StatusText(text:String, subText:String = "") {
				trace("StatusText: StatusText(): Called");
				
				var format:TextFormat = new TextFormat();
				format.font = "DS-Digital";
				format.bold = true;
				format.color = 0x4444FF;
				format.size = 60;
				format.align = flash.text.TextFormatAlign.CENTER;
				
				textField = new TextField();
				textField.defaultTextFormat = format;
				textField.width = GameConstants.LEVEL_WIDTH;
				textField.x = 0;
				textField.y = 0;
				textField.text = text;
				
				if(subText.length > 0) {
					format.size = 30;
					subField = new TextField();
					subField.defaultTextFormat = format;
					this.addChild(subField);
				}

				this.addChild(textField);
				
				this.x = 0;
				this.y = GameConstants.SCREEN_HEIGHT/2-this.height/2;
				this.addEventListener(Event.ENTER_FRAME,showHide);
				showing = true;
			}
			
			// Public Methods:
			private function showHide(event:Event):void {
				var frames:int = 10;
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