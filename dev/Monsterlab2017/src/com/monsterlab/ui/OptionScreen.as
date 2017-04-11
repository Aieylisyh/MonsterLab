package com.monsterlab.ui {
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class OptionScreen extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: OptionScreen;
		
		public static var wasTitleCard: Boolean;
		
		
		public var mcBackground:Sprite;
		public var mcHighScore:MovieClip;
		public var btnVolume:SimpleButton;
		public var btnBack:SimpleButton;

		public function OptionScreen() 
		{
			super();
		}
		
		public static function getInstance (): OptionScreen {
			if (instance == null) instance = new OptionScreen();
			return instance;
		}
		
		override protected function addListeners():void {
			btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			btnVolume.addEventListener(MouseEvent.CLICK, onClickSound);
		}
		
		override protected function removeListeners():void {
			btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
			btnVolume.removeEventListener(MouseEvent.CLICK, onClickSound);
		}
		
		private function onClickSound(pEvent:MouseEvent):void {
			
		}
		
		private function onClickBack(pEvent:MouseEvent):void {
			if (wasTitleCard) {
				wasTitleCard = false;	
				UIManager.getInstance().addScreen(TitleCard.getInstance());
			}
			else UIManager.getInstance().addScreen(PauseScreen.getInstance());
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