//
//  CustomTableViewCell.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/01/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
   
   
    @IBOutlet weak var RamenImage: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Address: UILabel!
    
    
    
    func setup(Name:String,Address:String,RamenImage:UIImage){
        self.Name.text = Name
        self.Address.text = Address
        self.RamenImage.image = RamenImage
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        RamenImage.layer.cornerRadius = RamenImage.frame.size.width * 0.1
        RamenImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
