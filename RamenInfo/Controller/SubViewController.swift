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
    @IBOutlet weak var tableView0: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var NavigationImage: UIImageView!
    
    var RamenColor:String = ""
    
        
    private var state: ArticleCellState = CellStateNotRegisteredAsFavorite()
    
    var selectedImage: UIImage!
    var selectedName: String?
    var selectedAddress : String?
    var selectedID: String?
    var selectedQuery:String?
    var tableViewArray0 = [UITableViewCell]()
    var tableViewArray1 = [UITableViewCell]()
    var TwitterInfo:[UserTimeline] = []
    var TwitterInfoSearch:[SearchTweet] = []
   

    // 処理分岐用
      var tag:Int = 0
      var cellIdentifier:String = ""
   
        // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //array作る
        //array = <Dicitionary>[String:String]
        
        ramenImage.layer.cornerRadius = 40
        
        self.accountLabel.layer.cornerRadius = 20
        self.accountLabel.clipsToBounds = true
        self.tweetLabel.layer.cornerRadius = 20
        self.tweetLabel.clipsToBounds = true
        
        
//        print("TwitterInfoSearch.countの数は、\(TwitterInfoSearch.count)")
        //口コミツイートと公式アカウント情報のUIの確認
        //selectedIDが渡ってない可能性
//        if let a = selectedID {
//            print("IDは\(a)")
//        } else {
//            print("ないよ")
//            print(selectedID)
//        }
//
//        if let b = selectedQuery {
//            print("クエリは\(b)")
//            print(b)
//        } else {
//            print("ないよ")
//            print(selectedQuery)
//        }

        var twitter = TwitterApi()
        twitter.get_user_timeline(id: selectedID ?? ""){ tweets in
            DispatchQueue.main.async {
//                print("tweetsの内容は、\(tweets)")
                self.TwitterInfo = tweets
//                print("get_user_timelineのカウント\(self.TwitterInfo.count)")
//                for info in self.TwitterInfo {
//                    print("urlのカウント\(info.url!.count)")
//                    for url in info.url! {
//                        print("URLは、\(url)")
//                    }
//                }
                self.tableView0.reloadData()
                self.tableView1.reloadData()
            }
        }
        
        twitter.search_tweet(query: selectedQuery ?? "") { tweets in
            DispatchQueue.main.async {
                //tweetsに値が入らないなぜだ?
//                print("クエリの内容は\(tweets)")
                self.TwitterInfoSearch = tweets
                for info in self.TwitterInfoSearch {
                    for url in info.url! {
                        print("TwitterInfoSearchのURLは、\(url)")
                    }
                }
                self.tableView0.reloadData()
                self.tableView1.reloadData()
            }
        }

        //self.ramenName.text = array[name]
        self.ramenName.text = self.selectedName
        self.addressName.text = self.selectedAddress
        self.ramenImage.image = self.selectedImage
//        print(selectedName,selectedAddress,selectedImage)
        
      
        self.tableView0.delegate = self
        self.tableView0.dataSource = self
        
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
  
        self.tableView0.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        
        self.tableView1.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        
//        print("TwitterInfo.countの値は、\(self.TwitterInfo.count)")
//        print("TwitterInfoSearch.countの値は、\(self.TwitterInfoSearch.count))"
    }
    
   
    
    @IBAction func favButton(_ sender: Any) {
        print("favButton")
        self.state.favoriteButtonTapped(articleCell: self)

//        let a = UIImage(named: "fILZIuljC5pkyyj1613632174_1613632219")
//        let b = UIImage(named: "Q8m72eGQpJpIlDI1613631400_1613631710")
//        if self.favButton.imageView?.image != a {
//            self.favButton.setImage(a, for: .normal)
//        } else {
//            self.favButton.setImage(b, for: .normal)
//        }
    }
    
//     State chaqnge
       func setState(state: ArticleCellState) {
           self.state = state
       }
//    // Actions
    func addFavorite() {
        print("Adding Favorite...")
        /*
            Repositoryへのアクセス、サーバー上のデータの更新などの一連の処理を実装
        */
//        self.likesArray.append()
        let a = UIImage(named: "fILZIuljC5pkyyj1613632174_1613632219")
        // 最後にボタンの色を変える
        self.favButton.setImage(a, for: .normal)
    }
    
    
    func removeFavorite() {
           print("Removing Favorite...")
           /*
               Repositoryへのアクセス、サーバー上のデータの更新などの一連の処理を実装
           */
//        self.likesArray.remove(at: 0)
        let b = UIImage(named: "Q8m72eGQpJpIlDI1613631400_1613631710")
           // 最後にボタンの色を変える
        self.favButton.setImage(b, for: .normal)
       }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        checkTableView(tableView)
        if tableView.tag == 0 {
//            print("ツイッターインフォのカウント\(self.TwitterInfo.count)")
            return self.TwitterInfo.count
        }else if tableView.tag == 1 {
            return self.TwitterInfoSearch.count
        }
        return Int()
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            if let cell0 = self.tableView0.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell {
                cell0.cellItem = TwitterInfo[indexPath.row]
                cell0.delegate = self
//                print("TwitterInfoの中身は、\(TwitterInfo[indexPath.row])")
//                print(cell0.cellItem)
                   return cell0
               }
        }else if tableView.tag == 1{
            if let cell1 = self.tableView1.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell {
                cell1.cellItem2 = TwitterInfoSearch[indexPath.row]
                cell1.delegate = self
                return cell1
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
 
    // segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueのIDを確認して特定のsegueのときのみ動作させる
        if (segue.identifier == "toShopImage") {
            print("わーい")
            tableView0.reloadData()
            //セルがタップされたとして反応していない
            if let indexPath = self.tableView0.indexPathForSelectedRow {
                print("おお")
                guard let destination = segue.destination as? ShopImageViewController else {
                    fatalError("Failed to prepare ShopImageViewController.")
                }
                destination.userInfos = TwitterInfo[indexPath.row]
            } else {
                print("table0でエラーが起きている。")
            }
//            // 2. 遷移先のViewControllerを取得
//            let nextVC = segue.destination as? ShopImageViewController
//            if let cell0 = self.tableView0.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell {
////                tableView0.reloadData()
////                tableView1.reloadData()
//                print("セルの中のイメージ\((cell0.ramenImage.image))")
//                nextVC?.RamengetImage = cell0.ramenImage.image
//            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView0.indexPathForSelectedRow{
            tableView0.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          guard let lastCell = tableView.cellForRow(at: IndexPath(row: tableView.numberOfRows(inSection: 0)-1, section: 0)) else {
              return
          }
          // ここでリフレッシュのメソッドを呼ぶ
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Erase header cells
        return .leastNormalMagnitude
    }
  
    @IBAction func Modoru(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
    }
}



extension SubViewController:toImageDelegate {
    func toShopImage(UserTimeline:UserTimeline) {
//        self.performSegue(withIdentifier:"toShopImage", sender: nil)
        let viewController = storyboard?.instantiateViewController(identifier: "ShopImageViewController") as! ShopImageViewController
        viewController.userInfos = UserTimeline
        viewController.modalPresentationStyle = .automatic
        self.present(viewController, animated: true, completion: nil)
//        print("ヤホーイ")
    }
}
