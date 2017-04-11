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

		
		//public var mcBackground:Sprite;
		public var btnPlay:SimpleButton;
		public var btnOption:SimpleButton;
		public var btnCredit:SimpleButton;

		public function TitleCard() 
		{
			super();
		}
		
		public function initBtn():void {
			addListeners();	
		}
		
		public static function getInstance (): TitleCard {
			if (instance == null) instance = new TitleCard();
			return instance;
		}
		
		override protected function addListeners():void {
			btnPlay.addEventListener(MouseEvent.CLICK, startGame);
			btnOption.addEventListener(MouseEvent.CLICK, onClickOption);
			btnCredit.addEventListener(MouseEvent.CLICK, onClickCredit);
		}
		
		override protected function removeListeners():void {
			btnPlay.removeEventListener(MouseEvent.CLICK, startGame);
			btnOption.removeEventListener(MouseEvent.CLICK, onClickOption);
			btnCredit.removeEventListener(MouseEvent.CLICK, onClickCredit);
		}
		
		private function startGame(pEvent:MouseEvent):void {
			trace("patate");
			GameManager.getInstance().startGame();
		}
		
		private function onClickOption(pEvent:MouseEvent):void {
			OptionScreen.wasTitleCard = true;
			UIManager.getInstance().addScreen(OptionScreen.getInstance());
		}
		
		private function onClickCredit(pEvent:MouseEvent):void {
			UIManager.getInstance().addScreen(CreditScreen.getInstance());
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