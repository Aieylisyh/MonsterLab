package com.monsterlab.game.gameobjects.sprites {
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import com.monsterlab.GameStage;
	import com.utils.FMath;
	/**
	 * ...
	 * @author Song
	 * this class is to be an instance of movieclip or sprite which will be displayed on screen and automaticly be delete when the animation is termined
	 */
	public class Effect extends GameObject
	{
		private var assetName:String;
		private var graphic:MovieClip;
		private var speed:Point = new Point(0, 0);
		private var lifeTime:Number;
		private var lifeTimeCount:Number;
		private var tragetFunction:Function = voidFunction;
		private var rotationSpeed:Number = 0;
		private var rotationAcc:Number = 0;
		private var startingX:Number;
		private var startingY:Number;
		private var accX:Number;
		private var accY:Number;
		private var float_turn_offsetX:Number;
		private var float_turn_offsetY:Number;
		private var float_turnTime:Number;
		
		private var heartCurve_size:Number;
		private var heartCurve_area:Number;
		private var heartCurve_finishPercentage:Number;
		private var heartCurve_finishPercentageCount:Number;
		
		private var ingradient_mixAnimation_startingRotationFromCenter:Number;
		private var ingradient_mixAnimation_goSpeed:Number;
		private var ingradient_mixAnimation_goOutTime:Number;
		private var ingradient_mixAnimation_goBackTime:Number;
		private var ingradient_mixAnimation_goLength:Number;
		private static var NUM_ENUM_VALUES:int = 0;
		private static const ENUM_Trajet_transitAndRotate:int = 1;
		private static const ENUM_Trajet_float:int = 2;
		private static const ENUM_Trajet_ingradient_mixAnimation:int = 3;
		private static const ENUM_Trajet_heartCurve:int = 4;
		private var myTraget:int;
		public function Effect(pName:String) 
		{
			super();
			assetName = pName;
			start();
		}
		
		public function init_common(pX:Number, pY:Number, pRotation:Number = 0, pLifeTime:Number =-1):void {
			var ClassReference:Class = getDefinitionByName(assetName) as Class;
            graphic = new ClassReference();
			if (graphic.totalFrames < 2) {
				graphic.cacheAsBitmap = true; 
				//graphic.cacheAsBitmapMatrix = new Matrix();
			}
			addChild(graphic);
            GameStage.getInstance().getGameContainer_5().addChild(this);
			
			lifeTime = pLifeTime;
			lifeTimeCount = lifeTime;
			if(pRotation!=0)
				rotation = pRotation;
			x = pX;
			y = pY;
			startingX = x;
			startingY = y;
		}
		
		public function init_rotateAndTransit(pX:Number, pY:Number, pRotation:Number = 0, pLifeTime:Number =-1, vX:Number = 0, vY:Number = 0, pRotationSpeed:Number = 0, pRotationAcc:Number = 0, pAccX:Number = 0, pAccY:Number = 0):void {
			init_common(pX, pY, pRotation, pLifeTime);
			this.x = pX;
			this.y = pY;
			this.rotationSpeed = pRotationSpeed;
			this.rotationAcc = pRotationAcc;
			this.accX = pAccX;
			this.accY = pAccY;
			tragetFunction = tragetFunction_transitAndRotate;
			myTraget = ENUM_Trajet_transitAndRotate;
		}
		
		public function init_float(pX:Number, pY:Number, pRotation:Number = 0, pLifeTime:Number =-1, turnFrames:Number = 30, offsetX:Number = 1, offsetY:Number = 1):void {
			init_common(pX, pY, pRotation, pLifeTime);
			this.float_turn_offsetX = offsetX;
			this.float_turn_offsetY = offsetY;
			this.float_turnTime = turnFrames;
			tragetFunction = tragetFunction_float;
			myTraget = ENUM_Trajet_float;
		}
		
		public function init_ingradient_mixAnimation(pX:Number, pY:Number, pRotation:Number = 0, pLifeTime:Number =-1, pRotationSpeed:Number = 0, startingRotationFromCenter:Number = 0, goSpeed:Number =2, goOutTime:Number = 15, goBackTime:Number = 15):void {
			init_common(pX, pY, pRotation, pLifeTime);
			this.ingradient_mixAnimation_goBackTime = goBackTime;
			this.ingradient_mixAnimation_goOutTime = goOutTime;
			this.ingradient_mixAnimation_goSpeed = goSpeed;
			this.rotationSpeed = pRotationSpeed;
			this.ingradient_mixAnimation_startingRotationFromCenter = startingRotationFromCenter;
			this.ingradient_mixAnimation_goLength = 1;
			tragetFunction = tragetFunction_ingradient_mixAnimation;
			myTraget = ENUM_Trajet_ingradient_mixAnimation;
			tragetFunction_ingradient_mixAnimation();
		}
		
		public function init_heartCurve(pX:Number, pY:Number, pRotation:Number = 0, pLifeTime:Number =-1, finishPercentage:Number=1, size:Number=1):void {
			init_common(pX, pY, pRotation, pLifeTime);
			this.heartCurve_finishPercentage = finishPercentage;
			this.heartCurve_finishPercentageCount = 0;
			this.heartCurve_size = size;
			this.heartCurve_area = 2 * Math.PI * heartCurve_finishPercentage;
			tragetFunction = tragetFunction_heartCurve;
			myTraget = ENUM_Trajet_heartCurve;
		}
		
		public function setEnd_ingradient_mixAnimation():void {
			if (myTraget == ENUM_Trajet_ingradient_mixAnimation) {
				lifeTimeCount = ingradient_mixAnimation_goBackTime;
			}
		}
		
		protected function voidFunction():void {}
		
		protected function tragetFunction_transit():void {
			x += speed.x;
			y += speed.y;
			speed.x += accX;
			speed.y += accY;
		}
		
		protected function tragetFunction_rotate():void {
			this.rotation += rotationSpeed;
			rotationSpeed += rotationAcc;
		}
		
		protected function tragetFunction_transitAndRotate():void {
			tragetFunction_transit();
			tragetFunction_rotate();
		}
		
		protected function tragetFunction_float():void {
			var elapsedTime:Number = lifeTime-lifeTimeCount;
			while (elapsedTime >= float_turnTime) {
				elapsedTime -= float_turnTime;
			}
			var factor:Number = Math.sin(elapsedTime / float_turnTime * Math.PI * 2);
			x = startingX + factor * float_turn_offsetX;
			y = startingY + factor * float_turn_offsetY;
		}
		
		protected function tragetFunction_ingradient_mixAnimation():void {
			var elapsedTime:Number = lifeTime-lifeTimeCount;
			//this.rotation += rotationSpeed; this rotationSpeed is not that rotationSpeed in tragetFunction_rotate!
			this.ingradient_mixAnimation_startingRotationFromCenter += rotationSpeed;
			if (lifeTimeCount <= this.ingradient_mixAnimation_goBackTime) {
				//go back
				this.ingradient_mixAnimation_goLength += ingradient_mixAnimation_goSpeed;
			}else if (elapsedTime <= this.ingradient_mixAnimation_goOutTime) {
				//go out
				this.ingradient_mixAnimation_goLength -= ingradient_mixAnimation_goSpeed;
			}else {
				//go along circle
			}
			var ingradient_mixAnimation_goXfactor:Number = FMath.xFactorByRotation(this.ingradient_mixAnimation_startingRotationFromCenter);
			var ingradient_mixAnimation_goYfactor:Number = FMath.yFactorByRotation(this.ingradient_mixAnimation_startingRotationFromCenter);
			x = startingX + ingradient_mixAnimation_goLength * ingradient_mixAnimation_goXfactor;
			y = startingY + ingradient_mixAnimation_goLength * ingradient_mixAnimation_goYfactor;
		}
		
		protected function tragetFunction_heartCurve():void {
			var elapsedTimePercent:Number = (lifeTime-lifeTimeCount) / lifeTime;
			var t:Number = elapsedTimePercent * heartCurve_area;
			x = startingX + (16 * (Math.pow(Math.sin(t), 3)))*heartCurve_size;
			y = startingY - (13 * Math.cos(t) - 5 * Math.cos(2 * t) - 2 * Math.cos(3 * t) -Math.cos(4 * t)) * heartCurve_size;
		}
		
		override protected function doActionNormal (): void {
			lifeTimeCount -= 1;
			tragetFunction();
			super.doActionNormal();
			if (graphic != null) {
				if (lifeTime > -1) {
					//if the lifeTime is set(if not it is -1), use life time to delete this instance after a certain time
					if (lifeTimeCount<0) {
						willBeDestroyed = true;
					}
				}else{
					//if the lifeTime is NOT set, when graphic is played out, delete this instance
					if (graphic.currentFrame == graphic.totalFrames) {
						willBeDestroyed = true;
					}
				}
			}else {
				willBeDestroyed = true;
			}
		}
		override public function destroy():void
		{
			removeChild(graphic);
			graphic = null;
			super.destroy();
		}
	}

}