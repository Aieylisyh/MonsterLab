package com.monsterlab.ui.screens {
	import com.monsterlab.GameManager;
	import com.monsterlab.game.gameobjects.sprites.Button;
	import com.monsterlab.ui.Screen;
	import com.monsterlab.ui.screens.OptionScreen;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	import flash.events.MouseEvent;
	
	public class PauseScreen extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: PauseScreen;

		
		public var mcBackground:Sprite;
		public var btnResume:SimpleButton;
		public var btnMenu:SimpleButton;
		public var btnOption:SimpleButton;
		public var btnRetry:SimpleButton;

		public function PauseScreen() 
		{
			super();
		}
		
		public static function getInstance (): PauseScreen {
			if (instance == null) instance = new PauseScreen();
			return instance;
		}
		
		override protected function addListeners():void {
			btnResume.addEventListener(MouseEvent.CLICK, onClickResume);
			btnOption.addEventListener(MouseEvent.CLICK, onClickOption);
			btnMenu.addEventListener(MouseEvent.CLICK, onClickMenu);
			btnRetry.addEventListener(MouseEvent.CLICK, restart);
		}
		
		override protected function removeListeners():void {
			btnResume.removeEventListener(MouseEvent.CLICK, onClickResume);
			btnOption.removeEventListener(MouseEvent.CLICK, onClickOption);
			btnMenu.removeEventListener(MouseEvent.CLICK, onClickMenu);
			btnRetry.removeEventListener(MouseEvent.CLICK, restart);
		}
		
		private function onClickOption(pEvent:MouseEvent):void {
			OptionScreen.wasTitleCard = false;
			UIManager.getInstance().addScreen(OptionScreen.getInstance());
		}
		
		private function onClickResume(pEvent:MouseEvent):void {
			UIManager.getInstance().closeScreens();
		}
		
		private function restart(pEvent:MouseEvent):void {
			UIManager.getInstance().closeScreens();
			GameManager.getInstance().restart();
		}
		
		private function onClickMenu(pEvent:MouseEvent):void {
			GameManager.getInstance().reset();
			UIManager.getInstance().addScreen(TitleCard.getInstance());
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			super.destroy();
		}

	}
}