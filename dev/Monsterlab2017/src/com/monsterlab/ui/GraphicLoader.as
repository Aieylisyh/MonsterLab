﻿package com.monsterlab.ui {
	import com.monsterlab.ui.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	

	public class GraphicLoader extends Screen 
	{
		
		/**
		 * instance unique de la classe GraphicLoader
		 */
		protected static var instance: GraphicLoader;

		public var mcContent:Sprite;
	
		public function GraphicLoader() 
		{
			super();
		}
		
		public static function getInstance (): GraphicLoader {
			if (instance == null) instance = new GraphicLoader();
			return instance;
		}
		
		override protected function init (pEvent:Event): void {
			super.init(pEvent);
			mcContent.scaleX = 0;
		}
		
		public function update (pProgress:Number): void {
			mcContent.scaleX = pProgress;
		}
		
		/**
		 * détruit l'instance unique et met sa référence interne à null
		 */
		override public function destroy (): void {
			instance = null;
			super.destroy();
		}

	}
}