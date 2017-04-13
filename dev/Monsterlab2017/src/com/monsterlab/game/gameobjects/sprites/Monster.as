package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
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
			
		}
	}

}