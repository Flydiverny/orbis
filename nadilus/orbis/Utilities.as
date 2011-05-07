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
	}
}