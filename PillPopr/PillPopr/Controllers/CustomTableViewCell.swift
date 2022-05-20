//
//  CustomTableViewCell.swift
//  PillPopr
//
//  Created by Simon Nguyen on 19/5/2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label:UILabel!
    @IBOutlet weak var clickme:UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
