package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.StateGraphic;
	import com.monsterlab.game.gameobjects.sprites.Monstre;
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Scientist extends StateGraphic 
	{
		public static const SCIENTISTSTATE_PHASE1:String = "default";
		public static const SCIENTISTSTATE_PHASE2:String = "happy";
		public static const SCIENTISTSTATE_PHASE3:String = "default";
		public static const SCIENTISTSTATE_PHASE4:String = "surprise";
		public static const SCIENTISTSTATE_PHASE5:String = "surprise";
		public static const SCIENTISTSTATE_PHASE6:String = "stress";
		public static const SCIENTISTSTATE_PHASE7:String = "angry";
		public static const SCIENTISTSTATE_PHASE8:String = "angry";
		public static const SCIENTISTSTATE_PHASE9:String = "cry";
		public static const SCIENTISTSTATE_DIE:String = "cry";
		public var scienstState:String;
		/**
		 * instance unique de la classe Scientist
		 */
		protected static var instance: Scientist;

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Scientist {
			if (instance == null) instance = new Scientist();
			return instance;
		}		
	
		public function Scientist() 
		{
			super();
			scienstState = SCIENTISTSTATE_PHASE1;
		}
		
		public function feedbackByMonster(state:String):void {
			switch(state) {
			case Monstre.MONSTERSTATE_DIE:
				scienstState = SCIENTISTSTATE_DIE
				break;
			case Monstre.MONSTERSTATE_PHASE1:
				scienstState = SCIENTISTSTATE_PHASE1;
				break;
			case Monstre.MONSTERSTATE_PHASE2:
				scienstState = SCIENTISTSTATE_PHASE2;
				break;
			case Monstre.MONSTERSTATE_PHASE3:
				scienstState = SCIENTISTSTATE_PHASE3;
				break;
			case Monstre.MONSTERSTATE_PHASE4:
				scienstState = SCIENTISTSTATE_PHASE4;
				break;
			case Monstre.MONSTERSTATE_PHASE5:
				scienstState = SCIENTISTSTATE_PHASE5;
				break;
			case Monstre.MONSTERSTATE_PHASE6:
				scienstState = SCIENTISTSTATE_PHASE6;
				break;
			case Monstre.MONSTERSTATE_PHASE7:
				scienstState = SCIENTISTSTATE_PHASE7;
				break;
			case Monstre.MONSTERSTATE_PHASE8:
				scienstState = SCIENTISTSTATE_PHASE8;
				Background.getInstance().setBGState(true);
				break;
			case Monstre.MONSTERSTATE_PHASE9:
				scienstState = SCIENTISTSTATE_PHASE9;
				break;
			default:
				trace("scientist unexpected state changed");
				break;
			}
			assetName = "Scientist";
			setState(scienstState);
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			super.destroy();
		}
	}
}