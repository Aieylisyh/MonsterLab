package com.monsterlab.game.gameobjects.sprites 
{
	import com.monsterlab.GameStage;
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.game.gameobjects.StateGraphic;
	import com.utils.SoundManager;
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
		public static const INGREDIENTS_TYPE:Vector.<Vector.<String>> = new <Vector.<String>>[
			new <String>["chauvante", "0x86B75C"],
			new <String>["calimero", "0x68ECED"],
			new <String>["pousume", "0xD4644C"],
			new <String>["rasticot", "0xFDFDFC"],
			new <String>["pierremomie", "0x94A238"],
			new <String>["pierredelevitation", "0xE46C93"],
			new <String>["maskerin", "0xA9F1F7"],
			new <String>["rocheplatonique", "0xFD4343"],
			new <String>["rocheciselee", "0x79DC6E"],
			new <String>["racineobservation", "0x9295FA"],
			new <String>["radante", "0x6FC01B"],
			new <String>["belierdeterre", "0xF33B2B"],
			new <String>["picaron", "0x27CA70"],
			new <String>["rochedelarbre", "0xE6F239"],
			new <String>["rochefendue", "0xAF24A5"],
			new <String>["rochecube", "0xF8340B"],
			new <String>["couillefleur", "0x6FFF33"],
			new <String>["champignonfarfelu", "0xD2431A"],
			new <String>["ventfleur", "0x372A81"],
			new <String>["hochetdudestin", "0xA77836"],
			new <String>["pissenlitdevision", "0xCE8373"],
			new <String>["choufleurvolant", "0xC1FA12"],
			new <String>["pommepain", "0x467D47"],
			new <String>["simi", "0x586366"],
			new <String>["stringdudestin", "0xEA2293"],
			new <String>["tetoeuil", "0xA8496A"],
			new <String>["fleurvorace", "0x623599"],
			new <String>["calcondedorce", "0x1F3F73"],
			new <String>["tornadedepq", "0x681506"],
			new <String>["cristal", "0xCF2A67"],
			new <String>["oignonhelice", "0xF9C379"],
			new <String>["arbreexotique", "0x258094"],
			new <String>["couteaumou", "0x414343"],
			new <String>["puce21", "0xE9B872"],
			new <String>["ceinturerubis", "0x97E0F8"],
			new <String>["feuillehautaine", "0xB65BCF"],
			new <String>["fleurbulle", "0x962127"],
			new <String>["baloncosmique", "0x74F4BF"],
			new <String>["planteelegante", "0xED9E46"]
		];
		
		private var list:Vector.<Ingredient> = new Vector.<Ingredient>();

		public var type:String;
		public var color:String;
		
		public function Ingredient(pIngredientID:int, pContainer:Sprite, pConveyor:Boolean = false, pType:String="unknown", pColor:String="oxFF0000", pX:Number=0, pY:Number=0) 
		{
			super("Ingredient_default");
			
			if (pIngredientID ==-1) {
				type = pType;
				color = pColor;
			}else {
				type = (Ingredient.INGREDIENTS_TYPE[pIngredientID])[0];
				color = (Ingredient.INGREDIENTS_TYPE[pIngredientID])[1];
			}
			
			if (type != null) {
				if (pConveyor) {
					assetName = "IngredientConvoyer_" + type;
				}else {
					assetName = "Ingredient_" + type;
				}
			}
			init(pContainer, Mixer.getInstance(), pX, pY, 0, 1,130, 85);
			ColorManager.setColor(this, color);
			//trace("Ingredient color is " + color);
			pContainer.addChild(this);
			list.push(this);
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
			/*x += Conveyor.speed;
			if (x > GameStage.SAFE_ZONE_WIDTH) {
				//parent.removeChild(this);
				GameObject.list.splice(GameObject.list.indexOf(this), 1);
				this.destroy();
			}*/
		}
		
		override protected function idleFunction():void {
			//this.rotation += rotationSpeed;
			//rotationSpeed += rotationAcc;
		}
		
		override protected function onStartDrag():void {
			SoundManager.getInstance().makeSound("sound_bubble");
		}
		
		override protected function dragingFunction():void {
			if (Math.random() > 0.3)
				return;
			var eff:Effect = new Effect("particle_whiteball");
			var t:Number = Math.random() * 360;
			eff.init_rotateAndTransit(0, -10, 0, 95 + Math.random() * 50, 1.8 * FMath.xFactorByRotation(t), 1.8* FMath.yFactorByRotation(t));
			eff.scaleX = eff.scaleY = 0.5;
			ColorManager.setColor(eff, color);
			this.addChildAt(eff,1);
		}
		
		private function drawHeart():void {
			
		}
		
		public static function destroyAll():void {
			for (var i:int = list.length - 1; i >= 0; i--) {
				list[i].destroy();
			}
		}
	}
}