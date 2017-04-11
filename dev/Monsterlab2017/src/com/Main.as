package com
{
	import com.monsterlab.GameManager;
	import com.monsterlab.GameManager;
	import com.monsterlab.GameStage;
	import com.monsterlab.ui.GraphicLoader;
	import com.monsterlab.ui.UIManager;
	import com.monsterlab.ui.GraphicLoader;
	//import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.display.StageQuality;
	import com.utils.*;

	/**
	 * ...
	 * @author Song Huang
	 */
	[Frame(factoryClass="com.Preloader")]
	public class Main extends Sprite 
	{

		/**
		 * chemin vers le fichier de configuration
		 */
		protected static const CONFIG_PATH:String = "config.xml";	
		
		protected static var instance: Main;
		
		public function Main() 
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			trace("Main is running fine!");
			instance = this;
		}

		private function deactivate(e:Event):void 
		{
			//make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		public function exit():void 
		{
			//NativeApplication.nativeApplication.exit();
		}
		
		public static function getInstance (): Main {
			if (instance == null) instance = new Main();
			return instance;
		}
		
		protected function init (pEvent:Event=null): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.color = 0xFF2222;
			trace("init is running fine!");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			stage.quality = StageQuality.LOW;
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			// entry point
			//if (Capabilities.touchscreenType == TouchscreenType.FINGER || Capabilities.touchscreenType == TouchscreenType.STYLUS) Controller.type = Controller.TOUCH;
			//padInput = new GameInput();
			//padInput.addEventListener(GameInputEvent.DEVICE_ADDED, addPad);
			
			
			var lLoader:AssetsLoader = new AssetsLoader ();
			lLoader.addTxtFile(CONFIG_PATH);
			lLoader.addDisplayFile("game.swf");
			lLoader.addEventListener(AssetsLoaderEvent.COMPLETE, onLoadConfigComplete);
			
			lLoader.load();
		}
		
		protected function onLoadConfigComplete (pEvent:AssetsLoaderEvent): void {
			
			pEvent.target.removeEventListener(AssetsLoaderEvent.COMPLETE, onLoadConfigComplete);
			
			Config.init(CONFIG_PATH, stage);
			
			addChild(GameStage.getInstance());
			GameStage.getInstance().init(loadAssets);
		}
		
		protected function loadAssets (): void {
			
			var lLoader:AssetsLoader = new AssetsLoader ();
			//lLoader.addTxtFile(Config.langPath + Config.language+"/main.xlf");
			//lLoader.addTxtFile("sound.xml");
			lLoader.addDisplayFile("assets.swf");
			lLoader.addDisplayFile("ui.swf");
			//lLoader.addDisplayFile("sound.swf");
			
			lLoader.addEventListener(AssetsLoaderEvent.PROGRESS, onLoadProgress);
			lLoader.addEventListener(AssetsLoaderEvent.COMPLETE, onLoadComplete);
			
			UIManager.getInstance().addScreen(GraphicLoader.getInstance());
			
			lLoader.load();
		}
		
		protected function onLoadProgress (pEvent:AssetsLoaderEvent): void {
			GraphicLoader.getInstance().update(pEvent.filesLoaded / pEvent.nbFiles);
		}
		
		protected function onLoadComplete (pEvent:AssetsLoaderEvent): void {
			pEvent.target.removeEventListener(AssetsLoaderEvent.PROGRESS, onLoadProgress);
			pEvent.target.removeEventListener(AssetsLoaderEvent.COMPLETE, onLoadComplete);
			
			//LocalizedTextField.init(String(AssetsLoader.getContent(Config.langPath + Config.language+"/main.xlf")));
			
			//UIManager.getInstance().addScreen(TitleCard.getInstance());
			trace("onLoadComplete");
			GameManager.getInstance().init();
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public function destroy (): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			instance = null;
		}
	}

}