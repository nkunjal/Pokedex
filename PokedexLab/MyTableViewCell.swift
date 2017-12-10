//
//  MyTableViewCell.swift
//  PokedexLab
//
//  Created by Neha Kunjal on 10/11/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var contents: UIView!
    
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
