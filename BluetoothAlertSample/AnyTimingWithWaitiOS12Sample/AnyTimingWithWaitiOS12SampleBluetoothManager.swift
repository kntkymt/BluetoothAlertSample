//
//  AnyTimingWithWaitiOS12SampleBluetoothManager.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/21.
//

import Foundation
import CoreBluetooth
import PromiseKit

final class AnyTimingWithWaitiOS12SampleBluetoothManager: NSObject {

    // MARK: - Property

    private var centralManager: CBCentralManager?

    private var statusObserver: (guarantee: Guarantee<Void>, resolve: (Void) -> Void)?

    var state: String {
        guard let centralManager = centralManager else {
            fatalError("need call setupAndRequestBluetoothAuthrizationIfNeeded in BluetoothManager")
        }

        return centralManager.state.name
    }

    // MARK: - Internal

    /// セットアップし、Bluetoothの許可が必要な場合はアラートを表示する
    func setupAndRequestBluetoothAuthorizationIfNeeded() -> Guarantee<Void> {
        if centralManager == nil {
            // 待機開始
            let statusObserver = Guarantee<Void>.pending()

            // あとでresolveできるようにresolverを変数に出す
            self.statusObserver = statusObserver

            let centralManager = CBCentralManager()
            centralManager.delegate = self
            self.centralManager = centralManager

            return statusObserver.guarantee
        } else {
            // 既にセットアップされている場合は即待機終了
            return Guarantee { $0(()) }
        }
    }
}

// MARK: - CBCentralManagerDelegate

extension AnyTimingWithWaitiOS12SampleBluetoothManager: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if #available(iOS 13.1, *) {
            // iOS13以上の場合は
            // 許可状態が決定済みの場合: 許可アラートが表示されず、即時呼ばれる
            // 許可状態が未決定の場合: 許可アラートが表示され、許可アラートが閉じた後に呼ばれる
            statusObserver?.resolve(())
            self.statusObserver = nil
        } else {
            // iOS12以下の場合は
            // 許可アラートは表示されず、セットアップが完了したら呼ばれる
            // これを待たないと.stateから正常な結果が取得できない
            statusObserver?.resolve(())
            self.statusObserver = nil
        }
    }
}
