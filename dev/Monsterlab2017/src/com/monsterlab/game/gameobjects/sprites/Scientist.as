package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.StateGraphic;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Scientist extends StateGraphic 
	{
		
		/**
		 * instance unique de la classe Scientist
		 */
		protected static var instance: Scientist;

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Scientist {
			if (instance == null) instance = new Scientist();
			return instance;
		}		
	
		public function Scientist() 
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