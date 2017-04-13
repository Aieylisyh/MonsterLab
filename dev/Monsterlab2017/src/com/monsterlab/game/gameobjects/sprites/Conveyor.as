package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.GameStage;
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Conveyor extends GameObject 
	{
		
		/**
		 * instance unique de la classe Conveyor
		 */
		protected static var instance: Conveyor;
		
		public static var speed:int = 3;
		public var mcTapis:MovieClip;
		

		/**
		 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
		 * @return instance unique
		 */
		public static function getInstance (): Conveyor {
			if (instance == null) instance = new Conveyor();
			return instance;
		}		
	
		public function Conveyor() 
		{
			super();
			mouseChildren = false;
			mouseEnabled = false;
			trace ("coucou");
			var lCouvercle:Couvercle = new Couvercle();
			GameStage.getInstance().getGameContainer_5().addChild(lCouvercle);
			lCouvercle.x = 683;
			lCouvercle.y = GameStage.MID_V * 1.6515;
			trace("okay");
			
		}
		
		public function increaseSpeed():void {
			speed += 2;
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
		}

	}
}