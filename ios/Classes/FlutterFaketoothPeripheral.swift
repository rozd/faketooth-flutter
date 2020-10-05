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

    // MARK: Characteristic

    override func readValue(for characteristic: CBCharacteristic) {
        print("[FlutterFaketooth] readValue(for:\(characteristic))")
        plugin.requestValueForCharacteristic(characteristic) { data in
            (characteristic as? FaketoothCharacteristic)?.setValue(data)
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(FaketoothSettings.delay.readValueForCharacteristicDelayInSeconds)) {
                self.delegate?.peripheral?(self, didUpdateValueFor: characteristic, error: nil)
            }
        }
    }

    override func notifyDidUpdateValue(for characteristic: CBCharacteristic) {
        print("[FlutterFaketooth] notifyDidUpdateValue(for:\(characteristic))")
        guard let faketoothCharacteristic = characteristic as? FaketoothCharacteristic else {
            print("[FlutterFaketooth] Warning: specified characteristic \"\(characteristic)\" is not a FaketoothCharacteristic subclass.")
            super.notifyDidUpdateValue(for: characteristic)
            return
        }
        plugin.requestValueForCharacteristic(characteristic) { data in
            faketoothCharacteristic.setValue(data)
            super.notifyDidUpdateValue(for: characteristic)
        }
    }

    override func writeValue(_ data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        print("[FlutterFaketooth] writeValue(\(data):for:\(characteristic)):type:\(type)")
        guard characteristic is FaketoothCharacteristic else {
            print("[FlutterFaketooth] Warning: specified characteristic \"\(characteristic)\" is not a FaketoothCharacteristic subclass.")
            super.writeValue(data, for: characteristic, type: type)
            return
        }
        plugin.updateValue(data, for: characteristic) { _ in
            super.writeValue(data, for: characteristic, type: type)
        }
    }

    // MARK: Descriptor

    override func readValue(for descriptor: CBDescriptor) {
        print("[FlutterFaketooth] readValue(for:\(descriptor))")
        guard let faketoothDescriptor = descriptor as? FaketoothDescriptor else {
            print("[FlutterFaketooth] Warning: specified descriptor \"\(descriptor)\" is not a FaketoothDescriptor subclass.")
            super.readValue(for: descriptor)
            return
        }
        plugin.requestValueForDescriptor(descriptor) { data in
            faketoothDescriptor.setValue(data)
            super.readValue(for: descriptor)
        }
    }

    override func writeValue(_ data: Data, for descriptor: CBDescriptor) {
        print("[FlutterFaketooth] writeValue(\(data):for:\(descriptor))")
        guard descriptor is FaketoothDescriptor else {
            print("[FlutterFaketooth] Warning: specified descriptor \"\(descriptor)\" is not a FaketoothDescriptor subclass.")
            super.writeValue(data, for: descriptor)
            return
        }
        plugin.updateValue(data, for: descriptor) { _ in
            super.writeValue(data, for: descriptor)
        }
    }
}
