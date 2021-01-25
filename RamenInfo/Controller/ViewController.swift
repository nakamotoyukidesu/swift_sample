//
//  ViewController.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/11.
//

import UIKit
import SwiftUI

var database_sample = FireBaseDatabase()

class ViewController: UIViewController, UIScrollViewDelegate,UISearchBarDelegate,UINavigationControllerDelegate,NextSegueDelegate{
    
    
   
   
    @IBOutlet weak var MainUIView: UIView!
    
   
    var searchController: UISearchController!
    var scrollView:UIScrollView!
    var scroll_view:CustomScrollView!
    var array = ["煮干し","二郎系","家系","豚骨","鶏","豚骨魚介"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        let BarButtonItem = UIBarButtonItem(image: UIImage(named: "人")!, style: .plain, target: self, action: #selector(self.gogoNext))
                navigationItem.rightBarButtonItem = BarButtonItem
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "RamenInfo文字透明")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        
        
        DispatchQueue.global(qos: .default).async {
          
            database_sample.set_ramen_object(){ data in
                DispatchQueue.main.async {
                   
                    self.scroll_view = CustomScrollView(frame: self.MainUIView.bounds, category: self.array,data: data, vc: self)
                    self.MainUIView.addSubview(self.scroll_view)
                }
            }
            
        }
        
    }
    @objc func gogoNext(){
        performSegue(withIdentifier: "toMypage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubViewController"{
            let vc = segue.destination as! SubViewController
            vc.selectedName = sender as! String
           
        }
    }
    func next_segue(name:String,address:String,image:String){
        
        let storyboard = UIStoryboard(name: "SubView", bundle: nil) // storyboardのインスタンスを名前指定で取得
        let nextVC = storyboard.instantiateInitialViewController() as! SubViewController
        nextVC.selectedName = name
        nextVC.selectedAddress = address
        let url = URL(string:image)
          do {
              let data = try Data(contentsOf: url!)
              let image_data = UIImage(data: data)!
            nextVC.selectedImage = image_data
          } catch let err {
              print("Error : \(err.localizedDescription)")
          }
        nextVC.modalPresentationStyle = .fullScreen
        // storyboard内で"is initial"に指定されているViewControllerを取得
        self.present(nextVC, animated: true, completion: nil) // presentする
       
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

