package com.monsterlab.ui {
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	
	public class PauseScreen extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: PauseScreen;

		
		public var mcBackground:Sprite;
		public var btnResume:Button;
		public var BtnMenu:Button;
		public var BtnOptions:Button;
		public var BtnRetry:Button;

		public function OptionScreen() 
		{
			super();

			btnResume = new Button("Btn4", onClickSound, 0, 40);
			addChild(btnResume);
			
			//btnOptions = new Button("", onClickOptions, 0, 40);
			//addChild(btnBack);
			
			btnRetry = new Button("BtnRestart", GameManager.getInstance().restart, 0, 90);
			addChild(btnRetry);
			
			btnMenu = new Button("BtnQuit", onClickMenu, 0, 200);
			addChild(btnExit);

		}
		
		public static function getInstance (): PauseScreen {
			if (instance == null) instance = new PauseScreen();
			return instance;
		}
		
		private function onClickOptions():void {
			OptionScreen.wasTitleCard = true;
			UIManager.getInstance().addScreen(OptionScreen.getInstance());
		}
		
		private function onClickResume():void {
			UIManager.getInstance().closeScreens();
		}
		
		private function restart():void {
			UIManager.getInstance().closeScreens();
			GameManager.getInstance().restart();
		}
		
		private function onClickMenu():void {
			UIManager.getInstance().addScreen(TitleCard.getInstance());
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			btnResume.destroy();
			//btnBack.destroy();
			btnResume = null;
			//btnBack = null;
			super.destroy();
		}

	}
}