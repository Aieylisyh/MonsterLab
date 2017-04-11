package com.monsterlab.ui {
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	
	public class CreditScreen extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: CreditScreen;

		
		public var mcBackground:Sprite;
		public var btnBack:SimpleButton;

		public function CreditScreen() 
		{
			super();
			//btnBack = new Button("", startGame, 0, 40);
			//addChild(btnBack);

		}
		
		public static function getInstance (): CreditScreen {
			if (instance == null) instance = new CreditScreen();
			return instance;
		}
		
		private function addListeners():void {
			//btnPlay.addEventListener(MouseEvent.CLICK, startGame);
			//btnOptions.addEventListener(MouseEvent.CLICK, startGame);
			//btnCredits.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function removeListeners():void {
			//btnPlay.removeEventListener(MouseEvent.CLICK, startGame);
			//btnOptions.removeEventListener(MouseEvent.CLICK, startGame);
			//btnCredits.removeEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function onClickBack():void {
			UIManager.getInstance().addScreen(TitleCard.getInstance());
		}
		
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			//btnBack.destroy();
			//btnBack = null;
			super.destroy();
		}

	}
}