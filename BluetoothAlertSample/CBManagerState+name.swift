//
//  CBManagerState+name.swift
//  BluetoothAlertSample
//
//  Created by kntk on 2021/11/19.
//

import CoreBluetooth

extension CBManagerState {

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
