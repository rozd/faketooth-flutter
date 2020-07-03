//
//  FlutterFaketoothPeripheral.swift
//  faketooth
//
//  Created by Max Rozdobudko on 7/1/20.
//

import Foundation

class FlutterFaketoothPeripheral: FaketoothPeripheral {

    fileprivate let plugin: SwiftFaketoothPlugin

    init(plugin: SwiftFaketoothPlugin, identifier: UUID, name: String, services: [FaketoothService]) {
        self.plugin = plugin
        super.init(
            identifier: identifier,
            name: name,
            services: services
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
}
