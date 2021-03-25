//
//  TableView.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/01/21.
//

import UIKit

class Tableview: UITableView, UITableViewDelegate, UITableViewDataSource, searchDelegate{
    
    
   
    var array:[Dictionary<String,String>]!
    var selectedLabel: String?
    var next_segue_protocol:NextSegueDelegate?
    var searchResult:[Dictionary<String,String>]!
    var viewcon:ViewController?
    
    init(frame: CGRect, array:[Dictionary<String,String>]) {
        super.init(frame: frame, style: UITableView.Style.plain)
        viewcon?.searchdelegate = self
        self.delegate = self
        self.dataSource = self
        self.frame = frame
        self.array = array
        self.register(UINib(nibName: "CustomTableViewCell", bundle: nil),forCellReuseIdentifier:"CustomCell")
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResult == nil{
        return self.array.count
        }else{
        return self.searchResult.count
        }
    }
    //セルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if searchResult == nil{
//           print("aaaaaaaaaaaaaaaaaaaaaaaa",array)
            tableView.tableFooterView = UIView()
            let nextcell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
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
        }else{
           
        
//        print("aaaaaaaaaaaaaaaaaaaaaaaaaa",array)
            tableView.tableFooterView = UIView()
            let next = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
            next.Name.text = self.searchResult[indexPath.row]["name"]
            next.Address.text = self.searchResult[indexPath.row]["address"]
            //image_urlをURLに変えてそれをData型に変えてそれをUIImage型に変えてからnextcellのimageに代入している
            let url = URL(string: self.searchResult[indexPath.row]["image_url"]!)
              do {
                  let data = try Data(contentsOf: url!)
                  let image_data = UIImage(data: data)
                next.RamenImage.image = image_data as? UIImage
              } catch let err {
                  print("Error : \(err.localizedDescription)")
              }
            
            return next
        }
    }
    //セルが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.next_segue_protocol?.next_segue(name: self.array[indexPath.row]["name"]!, address: self.array[indexPath.row]["address"]!, image: self.array[indexPath.row]["image_url"]!, twitter_id: self.array[indexPath.row]["twitter_id"]!, query: self.array[indexPath.row]["query"]!)
        
    }
   
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func searchItems(searchText: String?) {
        
        //searchTextに値が入ってきたら発火
        if searchText != "" {
         
            searchResult = array.filter{
                ($0["name"]?.contains(searchText!))! || (($0["address"]?.contains(searchText!))!)
                
            }
//            print(searchResult)
//            print(searchText)
//            print(array)
            
           
         
               } else {
                   //searchTextに値が入っていなかったら全てを表示させるためにsearchResultをnilにする
                   searchResult = nil

               }
               //tableViewを再読み込みする
            self.reloadData()
           }
    }



    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */




    

