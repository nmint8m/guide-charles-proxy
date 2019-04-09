//
//  ChecklistCellViewModel.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/9/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class ChecklistCellViewModel {

    private(set) var image: UIImage?
    private(set) var title: String = ""
    private(set) var subtitle: String = ""
    private var isLastCell: Bool = false

    var buttonString: String {
        return isLastCell ? "Bắt đầu" : "Bỏ qua"
    }

    init(image: UIImage? = nil,
         title: String = "",
         subtitle: String = "",
         isLastCell: Bool = false) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.isLastCell = isLastCell
    }
}
