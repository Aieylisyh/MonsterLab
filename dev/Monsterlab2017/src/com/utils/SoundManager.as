package com.utils 
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	import flash.media.SoundChannel;
	import  flash.events.Event;
	public class SoundManager 
	{
		private static var instance: SoundManager;
		private var sound_BackgroundMusic:SoundChannel;
		private var sound_sfxs:Vector.<SoundChannel> = new  Vector.<SoundChannel>();
		
		public function SoundManager() :void
		{
			sound_BackgroundMusic = null;
		}
		
		public static function getInstance (): SoundManager {
			if (instance == null) instance = new SoundManager();
			return instance;
		}
		
		public function startNewBackgroundMusic(className:String, vol:Number=1) :void
		{
			stopNewBackgroundMusic();
			var ClassReference:Class = getDefinitionByName(className) as Class;
			var snd:Sound = new ClassReference(); 
			var soundTransform:SoundTransform = new SoundTransform(vol, 0);
			sound_BackgroundMusic = snd.play(0, int.MAX_VALUE, soundTransform);
		}
		
		public function stopNewBackgroundMusic() :void
		{
			if (sound_BackgroundMusic != null) {
				sound_BackgroundMusic.stop();
			}
		}
		
		public function makeSound(className:String, loopTime:int=0, vol:Number=1):int {
			var ClassReference:Class = getDefinitionByName(className) as Class;
			var snd:Sound = new ClassReference(); 
			var soundTransform:SoundTransform = new SoundTransform(vol, 0);
			var channel:SoundChannel = snd.play(0,loopTime,soundTransform);
			if (channel != null) {
				sound_sfxs.push(channel)
				return -1;
			}
			return sound_sfxs.length-1;
		}
		
		public function stopSound(index:int):Boolean {
			if (sound_sfxs.length - 1 > index) {
				return false;
			}else {
				sound_sfxs[index].stop();
				return true;
			}
		}
		
		public function setSoundVol(index:int, vol:Number):Boolean {
			if (sound_sfxs.length - 1 > index) {
				return false;
			}else {
				var soundTransform:SoundTransform = new SoundTransform(vol, 0);
				sound_sfxs[index].soundTransform = soundTransform;
				return true;
			}
		}
	}
}