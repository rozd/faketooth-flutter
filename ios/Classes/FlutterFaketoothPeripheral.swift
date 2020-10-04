//
//  FlutterFaketoothPeripheral.swift
//  faketooth
//
//  Created by Max Rozdobudko on 7/1/20.
//

import Foundation

class FlutterFaketoothPeripheral: FaketoothPeripheral {

    fileprivate let plugin: SwiftFaketoothPlugin

    init(plugin: SwiftFaketoothPlugin, identifier: UUID, name: String, services: [FaketoothService]?, advertisementData: [String: Any]?) {
        self.plugin = plugin
        super.init(
            identifier: identifier,
            name: name,
            services: services,
            advertisementData: advertisementData
        )
    }

    override func readValue(for characteristic: CBCharacteristic) {
        print("[FlutterFaketooth] readValue(for:\(characteristic))")
        plugin.requestCharacteristicValue(characteristic: characteristic) { data in
            (characteristic as? FaketoothCharacteristic)?.setValue(data)
            self.delegate?.peripheral?(self, didUpdateValueFor: characteristic, error: nil)
        }
    }

    override func notifyDidUpdateValue(for characteristic: CBCharacteristic) {
        print("[FlutterFaketooth] notifyDidUpdateValue(for:\(characteristic))")
        plugin.requestCharacteristicValue(characteristic: characteristic) { data in
            (characteristic as? FaketoothCharacteristic)?.setValue(data)
            self.delegate?.peripheral?(self, didUpdateValueFor: characteristic, error: nil)
        }
    }

    override func readValue(for descriptor: CBDescriptor) {
        print("[FlutterFaketooth] readValue(for:\(descriptor))")
        plugin.requestDescriptorValue(descriptor: descriptor) { data in
            (descriptor as? FaketoothDescriptor)?.setValue(data)
            self.delegate?.peripheral?(self, didUpdateValueFor: descriptor, error: nil)
        }
    }
}
