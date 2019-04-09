//
//  ChecklistVC.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/7/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class ChecklistVC: UIViewController {
    var viewModel = CheckListViewModel()

    static private let cellID = "ChecklistCell"

    @IBOutlet private weak var collectionView: UICollectionView!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
                                                            for: indexPath) as? ChecklistCell
        else { return UICollectionViewCell() }
        cell.viewModel = viewModel.viewModelForCell(indexPath: indexPath)
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
        let vc = PokemonListVC()
        present(vc, animated: true, completion: nil)
    }
}
