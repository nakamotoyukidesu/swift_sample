//
//  FirstTableViewCell.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/18.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    
    var cellItem:UserTimeline? {
        didSet {
            if let url1 = URL(string: cellItem?.profile_image ?? ""){
                let data = try! Data(contentsOf: url1)
                logoImage.image = UIImage(data: data)
            }
            
//            if let url2 = URL(string: cellItem?.url ?? "") {
//                let data2 = try! Data(contentsOf: url2)
//                ramenImage.image = UIImage(data: data2)
//            }
//
            
                
            
            name.text = cellItem?.name
            address.text = cellItem?.username
            text1.text = cellItem?.text
        }
    }
    
    var cellItem2:SearchTweet? {
        didSet {
            name.text = cellItem2?.name
            address.text = cellItem2?.user_name
            
            
        }
    }
       
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var ramenImage: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        text1.adjustsFontSizeToFitWidth = true
        
        print("タイプは、\(type(of: cellItem?.url))",cellItem?.url)
        //usertimeLine型を定義
        
        
        
        separatorInset = UIEdgeInsets(top: 0, left: bounds.width, bottom: 0, right: 0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
