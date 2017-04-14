package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.ui.screens.Hud;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class RecipeGraphic extends GameObject
	{
		public static var occupyContainer:Vector.<Boolean> = new <Boolean>[false,false,false,false];
		private var graphicIngredients:Array;
		public var myRecipe:Recipe;
		private var id:int =-1;
		public function RecipeGraphic(myRecipe:Recipe, containerID:int) 
		{
			id = containerID;
			myRecipe.myRecipeGraphic = this;
			graphicIngredients = new Array();
			for each(var name:Vector.<String> in myRecipe.recipeIngredients) {
				addIngredient(name[0]);
			}
			occupyContainer[containerID] = true;
			var container:DisplayObjectContainer = Hud.getInstance().getRecipeContainer(containerID+1);
			container.addChild(this);
		}
		
		private function addIngredient(pAssetName:String):void {
			var ClassReference:Class = getDefinitionByName("Ingredient_"+pAssetName) as Class;
				var graphic:MovieClip = new ClassReference();
				if (graphic.totalFrames < 2) {
					graphic.cacheAsBitmap = true; 
					//graphic.cacheAsBitmapMatrix = new Matrix();
				}
				graphic.scaleX = graphic.scaleY = 0.8;
				graphic.x = graphicIngredients.length * 130 - 130;
				graphic.y = 10;
				addChild(graphic);
				graphicIngredients.push(graphic);
		}
		
		override public function destroy():void
		{
			occupyContainer[id] = false;
			for each(var graphic:MovieClip in graphicIngredients) {
				removeChild(graphic);
				graphic = null;
			}
			super.destroy();
		}
		
		public static function findEmptyContainerID():int {
			for (var i:int=0; i < 4; i++ ) {
				if (!occupyContainer[i]) {
					return i;
				}
			}
			return -1;
		}
	}

}