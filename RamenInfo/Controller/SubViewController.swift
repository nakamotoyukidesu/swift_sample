//
//  SubViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/14.
//

import UIKit

class SubViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,toContollerDelegate  {
 
    func toController(name:String) {
        self.performSegue(withIdentifier: name, sender: nil)
    }
    

    @IBOutlet weak var ramenImage: UIImageView!
    @IBOutlet weak var ramenName: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    @IBOutlet weak var tableView0: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    
    var selectedImage: UIImage!
    var selectedName: String?
    var selectedAddress : String?
    var selectedID: String?
    var selectedQuery:String?
    var tableViewArray0 = [UITableViewCell]()
    var tableViewArray1 = [UITableViewCell]()
    var TwitterInfo:[UserTimeline] = []

    // 処理分岐用
      var tag:Int = 0
      var cellIdentifier:String = ""
   
        // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        //口コミツイートと公式アカウント情報のUIの確認
        //selectedIDが渡ってない可能性
        if let a = selectedID {
            print("あるよ")
            print(a)
        } else {
            print("ないよ")
            print(selectedID)
        }
        
        if let b = selectedQuery {
            print("あるよ")
            print(b)
        } else {
            print("ないよ")
            print(selectedQuery)
        }
        
        var twitter = TwitterApi()
        twitter.get_user_timeline(id: selectedID ?? ""){ tweets in
            DispatchQueue.main.async {
                self.TwitterInfo = tweets
                
            }
        }

        self.ramenName.text = self.selectedName
        self.addressName.text = self.selectedAddress
        self.ramenImage.image = self.selectedImage
        print(selectedName,selectedAddress,selectedImage)
        
        tableView0.estimatedRowHeight = 66
        tableView0.rowHeight = UITableView.automaticDimension
      
        self.tableView0.delegate = self
        self.tableView0.dataSource = self
        
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        
        self.tableView0.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        self.tableView0.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        self.tableView0.register(UINib(nibName: "ThirdTableViewCell", bundle: nil), forCellReuseIdentifier: "ThirdTableViewCell")
//
        guard let firstTableViewCell0 = self.tableView0.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell else {
            return
        }
        guard let secondTableViewCell0 = self.tableView0.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as? SecondTableViewCell else {
            return
        }
        guard let thirdTableViewCell0 = self.tableView0.dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as? ThirdTableViewCell else {
            return
        }
        self.tableViewArray0.append(firstTableViewCell0)
        self.tableViewArray0.append(secondTableViewCell0)
        self.tableViewArray0.append(thirdTableViewCell0)
        
        self.tableView1.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        self.tableView1.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        self.tableView1.register(UINib(nibName: "ThirdTableViewCell", bundle: nil), forCellReuseIdentifier: "ThirdTableViewCell")
        
        guard let firstTableViewCell1 = self.tableView1.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell else {
            return
        }
        guard let secondTableViewCell1 = self.tableView1.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as? SecondTableViewCell else {
            return
        }
        guard let thirdTableViewCell1 = self.tableView1.dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as? ThirdTableViewCell else {
            return
        }
   
        self.tableViewArray1.append(firstTableViewCell1)
        self.tableViewArray1.append(secondTableViewCell1)
        self.tableViewArray1.append(thirdTableViewCell1)
        
//        print(tableViewArray0.count)
    }
    // 処理を分岐するメソッド
//      func checkTableView(_ tableView: UITableView) -> Void{
//          if (tableView.tag == 0) {
//              tag = 0
//              cellIdentifier = "cell0"
//          }
//          else if (tableView.tag == 1) {
//              tag = 1
//              cellIdentifier = "cell1"
//          }
//      }
//    items[tag].count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        checkTableView(tableView)
        return self.TwitterInfo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
                let tableViewCell = self.tableViewArray0[indexPath.row]
                  if tableViewCell is FirstTableViewCell {
                     tableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                      return tableViewCell
                  } else if tableViewCell is SecondTableViewCell {
                      tableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                      return tableViewCell
                  } else if tableViewCell is ThirdTableViewCell {
                      // no selectable
                      tableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                      return tableViewCell
                  }
        }else if tableView.tag == 1{
                let tableViewCell = self.tableViewArray1[indexPath.row]
                    if tableViewCell is FirstTableViewCell {
                        tableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                          return tableViewCell
                    } else if tableViewCell is SecondTableViewCell {
                        tableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                          return tableViewCell
                      } else if tableViewCell is ThirdTableViewCell {
                          // no selectable
                          tableViewCell.selectionStyle = UITableViewCell.SelectionStyle.none
                          return tableViewCell
                      }
        }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Erase header cells
        return .leastNormalMagnitude
    }
  
    @IBAction func Modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    
    }
}

