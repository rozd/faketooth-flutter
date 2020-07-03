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

    override var delegate: CBPeripheralDelegate? {
        didSet {
            print("[FlutterFaketooth] set delegate to \(delegate)")
        }
    }

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
            self.values[characteristic.uuid] = data
            self.delegate?.peripheral?(self, didUpdateValueFor: characteristic, error: nil)
        }
    }

    override func notifyDidUpdateValue(for characteristic: CBCharacteristic) {
        print("[FlutterFaketooth] notifyDidUpdateValue(for:\(characteristic))")
        plugin.requestCharacteristicValue(characteristic: characteristic) { data in
            if let data = data {
                print("[FlutterFaketooth] data received: \(data) as string: \(String(data: data, encoding: .utf8))")
            } else {
                print("[FlutterFaketooth] data is nil")
            }
            self.values[characteristic.uuid] = data
            self.delegate?.peripheral?(self, didUpdateValueFor: characteristic, error: nil)
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
