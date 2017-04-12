package com.monsterlab.sprites.gameobjects 
{
	import com.utils.Config;
	import com.utils.FMath;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.text.TextField;
	import com.monsterlab.GameStage;
	/**
	 * ...
	 * @author Song Huang
	 */
	public class MixerController 
	{
		//trigger events
		public static const DRAG_LEFT:String = "DRAG_LEFT";
		public static const DRAG_RIGHT:String = "DRAG_RIGHT";
		public static const DRAG_UP:String = "DRAG_UP";
		public static const DRAG_DOWN:String = "DRAG_DOWN";
		public static const DURATION_SHORT:String = "DURATION_SHORT";
		public static const DURATION_LONG:String = "DURATION_LONG";
		
		protected const TRIGGER_DURATION:int = 500;//more than this value will be regarded as drag/long click,else short click
		protected const TOLERANCE:int = 15;//x+y more than this value will be regarded as drag, else long click
		
		protected var host:Mixer;
		
		
		public var event_start_x:Number;
		public var event_start_y:Number;
		public var event_end_x:Number;
		public var event_end_y:Number;
		public var event_last_x:Number;
		public var event_last_y:Number;
		protected var timer:int;
		
		public var isDraging:Boolean = false;
		private var mixerRadius:Number  = 250;
		private var mixerDragFactor:Number  = 1;
		//private var text1:TextField;
		//private var text2:TextField;
		private var lastPos:Point;
		public function MixerController(theHost:Mixer) 
		{
			host = theHost;
			reset();
			/*text1 = new TextField();
			text1.scaleX = text1.scaleY = 4;
			GameStage.getInstance().getGameContainer_3().addChild(text1);
			text1.x = host.x + 180;
			text1.y = host.y + 50;
			text2 = new TextField();
			GameStage.getInstance().getGameContainer_3().addChild(text2);
			text2.scaleX = text2.scaleY = 4;
			text2.x = host.x + 180;
			text2.y = host.y + 100;
			text1.text = "1110";
			text2.text = "1110";*/
		}
		public function start():void {
			start_mouse();
			//start_touch();
		}
		public function stop():void {
			stop_mouse();
			//stop_touch();
			if (isDraging)
				onRelease();
		}
		
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
		
		private function onMouseDown(_:MouseEvent = null):void {
			lastPos = new Point(_.stageX, _.stageY);
			event_start_x = _.stageX;
			event_start_y = _.stageY;
			timer = getTimer();
			isDraging = true;
		}
		
		private function onMouseMove(_:MouseEvent):void {
			if (!isDraging) {
				lastPos = new Point(_.stageX, _.stageY);
				return;
			}
			var realPos:Point = GameStage.getInstance().stagePointToScreenPoint(new Point(_.stageX, _.stageY ));
			var relativePos:Point = new Point(realPos.x - host.x, realPos.y - host.y);
			//text1.text = Math.floor(realPos.x).toString() + "," +Math.floor(realPos.y).toString();
			if (IsPositionInMixer(relativePos))
			{
				var movement:Point = new Point(_.stageX-lastPos.x, _.stageY-lastPos.y);
				//text1.text = Math.floor(movement.x).toString() + "," +Math.floor(movement.y).toString();
                var cross:Number = movement.x * relativePos.y - movement.y * relativePos.x;
				//text2.text = cross.toString();
                host.setSpeed(Math.max(Math.min(-cross * 0.02, 25), -25));
			}
			else
			{
				//text2.text = "not in";
				onMouseUp();
			}
			lastPos = new Point(_.stageX, _.stageY);
		}
		
		private function onMouseUp(_:MouseEvent=null):void {
			//event_end_x = _.stageX;
			//event_end_y = _.stageY;
			//var duration:int = getTimer() - timer;
			//var p1:Point = new Point(event_start_x, event_start_y);
			//var p2:Point = new Point(event_end_x, event_end_y);
			if (isDraging)
				onRelease();
		}

		private function onRelease():void {
			isDraging = false;
		}

		private function IsPositionInMixer(point:Point):Boolean
		{
			return (FMath.getDistance(point, new Point(0, 0)) < mixerRadius);
		}
		
		private function reset():void
		{
			isDraging = false;
			host.reset();
		}
	}
} 