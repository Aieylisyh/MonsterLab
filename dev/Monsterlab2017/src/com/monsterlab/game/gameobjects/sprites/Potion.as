package com.monsterlab.game.gameobjects.sprites 
{
		import com.monsterlab.game.gameobjects.GameObject;
		import flash.display.DisplayObject;
		import flash.display.MovieClip;
		import flash.display.Sprite;
		import flash.geom.Point;
		import flash.media.Sound;
		import com.monsterlab.GameStage;
		import com.monsterlab.ui.ColorManager;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class Potion extends DragDropTarget
	{
		public var type:String;
		public var color:String;

		public function Potion(pType:String, pColor1:String, pColor2:String = "0x7F7F7F",pColor3:String = "0x7F7F7F") 
		{
			super("Player");
			init(Mixer.getInstance().getPotionContainer(), Monster.getInstance(), Math.random() * 280 - 140, 0, 0, 0.6, 120);
			type = pType;
			color = ColorManager.setColor(this, pColor1, pColor2, pColor3);
			trace("Potion color is "+color);
			Mixer.getInstance().getPotionContainer().addChild(this);
		}
		
		override protected function onDragToTarget():void {
			Monster.getInstance().usePotion(this);
			willGoBack = false;
			willBeDestroyed = true;
			Mixer.getInstance().potionUsed();
		}
	}

}