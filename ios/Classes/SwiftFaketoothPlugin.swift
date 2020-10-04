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

    func requestCharacteristicValue(characteristic: CBCharacteristic, completion: @escaping (Data?) -> ()) {
        let args = [
            "peripheral": characteristic.service.peripheral.identifier.uuidString,
            "uuid": characteristic.uuid.uuidString
        ]
        channel.invokeMethod("valueForCharacteristic", arguments: args) { (value) in
            completion((value as? FlutterStandardTypedData)?.data)
        }
    }

    func requestDescriptorValue(descriptor: CBDescriptor, completion: @escaping (Data?) -> ()) {
        let args = [
            "peripheral": descriptor.characteristic.service.peripheral.identifier.uuidString,
            "uuid": descriptor.uuid.uuidString
        ]
        channel.invokeMethod("valueForDescriptor", arguments: args) { (value) in
            completion((value as? FlutterStandardTypedData)?.data)
        }
    }

}
