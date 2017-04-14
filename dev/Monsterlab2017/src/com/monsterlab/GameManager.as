package com.monsterlab 
{
	import com.monsterlab.game.gameobjects.sprites.Background;
	import com.monsterlab.game.gameobjects.sprites.Button;
	import com.monsterlab.game.gameobjects.sprites.Ingredient;
	import com.monsterlab.game.gameobjects.sprites.IngredientContainer;
	import com.monsterlab.game.gameobjects.sprites.Monstre;
	import com.monsterlab.game.gameobjects.sprites.Recipe;
	import com.monsterlab.game.gameobjects.sprites.RecipeGraphic;
	import com.monsterlab.game.gameobjects.sprites.Scientist;
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
		private var score:int = 0;
		private var spawnTimer:int = 125;
		public var spawnFrame:int = 125;
		private var ingredientIndex:int=0
		public function spawn():void {
			if (Math.random() < 0.2)
				createRecipe();
			ingredientIndex++;
			if (ingredientIndex >= Recipe.ingredientList.length)
				ingredientIndex = 0;
			var lInfos:Vector.<String> = Recipe.ingredientList[ingredientIndex];
			
			var lContainer:IngredientContainer	 = new IngredientContainer();
			lContainer.myIngredient = new Ingredient( -1, lContainer, true, lInfos[0], lInfos[1]);
		}
		
		public function GameManager() 
		{
			Background.getInstance().setBGState();
			SoundManager.getInstance().startNewBackgroundMusic("sound_music1");
		}
		
		public static function getInstance (): GameManager {
			if (instance == null) instance = new GameManager();
			return instance;
		}
		
		public function init():void {
			//for first run this game
			trace("GameManager is running fine");
			UIManager.getInstance().closeScreens();
			GameStage.getInstance().getTitleCardContainer().addChild(TitleCard.getInstance());
		}
		
		
		
		public function startGame():void {
			isPaused = false;
			trace("GameManager startGame is running fine");
			UIManager.getInstance().closeScreens();
			GameStage.getInstance().getTitleCardContainer().removeChild(TitleCard.getInstance());
			GameStage.getInstance().addInterFace();
			GameStage.getInstance().addEventListener(Event.ENTER_FRAME, gameLoop);
			GameStage.getInstance().getGameContainer_5().addChild(Mixer.getInstance());
			SoundManager.getInstance().startNewBackgroundMusic("sound_music2");
			GameStage.getInstance().getGameContainer_2().addChild(Hud.getInstance());
			Recipe.initIngredientList();
			trace("!!");
			Monstre.getInstance();
			Scientist.getInstance();
			score = 0;
			Hud.getInstance().setScore(score/30);
			createRecipe();
		}
		
		private function createRecipe():void {
			SoundManager.getInstance().makeSound("sound_gaz",1,0.5);
			var id:int = RecipeGraphic.findEmptyContainerID();
			trace("!id!"+id);
			if (id < 0)
				return;
			new RecipeGraphic(Recipe.createRecipe(), id);
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
			Hud.getInstance().setScore(score/30);
			score++;
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
			Background.getInstance().setBGState(true);
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
			if (Hud.getInstance()["parent"] != null)
			{
				Hud.getInstance().parent.removeChild(Hud.getInstance());
			}
			Ingredient.destroyAll();
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