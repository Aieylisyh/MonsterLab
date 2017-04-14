package com.monsterlab.game.gameobjects.sprites {
	import adobe.utils.CustomActions;
	import com.monsterlab.game.gameobjects.GameObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import com.monsterlab.GameStage;
	import com.utils.FMath;
	import flash.events.MouseEvent;
	import com.utils.Config;
	/**
	 * ...
	 * @author Song
	 */
	public class DragDropTarget extends GameObject
	{
		protected var assetName:String;
		private var graphic:MovieClip;
		private var speed:Point = new Point(0, 0);
		private var startingX:Number;
		private var startingY:Number;
		private var startingX_drag:Number;
		private var startingY_drag:Number;
		private var startingMouseX:Number;
		private var startingMouseY:Number;
		private var originParent:Sprite;
		public var isDraging:Boolean;
		public var willGoBack:Boolean;
		public var canBeDragged:Boolean;
		private var forceUpdateMouseMove:int;
		private var myMouseEvent:MouseEvent;
		private var targetSprite:Sprite;
		private var distanceToTarget:Number;
		private var distanceToSelf:Number;
		private static var dragObjList:Vector.<DragDropTarget> = new Vector.<DragDropTarget>();
		public function DragDropTarget(pName:String) 
		{
			super();
			dragObjList.push(this);
			assetName = pName;
			start();
			forceUpdateMouseMove = 0;
		}
		
		public function init(pOriginParent:Sprite, pTargetSprite:Sprite, pX:Number, pY:Number, pRotation:Number = 0, pScale:Number=1, pDistanceToTarget:Number=80, pDistaceToSelf:Number = 100):void {
			var ClassReference:Class = getDefinitionByName(assetName) as Class;
            graphic = new ClassReference();
			graphic.mouseChildren = false;
			graphic.mouseEnabled = false;
			if (graphic.totalFrames < 2) {
				graphic.cacheAsBitmap = true; 
				//graphic.cacheAsBitmapMatrix = new Matrix();
			}
			addChild(graphic);
			targetSprite = pTargetSprite;
			distanceToTarget = pDistanceToTarget;
			distanceToSelf = pDistaceToSelf;
			if(pRotation!=0)
				rotation = pRotation;
			startingX = pX;
			startingY = pY;
			x = pX;
			y = pY;
			scaleX = scaleY = pScale;
			originParent = pOriginParent;
			originParent.addChild(this);
			myOnMouseUp();
			//trace("pos " + x + ", " + y);
			Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, myOnMouseDown);
			Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, myOnMouseMove);
			Config.stage.addEventListener(MouseEvent.MOUSE_UP, myOnMouseUp);
			canBeDragged = true;
			willGoBack = false;
		}
		
		private function myOnMouseDown(e:MouseEvent):void {
			trace("onMouseDown");
			for each(var obj:DragDropTarget in DragDropTarget.dragObjList) {
				if (obj != null && obj != this && obj.isDraging)
					return;
			}
			//trace("onMouseDownv1");
			if (!canBeDragged)
				return;
			//trace("onMouseDownv2");
			var mousePoint:Point = GameStage.getInstance().stagePointToScreenPoint(new Point(e.stageX, e.stageY));
			var distance:Number = FMath.getDistance(new Point(originParent.x + x, originParent.y + y), mousePoint);
			if (distance > distanceToSelf) {
				trace(distance);
				return;
			}
			//trace("onMouseDownv3");
			isDraging = true;
			originParent.removeChild(this);
			//startingX_drag =  (startingX - GameStage.getInstance().x)/GameStage.getInstance().scaleX;
			//startingY_drag =  (startingY - GameStage.getInstance().y)/GameStage.getInstance().scaleY;
			startingX_drag =  startingX +originParent.x;
			startingY_drag =  startingY +originParent.y;
			x = startingX_drag;
			y = startingY_drag;
			GameStage.getInstance().getGameContainer_5().addChild(this);
			startingMouseX = e.stageX;
			startingMouseY = e.stageY;
			willGoBack = false;
			myMouseEvent = e;
			//forceUpdateMouseMove = 2;
			//trace(startingMouseX+" startingMouse "+startingMouseY);
			//trace(parent==GameStage.getInstance().getGameContainer_5());
			//trace(e.stageX + " down " + e.stageY);
			//trace(x+" down "+y);
		}
		
		private function myOnMouseUp(e:MouseEvent = null):void {
			trace("onMouseUp");
			if (isDraging) {
				//trace(x + " me " + y);
				//trace(Mixer.getInstance().x + " Mixer " + Mixer.getInstance().y);
				var targetPos:Point = new Point(targetSprite.x,targetSprite.y);
				var distance:Number = FMath.getDistance(new Point(x, y), targetPos );
				//trace(distance);
				if (distance > distanceToTarget) {
					willGoBack = true;
				} else {
					onDragToTarget();
				}
				isDraging = false;
				canBeDragged = false;
			}
		}
		
		protected function onDragToTarget():void {
			 willGoBack = true;
		}
		
		private function myOnMouseMove(e:MouseEvent=null):void {
			if (isDraging) {
				//trace("myOnMouseMove");
				//trace(parent==GameStage.getInstance().getGameContainer_5());
				//trace(e.stageX + " move " + e.stageY);
				//trace(x + " move " + y);
				//trace(startingMouseX+" startingMouse "+startingMouseY);
				//trace((e.stageX-startingMouseX)+" deltamove "+(e.stageY-startingMouseY));
				x = (e.stageX-startingMouseX)/GameStage.getInstance().scaleX+startingX_drag;
				y = (e.stageY-startingMouseY)/GameStage.getInstance().scaleY+startingY_drag;
			}
		}
		protected function dragingFunction():void {}
		protected function idleFunction():void { }
		
		override protected function doActionNormal (): void {
			super.doActionNormal();
			if (graphic == null) {
				willBeDestroyed = true;
			}else {
				if (!isDraging && !canBeDragged && willGoBack) {
					var targetPos:Point = new Point(originParent.x+startingX,originParent.y+startingY);
					var distance:Number = FMath.getDistance(new Point(x,y),targetPos );
					if (distance>20) {
						//trace("GONING BACK");
						x -= (x-targetPos.x)*0.25;
						y -= (y-targetPos.y)*0.25;
					}else {
						//trace(" BACK");
						originParent.addChild(this);
						x = startingX;
						y = startingY;
						canBeDragged = true;
						willGoBack = false;	
					}
				}else if (forceUpdateMouseMove > 0) {
					forceUpdateMouseMove--;
					//myOnMouseMove(myMouseEvent);
					//trace(x+"  "+y);
				}else if (!isDraging && canBeDragged) {
					idleFunction();
				}else if (isDraging) {
					dragingFunction();
				}
			}
		}
		override public function destroy():void
		{
			var i:int = dragObjList.indexOf(this);
			dragObjList.splice(i, 1);
			if(graphic!=null)
				removeChild(graphic);
			graphic = null;
			super.destroy();
		}
	}
}