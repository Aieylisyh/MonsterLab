package com.monsterlab.game.gameobjects.sprites 
{
		import com.monsterlab.game.gameobjects.GameObject;
		import flash.display.DisplayObject;
		import flash.display.MovieClip;
		import flash.display.Sprite;
		import flash.geom.Point;
		import flash.media.Sound;
		import com.monsterlab.GameStage;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class Potion extends DragDropTarget
	{
		public var type:String;
		public var color:String;

		public function Potion(pType:String, pColor:String) 
		{
			super("Player");
			init(Mixer.getInstance().getPotionContainer(), Monster.getInstance(), Math.random() * 360 - 180, Math.random() * 200 - 100, 0, 0.6, 120);
			type = pType;
			color = pColor;
			setColor();
			Mixer.getInstance().getPotionContainer().addChild(this);
		}
		
		private function setColor():void {
			
		}
		
		override protected function onDragToTarget():void {
			Monster.getInstance().usePotion(this);
			willGoBack = false;
			willBeDestroyed = true;
		}
	}

}