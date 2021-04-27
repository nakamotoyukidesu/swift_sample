//
//  FirstTableViewCell.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/18.
//

import UIKit

protocol toImageDelegate {
    func toShopImage(UserTimeline:TweetModel)
}

class FirstTableViewCell: UITableViewCell {
 
    var delegate:toImageDelegate?
    var cellItem:TweetModel? {
        didSet {
            if let url1 = URL(string: cellItem?.profile_image ?? ""){
                let data = try! Data(contentsOf: url1)
                logoImage.image = UIImage(data: data)
            }
            
            if cellItem?.url?[0] != "a" {
                if let a:String = cellItem?.url?[0] {
                    if let url2 = URL(string: a) {
                        let data2 = try! Data(contentsOf: url2)
                        ramenImage.image = UIImage(data: data2)
                    }
                } else {
                    print("ありません")
                }
            }
            
            name.text = cellItem?.name
            address.text = "@" + cellItem!.username
            text1.text = cellItem?.text
//            print("タイプは、\(type(of: cellItem?.url))")
//            print("ラーメン画像のURLは、\(cellItem?.profile_image)")
//            print("名前は、\(cellItem?.name)")
//            print("テキスト\(cellItem?.text)")
        }
    }
    
    var cellItem2:TweetModel? {
        didSet {
            if let url3 = URL(string: cellItem2!.profile_image){
                print("イメージのURLは、\(url3)")
//                print("URLは\(type(of: url3))")
                do {
                    let data = try! Data(contentsOf: url3)
                    logoImage.image = UIImage(data: data)
                }catch let error{
//                    print(error.localizedDescription)
                    print("えらー")
                }
            }else {
                print("エラーだよ")
            }
            
            
//            if cellItem2?.url?[0] != nil {
//                print("cellItem2のURLは\(cellItem2?.url)")
//                if let a:String = cellItem2?.url![0] {
//                    if let url2 = URL(string: a) {
//                        let data2 = try! Data(contentsOf: url2)
//                        ramenImage.image = UIImage(data: data2)
//                        print("ツイート画像のURLは、\(cellItem2?.url)")
//                    }
//                } else {
//                    print("ありません")
//                }
//            }
            name.text = cellItem2?.name
            address.text = cellItem2?.username
            text1.text = cellItem2?.text
            print("cellItem2のurlの画像、\(cellItem2?.profile_image)")
            print("cellItem2のイメージのタイプは、\(type(of: cellItem2?.profile_image))")
            
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
        logoImage.layer.cornerRadius = 30
        logoImage.clipsToBounds = true
        print("cellItem2のurlの中身は、\(cellItem2?.url)")
//        print("タイプは、\(type(of: cellItem?.url))")
//        print("ラーメン画像のURLは、\(cellItem?.url)")
//        print("セルアイテムは、\(cellItem?.name)")
        //usertimeLine型を定義
        separatorInset = UIEdgeInsets(top: 0, left: bounds.width, bottom: 0, right: 0)
        
        //gestureを設定
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapIcon(sender:)))
        tapGesture.delegate = self
        ramenImage.isUserInteractionEnabled = true
        ramenImage.addGestureRecognizer(tapGesture)
    }

    @objc func tapIcon(sender:UITapGestureRecognizer) {
        self.delegate?.toShopImage(UserTimeline: cellItem!)
        
//        print("タップされたよ")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
