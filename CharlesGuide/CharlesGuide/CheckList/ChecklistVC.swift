//
//  ChecklistVC.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/7/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class ChecklistVC: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: ChecklistVC.cellID, bundle: nil)
        collectionView.register(nib,
                                forCellWithReuseIdentifier: ChecklistVC.cellID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ChecklistVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChecklistVC.cellID,
                                                            for: indexPath) as? ChecklistCell,
            let part = CheckList(rawValue: indexPath.row)
        else { return UICollectionViewCell() }
        cell.configCell(image: part.image,
                        title: "Bước \(indexPath.row + 1): \(part.title)",
                        subtitle: part.subtilte,
                        isLastCell: part == .trustSSLCertificateOnDeviceSimu)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return UIScreen.main.bounds.size
        }
        let screenSize = UIScreen.main.bounds.size
        return CGSize(width: screenSize.width,
                      height: screenSize.height - window.safeAreaInsets.top - window.safeAreaInsets.bottom - 45)
    }
}

extension ChecklistVC: ChecklistCellDelegate {
    func cell(_ cell: ChecklistCell, perform action: ChecklistCell.Action) {
        present(PokemonListVC(), animated: true, completion: nil)
    }
}

extension ChecklistVC {

    static private let cellID = "ChecklistCell"

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
