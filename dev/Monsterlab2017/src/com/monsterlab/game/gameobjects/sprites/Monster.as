package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.ui.ColorManager;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class Monster extends GameObject 
	{
		protected static var instance: Monster;
		public function Monster() 
		{
			super();
		}
		public static function getInstance (): Monster {
			if (instance == null) instance = new Monster();
			return instance;
		}
		public function usePotion(pPotion:Potion):void {
			var red:Number = ColorManager.red(pPotion.color);
			var green:Number = ColorManager.green(pPotion.color);
			var blue:Number = ColorManager.blue(pPotion.color);
			trace("red " + red);
			trace("green " + red);
			trace("blue " + red);
			
		}
	}

}