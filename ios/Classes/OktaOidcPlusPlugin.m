#import "OktaOidcPlusPlugin.h"
#if __has_include(<okta_oidc_plus/okta_oidc_plus-Swift.h>)
#import <okta_oidc_plus/okta_oidc_plus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
#import "okta_oidc_plus-Swift.h"
#endif

@implementation OktaOidcPlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOktaOidcPlusPlugin registerWithRegistrar:registrar];
}
@end
