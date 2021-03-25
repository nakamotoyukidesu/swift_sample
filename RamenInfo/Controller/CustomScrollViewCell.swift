//
//  CustomScrollViewCell.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/01/21.
//

import UIKit

class CustomScrollView: UIScrollView {
    var category:Array<String>!
    var data:RamenData!
    var tables:[Tableview] = []
    
    init(frame:CGRect, category:Array<String>,data:RamenData,vc:ViewController) {
        super.init(frame: frame)
        self.category = category
        self.data = data
        self.frame = frame
        self.isScrollEnabled = false
        self.contentSize = CGSize(width: Int(frame.width) * category.count, height: 0)
        for (index,category) in zip(self.category.indices, self.category) {
            var tableview = Tableview(frame: CGRect(x: frame.width * CGFloat(index), y: frame.origin.y, width: self.frame.width, height: frame.height), array: self.data.search_category(category: category))
            self.tables.append(tableview)
//            self.addSubview(tableview)
            print("subview")
            print(self.subviews)
            tableview.next_segue_protocol   = vc
            vc.searchdelegate = tableview
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scroll(_ category:String){
        var category_index = self.category.firstIndex(of: category)
        var position = CGPoint(x: self.frame.width * CGFloat(category_index!), y: 0)
        self.setContentOffset(position, animated: true)
    }
   
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


   

