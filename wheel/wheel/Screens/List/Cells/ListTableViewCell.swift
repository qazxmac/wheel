//
//  ListTableViewCell.swift
//  wheel
//
//  Created by admin on 03/03/2024.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var onTap: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tapCell(_ sender: Any) {
        onTap?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblTitle.text = ""
    }
}
