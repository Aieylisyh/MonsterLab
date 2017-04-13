package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.game.gameobjects.StateGraphic;
	import flash.display.DisplayObject;
	import com.monsterlab.GameStage;
	import flash.display.Sprite;
	import com.monsterlab.ui.ColorManager;
	import com.utils.FMath;
	/**
	 * ...
	 * @author COQUERELLE Killian
	 */
	public class Ingredient extends DragDropTarget 
	{
		public static const INGREDIENTS_LIST:Vector.<Vector.<String>> = new <Vector.<String>>[
			new <String>["chauvante", "0x000000"],
			new <String>["calimero", "0xFF0000"],
			new <String>["pousume", "0x0000FF"],
			new <String>["rasticot", "0x00FF00"],
			new <String>["pierreMomie", "0x00FF00"],
			new <String>["pierreDeLevitation", "0x0000FF"],
			new <String>["maskerin", "0xFF0000"],
			new <String>["rochePlatonique", "0x000000"],
			new <String>["rocheCiselée", "0x0000FF"],
			new <String>["racineObservation", "0x0000FF"],
			new <String>["radante", "0x0000FF"],
			new <String>["belierDeTerre", "0x0000FF"],
			new <String>["picaron", "0x0000FF"],
			new <String>["rocheDeLArbre", "0x0000FF"],
			new <String>["rocheFendue", "0x0000FF"],
			new <String>["rocheCube", "0x0000FF"],
			new <String>["couilleFleur", "0x0000FF"],
			new <String>["champignonFarfelu", "0x0000FF"],
			new <String>["ventFleur", "0x0000FF"],
			new <String>["hochetDuDestin", "0x0000FF"],
			new <String>["pissenlitDeVision", "0x0000FF"],
			new <String>["chouFleurVolant", "0x0000FF"],
			new <String>["pommePain", "0x0000FF"],
			new <String>["simi", "0x0000FF"],
			new <String>["stringDuDestin", "0x0000FF"],
			new <String>["tetoeuil", "0x0000FF"],
			new <String>["fleurVorace", "0x0000FF"],
			new <String>["calconDeForce", "0x0000FF"],
			new <String>["tornadeDePq", "0x0000FF"],
			new <String>["cristal", "0x0000FF"],
			new <String>["oignonHelice", "0x0000FF"],
			new <String>["arbreExotique", "0x0000FF"],
			new <String>["couteauMou", "0x0000FF"],
			new <String>["puce21", "0x0000FF"],
			new <String>["ceintureRubis", "0x0000FF"],
			new <String>["feuilleHautaine", "0x0000FF"],
			new <String>["fleurBulle", "0x0000FF"],
			new <String>["balonCosmique", "0x0000FF"],
			new <String>["planteElegante", "0x0000FF"]
		];
		public var type:String;
		public var color:String;
		
		public function Ingredient(pIngredientID:int, pContainer:Sprite, pType:String="unknown", pColor:String="oxFF0000", pX:Number=0, pY:Number=0) 
		{
			super("Ingredient_default");
			init(pContainer, Mixer.getInstance(), pX, pY, 0, 1, 80, 75);
			type = (Ingredient.INGREDIENTS_LIST[pIngredientID])[0];
			color = (Ingredient.INGREDIENTS_LIST[pIngredientID])[1];
			ColorManager.setColor(this, color);
			//trace("Ingredient color is " + color);
			pContainer.addChild(this);
			start();
		}
		
		override protected function onDragToTarget():void {
			if (Mixer.getInstance().addIngredient(this)) {
				willGoBack = false;
				willBeDestroyed = true;
			}else {
				willGoBack = true;
			}
		}
		
		override protected function doActionNormal():void 
		{
			super.doActionNormal();
		}
		
		override protected function idleFunction():void {
			//this.rotation += rotationSpeed;
			//rotationSpeed += rotationAcc;
		}
		
		override protected function dragingFunction():void {
			if (Math.random() > 0.3)
				return;
			var eff:Effect = new Effect("Bullet");
			var t:Number = Math.random() * 360;
			eff.init_rotateAndTransit(0, -10, 0, 50+Math.random() *22, 1.5*FMath.xFactorByRotation(t), 1.5*FMath.yFactorByRotation(t), 4);
			ColorManager.setColor(eff, color);
			this.addChildAt(eff,1);
		}
		
		private function drawHeart():void {
			
		}
	}
}