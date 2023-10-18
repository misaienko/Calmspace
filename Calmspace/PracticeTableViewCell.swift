//
//  PracticeTableViewCell.swift
//  Calmspace
//
//  Created by Admin on 09/10/2023.
//

import UIKit

class PracticeTableViewCell: UITableViewCell {
   
   
    @IBOutlet weak var customLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
