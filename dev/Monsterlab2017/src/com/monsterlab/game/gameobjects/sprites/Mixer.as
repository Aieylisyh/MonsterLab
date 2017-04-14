package com.monsterlab.game.gameobjects.sprites 
{
	import adobe.utils.CustomActions;
	import com.monsterlab.game.gameobjects.GameObject;
	import com.monsterlab.GameStage;
	import com.monsterlab.game.gameobjects.sprites.MixerController;
	import com.utils.FMath;
	import com.utils.SoundManager;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import com.monsterlab.ui.ColorManager;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class Mixer extends GameObject
	{
		
		protected static var instance: Mixer;
		protected var controller:MixerController;
		
		private var rotateSpeed:Number=0;
		private var rotateAcc:Number=0.3;
		private var text1:TextField;
		private var text2:TextField;
		private var numIngredientPerPotion:int=3;
		private var isMixerRotating:Boolean;
		private var mySoundIndex:int =-100;
		private var lastRotationSpeed:Number;
		private var effs:Vector.<Effect> = new Vector.<Effect>();
		private var liquideAnimation:LiquidInTube;
		private var _potionContainer:Sprite;
		private var hasPotion:Boolean;
		private var ingredients:Vector.<Ingredient> = new Vector.<Ingredient>();
		//private var myIngredient:Vector.<Ingredient> = new CustomActions
		
		private function get enoughToMix():Boolean {
		   return ingredients.length>=numIngredientPerPotion;
		}
	
		public function Mixer() 
		{
			super();
			scaleX = scaleY = 2.1;
			generateGraphics("mixer")
			x = GameStage.MID_H-10;
			y = GameStage.SAFE_ZONE_HEIGHT * 0.885;
			controller = new MixerController(this);
			controller.start();//receive event, can drag
			start();
			isMixerRotating = false;
			rotateSpeed = 0;
			hasPotion = false;
			liquideAnimation = new LiquidInTube();
			GameStage.getInstance().getGameContainer_3().addChild(liquideAnimation);
			liquideAnimation.x = this.x;
			liquideAnimation.y = this.y;
			/*text1 = new TextField();
			GameStage.getInstance().getGameContainer_3().addChild(text1);
			text1.scaleX = text1.scaleY = 4;
			text1.x = this.x-100 ;
			text1.y = this.y + 50;
			text2 = new TextField();
			GameStage.getInstance().getGameContainer_3().addChild(text2);
			text2.scaleX = text2.scaleY = 4;
			text2.x = this.x-100 ;
			text2.y = this.y + 100;*/
			if (_potionContainer == null) {
				_potionContainer = new Sprite();
				GameStage.getInstance().getGameContainer_5().addChild(_potionContainer);
				_potionContainer.x = 440+x;
				_potionContainer.y = 20+y;
			}
		}
		
		public static function getInstance (): Mixer {
			if (instance == null) instance = new Mixer();
			return instance;
		}
		
		public function setSpeed(speed:Number):void {
			rotateSpeed = speed;
		}
		override public function destroy():void
		{
			controller.stop();
			controller = null;
			instance = null;
			super.destroy();
		}
		
		override protected function doActionNormal (): void {
			super.doActionNormal();
			//text1.text = controller.isDraging.toString();
			//text2.text = x.toString() + "," +y.toString();
			if (rotateSpeed == 0)
			{
				if (isMixerRotating)
					onStopMixerRotating();
				isMixerRotating = false;
			}else {
				if (!isMixerRotating)
					onStartMixerRotating();
				else	if (lastRotationSpeed * rotateSpeed < 0) {
					onStopMixerRotating();
					onStartMixerRotating();
				}
				isMixerRotating = true;
				if (ingredients.length>0 && !hasPotion)
					liquideAnimation.setPercentage(rotateSpeed);
			}
			if (!controller.isDraging)
            {
                if (rotateSpeed == 0)
                {
                    return;
                }
                if (rotateSpeed > rotateAcc)
                    rotateSpeed -= rotateAcc;
                else if (rotateSpeed < -rotateAcc)
                    rotateSpeed += rotateAcc;
                else
                    rotateSpeed = 0;
            }
			//setSound(Math.abs(rotateSpeed/MixerController.MAXROTATIONSPEED))
            rotation += rotateSpeed;
			lastRotationSpeed = rotateSpeed;
		}
		
		private function onStopMixerRotating():void {
			if (mySoundIndex >-1) {
				trace("stop mySoundIndex="+mySoundIndex);
				SoundManager.getInstance().stopSound(mySoundIndex);
			}
			mySoundIndex =-100;
			stopEffects();
		}
		
		private function onStartMixerRotating():void {
			if (mySoundIndex >-1) {
				SoundManager.getInstance().stopSound(mySoundIndex);
			}
			mySoundIndex = SoundManager.getInstance().makeSound ("sound_mixer",99);
			if (ingredients.length>0/*????*/) {
				//liquideAnimation.setColor(?????);
				startEffects();
			}
		}
		
		public function addIngredient(ingredient:Ingredient):Boolean {
			if (ingredient == null) {
				trace("addIngredient null!");
				return false;
			}
			if (!enoughToMix && !liquideAnimation.isInProgress()) {
				//place image
				trace("addIngredient 1");
				ingredients.push(ingredient);
				SoundManager.getInstance().makeSound("sound_type");
				return true;
			}else {
				trace("can not addIngredient");
				return false;
			}
		}
		public function reset():void {
			//call this from controller
			rotateSpeed = 0;
			rotation = 0;
		}
		
		private function startEffects():void {
			var sign:int = 1;
			if (rotateSpeed < 0)
				sign =-1;
			stopEffects();
			var color:String = "";
			if(ingredients.length==3)
				color = ColorManager.getColor( ingredients[0].color,  ingredients[1].color, ingredients[2].color);
			else if(ingredients.length==2)
				color = ColorManager.getColor( ingredients[0].color,  ingredients[1].color);
			else if(ingredients.length==1)
				color = ColorManager.getColor( ingredients[0].color);
			else
				trace("wrong ingredients.length:"+ingredients.length);
			for (var i:int = 0; i < 6; i++ ) {
				var eff0:Effect = new Effect("particle_mixer");
				eff0.init_ingradient_mixAnimation(this.x, this.y, 60 *i , int.MAX_VALUE, 4 * sign, 60 * i,  4.6, 30, 25);
				eff0.scaleX = eff0.scaleY = 0.55;
				ColorManager.setColor(eff0,color);
				effs.push(eff0);
			}
		}
		
		private function stopEffects():void {
		
			
			for each(var pEff:Effect in effs) {
				if (pEff != null)
					pEff.setEnd_ingradient_mixAnimation();
			}
		}
		/*private function setSound(vol:Number ):void {
		
			if (mySoundIndex >-1) {
				vol = vol * 1.2;
				vol = Math.min(vol, 0.1);
				vol = Math.max(vol, 1);
				SoundManager.getInstance().setSoundVol (mySoundIndex,vol);
			}
		}*/
		
		public function generatePotion():void {
			//clear Ingredient
			//var potionType:String = getPotionTypeByIngredientType();
			var potionType:String = "potion";
			if(ingredients.length==3)
				new Potion(potionType, ingredients[0].color,  ingredients[1].color, ingredients[2].color);
			else if(ingredients.length==2)
				new Potion(potionType, ingredients[0].color,  ingredients[1].color);
			else if(ingredients.length==1)
				new Potion(potionType, ingredients[0].color);
			else
				trace("wrong ingredients.length:"+ingredients.length);
			rotateSpeed = 0;
			SoundManager.getInstance().makeSound("sound_water");
			SoundManager.getInstance().makeSound("sound_metal");
			deleteIngredients();
			hasPotion = true;
		}
		
		private function deleteIngredients():void {
			for each(var pIngredient:Ingredient in ingredients)
				pIngredient.willBeDestroyed = true;
			ingredients = new Vector.<Ingredient>();
		}
		
		public function potionUsed():void {
			hasPotion = false;
		}
		
		public function getPotionContainer():Sprite {
			return _potionContainer;
		}
	}
}