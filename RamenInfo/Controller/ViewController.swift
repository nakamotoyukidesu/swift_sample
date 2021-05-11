//
//  ViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/11.
//

import UIKit
import FirebaseAuth


var database_sample = FireBaseDatabase()

class ViewController: UIViewController, UIScrollViewDelegate,UISearchBarDelegate,UINavigationControllerDelegate,NextSegueDelegate,UITableViewDelegate{
    
    
    
    
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var MainUIView: UIView!
    //ボタン周り
    @IBOutlet weak var vc1: UIView!
    @IBOutlet weak var okiniiri: UIButton!
    @IBOutlet weak var niboshi: UIButton!
    @IBOutlet weak var jiro: UIButton!
    @IBOutlet weak var iekei: UIButton!
    @IBOutlet weak var tonkotsu: UIButton!
    @IBOutlet weak var tori: UIButton!
    @IBOutlet weak var tonkotsugyokai: UIButton!
    @IBOutlet weak var scrollbuttonview: UIScrollView!
    //ナビ周り
    @IBOutlet weak var naviview: UIView!
    @IBOutlet weak var naviimage: UIImageView!
    @IBOutlet weak var navibutton: UIButton!
    
    
    var searchController: UISearchController!
    var scrollView:UIScrollView!
    var scroll_view:CustomScrollView!
    var arrays = ["煮干し","二郎系","家系","豚骨","鶏","豚骨魚介"]
    var buttons:[UIButton] = []
    var image1: UIImage!
    var table:Tableview!
    var searchdelegate:searchDelegate?
    var user = FirebaseAuth.Auth.auth().currentUser//変えてる
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //何も入力されていなくてもReturnキーを押せるようにする。
        search.enablesReturnKeyAutomatically = false
        search.delegate = self
        search.searchBarStyle = .minimal
        vc1.translatesAutoresizingMaskIntoConstraints = true
        //色を変える
        scrollbuttonview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
        vc1.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
        niboshi.backgroundColor = UIColor.white
        search.barTintColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
        naviview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
        search.searchTextField.backgroundColor = UIColor.white
        // 色ボタンを配列に入れる
        self.buttons = [niboshi,jiro,iekei,tonkotsu,tori,tonkotsugyokai]
        // 色ボタンがタップされると呼び出される
        for button in buttons {
            button.layer.cornerRadius = 10.0
            // アクションの設定
            button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
            button.addTarget(self, action: #selector(self.tap), for: .touchUpInside)
        }
        let picture = UIImage(named: "人物ボタン (2).png")
        self.navibutton.setImage(picture, for: .normal)
        image1 = UIImage(named:"RamenInfo文字透明")
        naviimage.image = image1
        DispatchQueue.global(qos: .default).async {
            
            database_sample.set_ramen_object(){ data in
                DispatchQueue.main.async {
                    
                    self.scroll_view = CustomScrollView(frame: self.MainUIView.bounds, category: self.arrays,data: data, vc: self)
                    self.MainUIView.addSubview(self.scroll_view)
                    
                }
            }
            
        }
        
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        scrollbuttonview.contentSize = vc1.frame.size
//        scrollbuttonview.flashScrollIndicators()
//
//    }
    
    @objc func tapButton(sender: UIButton) {
        if let button = sender as? UIButton{
            //scrollviewの色
            if(button == niboshi){
                scrollbuttonview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
                vc1.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
                naviview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
                search.barTintColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
//            }else if(button == niboshi){
//                scrollbuttonview.backgroundColor = UIColor.orange
//                vc1.backgroundColor = UIColor.orange
//                naviview.backgroundColor = UIColor.orange
//                search.barTintColor = UIColor.orange
            }else if(button == jiro){
                scrollbuttonview.backgroundColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
                vc1.backgroundColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
                naviview.backgroundColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
                search.barTintColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
            }else if(button == iekei){
                scrollbuttonview.backgroundColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
                vc1.backgroundColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
                naviview.backgroundColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
                search.barTintColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
            }else if (button == tonkotsu){
                scrollbuttonview.backgroundColor =  UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
                vc1.backgroundColor =  UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
                naviview.backgroundColor = UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
                search.barTintColor = UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
            }else if (button == tori){
                scrollbuttonview.backgroundColor = UIColor.magenta
                vc1.backgroundColor = UIColor.magenta
                naviview.backgroundColor = UIColor.magenta
                search.barTintColor = UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
            }else if (button == tonkotsugyokai){
                scrollbuttonview.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.60, alpha: 1.00)
                vc1.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.60, alpha: 1.00)
                naviview.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.60, alpha: 1.00)
                search.barTintColor = UIColor(red: 1.00, green: 0.75, blue: 0.60, alpha: 1.00)
            }
        }
    }
    
    
    
    @objc func gogoNext(){
        performSegue(withIdentifier: "toMypage", sender: nil)
    }
    
    @objc func tap(){
        for button in buttons{
            button.backgroundColor = scrollbuttonview.backgroundColor
        }
        //buttonの色
        if scrollbuttonview.backgroundColor == UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00){
            niboshi.backgroundColor = UIColor.white
//        }else if scrollbuttonview.backgroundColor == UIColor.orange{
//            niboshi.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00){
            jiro.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00){
            iekei.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00){
            tonkotsu.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor.magenta{
            tori.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor(red: 1.00, green: 0.75, blue: 0.60, alpha: 1.00){
            tonkotsugyokai.backgroundColor = UIColor.white
        }
        
        
        
        
    }
    // Searchボタンが押されると呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる。
        search.endEditing(true)
        self.searchdelegate?.searchItems(searchText: searchBar.text! as String)
    }
    // テキストが変更される毎に呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //検索する
        self.searchdelegate?.searchItems(searchText: searchText)
    }
    // キャンセルボタンが押されると呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.text = ""
    }

    func next_segue(array:Dictionary<String,String>){
        print("next_segue呼ばれちゃってるじゃん")
        let storyboard = UIStoryboard(name: "SubView", bundle: nil) // storyboardのインスタンスを名前指定で取得
        let nextVC = storyboard.instantiateInitialViewController() as! SubViewController
        nextVC.selectedName = array["name"]
        nextVC.selectedAddress = array["address"]
        nextVC.selectedQuery = array["query"]
        nextVC.selectedID = array["twitter_id"]
        nextVC.likearray = [array]
        nextVC.uid = user!.uid
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
    
    
    
    @IBAction func Navibutton(_ sender: Any) {
        gogoNext()
    }
    
    @IBAction func Niboshi(_ sender: Any) {
        self.scroll_view.scroll("煮干し")
        var position = CGPoint(x: 0, y: 0)
        scrollbuttonview.setContentOffset(position, animated: true)
    }
    @IBAction func Jirou(_ sender: Any) {
        self.scroll_view.scroll("二郎系")
        var position = CGPoint(x: 114, y: 0)
        scrollbuttonview.setContentOffset(position, animated: true)
    }
    @IBAction func Iekei(_ sender: Any) {
        self.scroll_view.scroll("家系")
        var position = CGPoint(x: 228, y: 0)
        scrollbuttonview.setContentOffset(position, animated: true)
    }
    @IBAction func Tonkotsu(_ sender: Any) {
        self.scroll_view.scroll("豚骨")
        var position = CGPoint(x: 342, y: 0)
        scrollbuttonview.setContentOffset(position, animated: true)
    }
    @IBAction func Tori(_ sender: Any) {
        self.scroll_view.scroll("鶏")
    }
    @IBAction func Tonkotsugyokai(_ sender: Any) {
        self.scroll_view.scroll("豚骨魚介")
    }
}

