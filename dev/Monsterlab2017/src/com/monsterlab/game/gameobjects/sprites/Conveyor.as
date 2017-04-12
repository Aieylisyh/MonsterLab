package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Conveyor extends GameObject 
	{
		
		/**
		 * instance unique de la classe Conveyor
		 */
		protected static var instance: Conveyor;

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Conveyor {
			if (instance == null) instance = new Conveyor();
			return instance;
		}		
	
		public function Conveyor() 
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