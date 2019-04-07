//
//  ChecklistCell.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/7/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

protocol ChecklistCellDelegate: class {
    func cell(_ cell: ChecklistCell, perform action: ChecklistCell.Action)
}

final class ChecklistCell: UICollectionViewCell {

    weak var delegate: ChecklistCellDelegate?

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configCell(image: UIImage?, title: String, subtitle: String, isLastCell: Bool) {
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
        startButton.isHidden = !isLastCell
    }

    @IBAction func startButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(self, perform: .start)
    }

    enum Action {
        case start
    }
}
