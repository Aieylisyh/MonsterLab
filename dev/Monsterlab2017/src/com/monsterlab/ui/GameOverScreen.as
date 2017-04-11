package com.monsterlab.ui {
	import com.Main;
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName; 
	import flash.geom.Matrix;
	
	
	public class GameOverScreen extends Screen 
	{
		
		/**
		 * instance unique de la classe GameOver
		 */
		protected static var instance: GameOverScreen;
		
		protected var bmp:Bitmap;
		public var btnRetry:SimpleButton;
		public var btnMenu:SimpleButton;
		public var mcBackground:Sprite;
		public var mcScore:MovieClip;
		
		public function GameOverScreen() 
		{
			super();
			
			/*Exemple pour du bitmap
			//create just a "you win" image, but use bitmap to save memory, so it is very long
			var myBitmapData:BitmapData;
			var w:Number;
			var h:Number;
			var ClassReference:Class = getDefinitionByName("Win") as Class;
			var graphic:* = new ClassReference(); 
			w = graphic.width;
			h = graphic.height;
			myBitmapData = new BitmapData(w, h, true, 0);
			
			myBitmapData.draw(graphic, new Matrix(1, 0, 0, 1, graphic.width * 0.5, graphic.height * 0.5));
			bmp = new Bitmap(myBitmapData);
			bmp.x = -w * 0.5;
			bmp.y = -h * 0.5-60;
			addChild(bmp);
			*/
			
		}
		
		public static function getInstance (): GameOverScreen {
			if (instance == null) instance = new GameOverScreen();
			return instance;
		}
		
		override protected function addListeners():void {
			btnRetry.addEventListener(MouseEvent.CLICK, restart);
			btnMenu.addEventListener(MouseEvent.CLICK, onClickMenu);
		}
		
		override protected function removeListeners():void {
			btnRetry.removeEventListener(MouseEvent.CLICK, restart);
			btnMenu.removeEventListener(MouseEvent.CLICK, onClickMenu);
		}
		
		private function restart(pEvent:MouseEvent):void {
			UIManager.getInstance().closeScreens();
			GameManager.getInstance().restart();
		}
		
		private function onClickMenu(pEvent:MouseEvent):void {
			UIManager.getInstance().addScreen(TitleCard.getInstance());
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			//removeChild(bmp);
			bmp = null;
			super.destroy();
		}
		
		/*override protected function onResize (pEvent:Event=null): void {	
			UIManager.getInstance().setPosition(mcBackground, UIPosition.FIT_SCREEN);
		}*/

	}
}