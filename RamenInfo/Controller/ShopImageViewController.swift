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

    override func viewDidLoad() {
        super.viewDidLoad()

        
        ramenImage.image = RamengetImage
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
