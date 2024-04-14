//
//  ParkTableViewCell.swift
//  DemoPickerView
//
//  Created by Ryan on 2024/4/13.
//

import UIKit

class ParkTableViewCell: UITableViewCell {
    @IBOutlet weak var parkNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
