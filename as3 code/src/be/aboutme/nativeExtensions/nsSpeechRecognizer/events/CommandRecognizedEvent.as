package be.aboutme.nativeExtensions.nsSpeechRecognizer.events
{
	import flash.events.Event;
	
	public class CommandRecognizedEvent extends Event
	{
		
		public static const COMMAND_RECOGNIZED:String = "commandRecognized";
		
		public var command:String;
		
		public function CommandRecognizedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, command:String = null)
		{
			super(type, bubbles, cancelable);
			this.command = command;
		}
		
		override public function clone():Event
		{
			return new CommandRecognizedEvent(type, bubbles, cancelable, command);
		}
	}
}