#import "SimpleCalendarPlugin.h"
#if __has_include(<simple_calendar/simple_calendar-Swift.h>)
#import <simple_calendar/simple_calendar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "simple_calendar-Swift.h"
#endif

@implementation SimpleCalendarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSimpleCalendarPlugin registerWithRegistrar:registrar];
}
@end
