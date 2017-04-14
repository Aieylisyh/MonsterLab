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
		private var ingredient1Color:String = "0x7F7F7F";
		private var ingredient2Color:String = "0x7F7F7F";
		private var ingredient3Color:String = "0x7F7F7F";
		public function Potion(pType:String, pColor1:String, pColor2:String = "0x7F7F7F",pColor3:String = "0x7F7F7F") 
		{
			super("Player");
			scaleX = scaleY = 3;
			ingredient1Color = pColor1;
			ingredient2Color = pColor2;
			ingredient3Color = pColor3;
			init(Mixer.getInstance().getPotionContainer(), Monstre.getInstance(), Math.random() * 280 - 140, 0, 0, 0.6, 120);
			type = pType;
			color = ColorManager.setColor(this, pColor1, pColor2, pColor3);
			trace("Potion color is "+color);
			Mixer.getInstance().getPotionContainer().addChild(this);
			smokeCurce = new Effect("");
			smokeCurce.init_heartCurve(0, 0, 0, 50, 1, 12);
			this.addChild(smokeCurce);
		}
		
		override protected function onDragToTarget():void {
			Monstre.getInstance().usePotion(this);
			willGoBack = false;
			willBeDestroyed = true;
			Mixer.getInstance().potionUsed();
		}
		
		override protected function dragingFunction():void {
			if (Math.random() > 0.05)
				return;
			var eff:Effect = new Effect("particle_drop");
			eff.init_rotateAndTransit( Math.random() *120-60, 55, 0, 24+Math.random() *30, 0, 0, 0,0,0,0.3);
			ColorManager.setColor(eff, color);
			this.addChildAt(eff,1);
		}
		
		override protected function idleFunction():void {
			if (smokeCurce != null && smokeCurce.isDestroyed)
				smokeCurce = null;
			if (smokeCurce != null && Math.random() > 0.6) {
				var eff0:Effect = new Effect("particle_smoke");
				eff0.init_rotateAndTransit( smokeCurce.x + x, smokeCurce.y + y, 0, 72, 0, -2);
				Mixer.getInstance().getPotionContainer().addChild(eff0);
			}
			if (Math.random() > 0.04)
				return;
			var eff:Effect = new Effect("particle_smoke");
			eff.init_rotateAndTransit( x+Math.random() *32-16, y-90, 0, 72, 0, -2);
			Mixer.getInstance().getPotionContainer().addChild(eff);
		}
		
		public function compareRecette():Boolean {
			//TODO
			if (Recipe.recipeList.length == 0)
				return false;
			for each(var recipe:Recipe in Recipe.recipeList) {
				if (recipe.recipeIngredients.length == 0)
					continue;
				var result:Boolean = true;
				for each(var colorName:String in recipe.recipeIngredients) {
					if (colorName != ingredient1Color || colorName != ingredient2Color|| colorName != ingredient3Color) {
						result = false;
					}
				}
				if (result)
					return true;
			}
			return false;
		}
	}

}