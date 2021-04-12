//
//  ShopImageViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/28.
//

import UIKit

class ShopImageViewController: UIViewController {

    @IBOutlet weak var ramenImage: UIImageView!
    
    var RamengetImage:UIImage!
    var userInfos:UserTimeline!

    override func viewDidLoad() {
        super.viewDidLoad()

        if userInfos?.url?[0] != "a" {
            if let a:String = userInfos?.url?[0] {
                if let url2 = URL(string: a) {
                    let data2 = try! Data(contentsOf: url2)
                    RamengetImage = UIImage(data: data2)
                }
            } else {
                print("画像がないよーん")
            }
        }
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
