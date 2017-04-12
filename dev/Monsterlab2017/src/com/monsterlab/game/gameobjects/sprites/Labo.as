package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Labo extends GameObject 
	{
		
		/**
		 * instance unique de la classe Labo
		 */
		protected static var instance: Labo;

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Labo {
			if (instance == null) instance = new Labo();
			return instance;
		}		
	
		public function Labo() 
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