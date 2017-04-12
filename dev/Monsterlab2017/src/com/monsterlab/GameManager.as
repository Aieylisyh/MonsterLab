package com.monsterlab 
{
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.game.gameobjects.sprites.Button;
	import com.monsterlab.game.gameobjects.sprites.Player;
	import com.monsterlab.ui.screens.Hud;
	import com.monsterlab.ui.screens.TitleCard;
	import com.monsterlab.ui.screens.GameOverScreen;
	import com.monsterlab.ui.UIManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.monsterlab.game.gameobjects.sprites.Effect;
	import flash.text.TextField;
	public class GameManager 
	{
		protected static var instance: GameManager;
		public var btnTestAnim:Button;
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
			trace("GameManager startGame is running fine");
			UIManager.getInstance().closeScreens();
			GameStage.getInstance().addInterFace();
			GameStage.getInstance().getGameContainer_2().addChild(Player.getInstance());
			GameStage.getInstance().addEventListener(Event.ENTER_FRAME, gameLoop);
			//btnTestAnim = new Button("BtnTest", test, 10, GameStage.MID_V, false);
			//GameStage.getInstance().getHudContainer().addChild(btnTestAnim);
			var myText:TextField = new TextField();
			myText.text = "coucou";
			GameStage.getInstance().getHudContainer().addChild(myText);
			myText.x = 50;
			myText.y = 50;
			GameStage.getInstance().initHud();
			//var lHudContainer:Sprite = GameStage.getInstance().getHudContainer();
			myText.text = "hello";			
			GameStage.getInstance().getHudContainer().addChild(myText);
			//lHudContainer.addChild(Hud.getInstance());
			
			
			//UIManager.getInstance().addScreen(Hud.getInstance());
		}
		
		private var i:int = 0;
		private var effs:Vector.<Effect> = new Vector.<Effect>();
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
		
		private function test(_:Event=null):void {
			if (i > 3) {
				i = 0;
			}
			for each(var pEff:Effect in effs) {
				if (pEff != null)
					pEff.willBeDestroyed = true;
			}
			effs = new Vector.<Effect>();
			var eff0:Effect;
			if (i == 0) {
				eff0 = new Effect("Explosion10");
				eff0.init_rotateAndTransit(GameStage.SAFE_ZONE_WIDTH*0.5, GameStage.SAFE_ZONE_HEIGHT * 0.5,0, 100, 0, 0, 0, 0.1);
			}else if (i == 1) {
				eff0 = new Effect("ShootBoss");
				eff0.init_heartCurve(GameStage.SAFE_ZONE_WIDTH * 0.5, GameStage.SAFE_ZONE_HEIGHT * 0.5, 0, 100, 1.2, 12);
			}else if (i == 2) {
				eff0 = new Effect("ShootBoss");
				eff0.init_ingradient_mixAnimation(GameStage.SAFE_ZONE_WIDTH * 0.5, GameStage.SAFE_ZONE_HEIGHT * 0.6, 0, 100, 4, 0,   8, 24, 22);
				var eff1:Effect = new Effect("ShootBoss");
				eff1.init_ingradient_mixAnimation(GameStage.SAFE_ZONE_WIDTH * 0.5, GameStage.SAFE_ZONE_HEIGHT * 0.6, 0, 100, 4, 60,  2, 24, 22);
				var eff2:Effect = new Effect("ShootBoss");
				eff2.init_ingradient_mixAnimation(GameStage.SAFE_ZONE_WIDTH * 0.5, GameStage.SAFE_ZONE_HEIGHT * 0.6, 0, 100, 4, 120, 8, 24, 22);
				var eff3:Effect = new Effect("ShootBoss");
				eff3.init_ingradient_mixAnimation(GameStage.SAFE_ZONE_WIDTH * 0.5, GameStage.SAFE_ZONE_HEIGHT * 0.6, 0, 100, 4, 180, 2, 24, 22);
				var eff4:Effect = new Effect("ShootBoss");
				eff4.init_ingradient_mixAnimation(GameStage.SAFE_ZONE_WIDTH * 0.5, GameStage.SAFE_ZONE_HEIGHT * 0.6, 0, 100, 4, 240, 8, 24, 22);
				var eff5:Effect = new Effect("ShootBoss");
				eff5.init_ingradient_mixAnimation(GameStage.SAFE_ZONE_WIDTH * 0.5, GameStage.SAFE_ZONE_HEIGHT * 0.6, 0, 100, 4, 300, 2, 24, 22);
				effs.push(eff1);
				effs.push(eff2);
				effs.push(eff3);
				effs.push(eff4);
				effs.push(eff5);
			}else if (i == 3) {
				eff0 = new Effect("Explosion11");
				eff0.init_float(GameStage.SAFE_ZONE_WIDTH*0.5, GameStage.SAFE_ZONE_HEIGHT * 0.5, 0, 100, 30, 40, 10);	
			}
			effs.push(eff0);
			i++;
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
			
			UIManager.getInstance().addScreen(GameOverScreen.getInstance());
		}
	}

}