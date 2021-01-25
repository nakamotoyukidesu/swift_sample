//
//  SubViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/14.
//

import UIKit

class SubViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var ramenImage: UIImageView!
    @IBOutlet weak var ramenName: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    @IBOutlet weak var tableView0: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    
    var selectedImage: UIImage!
    var selectedName: String?
    var selectedAddress : String?
    // 表示用データ
    var items0: NSMutableArray = [
        """
        ねずみおおおおおおおおおいいいいいいい
        おsd語彙じゃおいg足fjはおうぃえhg
        オアs；おf技はウェおfん；亜webfn
        """
    ]
    var items1: NSMutableArray = ["りゅうooooooooooooooo"]
    var items: [NSMutableArray] = []

    
    // 処理分岐用
      var tag:Int = 0
      var cellIdentifier:String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ramenName.text = self.selectedName
        self.addressName.text = self.selectedAddress
        self.ramenImage.image = self.selectedImage
        
        // デリゲートの設定
        tableView0.delegate = self
        tableView0.dataSource = self
        tableView1.delegate = self
        tableView1.dataSource = self
        // Do any additional setup after loading the view.
        // 表示用データの配列を配列にする
        items.append(items0)
        items.append(items1)
        // Do any additional setup after loading the view.
    }
    // 処理を分岐するメソッド
      func checkTableView(_ tableView: UITableView) -> Void{
          if (tableView.tag == 0) {
              tag = 0
              cellIdentifier = "cell0"
          }
          else if (tableView.tag == 1) {
              tag = 1
              cellIdentifier = "cell1"
          }
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[tag].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkTableView(tableView)
        // セルにテキストを出力する。
        let cell = tableView.dequeueReusableCell(withIdentifier:  cellIdentifier, for:indexPath as IndexPath)
        cell.textLabel?.text = items[tag][indexPath.row] as? String
        return cell

    }
    
    @IBAction func Modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    
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
