//
//  AnyTimingSampleViewController.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/19.
//

import UIKit

final class AnyTimingSampleViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var statusLabel: UILabel!

    // MARK: - Property

    private let bluetoothManager = AnyTimingBluetoothManager()

    // MARK: - Action

    @IBAction private func buttonAction(_ sender: UIButton) {
        bluetoothManager.setupAndRequestBluetoothAuthorizationIfNeeded()
        statusLabel.text = bluetoothManager.state
    }
}
