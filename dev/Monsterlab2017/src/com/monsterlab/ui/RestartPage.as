package com.monsterlab.ui {
	import com.Main;
	import com.monsterlab.GameManager;
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.ui.Screen;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.UIManager;
	import flash.utils.getDefinitionByName; 
	import flash.geom.Matrix;
	
	
	public class RestartPage extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: RestartPage;
		protected var bmp:Bitmap;
		public var btn:Button;
		public var btn2:Button;
		public function RestartPage() 
		{
			super();
			
			btn = new Button("BtnRestart", GameManager.getInstance().restart, 0, 90);
			addChild(btn);
			
			btn2 = new Button("BtnQuit", Main.getInstance().exit, 0, 200);
			addChild(btn2);
			
			
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
		}
		
		public static function getInstance (): RestartPage {
			if (instance == null) instance = new RestartPage();
			return instance;
		}
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			removeChild(bmp);
			bmp = null;
			instance = null;
			btn.destroy();
			btn = null;
			btn2.destroy();
			btn2 = null;
			super.destroy();
		}

	}
}