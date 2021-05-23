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
    @IBOutlet weak var naviview: UIView!
    @IBOutlet weak var navilavel: UILabel!
    
    var array:[Dictionary<String,String>] = []
    var user = FirebaseAuth.Auth.auth().currentUser
    var ref: DatabaseReference!
    var uid:String = ""
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
        navilavel.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
        
        subtableview.delegate = self
        subtableview.dataSource = self
        subtableview.register(UINib(nibName: "SubTableViewCell", bundle: nil), forCellReuseIdentifier: "SubTableViewCell")
        self.get_favorite(){ favorite in
            self.array = favorite
            self.subtableview.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nextcell = tableView.dequeueReusableCell(withIdentifier: "SubTableViewCell") as! SubTableViewCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        next_segue(array: self.array[indexPath.row])
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    @IBAction func okiniirisegue(_ sender: Any) {
        performSegue(withIdentifier: "subcell", sender: nil)
    }
    @IBAction func modoru(_ sender: Any) {
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
    func next_segue(array:Dictionary<String,String>){
        let storyboard = UIStoryboard(name: "SubView", bundle: nil) // storyboardのインスタンスを名前指定で取得
        let nextVC = storyboard.instantiateInitialViewController() as! SubViewController
        nextVC.selectedName = array["name"]
        nextVC.selectedAddress = array["address"]
        nextVC.selectedQuery = array["query"]
        nextVC.selectedID = array["twitter_id"]
        nextVC.likearray = [array]
        nextVC.uid = user!.uid
//        guard case let nextVC.uid = user!.uid else {return}
        let url = URL(string:array["image_url"]!)
        do {
            let data = try Data(contentsOf: url!)
            let image_data = UIImage(data: data)!
            nextVC.selectedImage = image_data
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
        }
    
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
