package com.monsterlab.ui {
	
	import com.utils.Config;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class Screen extends Sprite 
	{
		
		public function Screen() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);

		}
		
		/**
		 * 
		 * @param	pEvent
		 */
		protected function init (pEvent:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Config.stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		/**
		 * repositionne les éléments de l'écran
		 * @param	pEvent
		 */
		protected function onResize (pEvent:Event=null): void {
			
		}
		
		/**
		 * nettoie l'instance
		 */
		public function destroy (): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Config.stage.removeEventListener(Event.RESIZE, onResize);
		}
		
	}

}