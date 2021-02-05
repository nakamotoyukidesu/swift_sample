//
//  ThirdTableViewCell.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/18.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {
    
    weak var delegate: toContollerDelegate?
   
    @IBOutlet weak var shopImage: UIImageView!
    @IBAction func toShopImage(_ sender: Any) {
        delegate?.toController(name: "toShopImage")
    }
    
    
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

protocol toContollerDelegate: class {
    func toController(name:String)
}

