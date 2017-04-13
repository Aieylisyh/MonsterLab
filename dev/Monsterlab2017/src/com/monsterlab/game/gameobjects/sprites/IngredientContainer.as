package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.GameStage;
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class IngredientContainer extends GameObject 
	{
		public var myIngredient:Ingredient;
		
		private var graphic:MovieClip;
		
		public function IngredientContainer(pName:String) 
		{
			super();
			x = 1400;
			y = GameStage.MID_V * 1.365;
			start();
			var ClassReference:Class = getDefinitionByName(pName) as Class;
            graphic = new ClassReference();
			if (graphic.totalFrames < 2) {
				graphic.cacheAsBitmap = true; 
				//graphic.cacheAsBitmapMatrix = new Matrix();
			}
			addChild(graphic);
			GameStage.getInstance().getGameContainer_4().addChild(this);
			//mouseChildren = false;
			mouseEnabled = false;
		}
		
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
			x -= Conveyor.speed;
			if (x < -30) {
				if (myIngredient != null) myIngredient.willBeDestroyed=true;
				destroy();
			}
		}
		
	}

}