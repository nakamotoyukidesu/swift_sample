//
//  PopupViewController.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/06/03.
//

import UIKit

class PopupViewController: UIViewController,UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var doui: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doui.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
    }
    @IBAction func dismiss(_ sender: Any) {
        self.performSegue(withIdentifier: "toMain", sender: nil)
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
