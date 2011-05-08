package nadilus.orbis
{
	import flash.geom.ColorTransform;

	public class Utilities
	{
		public static function setRGB(e:Object, color:uint):void {
			var c:ColorTransform = e.transform.colorTransform;
			c.color = color;
			e.transform.colorTransform = c;
		}
		
		public static function parseBoolean(value:Object):Boolean {
			switch(value) {
				case "1":
				case "true":
				case "yes":
					return true;
				case "0":
				case "false":
				case "no":
					return false;
				default:
					return Boolean(value);
			}
		}
	}
}