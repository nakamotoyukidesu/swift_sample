//
//  NextSegueDelegate.swift
//  RamenInfo
//
//  Created by 河原広夢 on 2021/01/21.
//

import UIKit

protocol NextSegueDelegate:class {
    func next_segue(name:String,address:String,image:String,twitter_id:String,query:String)
}
protocol searchDelegate:class {
    func searchItems(searchText:String?)
}
