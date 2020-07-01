//
//  FlutterFaketoothPeripheral.swift
//  faketooth
//
//  Created by Max Rozdobudko on 7/1/20.
//

import Foundation

class FlutterFaketoothPeripheral: FaketoothPeripheral {

    fileprivate let plugin: SwiftFaketoothPlugin

    fileprivate var values: [CBUUID: Data?] = [:]

    init(plugin: SwiftFaketoothPlugin, identifier: UUID, name: String, services: [FaketoothService]) {
        self.plugin = plugin
        super.init(
            identifier: identifier,
            name: name,
            services: services
        )
    }

    override func readValue(for characteristic: CBCharacteristic) {
        guard let delegate = delegate else {
            return
        }

        plugin.requestCharacteristicValue(characteristic: characteristic) { data in
            self.values[characteristic.uuid] = data
            delegate.peripheral?(self, didUpdateValueFor: characteristic, error: nil)
        }
    }
}

extension FlutterFaketoothPeripheral {

    func value(for characteristic: CBCharacteristic) -> Data? {
        return values[characteristic.uuid] ?? nil
    }

    func value(for descriptor: CBDescriptor) -> Data? {
        return values[descriptor.uuid] ?? nil
    }
}
