package com.monsterlab 
{
	import com.monsterlab.game.gameobjects.sprites.Button;
	import com.monsterlab.game.gameobjects.sprites.Ingredient;
	import com.monsterlab.game.gameobjects.sprites.IngredientContainer;
	import com.monsterlab.game.gameobjects.sprites.Player;
	import com.monsterlab.game.gameobjects.sprites.Recipe;
	import com.monsterlab.ui.UIManager;
	import flash.events.Event;
	import com.monsterlab.game.gameobjects.sprites.Effect;
	import com.monsterlab.game.gameobjects.sprites.Mixer;;
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.ui.screens.GameOverScreen;
	import com.monsterlab.ui.screens.TitleCard;
	import com.utils.SoundManager;
	import com.monsterlab.ui.screens.Hud;
	import flash.events.MouseEvent;
	import com.monsterlab.game.gameobjects.sprites.DragDropTarget;
	public class GameManager 
	{
		protected static var instance: GameManager;
		public var btnTestAnim:Button;
		private var isPaused:Boolean;
		
		private var spawnTimer:int = 125;
		public var spawnFrame:int = 125;
		
		public function spawn():void {
			
			var lInfos:Vector.<String> = Recipe.ingredientList[Math.floor(Math.random() * Recipe.ingredientList.length)];
			var lContainer:IngredientContainer	 = new IngredientContainer("Explosion12");
			new Ingredient(-1, lContainer, true, lInfos[0], lInfos[1]);
		}
		
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
			UIManager.getInstance().addScreen(TitleCard.getInstance());
		}
		
		
		
		public function startGame():void {
			isPaused = false;
			trace("GameManager startGame is running fine");
			UIManager.getInstance().closeScreens();
			GameStage.getInstance().addInterFace();
			GameStage.getInstance().addEventListener(Event.ENTER_FRAME, gameLoop);
			GameStage.getInstance().getGameContainer_5().addChild(Mixer.getInstance());
			//SoundManager.getInstance().startNewBackgroundMusic("sound_music1");
			GameStage.getInstance().getGameContainer_2().addChild(Hud.getInstance());
			Recipe.initIngredientList();
		}
		
		private function gameLoop(_:Event):void {
			defaultLoop();
			if (isPaused)
				return;
			for (var i:int = GameObject.list.length - 1; i > -1; i-- ) {
				var obj:* = GameObject.list[i];
				if (obj.willBeDestroyed) {
					obj.destroy();
				}else {
					obj.doAction();
				}
				
				
			} 
			
			if (spawnTimer == spawnFrame) {
				spawn();
				spawnTimer = 0;
			}else {
				spawnTimer += 1;
			}
		}
		
		private function defaultLoop():void {
			//execute even when pause
		}
		
		public function restart():void {
			startGame();
		}
		
		public function onPause():void {
			if (!isPaused)
				isPaused = true;
		}
		
		public function onResume():void {
			if (isPaused)
				isPaused = false;
		}
		
		public function reset():void {
			GameStage.getInstance().getGameContainer_5().removeChild(Mixer.getInstance());
			GameStage.getInstance().removeEventListener(Event.ENTER_FRAME, gameLoop);
			GameStage.getInstance().getGameContainer_5().removeChild(Hud.getInstance());
		}
		
		private function gameover():void {
			GameStage.getInstance().removeEventListener(Event.ENTER_FRAME, gameLoop);
			for (var i:int = GameObject.list.length - 1; i > -1; i-- ) {
				var obj:* = GameObject.list[i];
				obj.destroy();
			}
			
			UIManager.getInstance().addScreen(GameOverScreen.getInstance());
		}
	}

}