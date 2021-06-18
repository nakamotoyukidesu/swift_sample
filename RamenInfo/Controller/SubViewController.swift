//
//  SubViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/14.
//

import UIKit
import Firebase


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
    
    var ref:DatabaseReference!
    var uid:String = ""
    var likearray:[Dictionary<String,String>]!

    
    var selectedImage: UIImage!
    var selectedName: String?
    var selectedAddress : String?
    var selectedID: String?
    var selectedQuery:String?
    var tableViewArray0 = [UITableViewCell]()
    var tableViewArray1 = [UITableViewCell]()
    var TwitterInfo:[TweetModel] = []
    var TwitterInfoSearch:[TweetModel] = []
    
    
    let randomInt = Int.random(in: 1..<5)

    // 処理分岐用
      var tag:Int = 0
      var cellIdentifier:String = ""
   
        // Do any additional setup after loading the view.
    
//    override func loadView() {
//        super.loadView()
//
//
//
//    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TwitterInfoSearchの値は、\(TwitterInfoSearch)")
        print("TwitterInfoの中身は、\(TwitterInfo)")

        ref = Database.database().reference();
        

        ref.child("User").child(uid).child("likes").observe(.value) { (snapshot) in
            for itemSnapShot in snapshot.children {
//                print("itemSnapShotは、これだよ\(itemSnapShot)")
                print(self.selectedName!)
                if let snap = itemSnapShot as? DataSnapshot {
                    let snapdicitionary = snap.value as! [[String:String]]
                    print("snapdicitionaryの値は、\(snapdicitionary[0]["name"]!)")
//                    print("snap.childrenの値は、\(snap.children)")
                    if self.selectedName! == snapdicitionary[0]["name"]! {
                        print("存在する")
                        let a = UIImage(named: "fILZIuljC5pkyyj1613632174_1613632219")
                        // 最後にボタンの色を変える
                        self.favButton.setImage(a, for: .normal)
                        break
                    }else {
                        print("存在しない")
                        let b = UIImage(named: "Q8m72eGQpJpIlDI1613631400_1613631710")
                        // 最後にボタンの色を変える
                        self.favButton.setImage(b, for: .normal)
                    }
                }
            }
        }



        //array作る
        //array = <Dicitionary>[String:String]
        
        ramenImage.layer.cornerRadius = 40
        self.accountLabel.layer.cornerRadius = 20
        self.accountLabel.clipsToBounds = true
        self.tweetLabel.layer.cornerRadius = 20
        self.tweetLabel.clipsToBounds = true
        
        
        //口コミツイートと公式アカウント情報のUIの確認


        var twitter = TwitterApi()
        var user_timeline_request = UserTimelineRequest(id: selectedID!)
        var user_timeline_decord = UserTimelineDecord()
        twitter.get_tweet(api_request: UserTimelineRequest(id: selectedID!), tweet_codable: UserTimelineDecord()){ tweets in
            DispatchQueue.main.async {
                print("tweetsの内容は、\(tweets)")
                self.TwitterInfo = tweets
                self.tableView0.reloadData()
//                self.tableView1.reloadData()
            }
        }
        
        twitter.get_tweet(api_request: SearchRecentRequest(query: selectedQuery!), tweet_codable: SearchRecentDecord()) { tweets in
            DispatchQueue.main.async {
                //tweetsに値が入らないなぜだ?
//                print("クエリの内容は\(tweets)")
                self.TwitterInfoSearch = tweets
                for info in self.TwitterInfoSearch {
                    for url in info.url! {
                        print("TwitterInfoSearchのURLは、\(url)")
                    }
                }
                if self.TwitterInfoSearch.isEmpty{
                    let images:UIImage = UIImage(named: "存在しません")!
                    let imageView = UIImageView(image:images)
                    imageView.frame = self.tableView1.frame
                    self.tableView1.addSubview(imageView)
                }
//                self.tableView0.reloadData()
                self.tableView1.reloadData()
            }
        }
        self.ramenName.text = self.selectedName
        self.addressName.text = self.selectedAddress
        self.ramenImage.image = self.selectedImage
        self.tableView0.delegate = self
        self.tableView0.dataSource = self
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        self.tableView0.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        self.tableView1.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
    }
    
   
    
    @IBAction func favButton(_ sender: Any) {
        print("favButton")
        self.state.favoriteButtonTapped(articleCell: self)
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
        var newRf = self.ref.child("User").child(uid).child("likes").child(selectedName!)
        newRf.setValue(likearray)

        let a = UIImage(named: "fILZIuljC5pkyyj1613632174_1613632219")
        // 最後にボタンの色を変える
        self.favButton.setImage(a, for: .normal)
    }
    
    
    func removeFavorite() {
           print("Removing Favorite...")
           /*
               Repositoryへのアクセス、サーバー上のデータの更新などの一連の処理を実装
           */
        var fRef = self.ref.child("User").child(uid).child("likes").child(selectedName!).removeValue()

        let b = UIImage(named: "Q8m72eGQpJpIlDI1613631400_1613631710")
           // 最後にボタンの色を変える
        self.favButton.setImage(b, for: .normal)
       }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            print("ツイッターインフォのカウント\(self.TwitterInfo.count)")
            return self.TwitterInfo.count
        }else if tableView.tag == 1 {
            if self.TwitterInfoSearch.isEmpty{
                return 0
            }else {
                return self.TwitterInfoSearch.count
            }
            print("TwitterInfoSearchのカウント\(self.TwitterInfoSearch.count)")
        }
        return Int()
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            if let cell0 = self.tableView0.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell {
                cell0.cellItem = TwitterInfo[indexPath.row]
                cell0.delegate = self
                   return cell0
               }
        }else if tableView.tag == 1 {
            if let cell1 = self.tableView1.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell {
                cell1.cellItem2 = TwitterInfoSearch[indexPath.row]
                cell1.delegate = self
                   print("ppppppppppppppppppppppppppppppp")
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
    func toShopImage(UserTimeline:TweetModel) {
//        self.performSegue(withIdentifier:"toShopImage", sender: nil)
        if #available(iOS 13.0, *) {
            let viewController = storyboard?.instantiateViewController(identifier: "ShopImageViewController") as! ShopImageViewController
            viewController.userInfos = UserTimeline
            viewController.modalPresentationStyle = .automatic
            self.present(viewController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
       
    }
}
