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
		private var numIngredient:int;
		private var numIngredientPerPotion:int=3;
		private var isMixerRotating:Boolean;
		private var mySoundIndex:int =-100;
		private var lastRotationSpeed:Number;
		private var effs:Vector.<Effect> = new Vector.<Effect>();
		private var liquideAnimation:LiquidInTube;
		private var _potionContainer:Sprite;
		//private var myIngredient:Vector.<Ingredient> = new CustomActions
		
		private function get enoughToMix():Boolean {
		   return numIngredient>=numIngredientPerPotion;
		}
	
		public function Mixer() 
		{
			super();
			generateGraphics("Player")
			x = GameStage.MID_H;
			y = GameStage.SAFE_ZONE_HEIGHT * 0.9;
			controller = new MixerController(this);
			controller.start();//receive event, can drag
			start();
			numIngredient = 0;
			isMixerRotating = false;
			rotateSpeed = 0;
			liquideAnimation = new LiquidInTube();
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
				if (numIngredient>0)
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
				trace("stop"+mySoundIndex);
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
			if (numIngredient>0/*????*/) {
				//liquideAnimation.setColor(?????);
				startEffects();
			}
		}
		
		public function addIngredient(ingredient:int = 0):Boolean {
			if (!enoughToMix && !liquideAnimation.isInProgress()) {
				//place image
				trace("addIngredient 1");
				numIngredient++;
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
			var eff0:Effect = new Effect("ShootBoss");
			eff0.init_ingradient_mixAnimation(this.x, this.y, 0, int.MAX_VALUE, 4*sign, 0,     4, 25, 22);
			var eff1:Effect = new Effect("ShootBoss");
			eff1.init_ingradient_mixAnimation(this.x, this.y, 0, int.MAX_VALUE, 4*sign, 60,    4, 25, 22);
			var eff2:Effect = new Effect("ShootBoss");
			eff2.init_ingradient_mixAnimation(this.x, this.y, 0, int.MAX_VALUE, 4*sign, 120,   4, 25, 22);
			var eff3:Effect = new Effect("ShootBoss");
			eff3.init_ingradient_mixAnimation(this.x, this.y, 0, int.MAX_VALUE, 4*sign, 180,   4, 25, 22);
			var eff4:Effect = new Effect("ShootBoss");
			eff4.init_ingradient_mixAnimation(this.x, this.y, 0, int.MAX_VALUE, 4*sign, 240,   4, 25, 22);
			var eff5:Effect = new Effect("ShootBoss");
			eff5.init_ingradient_mixAnimation(this.x, this.y, 0, int.MAX_VALUE, 4*sign, 300,   4, 25, 22);
			effs.push(eff0);
			effs.push(eff1);
			effs.push(eff2);
			effs.push(eff3);
			effs.push(eff4);
			effs.push(eff5);
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
			numIngredient = 0;
			//clear Ingredient
			var potionType:String;
			var potionColor:String;
			var potion:Potion = new Potion(potionType, potionColor);
			rotateSpeed = 0;
		}
		
		public function getPotionContainer():Sprite {
			return _potionContainer;
		}
	}
}