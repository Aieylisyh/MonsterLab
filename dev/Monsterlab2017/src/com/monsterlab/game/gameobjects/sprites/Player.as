package com.monsterlab.game.gameobjects.sprites {
import com.monsterlab.game.gameobjects.GameObject;
import com.monsterlab.GameStage;
import com.utils.FMath;
import com.utils.SoundManager;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.media.Sound;
	public class Player extends GameObject
	{
		
		protected static var instance: Player;
		protected var controller:PlayerController;
		public function Player() 
		{
			super();
			init(GameStage.MID_H, GameStage.SAFE_ZONE_HEIGHT * 0.9,4,generateGraphics("Player"));
		}
		
		public static function getInstance (): Player {
			if (instance == null) instance = new Player();
			return instance;
		}
		
		private function init(pX:Number,py:Number,playerMode:int,sprite:Sprite):void {
			x = pX;
			y = Math.round(py);
			

			
			controller = new PlayerController(this);
			controller.start();
			start();
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
		}
	}
}