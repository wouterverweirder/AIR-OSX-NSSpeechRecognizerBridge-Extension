#import <Foundation/Foundation.h>
#import <Adobe AIR/Adobe AIR.h>

@interface AIRSpeechRecognitionAdapter : NSObject <NSSpeechRecognizerDelegate>
{   
    @private
    FREContext _freContext;
    NSSpeechRecognizer *_speechRecognizer;
}

-(id) initWithContext:(FREContext) theFreContext;
-(void) setCommands:(FREObject) commands;
-(void) startListening;
-(void) stopListening;

@end
