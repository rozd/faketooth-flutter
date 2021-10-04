import Flutter
import UIKit
import CoreBluetooth

public class SwiftFaketoothPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "faketooth", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(SwiftFaketoothPlugin(channel: channel), channel: channel)
    }

    let channel: FlutterMethodChannel

    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "isSimulated":
            result(NSNumber(booleanLiteral: CBCentralManager.isSimulated))
        case "setSimulatedPeripherals":
            guard let peripherals = [FaketoothPeripheral](plugin: self, flutterArguments: call.arguments) else {
                break
            }
            CBCentralManager.simulatedPeripherals = peripherals
            result("OK")
        case "setDelaySettings":
            guard let delay = FaketoothDelaySettings(plugin: self, flutterArguments: call.arguments) else {
                break
            }
            FaketoothSettings.delay = delay
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

//

extension SwiftFaketoothPlugin {

    func requestValueForCharacteristic(_ characteristic: CBCharacteristic, completion: @escaping (Data?) -> ()) {
        let args = [
            "peripheral": characteristic.service?.peripheral?.identifier.uuidString,
            "uuid": characteristic.uuid.uuidString
        ]
        channel.invokeMethod("getValueForCharacteristic", arguments: args) { (value) in
            completion((value as? FlutterStandardTypedData)?.data)
        }
    }

    func updateValue(_ value: Data?, for characteristic: CBCharacteristic, completion: ((Any?) -> ())?) {
        let args = [
            "peripheral": characteristic.service?.peripheral?.identifier.uuidString,
            "uuid": characteristic.uuid.uuidString,
            "value": value
        ] as [String: Any?]
        channel.invokeMethod("setValueForCharacteristic", arguments: args, result: completion)
    }

    func requestValueForDescriptor(_ descriptor: CBDescriptor, completion: @escaping (Data?) -> ()) {
        let args = [
            "peripheral": descriptor.characteristic?.service?.peripheral?.identifier.uuidString,
            "uuid": descriptor.uuid.uuidString
        ]
        channel.invokeMethod("getValueForDescriptor", arguments: args) { (value) in
            completion((value as? FlutterStandardTypedData)?.data)
        }
    }

    func updateValue(_ value: Any?, for descriptor: CBDescriptor, completion: ((Any?) -> ())?) {
        let args = [
            "peripheral": descriptor.characteristic?.service?.peripheral?.identifier.uuidString,
            "uuid": descriptor.uuid.uuidString,
            "value": value
        ] as [String: Any?]
        channel.invokeMethod("setValueForDescriptor", arguments: args, result: completion)
    }

}
