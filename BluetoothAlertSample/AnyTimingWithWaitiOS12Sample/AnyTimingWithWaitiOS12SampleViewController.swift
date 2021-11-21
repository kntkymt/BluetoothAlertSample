//
//  AnyTimingWithWaitiOS12SampleViewController.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/21.
//

import UIKit

final class AnyTimingWithWaitiOS12SampleViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var statusLabel: UILabel!

    // MARK: - Property

    private let bluetoothManager = AnyTimingWithWaitiOS12SampleBluetoothManager()

    // MARK: - Action

    @IBAction private func buttonAction(_ sender: UIButton) {
        bluetoothManager.setupAndRequestBluetoothAuthorizationIfNeeded()
            .done(on: .main) { [self] _ in
                statusLabel.text = bluetoothManager.state
            }
    }
}

