#import "AIRSpeechRecognitionAdapter.h"

@implementation AIRSpeechRecognitionAdapter

-(id) initWithContext:(FREContext)theFreContext
{
    if(self = [super init])
    {
        _freContext = theFreContext;
        _speechRecognizer = [[NSSpeechRecognizer alloc] init];
        [_speechRecognizer setDelegate:self];
        [_speechRecognizer setListensInForegroundOnly:YES];
    }
    return self;
}

-(void) dealloc
{
    [super dealloc];
    [_speechRecognizer release];
    _speechRecognizer = nil;
}

-(void) setCommands:(FREObject)asCommands
{
    uint32_t asNumCommands; FREGetArrayLength(asCommands, &asNumCommands);
    FREObject asCommand;
    uint32_t asCommandLength;
    NSMutableArray *mutableCommands = [[NSMutableArray alloc] init ];
    for(uint32_t i = 0; i < asNumCommands; i++)
    {
        FREGetArrayElementAt(asCommands, i, &asCommand);
        const uint8_t *command;
        FREGetObjectAsUTF8(asCommand, &asCommandLength, &command);
        NSString *commandString = [[NSString stringWithUTF8String:(const char *)command] retain];
        [mutableCommands addObject:commandString];
        [commandString release];
    }
    NSArray *commands = [[NSArray alloc] initWithArray:mutableCommands];
    [mutableCommands release];
    NSLog(@"AIRSpeechRecognitionAdapter: setCommands: %@", commands);
    [_speechRecognizer setCommands:commands];
    [commands release];
}

-(void) startListening
{
    NSLog(@"AIRSpeechRecognitionAdapter: startListening");
    [_speechRecognizer startListening];
    [_speechRecognizer setBlocksOtherRecognizers:YES];
}

-(void) stopListening
{
    NSLog(@"AIRSpeechRecognitionAdapter: stopListening");
    [_speechRecognizer setBlocksOtherRecognizers:NO];
    [_speechRecognizer stopListening];
}

- (void)speechRecognizer:(NSSpeechRecognizer *)sender didRecognizeCommand:(id)aCmd 
{
    NSLog(@"AIRSpeechRecognitionAdapter: didRecognizeCommand");
    FREDispatchStatusEventAsync(_freContext, (const uint8_t *) "commandRecognized", (const uint8_t *) [(NSString *)aCmd UTF8String]);
}

@end
