//
//  AnyTimingBluetoothManager.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/19.
//

import CoreBluetooth

final class AnyTimingBluetoothManager: NSObject {

    // MARK: - Property
    // MEMO: centralManagerは初期化時に許可リクエストを自動発行してしまう
    // 許可リクエスト発行タイミングを操作したいので、Optinalにして
    // setupAndrequestBluetoothAuthorizationIfNeededにて初期化することで手動発行できるようにする
    private var centralManager: CBCentralManager?

    var state: String {
        guard let centralManager = centralManager else {
            fatalError("need call setupAndRequestBluetoothAuthrizationIfNeeded in BluetoothManager")
        }

        return centralManager.state.name
    }

    // MARK: - Internal

    /// セットアップし、必要ならBluetooth許可アラートを表示する
    func setupAndRequestBluetoothAuthorizationIfNeeded() {
        if centralManager == nil {
            centralManager = CBCentralManager()
            centralManager?.delegate = self
        }
    }
}

// MARK: - CBCentralManagerDelegate

extension AnyTimingBluetoothManager: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("BluetoohManager setuped")
    }
}
