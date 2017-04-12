package com.monsterlab.ui.screens 
{	
	import com.monsterlab.ui.Screen;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Hud extends Screen 
	{
		
		/**
		 * instance unique de la classe Hud
		 */
		protected static var instance: Hud;
		
		private var mcTimer:MovieClip;
		private var mcHudPart:MovieClip;
		private var mcScore:MovieClip;
		private var mcConveyor:MovieClip;
		private var btnPause:SimpleButton;
		private var mcRecipe:MovieClip;

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
			super.destroy()
		}

	}
}