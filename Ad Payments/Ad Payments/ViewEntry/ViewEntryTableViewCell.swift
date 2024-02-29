//
//  ViewEntryTableViewCell.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 29/02/24.
//

import UIKit

class ViewEntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var urlLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
