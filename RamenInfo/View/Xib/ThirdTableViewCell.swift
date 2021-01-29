//
//  ThirdTableViewCell.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/18.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shopImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorInset = UIEdgeInsets(top: 0, left: bounds.width, bottom: 0, right: 0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
