package com.monsterlab.ui.screens 
{
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.Screen;
	import com.monsterlab.ui.UIManager;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Adridro
	 */
	public class Hud extends Screen 
	{
	
		public var btnPause:SimpleButton;
		public var Recipe0:MovieClip;
		public var Recipe1:MovieClip;
		public var Recipe2:MovieClip;
		public var Recipe3:MovieClip;
		public var mcRecipe:MovieClip;
		
		/**
		 * instance unique de la classe Hud
		 */
		protected static var instance: Hud;

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Hud {
			if (instance == null) instance = new Hud();
			return instance;
		}		
	
		public function Hud() 
		{
			super();
			x = GameStage.MID_H;
			y = GameStage.MID_V;
		}
		
		override protected function addListeners():void 
		{
			super.addListeners();
			btnPause.addEventListener(MouseEvent.CLICK, onClickPause);
		}
		
		override protected function removeListeners():void 
		{
			super.removeListeners();
			btnPause.removeEventListener(MouseEvent.CLICK, onClickPause);
		}
		
		private function onClickPause(pEvent:MouseEvent):void {
			//GameManger.getInstance().onPause();
			UIManager.getInstance().addScreen(PauseScreen.getInstance());
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
		}

	}
}