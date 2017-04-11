package com.monsterlab.sprites.gameobjects {
	import com.utils.Config;
	import com.utils.FMath;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	/**
	 * ...
	 * this class enable mouse/touch control for player
	 */
	public class PlayerController 
	{
		
		//trigger events
		public static const DRAG_LEFT:String = "DRAG_LEFT";
		public static const DRAG_RIGHT:String = "DRAG_RIGHT";
		public static const DRAG_UP:String = "DRAG_UP";
		public static const DRAG_DOWN:String = "DRAG_DOWN";
		public static const DURATION_SHORT:String = "DURATION_SHORT";
		public static const DURATION_LONG:String = "DURATION_LONG";
		
		public var isOn:Boolean = false;
		
		protected const TRIGGER_DURATION:int = 500;//more than this value will be regarded as drag/long click,else short click
		protected const TOLERANCE:int = 15;//x+y more than this value will be regarded as drag, else long click
		
		protected var host:Player;
		
		
		public var event_start_x:Number;
		public var event_start_y:Number;
		public var event_end_x:Number;
		public var event_end_y:Number;
		public var event_last_x:Number;
		public var event_last_y:Number;
		protected var timer:int;
		
		public function PlayerController(theHost:Player) 
		{
			host = theHost;
		}
		public function start():void {
			start_mouse();
		}
		public function stop():void {
			stop_mouse();
		
		private function start_mouse():void {
			Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Config.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function stop_mouse():void {
			Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Config.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		
		private function start_touch():void {
			
		}
		private function stop_touch():void {
			
		}
		
		private function onMouseDown(_:MouseEvent):void {
			event_start_x = _.stageX;
			event_start_y = _.stageY;
			timer = getTimer();
			isOn = true;
			
		}
		private function onMouseMove(_:MouseEvent):void {
			if (!isOn) return;
		}
		private function onMouseUp(_:MouseEvent):void {
			event_end_x = _.stageX;
			event_end_y = _.stageY;
			isOn = false;
			var duration:int = getTimer() - timer;
			var p1:Point = new Point(event_start_x, event_start_y);
			var p2:Point = new Point(event_end_x, event_end_y);
		}
		
	}

}