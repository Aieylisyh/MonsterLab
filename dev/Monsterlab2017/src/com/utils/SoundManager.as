package com.utils 
{
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;
	public class SoundManager 
	{
		
		public function SoundManager() 
		{
			
		}
		public static function makeSound(className:String):void {
			var ClassReference:Class = getDefinitionByName(className) as Class;
			var snd:Sound = new ClassReference(); 
			snd.play();
		}
	}

}