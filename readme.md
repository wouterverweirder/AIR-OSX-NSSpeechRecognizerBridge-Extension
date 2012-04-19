#AIR NSSpeechRecognizer Bridge

**Author: Wouter Verweirder**

*The NSSpeechRecognizerBridge gives you the option to add the simple built-in speech recognition capabilities of your mac to your Adobe AIR Desktop application.*

##Usage

First of all you need to create an instance of the bridge:

	var nsSpeechRecognizerBridge:NSSpeechRecognizerBridge = new NSSpeechRecognizerBridge();

After that, you add a list of valid commands:

	nsSpeechRecognizerBridge.setCommands(Vector.<String>([
		"square", 
		"circle",
	]));

You add an event handler, which is triggered when a command is recognized:

	nsSpeechRecognizerBridge.addEventListener(CommandRecognizedEvent.COMMAND_RECOGNIZED, commandRecognizedHandler);

And you start the recognizer:

	nsSpeechRecognizerBridge.startListening();

This will open the speech recognition widget of OSX, with your AIR application. The event handler is triggered when the bridge recognizes one of the commands. The CommandRecognizedEvent object, will contain the command that was recognized:

	protected function commandRecognizedHandler(event:CommandRecognizedEvent):void
	{
		trace("command recognized: " + event.command);
	}

Note that this built-in speech recognition engine is quite sensitive to background noise, and only recognizes US-English spoken words.