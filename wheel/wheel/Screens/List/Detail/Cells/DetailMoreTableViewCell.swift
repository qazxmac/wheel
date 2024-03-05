//
//  DetailMoreTableViewCell.swift
//  wheel
//
//  Created by admin on 04/03/2024.
//

import UIKit

class DetailMoreTableViewCell: UITableViewCell {
    
    var onTapPlus: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func tapPlus(_ sender: Any) {
        onTapPlus?()
    }
    
}
