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
            services: [FaketoothService](plugin: plugin, flutterArguments: map["services"]),
            advertisementData: (map["advertisementData"] as? [String: Any])?.toAdvertisementData()
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
        guard let properties = CBCharacteristicProperties(codes: map["properties"] as? [String]) else {
            print("[FlutterFaketooth] serialization failed, specified map doesn't contain valid \"properties\" value.")
            return nil
        }
        let initialData = (map["initialValue"] as? FlutterStandardTypedData)?.data
        self.init(
            uuid: uuid,
            valueProducer: initialData != nil ? { initialData } : nil,
            properties: properties,
            descriptors: [FaketoothDescriptor](plugin: plugin, flutterArguments: map["descriptors"])
        )
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
        let initialData = map["initialValue"]
        self.init(
            uuid: uuid,
            valueProducer: initialData != nil ? { initialData } : nil
        )
    }
}

extension FaketoothDelaySettings {
    init?(plugin: SwiftFaketoothPlugin, flutterArguments: Any?) {
        print("[FlutterFaketooth] attempt to serialize \(String(describing: flutterArguments)) to FaketoothDelaySettings instance.")
        guard let map = flutterArguments as? [String: Float] else {
            print("[FlutterFaketooth] serialization failed, specified arguments are not a valid map structure.")
            return nil
        }

        guard let scanForPeripheralDelayInSeconds = map["scanForPeripheralDelayInSeconds"] else {
            return nil
        }
        guard let connectPeripheralDelayInSeconds = map["connectPeripheralDelayInSeconds"] else {
            return nil
        }
        guard let cancelPeripheralConnectionDelayInSeconds = map["cancelPeripheralConnectionDelayInSeconds"] else {
            return nil
        }
        guard let discoverServicesDelayInSeconds = map["discoverServicesDelayInSeconds"] else {
            return nil
        }
        guard let discoverCharacteristicsDelayInSeconds = map["discoverCharacteristicsDelayInSeconds"] else {
            return nil
        }
        guard let discoverIncludedServicesDelayInSeconds = map["discoverIncludedServicesDelayInSeconds"] else {
            return nil
        }
        guard let discoverDescriptorsForCharacteristicDelayInSeconds = map["discoverDescriptorsForCharacteristicDelayInSeconds"] else {
            return nil
        }
        guard let readValueForCharacteristicDelayInSeconds = map["readValueForCharacteristicDelayInSeconds"] else {
            return nil
        }
        guard let writeValueForCharacteristicDelayInSeconds = map["writeValueForCharacteristicDelayInSeconds"] else {
            return nil
        }
        guard let readValueForDescriptorDelayInSeconds = map["readValueForDescriptorDelayInSeconds"] else {
            return nil
        }
        guard let writeValueForDescriptorDelayInSeconds = map["writeValueForDescriptorDelayInSeconds"] else {
            return nil
        }
        guard let setNotifyValueForCharacteristicDelayInSeconds = map["setNotifyValueForCharacteristicDelayInSeconds"] else {
            return nil
        }

        self.init(
            scanForPeripheralDelayInSeconds: scanForPeripheralDelayInSeconds,
            connectPeripheralDelayInSeconds: connectPeripheralDelayInSeconds,
            cancelPeripheralConnectionDelayInSeconds: cancelPeripheralConnectionDelayInSeconds,
            discoverServicesDelayInSeconds: discoverServicesDelayInSeconds,
            discoverCharacteristicsDelayInSeconds: discoverCharacteristicsDelayInSeconds,
            discoverIncludedServicesDelayInSeconds: discoverIncludedServicesDelayInSeconds,
            discoverDescriptorsForCharacteristicDelayInSeconds: discoverDescriptorsForCharacteristicDelayInSeconds,
            readValueForCharacteristicDelayInSeconds: readValueForCharacteristicDelayInSeconds,
            writeValueForCharacteristicDelayInSeconds: writeValueForCharacteristicDelayInSeconds,
            readValueForDescriptorDelayInSeconds: readValueForDescriptorDelayInSeconds,
            writeValueForDescriptorDelayInSeconds: writeValueForDescriptorDelayInSeconds,
            setNotifyValueForCharacteristicDelayInSeconds: setNotifyValueForCharacteristicDelayInSeconds
        )
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

    init?(code: String?) {
        guard let code = code else {
            return nil
        }
        switch code {
        case "broadcast"                    : self = .broadcast
        case "read"                         : self = .read
        case "writeWithoutResponse"         : self = .writeWithoutResponse
        case "write"                        : self = .write
        case "notify"                       : self = .notify
        case "indicate"                     : self = .indicate
        case "authenticatedSignedWrites"    : self = .authenticatedSignedWrites
        case "extendedProperties"           : self = .extendedProperties
        case "notifyEncryptionRequired"     : self = .notifyEncryptionRequired
        case "indicateEncryptionRequired"   : self = .broadcast
        default:
            return nil
        }
    }

    init?(codes: [String]?) {
        guard let codes = codes else {
            return nil
        }
        self = CBCharacteristicProperties(codes.map { CBCharacteristicProperties(code: $0) }.compactMap { $0 })
    }
}

extension Dictionary where Key == String, Value == Any {
    func toAdvertisementData() -> [String: Any]? {
        var data: [String: Any] = [:]

        if let localName = self["localName"] {
            data[CBAdvertisementDataLocalNameKey] = localName
        }

        if let serviceUUIDs = self["serviceUUIDs"] as? [String] {
            data[CBAdvertisementDataServiceUUIDsKey] = serviceUUIDs.map { CBUUID(string: $0) }
        }

        guard !data.isEmpty else {
            return nil
        }

        return data
    }
}
