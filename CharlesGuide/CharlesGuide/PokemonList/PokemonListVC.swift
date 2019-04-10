//
//  PokemonListVC.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/7/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class PokemonListVC: UIViewController {

    // MARK: - Properties
    var viewModel = PokemonListViewModel()
    private let cellIDString = "PokemonCell"

    // MARK: - IBOutlet
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var previousButton: UIButton!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configStatusLabel()
        configButtons()
        loadData(pageType: .current)
    }

    private func configTableView() {
        let nib = UINib(nibName: cellIDString, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: cellIDString)
        tableView.dataSource = self
    }

    private func configStatusLabel() {
        statusLabel.text = viewModel.status
    }

    private func configButtons() {
        previousButton.isEnabled = viewModel.previousURLString != ""
        previousButton.alpha = viewModel.previousURLString != "" ? 1 : 0.5
    }

    private func loadData(pageType: PokemonListViewModel.PageType) {
        viewModel.getListPokemon(pageType: pageType) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
                this.configStatusLabel()
                this.configButtons()
            case .failure(let error):
                let alert = UIAlertController(title: "Error",
                                              message: "Error happened with code: \(error.code)",
                    preferredStyle: .alert)
                let action = UIAlertAction(title: "OK",
                                           style: .default,
                                           handler:
                    { _ in
                        this.loadData(pageType: .current)
                })
                alert.addAction(action)
                this.present(alert,
                             animated: true,
                             completion: nil)
            }
        }
    }

    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pageButtonTouchUpInside(_ sender: UIButton) {
        let pageType: PokemonListViewModel.PageType = sender.tag == 0 ? .previous : .next
        loadData(pageType: pageType)
    }
}

extension PokemonListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPokemon()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIDString, for: indexPath) as? PokemonCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForCell(indexPath: indexPath)
        return cell
    }
}
