package com.monsterlab.sprites.gameobjects 
{
	import com.monsterlab.GameObject;
	import com.monsterlab.GameStage;
	import com.utils.FMath;
	import com.utils.SoundManager;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class Mixer extends GameObject
	{
		
		protected static var instance: Mixer;
		protected var controller:MixerController;
		
		private var rotateSpeed:Number=0;
		private var rotateAcc:Number=0.6;
		private var text1:TextField;
		private var text2:TextField;
		public function Mixer() 
		{
			super();
			generateGraphics("Player")
			x = GameStage.MID_H;
			y = GameStage.SAFE_ZONE_HEIGHT * 0.7;
			controller = new MixerController(this);
			controller.start();//receive event, can drag
			start();
			/*text1 = new TextField();
			GameStage.getInstance().getGameContainer_3().addChild(text1);
			text1.scaleX = text1.scaleY = 4;
			text1.x = this.x-100 ;
			text1.y = this.y + 50;
			text2 = new TextField();
			GameStage.getInstance().getGameContainer_3().addChild(text2);
			text2.scaleX = text2.scaleY = 4;
			text2.x = this.x-100 ;
			text2.y = this.y + 100;*/
		}
		
		public static function getInstance (): Mixer {
			if (instance == null) instance = new Mixer();
			return instance;
		}
		
		public function setSpeed(speed:Number):void {
			rotateSpeed = speed;
		}
		override public function destroy():void
		{
			controller.stop();
			controller = null;
			instance = null;
			super.destroy();
		}
		
		override protected function doActionNormal (): void {
			super.doActionNormal();
			//text1.text = controller.isDraging.toString();
			//text2.text = x.toString() + "," +y.toString();
			if (!controller.isDraging)
            {
                if (rotateSpeed == 0)
                {
                    return;
                }
                if (rotateSpeed > rotateAcc)
                    rotateSpeed -= rotateAcc;
                else if (rotateSpeed < -rotateAcc)
                    rotateSpeed += rotateAcc;
                else
                    rotateSpeed = 0;
            }
            rotation += rotateSpeed;
		}
		
		public function reset():void {
			//call this from controller
			rotateSpeed = 0;
			rotation = 0;
		}
	}
}