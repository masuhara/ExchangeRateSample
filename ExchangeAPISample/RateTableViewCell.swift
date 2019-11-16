//
//  RateTableViewCell.swift
//  ExchangeAPISample
//
//  Created by Masuhara on 2019/11/16.
//  Copyright © 2019 Ylab Inc. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
