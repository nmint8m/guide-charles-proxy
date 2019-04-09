//
//  PokemonCell.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/9/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class PokemonCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!

    var viewModel = PokemonCellViewModel(Pokemon()) {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    func updateCell() {
        nameLabel.text = viewModel.pokemonName
        urlLabel.text = viewModel.pokemonURLString
    }
}
