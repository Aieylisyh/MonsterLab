package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.GameStage;
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class Background extends GameObject
	{
		protected static var instance: Background;
		public function Background() 
		{
			super();
			setBGState();
			x = GameStage.MID_H;
			y = GameStage.MID_V;
			GameStage.getInstance().getGameContainer_1().addChild(this);
		}
		public static function getInstance (): Background {
			if (instance == null) instance = new Background();
			return instance;
		}		
		
		public function setBGState(isAlert:Boolean=false ):void {
			generateGraphics(isAlert?"BackgroundAlert":"Background");
		}
	}

}