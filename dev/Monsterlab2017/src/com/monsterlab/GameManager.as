package com.monsterlab 
{
	import com.monsterlab.sprites.gameobjects.Button;
	import com.monsterlab.sprites.gameobjects.Player;
	import com.monsterlab.ui.MenuPage;
	import com.monsterlab.ui.RestartPage;
	import com.monsterlab.ui.UIManager;
	import flash.events.Event;
	import com.monsterlab.sprites.gameobjects.Effect;
	import com.monsterlab.sprites.gameobjects.Mixer;;
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
			UIManager.getInstance().addScreen(MenuPage.getInstance());
		}
		
		
		
		public function startGame():void {
			trace("GameManager startGame is running fine");
			UIManager.getInstance().closeScreens();
			GameStage.getInstance().addInterFace();
			//GameStage.getInstance().getGameContainer_2().addChild(Player.getInstance());
			GameStage.getInstance().addEventListener(Event.ENTER_FRAME, gameLoop);
			btnTestAnim = new Button("BtnTest", test, 10, GameStage.MID_V*0.8, false);
			GameStage.getInstance().getHudContainer().addChild(btnTestAnim);
			GameStage.getInstance().getGameContainer_2().addChild(Mixer.getInstance());
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
			
			UIManager.getInstance().addScreen(RestartPage.getInstance());
		}
	}

}