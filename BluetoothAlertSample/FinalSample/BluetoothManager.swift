//
//  BluetoothManager.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/19.
//

import CoreBluetooth

final class BluetoothManager: NSObject {

    // MARK: - Property

    private var centralManager: CBCentralManager?
    private var continuation: CheckedContinuation<Void, Never>?

    var state: String {
        guard let centralManager = centralManager else {
            fatalError("need call setupAndRequestBluetoothAuthrizationIfNeeded in BluetoothManager")
        }

        return centralManager.state.name
    }

    // MARK: - Internal

    /// セットアップし、必要ならBluetooth許可アラートを表示する
    /// 許可状態が決定済みの場合: 許可アラートが表示されず、即時resume
    /// 許可状態が未決定の場合: 許可アラートが表示され、許可アラートが閉じた後にresume
    func setupAndRequestBluetoothAuthorizationIfNeeded() async {
        return await withCheckedContinuation { continuation in
            if centralManager == nil {
                // クラス内の変数にcontinuationを出し、後でresumeできるようにする
                self.continuation = continuation
                centralManager = CBCentralManager()
                centralManager?.delegate = self
            } else {
                // 既にセットアップされている場合は即待機終了
                continuation.resume()
            }
        }
    }
}

// MARK: - CBCentralManagerDelegate

extension BluetoothManager: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("BluetoohManager setuped")

        // 待機終了
        continuation?.resume()
    }
}
