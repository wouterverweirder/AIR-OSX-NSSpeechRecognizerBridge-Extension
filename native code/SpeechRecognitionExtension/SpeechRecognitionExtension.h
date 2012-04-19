//
// AIR Native Extension, to bring Speech Recognition to Adobe AIR.
// Thanks to http://www.richardlord.net/blog/20-tips-for-creating-air-native-extensions-for-ios
// for some of the great tips on writing native extensions
//

#define EXTENSION_API __attribute__((visibility("default")))
#include <Adobe AIR/Adobe AIR.h>

//initializer / finalizer
void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions);
void contextFinalizer(FREContext ctx);
    
EXTENSION_API void speechRecognizerBridgeExtensionInitializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
EXTENSION_API void speechRecognizerBridgeExtensionFinalizer(void* extData);