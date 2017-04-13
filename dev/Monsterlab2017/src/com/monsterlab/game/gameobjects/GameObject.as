package com.monsterlab.game.gameobjects
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class GameObject extends Sprite
	{
		
		public var doAction:Function;
		public static var list:Vector.<GameObject> = new Vector.<GameObject>(); //all gameobjects
		public var willBeDestroyed:Boolean = false;
		public static var cachedBmp:Object={};
		public function GameObject()
		{
			super();
			setModeVoid();
			list.push(this);
		}
		
		/**
		 * applique le mode "ne fait rien"
		 */
		protected function setModeVoid():void
		{
			doAction = doActionVoid;
		}
		
		/**
		 * fonction vidé destinée à maintenir la référence de doAction sans rien faire
		 */
		protected function doActionVoid():void
		{
		}
		
		/**
		 * applique le mode normal (mode par defaut)
		 */
		protected function setModeNormal():void
		{
			doAction = doActionNormal;
		}
		
		/**
		 * fonction destinée à appliquer un comportement par defaut
		 */
		protected function doActionNormal():void
		{
		}
		
		/**
		 * Activation
		 */
		public function start():void
		{
			setModeNormal();
		}
		
		/**
		 * nettoie et détruit l'instance
		 */
		public function destroy():void
		{
			setModeVoid();
			if (this["parent"] != null)
			{
				parent.removeChild(this);
			}
			else
			{
				trace(this.toString() + "has no parent");
			}

			var i:int = list.indexOf(this);
			list.splice(i, 1);
		}
		
		protected function generateGraphics(className:String, alignX:int = 1, alignY:int = 1):Sprite
		{
			//generate a bitmap and add it to the gameobject, return the Sprite if necessary, example:Player should take a mcShoot from the Sprite
			//w h are the width and height of the sprite in flash, alignX and alignY is 0:left top 1:center center 2:right bottom
			//i haven't test alignX alignY with 0 and 2, so if you meet a bug, try find this here
			//using cache to save BitmapData.if the name is exactly the same, will use from cache;
			
			var myBitmapData:BitmapData;
			var bmp:Bitmap;
			var graphic:Sprite;
			var w:Number;
			var h:Number;
			if (cachedBmp[className] != null) {
				myBitmapData = cachedBmp[className][1];
				graphic = cachedBmp[className][0];
				w = graphic.width;
				h = graphic.height;
				
			}else {
				var ClassReference:Class = getDefinitionByName(className) as Class;
				graphic = new ClassReference(); 
				w = graphic.width;
				h = graphic.height;
				myBitmapData = new BitmapData(w, h, true, 0);
				
				myBitmapData.draw(graphic, new Matrix(1, 0, 0, 1, w * (alignX * 0.5), h * (alignY * 0.5)));
				cachedBmp[className] = [graphic, myBitmapData];
			}
			bmp = new Bitmap(myBitmapData);
			bmp.x = -w * (alignX * 0.5);
			bmp.y = -h * (alignY * 0.5);
			addChild(bmp);
			graphic.cacheAsBitmap = true; 
			//trace(cachedBmp[className]);
			//trace(cachedBmp["foo"]==null);
			return graphic;
		}
	}

}