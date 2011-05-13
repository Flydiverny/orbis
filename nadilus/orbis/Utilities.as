package nadilus.orbis
{
	import flash.geom.ColorTransform;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;

	public class Utilities
	{
		public static function setRGB(e:Object, color:uint):void {
			trace("Utilities: setRGB(): Called: " + e + " " + color);
			var c:ColorTransform = e.transform.colorTransform;
			c.color = color;
			e.transform.colorTransform = c;
		}
		
		public static function parseBoolean(value:Object):Boolean {
			trace("Utilities: parseBoolean(): Called: " + value);
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
		
		public static function getTime():Number
		{
			return new Date().getTime();
		}
		
		public static function createHueShiftColorMatrixFilter(angle:Number):ColorMatrixFilter
		{
			trace("Utilities: createHueShiftColorMatrixFilter(): Called: " + angle);
			angle *= Math.PI/180;
			
			var c:Number = Math.cos(angle);
			var s:Number = Math.sin(angle);
			
			var mulR:Number = 0.213;
			var mulG:Number = 0.715;
			var mulB:Number = 0.072;
			
			var matrix:Array = new Array();
			
			matrix = matrix.concat([(mulR + (c * (1 - mulR))) + (s * (-mulR)), (mulG + (c * (-mulG))) + (s * (-mulG)), (mulB + (c * (-mulB))) + (s * (1 - mulB)), 0, 0]);
			matrix = matrix.concat([(mulR + (c * (-mulR))) + (s * 0.143), (mulG + (c * (1 - mulG))) + (s * 0.14), (mulB + (c * (-mulB))) + (s * -0.283), 0, 0]);
			matrix = matrix.concat([(mulR + (c * (-mulR))) + (s * (-(1 - mulR))), (mulG + (c * (-mulG))) + (s * mulG), (mulB + (c * (1 - mulB))) + (s * mulB), 0, 0]);
			matrix = matrix.concat([0, 0, 0, 1, 0]);
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return filter;
		}
		
		public static function setHue(e:Object, angle:Number):void {
			trace("Utilities: setHue(): Called: " + e + " " + angle);
			var filters:Array = new Array();
			filters.push(Utilities.createHueShiftColorMatrixFilter(angle));
			e.filters = filters;
		}
		
		public static function degreesToXY(radius:Number, degree:Number):Point {
			var myPoint:Point = new Point();
			var radians=Math.PI/180;
			myPoint.x = radius * Math.cos(degree*(radians));
			myPoint.y = radius * Math.sin(degree*(radians));
			return myPoint;
		} 
	}
}