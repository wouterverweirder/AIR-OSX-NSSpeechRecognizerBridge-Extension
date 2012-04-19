#import "SpeechRecognitionExtension.h"
#import "AIRSpeechRecognitionAdapter.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

DEFINE_ANE_FUNCTION( initNativeCode )
{
    //create an adapter for this instance
    AIRSpeechRecognitionAdapter *adapter = [[AIRSpeechRecognitionAdapter alloc] initWithContext:context];
    FRESetContextNativeData(context, adapter);
    return NULL;
}

DEFINE_ANE_FUNCTION( releaseNativeCode )
{
    AIRSpeechRecognitionAdapter *adapter;
    FREGetContextNativeData(context, (void **) &adapter);
    [adapter release];
    adapter = nil;
    return NULL;
}

DEFINE_ANE_FUNCTION( setCommands )
{
    AIRSpeechRecognitionAdapter *adapter;
    FREGetContextNativeData(context, (void **) &adapter);
    [adapter setCommands:argv[0]];
    return NULL;
}

DEFINE_ANE_FUNCTION( startListening )
{
    AIRSpeechRecognitionAdapter *adapter;
    FREGetContextNativeData(context, (void **) &adapter);
    [adapter startListening];
    return NULL;
}

DEFINE_ANE_FUNCTION( stopListening )
{
    AIRSpeechRecognitionAdapter *adapter;
    FREGetContextNativeData(context, (void **) &adapter);
    [adapter stopListening];
    return NULL;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION( initNativeCode, NULL ),
        MAP_FUNCTION( releaseNativeCode, NULL ),
        MAP_FUNCTION( setCommands, NULL ),
        MAP_FUNCTION( startListening, NULL ),
        MAP_FUNCTION( stopListening, NULL )
    };
    *numFunctions = sizeof( functionMap ) / sizeof( FRENamedFunction );
    *functions = functionMap;
}

void contextFinalizer(FREContext ctx)
{
    return;
}

void speechRecognizerBridgeExtensionInitializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
{
    *ctxInitializer = &contextInitializer;
    *ctxFinalizer = &contextFinalizer;
}

void speechRecognizerBridgeExtensionFinalizer(void* extData)
{
    return;
}