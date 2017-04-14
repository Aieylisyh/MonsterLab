package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class LiquidInTube extends GameObject
	{
		public var liquid:MovieClip;
		public static const COLOR_1:uint = 0xFF0000;
		public static const COLOR_2:uint = 0xFFFF00;
		public static const COLOR_3:uint = 0xFF00FF;
		public static const COLOR_4:uint = 0x00FF00;
		public static const COLOR_5:uint = 0x00FFFF;
		public static const COLOR_6:uint = 0x777777;
		public function LiquidInTube() 
		{
			super();
			var ClassReference:Class = getDefinitionByName("liquid") as Class;
            liquid = new ClassReference();
			liquid.gotoAndStop(1);
			addChild(liquid);
		}
		
		public function setColor(color:uint):void {
			var myColorTransform:ColorTransform = new ColorTransform();
			myColorTransform.color = color;
			liquid.getChildAt(0).transform.colorTransform = myColorTransform;
		}
		
		public function setPercentage(speed:Number):void {
			var delta:int = Math.floor(Math.abs(speed / MixerController.MAXROTATIONSPEED) * 1.1);
			if (delta <= 0)
				return;
			if (delta > 0 && liquid.currentFrame == liquid.totalFrames) {
				trace("liquid finish!");
				liquid.gotoAndStop(1);
				Mixer.getInstance().generatePotion();
				return;
			}
			liquid.gotoAndStop(int(liquid.currentFrame+delta));
			trace("liquid.currentFrame " + liquid.currentFrame);
		}
		
		public function isInProgress():Boolean {
			return liquid.currentFrame != 1;
		}
	}
}