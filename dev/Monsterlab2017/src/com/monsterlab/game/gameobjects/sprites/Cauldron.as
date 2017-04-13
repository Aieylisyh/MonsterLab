package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.StateGraphic;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Cauldron extends StateGraphic 
	{
		
		/**
		 * instance unique de la classe Cauldron
		 */
		protected static var instance: Cauldron;
		
		public var ingredientList:Vector.<Vector.<String>>;

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Cauldron {
			if (instance == null) instance = new Cauldron();
			return instance;
		}		
	
		public function Cauldron() 
		{
			super();
			
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public function destroy (): void {
			instance = null;
		}

	}
}