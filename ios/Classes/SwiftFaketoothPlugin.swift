import Flutter
import UIKit
import CoreBluetooth

public class SwiftFaketoothPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "faketooth", binaryMessenger: registrar.messenger())
    let instance = SwiftFaketoothPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "isSimulated":
        result(NSNumber(booleanLiteral: CBCentralManager.isSimulated))
    case "setSimulatedPeripherals":
        guard let peripherals = [FaketoothPeripheral](flutterArguments: call.arguments) else {
            break
        }
        CBCentralManager.simulatedPeripherals = peripherals
        result("OK")
    default:
        result(FlutterError.unsupportedMethodInvokation(call: call))
    }
  }
}

//

extension FlutterError {
    static func unsupportedMethodInvokation(call: FlutterMethodCall) -> FlutterError {
        return FlutterError(
            code: "general",
            message: "Unsupported method \(call.method)",
            details: nil
        )
    }
}
