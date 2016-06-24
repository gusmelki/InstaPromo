//
//  PromoTableViewCell.swift
//  InstaPromo
//
//  Created by Gustavo Leal on 6/24/16.
//  Copyright © 2016 Moip. All rights reserved.
//

import UIKit

class PromoTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var prmoImage: UIImageView!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var preco: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
