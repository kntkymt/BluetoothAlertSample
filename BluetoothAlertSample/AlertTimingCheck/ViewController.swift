//
//  ViewController.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/12.
//

import UIKit
import CoreBluetooth

private extension CBManagerState {

    var name: String {
        switch self {
        case .unknown: return "unknown"
        case .resetting: return "resetting"
        case .unsupported: return "unsupported"
        case .unauthorized: return "unauthorized"
        case .poweredOff: return "poweredOff"
        case .poweredOn: return "poweredOn"
        @unknown default: return "unknown"
        }
    }
}

final class ViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var statusLabel: UILabel!

    // MARK: - Property

    private var centralManager: CBCentralManager!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print("manager init func: \(#function)")
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: true])

        print("manager delegate set func: \(#function)")
        centralManager.delegate = self
    }

    // MARK: - Action

    @IBAction private func buttonAction(_ sender: UIButton) {
        print("maneger used func: \(#function)")
        statusLabel.text = centralManager.state.name
    }
}

// MARK: - CBCentralManagerDelegate

extension ViewController: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("manager setuped func: \(#function)")
    }
}
