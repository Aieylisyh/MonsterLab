package com.monsterlab.ui {
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	
	public class OptionScreen extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: OptionScreen;
		
		public static var wasTitleCard: Boolean;

		public var btnSound:Button;
		public var btnBack:Button;

		public function OptionScreen() 
		{
			super();

			btnSound = new Button("Btn4", onClickSound, 0, 40);
			//btnBack = new Button("", startGame, 0, 40);

			addChild(btnSound);
			//addChild(btnBack);

		}
		
		public static function getInstance (): OptionScreen {
			if (instance == null) instance = new OptionScreen();
			return instance;
		}
		
		private function onClickSound():void {
			
		}
		
		private function onClickBack():void {
			if (wasTitleCard) {
				wasTitleCard = false;	
				UIManager.getInstance().addScreen(TitleCard.getInstance());
			}
			else UIManager.getInstance().addScreen(TitleCard.getInstance());
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			btnSound.destroy();
			//btnBack.destroy();
			btnSound = null;
			//btnBack = null;
			super.destroy();
		}

	}
}