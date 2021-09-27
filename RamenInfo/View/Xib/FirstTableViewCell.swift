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

class FirstTableViewCell: UITableViewCell,UITableViewDelegate {
    var protcol:removeDelegate?
    var delegate:toImageDelegate?
    var TwitterInfoindex:Int!
    var TwitterInfoSearchindex:Int!
    var cellItem:TweetModel? {
        didSet {
            if let url1 = URL(string: cellItem?.profile_image ?? ""){
                let data = try! Data(contentsOf: url1)
                logoImage.image = UIImage(data: data)
            }
            dateLabel.text = calculatDate(startDate: cellItem!.created_at)
            if cellItem?.url?[0] != "a" {
                if let a:String = cellItem?.url?[0] {
                    if let url2 = URL(string: a) {
                        let data2 = try! Data(contentsOf: url2)
                        ramenImage.image = UIImage(data: data2)
                    }
                } else {
                    ramenImage?.removeFromSuperview()
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
    func calculatDate(startDate:String) -> String{
        let current = Calendar.current
        let year = String(current.component(.year, from: Date())) //年
        let StartDate = year+"-"+startDate
        print("StartDateの値は、\(type(of: StartDate))")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let formatedStartDate = dateFormatter.date(from: StartDate)
        print("formatedStartDateの値\(formatedStartDate)")
        let currentDate = Date()
        var elapsedDays = Calendar.current.dateComponents([.hour], from: currentDate, to: formatedStartDate!).hour!
        elapsedDays *= -1
        if elapsedDays <= 1 {
            return "\(elapsedDays * 60)分前"
        }else if 1 < elapsedDays && elapsedDays <= 24{
            return "\(elapsedDays)時間前"
        }else if 24 < elapsedDays && elapsedDays <= 168 {
            return "\(elapsedDays / 24)日前"
            
        }else {
            var Date:String = ""
            if let date = dateFormatter.date(from: startDate){
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy/MM"
                Date = outputFormatter.string(from: date)
            }
            return Date
        }
    }
    
    var cellItem2:TweetModel? {
        didSet {
            if let url3 = URL(string: cellItem2!.profile_image){
                print("イメージのURLは、\(url3)")
                do {
                    let data = try! Data(contentsOf: url3)
                    logoImage.image = UIImage(data: data)
                }catch let error{
                    print("えらー")
                }
            }else {
                print("エラーだよ")
            }
            name.text = cellItem2?.name
            address.text = cellItem2?.username
            text1.text = cellItem2?.text

        }
    }
       
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var ramenImage: UIImageView!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        text1.adjustsFontSizeToFitWidth = true
        logoImage.layer.cornerRadius = 32
        logoImage.clipsToBounds = true
        
        let shapeLayer = CAShapeLayer()
        
        let uiPath = UIBezierPath()
        uiPath.move(to: CGPoint(x: 0, y: 20))       // ここから
        uiPath.addLine(to: CGPoint(x: 420, y:20))
        shapeLayer.lineWidth = 5
        
        shapeLayer.strokeColor = UIColor.lightGray.cgColor  // 微妙に分かりにくい。色は要指定。
        shapeLayer.path = uiPath.cgPath  // なんだこれは
        
        
        // 作成したCALayerを画面に追加
        
        view.layer.addSublayer(shapeLayer)
//        print("cellItem2のurlの中身は、\(cellItem2?.url)")
//        print("タイプは、\(type(of: cellItem?.url))")
//        print("ラーメン画像のURLは、\(cellItem?.url)")
//        print("セルアイテムは、\(cellItem?.name)")
        //usertimeLine型を定義
        separatorInset = UIEdgeInsets(top: 0, left: bounds.width, bottom: 0, right: 0)
        
        //gestureを設定
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapIcon(sender:)))
        tapGesture.delegate = self
//        ramenImage.isUserInteractionEnabled = true
//        ramenImage.addGestureRecognizer(tapGesture)
    }

    @objc func tapIcon(sender:UITapGestureRecognizer) {
        self.delegate?.toShopImage(UserTimeline: cellItem!)
        
//        print("タップされたよ")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func block(_ sender: Any) {
        
        
        if TwitterInfoindex != nil {
            self.protcol?.remove(index:TwitterInfoindex!,TargetArray:"TwitterInfo")
        }else if TwitterInfoSearchindex != nil{
            self.protcol?.remove(index: TwitterInfoSearchindex!,TargetArray:"TwitterInfoSearch")
        }
    }
    
}
