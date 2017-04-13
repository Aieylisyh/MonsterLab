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
		private var smokeCurce:Effect;
		public function Potion(pType:String, pColor1:String, pColor2:String = "0x7F7F7F",pColor3:String = "0x7F7F7F") 
		{
			super("Player");
			init(Mixer.getInstance().getPotionContainer(), Monster.getInstance(), Math.random() * 280 - 140, 0, 0, 0.6, 120);
			type = pType;
			color = ColorManager.setColor(this, pColor1, pColor2, pColor3);
			trace("Potion color is "+color);
			Mixer.getInstance().getPotionContainer().addChild(this);
			smokeCurce = new Effect("");
			smokeCurce.init_heartCurve(0, 0, 0, 50, 1, 12);
			this.addChild(smokeCurce);
		}
		
		override protected function onDragToTarget():void {
			Monster.getInstance().usePotion(this);
			willGoBack = false;
			willBeDestroyed = true;
			Mixer.getInstance().potionUsed();
		}
		
		override protected function dragingFunction():void {
			if (Math.random() > 0.05)
				return;
			var eff:Effect = new Effect("Bullet");
			eff.init_rotateAndTransit( Math.random() *120-60, 55, 0, 24+Math.random() *30, 0, 0, 0,0,0,0.3);
			ColorManager.setColor(eff, color);
			this.addChildAt(eff,1);
		}
		
		override protected function idleFunction():void {
			if (smokeCurce != null && smokeCurce.isDestroyed)
				smokeCurce = null;
			if (smokeCurce != null && Math.random() > 0.6) {
				var eff0:Effect = new Effect("Bullet");
				eff0.init_rotateAndTransit( smokeCurce.x + x, smokeCurce.y + y, 0, 72, 0, -2);
				Mixer.getInstance().getPotionContainer().addChild(eff0);
			}
			if (Math.random() > 0.04)
				return;
			var eff:Effect = new Effect("Bullet");
			eff.init_rotateAndTransit( x+Math.random() *32-16, y-90, 0, 72, 0, -2);
			Mixer.getInstance().getPotionContainer().addChild(eff);
		}
	}

}