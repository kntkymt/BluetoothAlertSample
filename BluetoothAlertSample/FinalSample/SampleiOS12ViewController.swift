//
//  FinalSampleViewController.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/19.
//

import UIKit

final class FinalSampleViewController: UIViewController {
    
    // MARK: - Outlet

    @IBOutlet private weak var statusLabel: UILabel!

    // MARK: - Property

    private let bluetoothManager = BluetoothManager()

    // MARK: - Action

    @IBAction private func buttonAction(_ sender: UIButton) {
        Task {
            await bluetoothManager.setupAndRequestBluetoothAuthorizationIfNeeded()
            statusLabel.text = bluetoothManager.state
        }
    }
}
