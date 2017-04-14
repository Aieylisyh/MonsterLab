package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.GameStage;
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.game.gameobjects.StateGraphic;
	import com.monsterlab.ui.ColorManager;
	import com.monsterlab.game.gameobjects.sprites.Scientist;
	import com.utils.SoundManager;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class Monstre extends StateGraphic 
	{
		//TODO　ｒｅｐｌａｃｅ　ｔｈｅｓｅ　ｓｔａｔｅｓ
		public static const MONSTERSTATE_PHASE1:String = "phase1";
		public static const MONSTERSTATE_PHASE2:String = "phase2";
		public static const MONSTERSTATE_PHASE3:String = "phase3";
		public static const MONSTERSTATE_PHASE4:String = "phase4";
		public static const MONSTERSTATE_PHASE5:String = "phase5";
		public static const MONSTERSTATE_PHASE6:String = "phase6";
		public static const MONSTERSTATE_PHASE7:String = "phase7";
		public static const MONSTERSTATE_PHASE8:String = "phase8";
		public static const MONSTERSTATE_PHASE9:String = "phase9";
		public static const MONSTERSTATE_DIE:String = "mort";
		public var monsterState:String;
		protected static var instance: Monstre;
		
		public var ID:int = 1;
		
		private var frameToMutate:int = 600;
		private var frameToMutate_count:int;
		private var smokeCurce:Effect;
		public function Monstre() 
		{
			skip = true;
			//ID = Math.floor(Math.random() * 2 + 1);
			ID = 1;
			frameToMutate_count = frameToMutate;
			super();
			start();
			handleNewMonsterState(MONSTERSTATE_PHASE1);
			GameStage.getInstance().getGameContainer_3().addChild(this);
			this.x = GameStage.MID_H-210;
			this.y = GameStage.MID_V+165;
			//setState("phase1");
		}
		
		public static function getInstance (): Monstre {
			if (instance == null) instance = new Monstre();
			return instance;
		}
		
		public function usePotion(pPotion:Potion):void {
			/*var red:Number = ColorManager.red(pPotion.color);
			var green:Number = ColorManager.green(pPotion.color);
			var blue:Number = ColorManager.blue(pPotion.color);
			trace("red " + red);
			trace("green " + red);
			trace("blue " + red);*/
			trace("!!!!usePotion");
			if (!pPotion.compareRecette()) {
				accelerateMutation();
			}else {
				decelerateMutation();	
			}
			smokeCurce = new Effect("");
			smokeCurce.init_heartCurve(0, 0, 0, 60, 1, 15);
			this.addChild(smokeCurce);
		}
		
		private function getNewMonsterState():String {
			
			var newState:String = monsterState;
			switch(newState) {
			case MONSTERSTATE_PHASE1:
				newState = MONSTERSTATE_PHASE2;
				break;
			case MONSTERSTATE_PHASE2:
				newState = MONSTERSTATE_PHASE3;
				break;
			case MONSTERSTATE_PHASE3:
				newState = MONSTERSTATE_PHASE4;
				break;
			case MONSTERSTATE_PHASE4:
				newState = MONSTERSTATE_PHASE5;
				break;
			case MONSTERSTATE_PHASE5:
				newState = MONSTERSTATE_PHASE6;
				break;
			case MONSTERSTATE_PHASE6:
				newState = MONSTERSTATE_PHASE7;
				break;
			case MONSTERSTATE_PHASE7:
				newState = MONSTERSTATE_PHASE8;
				break;
			case MONSTERSTATE_PHASE8:
				newState = MONSTERSTATE_PHASE9;
				break;
			case MONSTERSTATE_PHASE9:
				newState = MONSTERSTATE_DIE;
				break;
			default:
				newState = MONSTERSTATE_DIE;
				trace("monster unexpected state changed");
				break;
			}
			trace("monster state changed to "+newState);
			return newState;
		}
		
		private function handleNewMonsterState(newState:String):void {
			assetName = "Monstre" + ID.toString();
			monsterState = newState;
			setState(monsterState);
			Scientist.getInstance().feedbackByMonster(monsterState);
			SoundManager.getInstance().makeSound("sound_monster"+(Math.floor(Math.random()*6+1)).toString());
		}
		
		private function doMutation():void {
			var newState:String = getNewMonsterState();
			handleNewMonsterState(newState);
			Scientist.getInstance().feedbackByMonster(newState);
		}
		
		
		public function accelerateMutation():void {
			frameToMutate_count = 0;
		}
		
		public function decelerateMutation(frames:int=500):void {
			frameToMutate_count += frames;
		}
		
		override protected function doActionNormal():void
		{
			if (smokeCurce != null && smokeCurce.isDestroyed)
				smokeCurce = null;
			if (smokeCurce != null && Math.random() > 0.66) {
				var eff0:Effect = new Effect("particle_smoke");
				eff0.init_rotateAndTransit( smokeCurce.x , smokeCurce.y , 0, 72, 0, -2);
				eff0.scaleY = eff0.scaleX = 2;
				addChild(eff0);
			}
			super.doActionNormal();
			frameToMutate_count--;
			if (frameToMutate_count < 0) {
				frameToMutate_count = frameToMutate;
				doMutation();
			}
		}
	}

}