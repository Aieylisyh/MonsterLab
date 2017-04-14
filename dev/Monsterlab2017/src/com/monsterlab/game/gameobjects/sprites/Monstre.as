package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.game.gameobjects.StateGraphic;
	import com.monsterlab.ui.ColorManager;
	import com.monsterlab.game.gameobjects.sprites.Scientist;
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
		public function Monstre() 
		{
			skip = true;
			ID = Math.floor(Math.random() * 2 + 1);
			frameToMutate_count = frameToMutate;
			super();
			start();
			handleNewMonsterState(MONSTERSTATE_PHASE1);
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
			if (pPotion.compareRecette()) {
				var newState:String = getNewMonsterState();
				handleNewMonsterState(newState);
			}
			Scientist.getInstance().feedbackByMonster(newState);
		}
		
		private function getNewMonsterState():String{
			var newState:String = "";
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
			return newState;
		}
		
		private function handleNewMonsterState(newState:String):void {
			assetName = "Monstre" + ID.toString();
			monsterState = newState;
			trace(assetName);
			trace(assetName+"_" + monsterState);
			setState(monsterState);
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
			super.doActionNormal();
			frameToMutate_count--;
			if (frameToMutate_count < 0) {
				frameToMutate_count = frameToMutate;
				doMutation();
			}
		}
	}

}