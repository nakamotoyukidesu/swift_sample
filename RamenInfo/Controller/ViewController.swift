//
//  ViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/11.
//

import UIKit
import SwiftUI

var database_sample = FireBaseDatabase()

class ViewController: UIViewController, UIScrollViewDelegate,UISearchBarDelegate,UINavigationControllerDelegate,NextSegueDelegate,UITableViewDelegate{
    
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var MainUIView: UIView!
    @IBOutlet weak var vc1: UIView!
    @IBOutlet weak var niboshi: UIButton!
    @IBOutlet weak var jiro: UIButton!
    @IBOutlet weak var iekei: UIButton!
    @IBOutlet weak var tonkotsu: UIButton!
    @IBOutlet weak var tori: UIButton!
    @IBOutlet weak var tonkotsugyokai: UIButton!
    @IBOutlet weak var scrollbuttonview: UIScrollView!
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
    var searchdelegate:searchDelegate!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table?.delegate = self
        table?.viewcon = self
        
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
        naviview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
        DispatchQueue.global(qos: .default).async {
            
            database_sample.set_ramen_object(){ data in
                DispatchQueue.main.async {
                    
                    self.scroll_view = CustomScrollView(frame: self.MainUIView.bounds, category: self.arrays,data: data, vc: self)
                    self.MainUIView.addSubview(self.scroll_view)
                }
            }
            
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollbuttonview.contentSize = vc1.frame.size
        scrollbuttonview.flashScrollIndicators()
        
    }
 
    @objc func tapButton(sender: UIButton) {
        if let button = sender as? UIButton{
            //scrollviewの色
            if(button == niboshi){
                scrollbuttonview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
            }else if(button == jiro){
                scrollbuttonview.backgroundColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
            }else if(button == iekei){
                scrollbuttonview.backgroundColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
            }else if (button == tonkotsu){
                scrollbuttonview.backgroundColor =  UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
            }else if (button == tori){
                scrollbuttonview.backgroundColor = UIColor.magenta
            }else if (button == tonkotsugyokai){
                scrollbuttonview.backgroundColor = UIColor.orange
            }
            if(button == niboshi){
                vc1.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
            }else if(button == jiro){
                vc1.backgroundColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
            }else if(button == iekei){
                vc1.backgroundColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
            }else if (button == tonkotsu){
                vc1.backgroundColor =  UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
            }else if (button == tori){
                vc1.backgroundColor = UIColor.magenta
            }else if (button == tonkotsugyokai){
                vc1.backgroundColor = UIColor.orange
            }
            //naviviewの色
            if(button == niboshi){
                naviview.backgroundColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
            }else if(button == jiro){
                naviview.backgroundColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
            }else if(button == iekei){
                naviview.backgroundColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
            }else if (button == tonkotsu){
                naviview.backgroundColor = UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
            }else if (button == tori){
                naviview.backgroundColor = scrollbuttonview.backgroundColor
            }else if (button == tonkotsugyokai){
                naviview.backgroundColor = UIColor(red: 1.00, green: 0.45, blue: 0.00, alpha: 0.90)
            }
            
            //serchの色
            if(button == niboshi){
                search.barTintColor = UIColor(red: 1.00, green: 0.30, blue: 0.00, alpha: 1.00)
            }else if(button == jiro){
                search.barTintColor = UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00)
            }else if(button == iekei){
                search.barTintColor = UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00)
            }else if(button == tonkotsu){
                search.barTintColor = UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
            }else if(button == tori){
                search.barTintColor = UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00)
            }else if(button == tonkotsugyokai){
                search.barTintColor = UIColor.orange
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
        }else if scrollbuttonview.backgroundColor == UIColor(red: 0, green: 0.40, blue: 1.00, alpha: 1.00){
            jiro.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor(red: 0.00, green: 1.00, blue: 0.40, alpha: 1.00){
            iekei.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor(red: 0.00, green: 0.80, blue: 0.80, alpha: 1.00){
            tonkotsu.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor.magenta{
            tori.backgroundColor = UIColor.white
        }else if scrollbuttonview.backgroundColor == UIColor.orange{
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
        table?.reloadData()
       }
           
  
    
    func next_segue(name:String,address:String,image:String,twitter_id:String,query:String){
        
        let storyboard = UIStoryboard(name: "SubView", bundle: nil) // storyboardのインスタンスを名前指定で取得
        let nextVC = storyboard.instantiateInitialViewController() as! SubViewController
        nextVC.selectedName = name
        nextVC.selectedAddress = address
        nextVC.selectedQuery = query
        nextVC.selectedID = twitter_id
        let url = URL(string:image)
        do {
            let data = try Data(contentsOf: url!)
            let image_data = UIImage(data: data)!
            nextVC.selectedImage = image_data
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil) // presentする
        
    }

    
    @IBAction func Navibutton(_ sender: Any) {
        gogoNext()
    }
    @IBAction func Niboshi(_ sender: Any) {
        self.scroll_view.scroll("煮干し")
    }
    
    @IBAction func Jirou(_ sender: Any) {
        self.scroll_view.scroll("二郎系")
    }
    @IBAction func Iekei(_ sender: Any) {
        self.scroll_view.scroll("家系")
    }
    @IBAction func Tonkotsu(_ sender: Any) {
        self.scroll_view.scroll("豚骨")
    }
    @IBAction func Tori(_ sender: Any) {
        self.scroll_view.scroll("鶏")
    }
    @IBAction func Tonkotsugyokai(_ sender: Any) {
        self.scroll_view.scroll("豚骨魚介")
    }
}

