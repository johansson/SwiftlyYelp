//
//  BusinessCell.swift
//  SwiftlyYelp
//
//  Created by Will Johansson on 2015-04-25.
//  Copyright (c) 2015 Will Johansson. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    static let reuseId = "BusinessCellReuseId"
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessRatingImageView: UIImageView!
    @IBOutlet weak var businessReviewCountLabel: UILabel!
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var businessCategoryLabel: UILabel!
    @IBOutlet weak var businessDistanceLabel: UILabel!
    @IBOutlet weak var businessPricinessLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        businessImageView.layer.cornerRadius = 3
        businessImageView.clipsToBounds = true
        
        // not sure if I need this? Seems to work without?
        //businessNameLabel.preferredMaxLayoutWidth = businessNameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // ditto ^?
        //businessNameLabel.preferredMaxLayoutWidth = businessNameLabel.frame.size.width
    }
}
