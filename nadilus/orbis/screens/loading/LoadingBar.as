package nadilus.orbis.screens.loading
{
	import fl.text.TLFTextField;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class LoadingBar extends MovieClip
	{
		private var _text:TLFTextField;
		private var _inside:MovieClip;
		
		private static const STROKE_PX:Number = 2;
		
		public function LoadingBar() {
			trace("LoadingBar: LoadingBar(): Called");
			_inside = loadingInside_mc;
			_text = text_mc;
			_inside.width = 0;
						
			_text.y = this.height/2-_text.height/2;
			_text.x = this.width/2-_text.width/2;
		
		}
		
		public function setText(text:String):void {
			trace("LoadingBar: setText(): Called: " + text);
			_text.text = text;
		}
		
		public function setPercent(percent:Number):void {
			trace("LoadingBar: setScale(): Called: " + percent);
			_inside.width = (percent*this.width)-STROKE_PX*2;
		}
	}
}