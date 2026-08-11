import Flutter
import UIKit
import OktaOidc

public class SwiftOktaOidcPlusPlugin: NSObject, FlutterPlugin {
    var oktaSessionManager: OktaSessionManager?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "okta_oidc_plus", binaryMessenger: registrar.messenger())
        let instance = SwiftOktaOidcPlusPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "initialize-okta") {
            guard let oktaInfo: Dictionary = call.arguments as? [String: Any?] else {
                result(false)
                return
            }
            let oktaConfig = OktaConfigModel(response: ((oktaInfo["config"]!! as! String).toJSON() as! [String: Any]))
            oktaSessionManager = OktaSessionManager(oktaConfigModel: oktaConfig)
            result(true)
        } else if (call.method == "sign-in") {
            guard let viewController: UIViewController = UIApplication.shared.delegate?.window??.rootViewController else {
                result(["status": false, "message": "Root view controller not found"])
                return
            }
            oktaSessionManager?.oktaLogin(params: [:], viewController: viewController, success: { (response) in
                result(["status": response.status, "message": response.message])
            }, failure: { (response) in
                result(response)
            })
        } else if (call.method == "social-login") {
            guard let viewController: UIViewController = UIApplication.shared.delegate?.window??.rootViewController else {
                result(["status": false, "message": "Root view controller not found"])
                return
            }
            guard let oktaInfo: Dictionary = call.arguments as? [String: Any?] else {
                let flutterError = FlutterError(
                    code: "OktaLogin_Error",
                    message: "Please provide idp for social login",
                    details: "Please provide idp for social login"
                )
                result(flutterError)
                return
            }
            oktaSessionManager?.oktaLogin(
                params: ["idp": oktaInfo["idp"]!! as! String],
                viewController: viewController,
                success: { (response) in
                    result(["status": response.status, "message": response.message])
                },
                failure: { (response) in
                    result(response)
                }
            )
        } else if (call.method == "get-access-token") {
            oktaSessionManager?.renewTokens(success: {
                result(["status": true, "message": self.oktaSessionManager?.stateManager?.accessToken ?? ""])
            }, failure: { (response) in
                result(["status": false, "message": response])
            })
        } else if (call.method == "logout") {
            oktaSessionManager?.revokeTokens(success: {
                result(true)
            }, failure: {
                result(false)
            })
        } else if (call.method == "get-user-profile") {
            oktaSessionManager?.getUser(callback: { user, error in
                if (error != nil) {
                    result(error)
                    return
                }
                result(user)
            })
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
