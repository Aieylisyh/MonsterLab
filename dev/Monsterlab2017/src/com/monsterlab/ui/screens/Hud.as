package com.monsterlab.ui.screens 
{
	import com.monsterlab.ui.Screen;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	/**
	 * ...
	 * @author Adridro
	 */
	public class Hud extends Screen 
	{
	
		public var btnPause:SimpleButton;
		public var Recipe0:MovieClip;
		public var Recipe1:MovieClip;
		public var Recipe2:MovieClip;
		public var Recipe3:MovieClip;
		public var mcRecipe:MovieClip;
		
		/**
		 * instance unique de la classe Hud
		 */
		protected static var instance: Hud;

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Hud {
			if (instance == null) instance = new Hud();
			return instance;
		}		
	
		public function Hud() 
		{
			super();
			
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
		}

	}
}