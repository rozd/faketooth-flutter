//
//  Serialization.swift
//  faketooth
//
//  Created by Max Rozdobudko on 6/26/20.
//

import Foundation
import Flutter

extension Array where Element == FaketoothPeripheral {
    init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[Faketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothPeripheral list.")
        guard let list = flutterArguments as? [Any] else {
            print("[Faketooth] serialization failed as specified arguments are not a valid list.")
            return nil
        }
        self.init(list.compactMap { FaketoothPeripheral(plugin: plugin, flutterArguments: $0) })
    }
}

extension Array where Element == FaketoothService {
    init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[Faketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothService list.")
        guard let list = flutterArguments as? [Any] else {
            print("[Faketooth] serialization failed as specified arguments are not a valid list.")
            return nil
        }
        self.init(list.compactMap { FaketoothService(plugin: plugin, flutterArguments: $0) })
    }
}

extension Array where Element == FaketoothCharacteristic {
    init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[Faketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothCharacteristic list.")
        guard let list = flutterArguments as? [Any] else {
            print("[Faketooth] serialization failed as specified arguments are not a valid list.")
            return nil
        }
        self.init(list.compactMap { FaketoothCharacteristic(plugin: plugin, flutterArguments: $0) })
    }
}

extension FaketoothPeripheral {

    convenience init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[Faketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothPeripheral instance.")
        guard let map = flutterArguments as? [String: Any] else {
            print("[Faketooth] serialization failed as specified arguments are not a valid map structure.")
            return nil
        }
        guard let identifier = UUID(uuidString: map["identifier"] as? String) else {
            print("[Faketooth] serialization failed as specified map doesn't contain valid \"identifier\" field.")
            return nil
        }

        self.init(
            identifier: identifier,
            name: map["name"] as? String ?? "Unknown", // TODO: name should be nullable on iOS side
            services: [FaketoothService](plugin: plugin, flutterArguments: map["services"]) ?? []
        )

        print("[Faketooth] serialization complete \(self)")
    }
}

extension FaketoothService {

    convenience init?(plugin: SwiftFaketoothPlugin,flutterArguments: Any?) {
        print("[Faketooth] attempt to serialize \(String(describing: flutterArguments)) to FaketoothService instance.")
        guard let map = flutterArguments as? [String: Any] else {
            print("[Faketooth] serialization failed as specified arguments are not a valid map structure.")
            return nil
        }
        guard let uuid = CBUUID(string: map["uuid"] as? String) else {
            print("[Faketooth] serialization failed, specified map doesn't contain valid \"uuid\" value.")
            return nil
        }
        self.init(
            uuid: uuid,
            isPrimary: (map["isPrimary"] as! NSNumber).boolValue,
            characteristics: [FaketoothCharacteristic](plugin: plugin, flutterArguments: map["characteristics"]) ?? [],
            includedServices: [FaketoothService](plugin: plugin, flutterArguments: map["includedServices"])
        )
    }
}

extension FaketoothCharacteristic {

    convenience init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[Faketooth] attempt to serialize \(String(describing: flutterArguments)) to FaketoothCharacteristic instance.")
        guard let map = flutterArguments as? [String: Any] else {
            print("[Faketooth] serialization failed, specified arguments are not a valid map structure.")
            return nil
        }
        guard let uuid = CBUUID(string: map["uuid"] as? String) else {
            print("[Faketooth] serialization failed, specified map doesn't contain valid \"uuid\" value.")
            return nil
        }
        guard let properties = CBCharacteristicProperties(rawValue: map["properties"] as? UInt) else {
            print("[Faketooth] serialization failed, specified map doesn't contain valid \"properties\" value.")
            return nil
        }
        var wrapper = Wrapper(plugin: plugin)
        self.init(
            uuid: uuid,
            dataProducer: wrapper.valueProducer,
            properties: properties,
            isNotifying: false,
            descriptors: nil
        )
        wrapper.characteristic = self
    }

    struct Wrapper {
        let plugin: SwiftFaketoothPlugin
        var characteristic: FaketoothCharacteristic?
        func valueProducer() -> Data? {
            guard let characteristic = characteristic else {
                return nil
            }
            return plugin.value(for: characteristic)
        }
    }
}

// MARK: - Utils

extension UUID {
    init?(uuidString: String?) {
        guard let uuidString = uuidString else {
            return nil
        }
        self.init(uuidString: uuidString)
    }
}

extension CBUUID {
    convenience init?(string: String?) {
        guard let string = string else {
            return nil
        }
        self.init(string: string)
    }
}

extension CBCharacteristicProperties {
    init?(rawValue: UInt?) {
        guard let rawValue = rawValue else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}
