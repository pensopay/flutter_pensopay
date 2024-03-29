#import "PensopayPlugin.h"
#if __has_include(<pensopay_ios/pensopay_ios-Swift.h>)
#import <pensopay_ios/pensopay_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pensopay_ios-Swift.h"
#endif

@implementation PensopayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPensopayPlugin registerWithRegistrar:registrar];
}
@end
