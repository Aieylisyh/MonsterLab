package com.monsterlab.game.gameobjects.sprites {
	import flash.display.DisplayObject;
    import flash.display.Sprite;
	import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
	import com.monsterlab.game.gameobjects.GameObject
	public class Button extends GameObject
	{
		private var clickFunction:Function = null;
		
		
		
		
		public function Button(name_graphic:String, onClick:Function, pX:Number = 0, pY:Number = 0, onceOnly:Boolean = true, alignX:int = 1, alignY:int = 1 ) {
			super();
			generateGraphics(name_graphic,alignX,alignY);

			//trace(graphic);

			clickFunction = onClick;
			if (onceOnly) {
				addEventListener(MouseEvent.CLICK, onClickFunction);
			}else {
				addEventListener(MouseEvent.CLICK, onClick);
			}
			x = pX;
			y = pY;
		}
		private function onClickFunction(_:MouseEvent):void {
			removeEventListener(MouseEvent.CLICK, onClickFunction);
			clickFunction();
		}
		override public function destroy():void
		{
			super.destroy();
		}
	}

}