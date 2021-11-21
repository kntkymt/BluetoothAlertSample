//
//  AnyTimingWithWaitiOS15SampleViewController.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/19.
//

import UIKit

@available(iOS 15.0, *)
final class AnyTimingWithWaitiOS15SampleViewController: UIViewController {
    
    // MARK: - Outlet

    @IBOutlet private weak var statusLabel: UILabel!

    // MARK: - Property

    private let bluetoothManager = AnyTimingWithWaitiOS15SampleBluetoothManager()

    // MARK: - Action

    @IBAction private func buttonAction(_ sender: UIButton) {
        Task {
            await bluetoothManager.setupAndRequestBluetoothAuthorizationIfNeeded()
            statusLabel.text = bluetoothManager.state
        }
    }
}
