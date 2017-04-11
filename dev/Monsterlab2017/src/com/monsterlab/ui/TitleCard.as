package com.monsterlab.ui {
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	import flash.events.MouseEvent;
	public class TitleCard extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: TitleCard;

		
		public var mcBackground:Sprite;
		public var btnPlay:SimpleButton;
		public var btnOptions:SimpleButton;
		public var btnCredits:SimpleButton;

		public function TitleCard() 
		{
			super();
		}
		
		public static function getInstance (): TitleCard {
			if (instance == null) instance = new TitleCard();
			return instance;
		}
		
		private function addListeners():void {
			btnPlay.addEventListener(MouseEvent.CLICK, startGame);
			//btnOptions.addEventListener(MouseEvent.CLICK, startGame);
			//btnCredits.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function removeListeners():void {
			btnPlay.removeEventListener(MouseEvent.CLICK, startGame);
			//btnOptions.removeEventListener(MouseEvent.CLICK, startGame);
			//btnCredits.removeEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function startGame():void {
			GameManager.getInstance().startGame();
		}
		
		private function onClickOptions():void {
			OptionScreen.wasTitleCard = true;
			UIManager.getInstance().addScreen(OptionScreen.getInstance());
		}
		
		private function onClickCredits():void {
			UIManager.getInstance().addScreen(CreditScreen.getInstance());
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			//btnPlay.destroy();
			//btnOptions.destroy();
			//btnCredits.destroy();
			//btnPlay = null;
			//btnOptions = null;
			//btnCredits = null;
			super.destroy();
		}

	}
}