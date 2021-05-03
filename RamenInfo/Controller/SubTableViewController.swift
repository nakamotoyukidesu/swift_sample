//
//  SubTableViewController.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/04/26.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SubTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var subtableview: UITableView!
    
    var array:[Dictionary<String,String>] = []
    var user = FirebaseAuth.Auth.auth().currentUser
    var ref: DatabaseReference!
    var uid:String = ""
    
    override func viewWillAppear(_ animated:Bool){
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        subtableview.register(UINib(nibName: "subcell", bundle: nil), forCellReuseIdentifier: "customsubcell")
        self.get_favorite(){ favorite in
            print("お気に入り")
            print(favorite)
            self.array = favorite
            self.subtableview.reloadData()
            print(self.array)
        }
        //クロージャ↓メソッド作って絵すけで外してリロード
        //ライフサイクルメソッド
        //ディスパッチキュー調べる
//        let dispatchGroup = DispatchGroup()
//        let queue = DispatchQueue(label: "com.hogehoge.fuga", qos: .userInteractive)
//        queue.async(group: dispatchGroup) {
//            self.ref = Database.database().reference()
//            self.ref.child("User").child(self.user!.uid).child("likes").observeSingleEvent(of: .value, with: { (snapshot) in
//
//               var test:Dictionary<String,Array> = snapshot.value! as! Dictionary<String,Array<Any>>
//               for (key,value) in test {
//                   for test2 in value {
//                       self.array.append(test2 as! Dictionary<String, String>)
//                   }
//               }
//                print(self.array)
//            })
//            dispatchGroup.notify(queue: .main) {
//                self.subtableview.reloadData()
//                print("reload")
//                print(self.array)
//            }
//        }
        
//        print(self.array)
//        subtableview.register(UINib(nibName: "subcell", bundle: nil), forCellReuseIdentifier: "customsubcell")
        // Do any additional setup after loading the view.

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("arrayの個数")
        print(self.array.count)
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("テーブルビューの初期化処理")
        print(self.array)
       
        let nextcell = tableView.dequeueReusableCell(withIdentifier: "customsubcell") as! SubTableViewCell
        nextcell.Name.text = self.array[indexPath.row]["name"]
        nextcell.Address.text = self.array[indexPath.row]["address"]
        //image_urlをURLに変えてそれをData型に変えてそれをUIImage型に変えてからnextcellのimageに代入している
        let url = URL(string: self.array[indexPath.row]["image_url"]!)
        do {
            let data = try Data(contentsOf: url!)
            let image_data = UIImage(data: data)
            nextcell.RamenImage.image = image_data as? UIImage
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return nextcell
    }
    
    
    @IBAction func okiniirisegue(_ sender: Any) {
        performSegue(withIdentifier: "subcell", sender: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func get_favorite(completion:@escaping (([Dictionary<String,String>])->Void)){
        var favorite:[Dictionary<String,String>] = []
        self.ref = Database.database().reference()
        self.ref.child("User").child(self.user!.uid).child("likes").observeSingleEvent(of: .value, with: { (snapshot) in
           var test:Dictionary<String,Array> = snapshot.value! as! Dictionary<String,Array<Any>>
           for (key,value) in test {
               for test2 in value {
                   favorite.append(test2 as! Dictionary<String, String>)
               }
           }
            print(favorite)
            completion(favorite)
        })
        
    }
}
