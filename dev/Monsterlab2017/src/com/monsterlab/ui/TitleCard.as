package com.monsterlab.ui {
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	public class TitleCard extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: TitleCard;

		
		public var mcBackground:Sprite;
		public var btnPlay:Button;
		public var btnOptions:Button;
		public var btnCredits:Button;

		public function TitleCard() 
		{
			super();

			btnPlay = new Button("Btn4", startGame, 0, 40);
			//btnOptions = new Button("", startGame, 0, 40);
			//btnCredits = new Button("", startGame, 0, 40);

			addChild(btnPlay);
			//addChild(btnOptions);
			//addChild(btnCredits);

		}
		
		public static function getInstance (): TitleCard {
			if (instance == null) instance = new TitleCard();
			return instance;
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
			btnPlay.destroy();
			//btnOptions.destroy();
			//btnCredits.destroy();
			btnPlay = null;
			//btnOptions = null;
			//btnCredits = null;
			super.destroy();
		}

	}
}