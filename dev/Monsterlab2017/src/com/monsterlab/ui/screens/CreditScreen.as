package com.monsterlab.ui.screens {
	import com.monsterlab.GameManager;
	import com.monsterlab.game.gameobjects.sprites.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	import flash.events.MouseEvent;
	
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
		}
		
		public static function getInstance (): CreditScreen {
			if (instance == null) instance = new CreditScreen();
			return instance;
		}
		
		override protected function addListeners():void {
			btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
		}
		
		override protected function removeListeners():void {
			btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
		}
		
		private function onClickBack(pEvent:MouseEvent):void {
			UIManager.getInstance().addScreen(OptionScreen.getInstance());
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