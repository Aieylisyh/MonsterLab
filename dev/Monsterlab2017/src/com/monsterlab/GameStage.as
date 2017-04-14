package com.monsterlab {
	
	import com.Main;
	import com.monsterlab.game.gameobjects.sprites.Button;
	import com.monsterlab.game.gameobjects.sprites.Ingredient;
	import com.monsterlab.ui.screens.Hud;
	import com.monsterlab.ui.screens.PauseScreen;
	import com.monsterlab.ui.UIManager;
	import com.utils.Config;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;

	public class GameStage extends Sprite 
	{
		
		/**
		 * instance unique de la classe GameStage
		 */
		protected static var instance: GameStage;
		
		/**
		 * largeur minimum pour le contenu visible
		 */
		public static const SAFE_ZONE_WIDTH: int = 1366;

		/**
		 * hauteur minimum pour le contenu visible
		 */
		public static const SAFE_ZONE_HEIGHT: int = 2048;
		
		
		public static const MID_H: int = 683;
		public static const MID_V: int = 1024;
		/**
		 * conteneur des pop-in
		 */
		protected var popinContainer:Sprite;
		
		/**
		 * conteneur du Hud
		 */
		protected var hudContainer:Sprite;
		
		/**
		 * conteneur des écrans d'interface
		 */
		protected var screensContainer:Sprite;
		protected var titleCardContainer:Sprite;
		
		/**
		 * conteneur du jeu
		 */
		protected var gameContainer:Sprite;
		protected var gameLayer_1:Sprite;
		protected var gameLayer_2:Sprite;
		protected var gameLayer_3:Sprite;
		protected var gameLayer_4:Sprite;
		protected var gameLayer_5:Sprite;
		public function GameStage() 
		{
			super();	
		}
		
		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): GameStage {
			if (instance == null) instance = new GameStage();
			return instance;
		}
		public function addInterFace():void {
			/*var btnQuit:Button;
			btnQuit = new Button("BtnQuit", testPause, 0,48,true);
			hudContainer.addChild(btnQuit);*/
		}
		
		public function init (pCallBack:Function): void {
			
			gameContainer = new Sprite();
			gameLayer_1 = new Sprite();
			gameLayer_2 = new Sprite();
			gameLayer_3 = new Sprite();
			gameLayer_4 = new Sprite();
			gameLayer_5 = new Sprite();
			addChild(gameContainer);//game
			gameContainer.addChild(gameLayer_1);
			gameContainer.addChild(gameLayer_2);
			gameContainer.addChild(gameLayer_3);
			gameContainer.addChild(gameLayer_4);
			gameContainer.addChild(gameLayer_5);
			
			hudContainer = new Sprite();//hud
			addChild(hudContainer);
			hudContainer.x = MID_H;
			hudContainer.y = MID_V;
			
			titleCardContainer = new Sprite();
			addChild(titleCardContainer);//screen
			titleCardContainer.x = MID_H;
			titleCardContainer.y = MID_V;
			
			screensContainer = new Sprite();
			addChild(screensContainer);//screen
			screensContainer.x = MID_H;
			screensContainer.y = MID_V;
			
			popinContainer = new Sprite();//popin maybe never used
			addChild(popinContainer);
			popinContainer.x = MID_V;
			popinContainer.y = MID_H;
			
			Config.stage.addEventListener(Event.RESIZE, resize);
			resize();
			
			pCallBack();
			
			
			
			
			
		}
		
		/**
		 * Redimensionne la scène du jeu en fonction de la taille disponible pour l'affichage
		 * @param	pEvent
		 */
		protected function resize (pEvent:Event=null): void {
			
			var lRatio:Number = Math.round(10000 * Math.min(Config.stage.stageWidth / SAFE_ZONE_WIDTH, Config.stage.stageHeight / SAFE_ZONE_HEIGHT)) / 10000;
			
			scaleX = scaleY = lRatio;
			
			x = (Config.stage.stageWidth-SAFE_ZONE_WIDTH*scaleX) * 0.5;
			y = (Config.stage.stageHeight - SAFE_ZONE_HEIGHT * scaleY) * 0.5;
			
		}
		
		/**
		 * accès en lecture au conteneur de jeu
		 * @return gameContainer
		 */
		public function getGameContainer (): Sprite {
			return gameContainer;
		}
		public function getGameContainer_1(): Sprite {
			return gameLayer_1;
		}
		public function getGameContainer_2 (): Sprite {
			return gameLayer_2;
		}
		public function getGameContainer_3 (): Sprite {
			return gameLayer_3;
		}
		public function getGameContainer_4 (): Sprite {
			return gameLayer_4;
		}
		public function getGameContainer_5 (): Sprite {
			return gameLayer_5;
		}
		
		public function stagePointToScreenPoint (p:Point): Point {
			var point:Point = new Point(p.x, p.y);
			point.x = p.x / this.scaleX - this.x / this.scaleX;
			point.y = p.y / this.scaleY - this.y / this.scaleY;
			return point;
		}

		/**
		 * accès en lecture au conteneur d'écrans
		 * @return screensContainer
		 */
		public function getScreensContainer (): Sprite {
			return screensContainer;
		}
		
		public function getTitleCardContainer (): Sprite {
			return titleCardContainer;
		}
		
		/**
		 * accès en lecture au conteneur de hud
		 * @return hudContainer
		 */
		public function getHudContainer (): Sprite {
			return hudContainer;
		}
		
		/**
		 * accès en lecture au conteneur de PopIn
		 * @return popinContainer
		 */
		public function getPopInContainer (): Sprite {
			return popinContainer;
		}
				
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		public function destroy (): void {
			Config.stage.removeEventListener(Event.RESIZE, resize);
			instance = null;
		}

	}
}