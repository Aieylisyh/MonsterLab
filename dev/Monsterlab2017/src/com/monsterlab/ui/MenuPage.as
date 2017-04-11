package com.monsterlab.ui {
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	public class MenuPage extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: MenuPage;

		public var btn:Button;

		public function MenuPage() 
		{
			super();

			btn = new Button("Btn4", startGame, 0, 40);

			addChild(btn);

		}
		
		public static function getInstance (): MenuPage {
			if (instance == null) instance = new MenuPage();
			return instance;
		}
		
		private function startGame():void {
			GameManager.getInstance().startGame();
		}
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			btn.destroy();
			btn = null;
			super.destroy();
		}

	}
}