package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.InteractiveObject;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Recipe extends GameObject 
	{
		public static var ingredientList:Vector.<Vector.<String>>;
		public static var recipeList:Vector.<Recipe>= new Vector.<Recipe>();
		
		public var recipeIngredients:Vector.<Vector.<String>>=new Vector.<Vector.<String>>();
		public var myRecipeGraphic:RecipeGraphic;
		public function Recipe() 
		{
			super();
			recipeList.push(this);
			
		}
		
		public static function initIngredientList():void {
			ingredientList = selectIngredients(5, Ingredient.INGREDIENTS_TYPE);
		}
		
		private static function checkIngredient(pIngredient:Vector.<String>, pListToPut:Vector.<Vector.<String>>, pListToTake:Vector.<Vector.<String>>):Vector.<String> {
			var lIsIn:Boolean = false;
			var lLength:int = pListToPut.length;
			for (var i:int = 0; i < lLength; i++) {
				if (pIngredient == pListToPut[i]) {
					lIsIn = true;
				}
			}
			
			if (lIsIn) {
				pIngredient = pListToTake[Math.floor(Math.random() * pListToTake.length)];
				checkIngredient(pIngredient, pListToPut, pListToTake);
			}
			
			return pIngredient;
		}
		
		public static function createRecipe():Recipe {
			var lRecipe:Recipe = new Recipe();
			trace("11!"	);
			var lList:Vector.<Vector.<String>> = selectIngredients(3, ingredientList);
			trace(lList);
			for (var i:int = 0; i < lList.length; i++) {
				lRecipe.recipeIngredients.push(lList[i]);
			}
			trace("!"+lRecipe);
			return lRecipe;
		}
		
		public static function selectIngredients(pNum:int, pList:Vector.<Vector.<String>>):Vector.<Vector.<String>>{
			var lArray:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
			var lLength:int = pList.length;
			trace(lLength);
			for (var i:int = 0; i < pNum; i++) {
				var lIngredient:Vector.<String> = pList[Math.floor(Math.random() * lLength)];
				if (lArray.length == 0) lArray.push(lIngredient);
				else {
					lIngredient = checkIngredient(lIngredient, lArray, pList);
					lArray.push(lIngredient);
				}
			}
			
			return lArray;
		}
		override public function destroy():void
		{
			
			var i:int = recipeList.indexOf(this);
			recipeList.splice(i, 1);
			if (myRecipeGraphic != null )
				myRecipeGraphic.destroy();
			super.destroy();
		}
	}
	

}