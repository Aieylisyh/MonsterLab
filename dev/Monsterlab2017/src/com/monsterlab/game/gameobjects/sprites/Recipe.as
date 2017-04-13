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
		public static var recipeList:Vector.<Recipe>;
		
		public var recipeIngredients:Vector.<String>;
		
		public function Recipe() 
		{
			super();
			recipeList.push(this);
			
		}
		
		public static function initIngredientList():void {
			ingredientList = selectIngredients(5, Ingredient.INGREDIENTS_LIST);
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
		
		public static function createRecipe():void {
			var lRecipe:Recipe = new Recipe();
			var lList:Vector.<Vector.<String>> = selectIngredients(3, ingredientList);
			for (var i:int = 0; i < lList.length; i++) {
				lRecipe.recipeIngredients.push(lList[i][1]);
			}
			//lRecipe.recipeIngredients.sort();
		}
		
		public static function selectIngredients(pNum:int, pList:Vector.<Vector.<String>>):Vector.<Vector.<String>>{
			var lArray:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
			var lLength:int = pList.length;
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
	}

}