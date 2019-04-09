//
//  CheckListViewModel.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/9/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class CheckListViewModel {
    func numberOfCell() -> Int {
        return 6
    }

    func viewModelForCell(indexPath: IndexPath) -> ChecklistCellViewModel {
        guard let checkList = CheckList(rawValue: indexPath.row) else { return ChecklistCellViewModel() }
        return ChecklistCellViewModel(image: checkList.image,
                                      title:  "Bước \(indexPath.row + 1): \(checkList.title)",
                                      subtitle: checkList.subtilte,
                                      isLastCell: indexPath.row == 5)
    }
}

extension CheckListViewModel {
    enum CheckList: Int {
        case configProxy = 0
        case configProxyForDevice
        case configSSLProxyingCertificates
        case addCharlesCACertificate
        case turnOnSSLProxy
        case trustSSLCertificateOnDeviceSimu

        var title: String {
            switch self {
            case .configProxy:
                return "Config Proxy, bật macOS Proxy cho Charles"
            case .configProxyForDevice:
                return "Config proxy cho device"
            case .configSSLProxyingCertificates:
                return "Config Configuring SSL Proxying Certificates"
            case .addCharlesCACertificate:
                return "Thêm Charles CA Certificate cho máy mac"
            case .turnOnSSLProxy:
                return "Bật SSL Proxy cho máy mac và cài đặt SSL cho tất cả host name"
            case .trustSSLCertificateOnDeviceSimu:
                return "Bật trust SSL Certificate cho device/simulator"
            }
        }

        var subtilte: String {
            switch self {
            case .configProxy:
                return "Config: View > Proxy Settings...\nTurn on: View > macOS Proxy"
            case .configProxyForDevice:
                return "Settings > Wifi > Choosen wifi > Config Proxy > Manual"
            case .configSSLProxyingCertificates:
                return "Help > SSL Proxying > Install Charles Root Certificates"
            case .addCharlesCACertificate:
                return "Certificates > Charles Proxy CA > Always Trust"
            case .turnOnSSLProxy:
                return "Proxy > SSL Proxying Settings..."
            case .trustSSLCertificateOnDeviceSimu:
                return "Device: Settings > General > About > Certificate Trust Settings\nSimulator: Help > SSL Proxying > Install Charles Root Certificate in iOS Simulators"
            }
        }

        var image: UIImage? {
            let name: String
            switch self {
            case .configProxy:
                name = "img-check-proxy"
            case .configProxyForDevice:
                name = "img-check-manual-device"
            case .configSSLProxyingCertificates:
                name = "img-check-ssl-install"
            case .addCharlesCACertificate:
                name = "img-check-ssl-cer"
            case .turnOnSSLProxy:
                name = "img-check-ssl"
            case .trustSSLCertificateOnDeviceSimu:
                name = "img-check-trust-ssl-simu"
            }
            guard let image = UIImage(named: name) else { return nil }
            return image
        }
    }
}
