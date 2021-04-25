//
//  NextSegueDelegate.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/01/21.
//

import UIKit

protocol NextSegueDelegate:class {
    //func next_segue(id:,name: .......)
    func next_segue(array:Dictionary<String,String>)
}
protocol searchDelegate:class {
    func searchItems(searchText:String?)
}
