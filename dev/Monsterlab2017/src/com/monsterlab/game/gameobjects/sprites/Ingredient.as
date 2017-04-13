package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.StateGraphic;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Ingredient extends StateGraphic 
	{
		public static const INGREDIENTS_LIST:Vector.<Vector.<String>> = new Vector.<Vector.<String>>([
			["chauvante", ""],
			["calimero", ""],
			["pousume", ""],
			["rasticot", ""],
			["pierreMomie", ""],
			["pierreDeLevitation", ""],
			["maskerin", ""],
			["rochePlatonique", ""],
			["rocheCiselée", ""],
			["racineObservation", ""],
			["radante", ""],
			["belierDeTerre", ""],
			["picaron", ""],
			["rocheDeLArbre", ""],
			["rocheFendue", ""],
			["rocheCube", ""],
			["couilleFleur", ""],
			["champignonFarfelu", ""],
			["ventFleur", ""],
			["hochetDuDestin", ""],
			["pissenlitDeVision", ""],
			["chouFleurVolant", ""],
			["pommePain", ""],
			["simi", ""],
			["stringDuDestin", ""],
			["tetoeuil", ""],
			["fleurVorace", ""],
			["calconDeForce", ""],
			["tornadeDePq", ""],
			["cristal", ""],
			["oignonHelice", ""],
			["arbreExotique", ""],
			["couteauMou", ""],
			["puce21", ""],
			["ceintureRubis", ""],
			["feuilleHautaine", ""],
			["fleurBulle", ""],
			["balonCosmique", ""],
			["planteElegante", ""]
		]);
		
		public var type:String;
		public var color:String;
		
		public function Ingredient() 
		{
			super();
			
		}
		
		/*private function init(pIngredient:String, pColor:String):void {
			setState(pIngredient);
			type = pIngredient;
			color = pColor;
			
		}*/
		
		public function startMove():void {
			setModeNormal();
		}
		
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
			x += Conveyor.speed;
		}
		
		
		
	}

}