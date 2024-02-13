import UIKit
import FirebaseCore
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

     GMSServices.provideAPIKey("AIzaSyAm_ZEJZ58IDAn9IjtGr3a9Y0UKKjOcWI0")
     GeneratedPluginRegistrant.register(with: self)
     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

