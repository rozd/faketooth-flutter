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
        print("[FlutterFaketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothPeripheral list.")
        guard let list = flutterArguments as? [Any] else {
            print("[FlutterFaketooth] serialization failed as specified arguments are not a valid list.")
            return nil
        }
        self.init(list.compactMap { FlutterFaketoothPeripheral(plugin: plugin, flutterArguments: $0) })
    }
}

extension Array where Element == FaketoothService {
    init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[FlutterFaketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothService list.")
        guard let list = flutterArguments as? [Any] else {
            print("[FlutterFaketooth] serialization failed as specified arguments are not a valid list.")
            return nil
        }
        self.init(list.compactMap { FaketoothService(plugin: plugin, flutterArguments: $0) })
    }
}

extension Array where Element == FaketoothCharacteristic {
    init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[FlutterFaketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothCharacteristic list.")
        guard let list = flutterArguments as? [Any] else {
            print("[FlutterFaketooth] serialization failed as specified arguments are not a valid list.")
            return nil
        }
        self.init(list.compactMap { FaketoothCharacteristic(plugin: plugin, flutterArguments: $0) })
    }
}

extension Array where Element == FaketoothDescriptor {
    init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[FlutterFaketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothDescriptor list.")
        guard let list = flutterArguments as? [Any] else {
            print("[FlutterFaketooth] serialization failed as specified arguments are not a valid list.")
            return nil
        }
        self.init(list.compactMap { FaketoothDescriptor(plugin: plugin, flutterArguments: $0) })
    }
}

extension FlutterFaketoothPeripheral {

    convenience init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[FlutterFaketooth] trying to serialize \(String(describing: flutterArguments)) to FaketoothPeripheral instance.")
        guard let map = flutterArguments as? [String: Any] else {
            print("[FlutterFaketooth] serialization failed as specified arguments are not a valid map structure.")
            return nil
        }
        guard let identifier = UUID(uuidString: map["identifier"] as? String) else {
            print("[FlutterFaketooth] serialization failed as specified map doesn't contain valid \"identifier\" field.")
            return nil
        }

        self.init(
            plugin: plugin,
            identifier: identifier,
            name: map["name"] as? String ?? "Unknown", // TODO: name should be nullable on iOS side
            services: [FaketoothService](plugin: plugin, flutterArguments: map["services"]) ?? []
        )

        print("[FlutterFaketooth] serialization complete \(self)")
    }
}

extension FaketoothService {

    convenience init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[FlutterFaketooth] attempt to serialize \(String(describing: flutterArguments)) to FaketoothService instance.")
        guard let map = flutterArguments as? [String: Any] else {
            print("[FlutterFaketooth] serialization failed as specified arguments are not a valid map structure.")
            return nil
        }
        guard let uuid = CBUUID(string: map["uuid"] as? String) else {
            print("[FlutterFaketooth] serialization failed, specified map doesn't contain valid \"uuid\" value.")
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
        print("[FlutterFaketooth] attempt to serialize \(String(describing: flutterArguments)) to FaketoothCharacteristic instance.")
        guard let map = flutterArguments as? [String: Any] else {
            print("[FlutterFaketooth] serialization failed, specified arguments are not a valid map structure.")
            return nil
        }
        guard let uuid = CBUUID(string: map["uuid"] as? String) else {
            print("[FlutterFaketooth] serialization failed, specified map doesn't contain valid \"uuid\" value.")
            return nil
        }
        guard let properties = CBCharacteristicProperties(rawValue: map["properties"] as? UInt) else {
            print("[FlutterFaketooth] serialization failed, specified map doesn't contain valid \"properties\" value.")
            return nil
        }
        let wrapper = Wrapper(plugin: plugin)
        self.init(
            uuid: uuid,
            dataProducer: wrapper.valueProducer,
            properties: properties,
            isNotifying: (map["isNotifying"] as! NSNumber).boolValue,
            descriptors: [FaketoothDescriptor](plugin: plugin, flutterArguments: map["descriptors"])
        )
        wrapper.characteristic = self
    }

    class Wrapper {
        let plugin: SwiftFaketoothPlugin
        var characteristic: FaketoothCharacteristic?
        init(plugin: SwiftFaketoothPlugin) {
            self.plugin = plugin
        }
        func valueProducer() -> Data? {
            guard let characteristic = characteristic else {
                return nil
            }
            return plugin.value(for: characteristic)
        }
    }
}

extension FaketoothDescriptor {

    convenience init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[FlutterFaketooth] attempt to serialize \(String(describing: flutterArguments)) to FaketoothDescriptor instance.")
        guard let map = flutterArguments as? [String: Any] else {
            print("[FlutterFaketooth] serialization failed, specified arguments are not a valid map structure.")
            return nil
        }
        guard let uuid = CBUUID(string: map["uuid"] as? String) else {
            print("[FlutterFaketooth] serialization failed, specified map doesn't contain valid \"uuid\" value.")
            return nil
        }
        let wrapper = Wrapper(plugin: plugin)
        self.init(
            uuid: uuid,
            valueProducer: wrapper.valueProducer
        )
        wrapper.descriptor = self
    }

    class Wrapper {
        let plugin: SwiftFaketoothPlugin
        var descriptor: FaketoothDescriptor?
        init(plugin: SwiftFaketoothPlugin) {
            self.plugin = plugin
        }
        func valueProducer() -> Data? {
            guard let descriptor = descriptor else {
                return nil
            }
            return plugin.value(for: descriptor)
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
