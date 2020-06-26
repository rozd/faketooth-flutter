#import "FaketoothPlugin.h"
#if __has_include(<faketooth/faketooth-Swift.h>)
#import <faketooth/faketooth-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "faketooth-Swift.h"
#endif

@implementation FaketoothPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFaketoothPlugin registerWithRegistrar:registrar];
}
@end
