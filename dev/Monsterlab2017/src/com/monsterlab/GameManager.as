package com.monsterlab 
{
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.sprites.gameobjects.Player;
	import com.monsterlab.ui.MenuPage;
	import com.monsterlab.ui.RestartPage;
	import com.monsterlab.ui.UIManager;
	import flash.events.Event;
	
	public class GameManager 
	{
		protected static var instance: GameManager;
		public var btnRestart:Button;
		public function GameManager() 
		{
			
		}
		public static function getInstance (): GameManager {
			if (instance == null) instance = new GameManager();
			return instance;
		}
		
		public function init():void {
			//for first run this game
			trace("GameManager is running fine");
			UIManager.getInstance().addScreen(MenuPage.getInstance());
		}
		
		
		
		public function startGame():void {
			trace("GameManager startGame is running fine");
			UIManager.getInstance().closeScreens();
			GameStage.getInstance().addInterFace();
			//GameStage.getInstance().getGameContainer_2().addChild(Player.getInstance());
			GameStage.getInstance().addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		
		private function gameLoop(_:Event):void {
			
			defaultLoop();
			for (var i:int = GameObject.list.length - 1; i > -1; i-- ) {
				var obj:* = GameObject.list[i];
				if (obj.willBeDestroyed) {
					obj.destroy();
				}else {
					obj.doAction();
				}
			}
		}
		
		
		private function defaultLoop():void {
			
		}
		
		public function restart():void {
			startGame();
		}
		
		private function gameover():void {
			GameStage.getInstance().removeEventListener(Event.ENTER_FRAME, gameLoop);
			for (var i:int = GameObject.list.length - 1; i > -1; i-- ) {
				var obj:* = GameObject.list[i];
				obj.destroy();
			}
			
			UIManager.getInstance().addScreen(RestartPage.getInstance());
		}
	}

}