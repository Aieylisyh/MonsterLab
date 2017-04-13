package com.monsterlab.ui 
{
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Adridro
	 */
	public class ColorManager 
	{
		
		public function ColorManager() 
		{
			
		}
		
		public static function setColor(pObject:DisplayObject, pColor1:String, pColor2:String = "0x7F7F7F", pColor3:String = "0x7F7F7F"):void
		{
			//red
			var lRed:Number = colorCalcul(pColor1, pColor2, pColor3, "red") / 255;
			var lGreen:Number = colorCalcul(pColor1, pColor2, pColor3, "green") / 255;
			var lBlue:Number = colorCalcul(pColor1, pColor2, pColor3, "blue") / 255;
			
			var filterMatrix:Array = new Array();
			filterMatrix = filterMatrix.concat([lRed, 0, 0, 0, 0]); // red
			filterMatrix = filterMatrix.concat([0, lGreen, 0, 0, 0]); // green
			filterMatrix = filterMatrix.concat([0, 0, lBlue, 0, 0]); // blue
			filterMatrix = filterMatrix.concat([0, 0, 0, 1, 0]); // alpha
			
			trace();
			
			
			applyFilter(pObject, filterMatrix);
		}
		
		private static function applyFilter(pObject:DisplayObject, matrix:Array):void {
            var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
            var filters:Array = new Array();
            filters.push(filter);
            pObject.filters = filters;
        }
		
		private static function red(pColor:String):int
		{
			pColor = pColor.substr(2);
			pColor = pColor.slice(0, 2);
			return int("0x"+pColor);
		}
		
		private static function green(pColor:String):int
		{
			pColor = pColor.substr(2);
			pColor = pColor.slice(2, 4);
			return int("0x"+pColor);
		}
		
		private static function blue(pColor:String):int
		{
			pColor = pColor.substr(2);
			pColor = pColor.slice(4);
			return int("0x"+pColor);
		}
		
		private static function colorCalcul(pColor1:String, pColor2:String, pColor3:String, pColorChoose:String):int
		{
			var lColor:int;
			var lAlpha:int = 1;
			
			var lColor1:int;
			var lColor2:int;
			var lColor3:int;
			
			if (pColorChoose == "red")
			{
				lColor1 = red(pColor1);
				lColor2 = red(pColor2);
				lColor3 = red(pColor3);
			}
			if (pColorChoose == "green")
			{
				lColor1 = green(pColor1);
				lColor2 = green(pColor2);
				lColor3 = green(pColor3);
			}
			if (pColorChoose == "blue")
			{
				lColor1 = blue(pColor1);
				lColor2 = blue(pColor2);
				lColor3 = blue(pColor3);
			}
			
			lColor = (lColor1 + lColor2 + lColor3)/3;
			
			return lColor;
		}
	}
}