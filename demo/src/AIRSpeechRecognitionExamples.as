package
{
	
	import be.aboutme.nativeExtensions.nsSpeechRecognizer.NSSpeechRecognizerBridge;
	import be.aboutme.nativeExtensions.nsSpeechRecognizer.events.CommandRecognizedEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(frameRate="60", width="800", height="600")]
	public class AIRSpeechRecognitionExamples extends Sprite
	{
		
		private var nsSpeechRecognizerBridge:NSSpeechRecognizerBridge;
		
		public function AIRSpeechRecognitionExamples()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.nativeWindow.visible = true;
			
			nsSpeechRecognizerBridge = new NSSpeechRecognizerBridge();
			nsSpeechRecognizerBridge.setCommands(Vector.<String>([
				"square", 
				"circle",
			]));
			nsSpeechRecognizerBridge.addEventListener(CommandRecognizedEvent.COMMAND_RECOGNIZED, commandRecognizedHandler, false, 0, true);
			nsSpeechRecognizerBridge.startListening();
		}
		
		protected function commandRecognizedHandler(event:CommandRecognizedEvent):void
		{
			trace("command recognized: " + event.command);
			switch(event.command)
			{
				case "square":
					graphics.beginFill(Math.random() * 0xFFFFFF);
					graphics.drawRect(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight, 100, 100);
					graphics.endFill();
					break;
				case "circle":
					graphics.beginFill(Math.random() * 0xFFFFFF);
					graphics.drawCircle(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight, 100);
					graphics.endFill();
					break;
			}
		}
	}
}