//
//  MemeTableViewCell.swift
//  MemeMe 1.0
//
//  Created by Zhazira Garipolla on 7/17/19.
//  Copyright © 2019 Zhazira Garipolla. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
