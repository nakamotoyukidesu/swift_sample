//
//  FirstTableViewCell.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/18.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
       
    var userInfo:[UserTimeline] = []
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var accountName: UILabel!
    
    var twiiterAPI = TwitterApi()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
        //usertimeLine型を定義
        
        
        
        separatorInset = UIEdgeInsets(top: 0, left: bounds.width, bottom: 0, right: 0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
