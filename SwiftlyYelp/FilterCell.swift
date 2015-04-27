//
//  FilterCell.swift
//  SwiftlyYelp
//
//  Created by Will Johansson on 2015-04-26.
//  Copyright (c) 2015 Will Johansson. All rights reserved.
//

import UIKit

@objc protocol FilterCellDelegate {
    optional func filterCell(filterCell: FilterCell, didChangeValue value: Bool)
}

class FilterCell: UITableViewCell {
    static let reuseId = "FilterCellReuseId"
    
    weak var delegate : FilterCellDelegate?
    
    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBAction func onFilterSwitchValueChanged(sender: AnyObject) {
        delegate?.filterCell?(self, didChangeValue: filterSwitch.on)
    }
}
