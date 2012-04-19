package be.aboutme.nativeExtensions.nsSpeechRecognizer
{
	import be.aboutme.nativeExtensions.nsSpeechRecognizer.events.CommandRecognizedEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	[Event(name="commandRecognized", type="be.aboutme.nativeExtensions.nsSpeechRecognizer.events.CommandRecognizedEvent")]
	public class NSSpeechRecognizerBridge extends EventDispatcher
	{
		
		private var disposed:Boolean;
		private var context:ExtensionContext;
		
		public function NSSpeechRecognizerBridge()
		{
			//create the extension _context
			context = ExtensionContext.createExtensionContext("be.aboutme.nativeExtensions.nsspeechrecognizerbridge", null);
			context.addEventListener(StatusEvent.STATUS, contextStatusHandler, false, 0, true);
			
			//initialize the native code
			context.call("initNativeCode");
			
			//dispose the extension on application exit
			NativeApplication.nativeApplication.addEventListener("exiting", exitingHandler, false, 0, true);
		}
		
		protected function contextStatusHandler(event:StatusEvent):void
		{
			switch(event.code)
			{
				case "commandRecognized":
					dispatchEvent(new CommandRecognizedEvent(CommandRecognizedEvent.COMMAND_RECOGNIZED, false, false, event.level));
					break;
				default:
					trace("contextStatusHandler", event.code, event.level);
					break;
			}
		}
		
		protected function exitingHandler(event:Event):void
		{
			dispose();
		}
		
		public function setCommands(commands:Vector.<String>):void
		{
			context.call("setCommands", commands);
		}
		
		public function startListening():void
		{
			context.call("startListening");
		}
		
		public function stopListening():void
		{
			context.call("stopListening");
		}
		
		public function dispose():void
		{
			if(!disposed)
			{
				disposed = true;
				context.call("releaseNativeCode");
				context.dispose();
			}
		}
	}
}