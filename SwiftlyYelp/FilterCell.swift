//
//  FilterCell.swift
//  SwiftlyYelp
//
//  Created by Will Johansson on 2015-04-26.
//  Copyright (c) 2015 Will Johansson. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    static let reuseId = "FilterCellReuseId"
    
    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
}
