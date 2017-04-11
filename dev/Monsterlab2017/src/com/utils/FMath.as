package com.utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class FMath 
	{
		public static const RAD2DEG:Number = 180 / Math.PI;
		public static const DEG2RAD:Number = Math.PI / 180;
		public function FMath() 
		{
			
		}
		
		public static function rotationBy2Points(from:Point, to:Point):Number {
			//the origin image to be 0 degree and face upwards, if not ,you can plus some degree in your situation
			var result:Number = 0;
			var dx:Number = to.x - from.x;
			var dy:Number = to.y - from.y;
			if (dx == 0) {
				if (dy > 0) result = 180;
			}else {
				result = Math.atan2(dy, dx) * RAD2DEG + 90;
			}
			return result;
		}
		public static function getDistance(from:Point, to:Point):Number {
			var result:Number = 0;
			var dx:Number = to.x - from.x;
			var dy:Number = to.y - from.y;
			var point:Point = new Point(dx, dy);
			result = point.length;
			return result;
		}
		public static function valueByRotation(rotation:Number):Point {
			//the origin image is supposed to be 0 degree and face upwards
			var point:Point = new Point(0, 0);
			point.x = Math.cos((rotation - 90)*DEG2RAD) ;
			point.y = Math.sin((rotation - 90)*DEG2RAD) ;
			return point;
		}
		public static function xFactorByRotation(lRotation:Number):Number {
			return Math.cos(lRotation*DEG2RAD);
		}
		public static function yFactorByRotation(lRotation:Number):Number {
			return Math.sin(lRotation*DEG2RAD);
		}
	}

}