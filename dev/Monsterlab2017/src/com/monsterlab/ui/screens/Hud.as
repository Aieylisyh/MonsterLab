package com.monsterlab.ui.screens 
{
	import com.monsterlab.GameManager;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.Screen;
	import com.monsterlab.ui.UIManager;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.DisplayObjectContainer;
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
		public var mcConveyor:MovieClip;
		public var hudPart:MovieClip;
		public var scoreBar:TextField;
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
			hudPart.hudTop.x = 0;
			hudPart.hudTop.y = hudPart.hudTop.height / 2 - GameStage.MID_V;
			
			hudPart.hudBottom.x = 2;
			hudPart.hudBottom.y = -hudPart.hudBottom.height/2+(2430-2048)/2+GameStage.MID_V - 12;
		}
		
		public function getLiquidContainer():DisplayObjectContainer {
			trace(this.numChildren);
			var hudPart1:DisplayObjectContainer = DisplayObjectContainer(this.getChildAt(1));
			trace(hudPart1.numChildren);
			var hudPart2:DisplayObjectContainer = DisplayObjectContainer(hudPart1.getChildAt(1));
			trace(hudPart2.numChildren);
			var hudPart3:DisplayObjectContainer = DisplayObjectContainer(hudPart2.getChildAt(0));
			trace(hudPart3.numChildren);
			//hudPart1.removeChild(hudPart1.getChildAt(hudPart1.numChildren - 2));
			//hudPart1.removeChild(hudPart1.getChildAt(hudPart1.numChildren - 3));
			//return DisplayObjectContainer(hudPart1.getChildAt(hudPart1.numChildren-1));
			return DisplayObjectContainer(hudPart3);
		}
		override protected function addListeners():void 
		{
			super.addListeners();
			btnPause = hudPart.hudTop.btnPause;
			scoreBar = hudPart.hudTop.scoreBar.score;
			scoreBar.text = "10";
			trace(scoreBar.text);
			btnPause.addEventListener(MouseEvent.CLICK, onClickPause);
		}
		
		override protected function removeListeners():void 
		{
			super.removeListeners();
			btnPause.removeEventListener(MouseEvent.CLICK, onClickPause);
		}
		
		private function onClickPause(pEvent:MouseEvent):void {
			GameManager.getInstance().onPause();
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